import 'package:flu_editor/widgets/fonts/style/style_widget.dart';
import 'package:flutter/material.dart';

import '../slider_opacity_parameter.dart';
import '../slider_opacity_parameter_2.dart';
import 'color/color_widget.dart';

class FontStylePan extends StatefulWidget {
  /// style 0 粗体 1 斜体 2 下划线
  final Function({Color? color, double? opacity, int style}) onChanged;

  FontStylePan({super.key, required this.onChanged});

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
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 33, bottom: 23),
            child: ColorWidget(
              onSelect: (color) {
                debugPrint('color: $color');
              },
            ),
          ),
          SliderOpacityParameterWidget2(
            value: 1.0,
            onChanged: (double value) {
              debugPrint('opacity: $value');
            },
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: StyleWidget(
              onSelect: (style) {},
            ),
          ))
        ],
      ),
    );
  }
}
