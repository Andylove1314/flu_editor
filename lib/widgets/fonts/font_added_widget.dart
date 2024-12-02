import 'package:flu_editor/utils/constant.dart';
import 'package:flutter/material.dart';

/// 文字编辑
class FontAddedWidget extends StatelessWidget {
  final String text;
  String? font;
  String? color;
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
      this.color,
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
          text.isEmpty ? '点击输入文案' : text,
          style: TextStyle(
              fontFamily: font,
              fontSize: 28,
              color: Color(int.parse(color ?? colorStrs[1])),
              fontWeight: (bold ?? false) ? FontWeight.w700 : null,
              fontStyle: (italic ?? false) ? FontStyle.italic : null,
              decorationColor: Color(int.parse(color ?? colorStrs[1])),
              decoration:
                  (underline ?? false) ? TextDecoration.underline : null,
              letterSpacing: worldSpace,
              height: lineSpace),
          textAlign: textAlign,
        ));
  }
}
