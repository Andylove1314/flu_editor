import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';

import '../blocs/edtor_home_cubit.dart';
import '../flu_editor.dart';
import '../widgets/fonts/font_pan.dart';
import '../widgets/fonts/font_pre_view.dart';

class EditorFontPage extends StatefulWidget {
  final String afterPath;

  const EditorFontPage({super.key, required this.afterPath});

  @override
  State<EditorFontPage> createState() => _EditorFontPageState();
}

class _EditorFontPageState extends State<EditorFontPage> {
  late LindiController _stickerController;

  /// current sticker
  FontDetail? _fontDetail;
  String? _ttfPath;
  String? _imgPath;

  var _contentW = 0.0;
  var _contentH = 0.0;

  final GlobalKey _imageKey = GlobalKey();

  int _stickerCount = 0;

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
          Expanded(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Image.file(
                key: _imageKey,
                File(widget.afterPath),
                frameBuilder: (context, child, loadingProgress, loaded) {
                  if (loaded) {
                    _getImageWidgetSize();
                    return child;
                  }
                  return EditorUtil.loadingWidget(context);
                },
              ),
              FontPreView(
                stvWidth: _contentW,
                stvHeight: _contentH,
                bgChild: Container(
                  width: _contentW,
                  height: _contentH,
                  color: Colors.transparent,
                ),
                onInited: (LindiController stickerController) {
                  _stickerController = stickerController;
                },
                fontStickerSize: const Size(186, 65),
                addFontStickerPath: _imgPath,
                addCount: _stickerCount,
              ),
            ],
          )),
          FontPan(
            usingDetail: _fontDetail,
            onFontChanged: (
                {FontDetail? item, String? ttfPath, String? imgPath}) {
              _fontDetail = item;
              _ttfPath = ttfPath;
              _imgPath = imgPath;
              _stickerCount++;
              setState(() {});
            },
            onEffectSave: () async {
              if (_fontDetail == null) {
                return;
              }

              EditorUtil.showLoadingdialog(context);
              EditorUtil.addText(widget.afterPath, _stickerController)
                  .then((after) {
                /// 更新 home after
                EditorUtil.homeCubit?.emit(
                  EditorHomeState(after),
                );
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
            onColorChanged: (Color color) {},
            onOpacityChanged: (double opacity) {},
            onStyleChanged: (int style) {},
            onWorldSpaceChanged: (double? worldSpace) {},
            onLineSpaceChanged: (double? lineSpace) {},
            onAlignChanged: (int algin) {},
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  void _getImageWidgetSize() {
    if (_contentW != 0.0 && _contentH != 0.0) {
      return;
    }

    var renderBox = _imageKey.currentContext?.findRenderObject();
    if (renderBox == null) {
      return;
    }
    var size = (renderBox as RenderBox).size; // 获取 widget 的宽高

    WidgetsBinding.instance.addPostFrameCallback((s) {
      setState(() {
        _contentW = size.width;
        _contentH = size.height;
      });
      debugPrint('Image width: $_contentW, height: $_contentW');
    });
  }
}
