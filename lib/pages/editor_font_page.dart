import 'dart:io';

import 'package:flu_editor/widgets/stickers/sticker_pan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/edtor_home_cubit.dart';
import '../blocs/source_image_bloc/source_image_bloc.dart';
import '../flu_editor.dart';
import '../widgets/fonts/font_pan.dart';
import '../widgets/slider_aloha_parameter.dart';

class EditorFontPage extends StatefulWidget {
  final String afterPath;

  const EditorFontPage({super.key, required this.afterPath});

  @override
  State<EditorFontPage> createState() => _EditorFontPageState();
}

class _EditorFontPageState extends State<EditorFontPage> {
  /// current sticker
  FontDetail? _fontDetail;
  String? ttfFilePath;

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
            child: Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: Image.file(File(widget.afterPath)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FontPan(
                  fons: EditorUtil.fontList,
                  usingDetail: _fontDetail,
                  onChanged: ({FontDetail? item, String? path}) {
                    _fontDetail = item;
                    ttfFilePath = path;
                    setState(() {});
                    EditorUtil.showToast('select $path');
                  },
                  onEffectSave: () async {
                    if (_fontDetail == null) {
                      return;
                    }

                    EditorUtil.addText(widget.afterPath).then((after) {
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
