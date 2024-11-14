import 'dart:io';

import 'package:flu_editor/widgets/stickers/sticker_pan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/edtor_home_cubit.dart';
import '../blocs/source_image_bloc/source_image_bloc.dart';
import '../flu_editor.dart';
import '../widgets/slider_aloha_parameter.dart';

class EditorStickerPage extends StatefulWidget {
  const EditorStickerPage({super.key});

  @override
  State<EditorStickerPage> createState() => _EditorStickerPageState();
}

class _EditorStickerPageState extends State<EditorStickerPage> {
  /// current sticker
  StickDetail? _stickerDetail;

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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<SourceImageCubit, SourceImageReady>(
              builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 150),
                  child: Image.file(File(state.afterPath)),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SliderAlphaParameterWidget(
                  alpha: 0.0,
                  initValue: 1.0,
                  onChanged: (double value) {
                    debugPrint('alpha = $value');
                  },
                ),
                StickerPan(
                  sts: EditorUtil.stickerList,
                  usingDetail: _stickerDetail,
                  onChanged: ({StickDetail? item, String? path}) {
                    _stickerDetail = item;
                    setState(() {});
                    EditorUtil.showToast('select $path');
                  },
                  onEffectSave: () async {
                    if (_stickerDetail == null) {
                      return;
                    }

                    EditorUtil.addSticker(
                            context.read<SourceImageCubit>().state.afterPath)
                        .then((after) {
                      /// 更新 home after
                      EditorUtil.homeCubit?.emit(
                        EditorHomeState(after),
                      );
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
