import 'package:flu_editor/widgets/fonts/style/style_widget.dart';
import 'package:flutter/material.dart';

import '../slider_normal_parameter.dart';
import 'color/color_widget.dart';

class FontStylePan extends StatefulWidget {
  /// style 0 粗体 1 斜体 2 下划线
  final Function(Color color) onColorChanged;
  final Function(double opacity) onOpacityChanged;
  final Function(int style) onStyleChanged;

  FontStylePan(
      {super.key,
      required this.onColorChanged,
      required this.onOpacityChanged,
      required this.onStyleChanged});

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
              onSelect: (color) {
                debugPrint('color: $color');
                widget.onColorChanged.call(color);
              },
            ),
          ),
          SliderNormalParameterWidget(
            initValue: 1.0,
            value: 1.0,
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
              onSelect: (style) {
                widget.onStyleChanged.call(style);
              },
            ),
          ))
        ],
      ),
    );
  }
}
