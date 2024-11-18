import 'dart:io';

import 'package:flu_editor/widgets/stickers/sticker_pan.dart';
import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';

import '../blocs/edtor_home_cubit.dart';
import '../flu_editor.dart';
import '../widgets/fonts/sticker_view.dart';
import '../widgets/slider_aloha_parameter.dart';

class EditorStickerPage extends StatefulWidget {
  final String afterPath;

  const EditorStickerPage({super.key, required this.afterPath});

  @override
  State<EditorStickerPage> createState() => _EditorStickerPageState();
}

class _EditorStickerPageState extends State<EditorStickerPage> {
  /// current sticker
  StickDetail? _stickerDetail;

  late LindiController _stickerController;

  var _contentW = 0.0;
  var _contentH = 0.0;

  final GlobalKey _imageKey = GlobalKey();

  late final _stickerSize;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((s) {
      _stickerSize = (MediaQuery.of(context).size.width - 63) / 4;
    });
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
              SizedBox(
                width: _contentW,
                height: _contentH,
                child: StikerView(
                  bgChild: Container(
                    width: _contentW,
                    height: _contentH,
                    color: Colors.transparent,
                  ),
                  onInited: (LindiController stickerController) {
                    _stickerController = stickerController;
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SliderAlphaParameterWidget(
                  initValue: 1.0,
                  onChanged: (double value) {
                    debugPrint('alpha = $value');
                  },
                ),
              ),
            ],
          )),
          StickerPan(
            sts: EditorUtil.stickerList,
            usingDetail: _stickerDetail,
            onChanged: ({StickDetail? item, String? path}) {
              setState(() {
                _stickerDetail = item;
              });

              _stickerController.add(SizedBox(
                width: _stickerSize,
                height: _stickerSize,
                child: Image.file(File(path ?? '')),
              ));
            },
            onEffectSave: () async {
              if (_stickerDetail == null) {
                return;
              }
              EditorUtil.showLoadingdialog(context);
              EditorUtil.addSticker(widget.afterPath, _stickerController)
                  .then((after) {
                /// 更新 home after
                EditorUtil.homeCubit?.emit(
                  EditorHomeState(after),
                );
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  void _getImageWidgetSize() {
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
    });
    debugPrint('Image width: $_contentW, height: $_contentW');
  }
}
