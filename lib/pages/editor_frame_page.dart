import 'dart:io';

import 'package:flu_editor/widgets/frames/frame_pan.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../blocs/edtor_home_cubit.dart';
import '../flu_editor.dart';
import '../widgets/frames/frame_bg_container_widget.dart';

class EditorFramePage extends StatefulWidget {
  final String afterPath;

  const EditorFramePage({super.key, required this.afterPath});

  @override
  State<EditorFramePage> createState() => _EditorFramePageState();
}

class _EditorFramePageState extends State<EditorFramePage> {
  /// current frame
  FrameDetail? _frameDetail;
  String? _currentFrame;

  PhotoViewController? _photoViewController;

  final GlobalKey _imageKey = GlobalKey();

  late double frameAspectRatio;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _getPre()),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FramePan(
                frs: EditorUtil.frameList,
                usingDetail: _frameDetail,
                onChanged: ({FrameDetail? item, String? path}) {
                  _frameDetail = item;
                  _currentFrame = path;
                  setState(() {});
                },
                onEffectSave: () async {
                  if (_frameDetail == null) {
                    return;
                  }
                  EditorUtil.showLoadingdialog(context);
                  EditorUtil.addFrame(_imageKey, widget.afterPath,
                          _currentFrame ?? '', frameAspectRatio)
                      .then((after) {
                    if (EditorUtil.editorType == null) {
                      /// 更新 home after
                      EditorUtil.homeCubit?.emit(
                        EditorHomeState(after),
                      );
                    } else {
                      if(EditorUtil.singleEditorSavetoAlbum){
                        EditorUtil.saveCallback?.call(after);
                      }
                      EditorUtil.clearTmpObject(after);
                    }

                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
              )
            ],
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  /// 相框预览
  Widget _getPre() {
    Widget input = Image.file(
      File(widget.afterPath),
    );
    if (_frameDetail == null) {
      return input;
    }

    return LayoutBuilder(builder: (context, constraints) {
      var bgWidth = constraints.maxWidth;
      var bgHeight = constraints.maxHeight;
      debugPrint('容器Widget宽高: $bgWidth - $bgWidth');

      // 假设图片的实际尺寸为 imagePixelWidth 和 imagePixelHeight
      double imagePixelWidth =
          _frameDetail?.params?.frameWidth * 1.0; // 图片的实际宽度（像素）
      double imagePixelHeight =
          _frameDetail?.params?.frameHeight * 1.0; // 图片的实际高度（像素）
      // 镂空区域的像素值
      double frameLeftPixel = _frameDetail?.params?.frameLeft * 1.0;
      double frameTopPixel = _frameDetail?.params?.frameTop * 1.0;
      double frameRightPixel = _frameDetail?.params?.frameRight * 1.0;
      double frameBottomPixel = _frameDetail?.params?.frameBottom * 1.0;
      debugPrint('图片pix宽高: $imagePixelWidth - $imagePixelHeight');

      // 计算图片的宽高比
      frameAspectRatio = imagePixelWidth / imagePixelHeight;

      // 计算容器的宽高比
      double containerAspectRatio = bgWidth / bgHeight;

      double displayWidth, displayHeight;
      // 判断是按宽度还是按高度来适应
      if (frameAspectRatio > containerAspectRatio) {
        // 图片宽高比大，按宽度适应容器
        displayWidth = bgWidth;
        displayHeight = bgWidth / frameAspectRatio;
      } else {
        // 图片高宽比大，按高度适应容器
        displayHeight = bgHeight;
        displayWidth = bgHeight * frameAspectRatio;
      }

      debugPrint('图片Widget宽高: $displayWidth - $displayHeight');

      // 计算缩放比例
      double scaleX = displayWidth / imagePixelWidth;
      double scaleY = displayHeight / imagePixelHeight;

      // 将镂空区域像素值转换为显示区域的比例值
      double imageLeft = frameLeftPixel * scaleX;
      double imageTop = frameTopPixel * scaleY;
      double imageRight = frameRightPixel * scaleX;
      double imageBottom = frameBottomPixel * scaleY;
      debugPrint(
          '图片Widget镂边距: $imageLeft - $imageTop - $imageRight - $imageBottom');

      double bgLeft = imageLeft + (bgWidth - displayWidth) / 2;
      double bgTop = imageTop + (bgHeight - displayHeight) / 2;
      double bgRight = imageRight + (bgWidth - displayWidth) / 2;
      double bgBottom = imageBottom + (bgHeight - displayHeight) / 2;
      debugPrint('容器Widget镂边距: $bgLeft - $bgTop - $bgRight - $bgBottom');

      _initInputPosition((displayWidth - imageLeft - imageLeft) / displayWidth);
      // _initInputPosition(
      //     (displayHeight - imageTop - imageBottom) / displayHeight);

      return Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              child: SizedBox(
                width: displayWidth,
                height: displayHeight,
                child: RepaintBoundary(
                  key: _imageKey,
                  child: PhotoView.customChild(
                    enablePanAlways: true,
                    controller: _photoViewController,
                    enableRotation: true,
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.white),
                    child: input,
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: IgnorePointer(
                child: _currentFrame == null
                    ? const SizedBox()
                    : FrameBgContainerWidget(
                        frameLeft: bgLeft,
                        frameTop: bgTop,
                        frameRight: bgRight,
                        frameBottom: bgBottom,
                        containerW: bgWidth,
                        containerH: bgHeight,
                      ),
              )),
          Align(
            alignment: Alignment.center,
            child: IgnorePointer(
              child: SizedBox(
                width: displayWidth,
                height: displayHeight,
                child: Image.file(
                  File(_currentFrame ?? ''),
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  void _initInputPosition(double scale) {
    debugPrint('refresh position');
    Duration dur = const Duration(milliseconds: 0);
    if (_photoViewController == null) {
      _photoViewController = PhotoViewController();
      dur = const Duration(milliseconds: 80);
    }
    Future.delayed(dur, () {
      _photoViewController?.reset();
      _photoViewController?.scale = scale;
      _photoViewController?.position = Offset.zero;
    });
  }
}
