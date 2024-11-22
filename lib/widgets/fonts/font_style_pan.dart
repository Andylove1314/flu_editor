import 'package:flu_editor/widgets/fonts/style/style_widget.dart';
import 'package:flutter/material.dart';

import '../slider_normal_parameter.dart';
import 'color/color_widget.dart';

class FontStylePan extends StatefulWidget {
  /// 初始化参数
  String? color;
  double? opacity;
  bool? bold;
  bool? italic;
  bool? underline;

  final Function(String? color) onColorChanged;
  final Function(double? opacity) onOpacityChanged;

  final Function(bool? bold) onBold;
  final Function(bool? italic) onItalic;
  final Function(bool? underline) onUnderline;

  FontStylePan({
    super.key,
    required this.onColorChanged,
    required this.onOpacityChanged,
    required this.onBold,
    required this.onItalic,
    required this.onUnderline,
    this.color,
    this.opacity,
    this.bold,
    this.italic,
    this.underline,
  });

  @override
  State<StatefulWidget> createState() => _FontStylePanState();
}

class _FontStylePanState extends State<FontStylePan>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: const Color(0xff19191A).withOpacity(0.1))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 33, bottom: 23),
            child: ColorWidget(
              colorHex: widget.color,
              onSelect: (color) {
                debugPrint('color: $color');
                widget.onColorChanged.call(color);
              },
            ),
          ),
          SliderNormalParameterWidget(
            initValue: widget.opacity ?? 1.0,
            max: 1.0,
            min: 0.0,
            name: '透明',
            onChanged: (double value) {
              widget.onOpacityChanged.call(value);
            },
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: StyleWidget(
              bold: widget.bold,
              italic: widget.italic,
              underline: widget.underline,
              onBold: (bool bold) {
                widget.onBold.call(bold);
              },
              onItalic: (bool italic) {
                widget.onItalic.call(italic);
              },
              onUnderline: (bool underline) {
                widget.onUnderline.call(underline);
              },
            ),
          ))
        ],
      ),
    );
  }
}
