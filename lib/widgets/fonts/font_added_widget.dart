import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

/// todo 文字编辑
class FontAddedWidget extends StatelessWidget {
  GlobalKey fontStickerKey;
  double initOpacity;
  final String fontStickerPath;

  FontAddedWidget(
      {super.key,
      this.initOpacity = 1.0,
      required this.fontStickerPath,
      required this.fontStickerKey});

  @override
  Widget build(BuildContext context) {
    debugPrint('FontAddedWidget build');
    return Opacity(
        key: fontStickerKey,
        opacity: initOpacity,
        // child: Image.file(
        //   File(fontStickerPath ?? ''),
        // )
        child: ExtendedImage.network(
          fontStickerPath,
        ));
  }
}
