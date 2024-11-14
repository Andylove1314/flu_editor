import 'dart:io';

import 'package:flu_editor/widgets/frames/frame_pan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/edtor_home_cubit.dart';
import '../blocs/source_image_bloc/source_image_bloc.dart';
import '../flu_editor.dart';

class EditorFramePage extends StatefulWidget {
  const EditorFramePage({super.key});

  @override
  State<EditorFramePage> createState() => _EditorFramePageState();
}

class _EditorFramePageState extends State<EditorFramePage> {
  /// current frame
  FrameDetail? _frameDetail;

  String? _currentFrame;

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
            children: [
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<SourceImageCubit, SourceImageReady>(
                  builder: (context, state) {
                    return Image.file(File(state.afterPath));
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: _currentFrame == null
                    ? const SizedBox()
                    : Image.file(File(_currentFrame ?? '')),
              ),
            ],
          )),
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

                  EditorUtil.addFrame(
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
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
