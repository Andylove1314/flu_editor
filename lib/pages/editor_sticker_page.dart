import 'dart:io';

import 'package:flu_editor/widgets/stickers/sticker_pan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/source_image_bloc/source_image_bloc.dart';
import '../flu_editor.dart';

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
                return Container(margin: const EdgeInsets.only(bottom: 150), child: Image.file(File(state.afterPath)),);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// alpha todo

                StickerPan(
                  sts: EditorUtil.stickerList,
                  usingDetail: _stickerDetail,
                  onChanged: ({StickDetail? item}) {
                    _stickerDetail = item;
                    setState(() {});
                    EditorUtil.showToast('select ${_stickerDetail?.image}');
                  },
                  onEffectSave: () async {

                    if(_stickerDetail == null){
                      return;
                    }

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
