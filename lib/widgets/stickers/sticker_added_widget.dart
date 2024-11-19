import 'dart:io';

import 'package:flutter/cupertino.dart';

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
    debugPrint('StickerAddedWidget build');
    return Opacity(
        key: stickerKey,
        opacity: initOpacity,
        child: Image.file(
          File(stickerPath ?? ''),
        ));
  }
}
