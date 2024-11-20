import 'package:flutter/material.dart';

/// 文字编辑
class FontAddedWidget extends StatelessWidget {
  GlobalKey fontStickerKey;
  String font;
  Color initColor;
  double opacity;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextDecoration? decoration;
  TextAlign textAlign;

  final String text;

  FontAddedWidget(
      {super.key,
      this.font = '',
      this.opacity = 1.0,
      required this.text,
      required this.fontStickerKey,
      this.initColor = Colors.white,
      this.textAlign = TextAlign.left,
      this.fontWeight,
      this.fontStyle,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    debugPrint('FontAddedWidget build');
    return Opacity(
        key: fontStickerKey,
        opacity: opacity,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 28,
              color: initColor,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration),
          textAlign: textAlign,
        ));
  }
}
