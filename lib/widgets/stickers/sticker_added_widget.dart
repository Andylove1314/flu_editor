import 'dart:io';

import 'package:flu_editor/blocs/sticker_added_bloc/sticker_added_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StickerAddedWidget extends StatelessWidget {
  GlobalKey stickerKey;
  double initOpacity;
  final String stickerPath;

  StickerAddedWidget(
      {super.key,
      this.initOpacity = 1.0,
      required this.stickerPath,
      required this.stickerKey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return StickerAddedCubit(StickerAddedState(initOpacity));
      },
      child: BlocBuilder<StickerAddedCubit, StickerAddedState>(
          builder: (cubit, state) {
        return Opacity(
            key: stickerKey,
            opacity: state.opacity,
            child: Image.file(
              File(stickerPath ?? ''),
            ));
      }),
    );
  }
}
