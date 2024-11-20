import 'package:flutter/material.dart';

/// 文字编辑
class FontAddedWidget extends StatelessWidget {
  final String text;
  String? font;
  Color? color;
  double? opacity;
  bool? bold;
  bool? italic;
  bool? underline;
  TextAlign? textAlign;
  double? worldSpace;
  double? lineSpace;

  GlobalKey stickerKey;

  FontAddedWidget(
      {super.key,
      required this.stickerKey,
      required this.text,
      this.font = '',
      this.opacity = 1.0,
      this.color = Colors.white,
      this.bold = false,
      this.italic = false,
      this.underline = false,
      this.textAlign = TextAlign.left,
      this.worldSpace = 1.0,
      this.lineSpace = 1.0});

  @override
  Widget build(BuildContext context) {
    debugPrint('FontAddedWidget build');
    return Opacity(
        key: stickerKey,
        opacity: opacity ?? 1.0,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 28,
              color: color ?? Colors.white,
              fontWeight: (bold ?? false) ? FontWeight.w700 : null,
              fontStyle: (italic ?? false) ? FontStyle.italic : null,
              decorationColor: color ?? Colors.white,
              decoration:
                  (underline ?? false) ? TextDecoration.underline : null,
              letterSpacing: worldSpace,
              height: lineSpace),
          textAlign: textAlign,
        ));
  }
}
