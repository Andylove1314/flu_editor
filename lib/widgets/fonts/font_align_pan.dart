import 'package:flutter/material.dart';

import '../slider_opacity_parameter_2.dart';
import 'align/align_widget.dart';

class FontAlginPan extends StatefulWidget {
  /// algin 0 居左 1 居中 2 居右
  final Function({double? worldSpace, double? lineSpace, int algin}) onChanged;

  FontAlginPan({super.key, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _FontAlginPanState();
}

class _FontAlginPanState extends State<FontAlginPan>
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
            padding: const EdgeInsets.only(top: 33, bottom: 20),
            child: SliderOpacityParameterWidget2(
              value: 1.0,
              onChanged: (double value) {
                debugPrint('worldspace: $value');
              },
            ),
          ),
          SliderOpacityParameterWidget2(
            value: 1.0,
            onChanged: (double value) {
              debugPrint('linespace: $value');
            },
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: AlignWidget(
              onSelect: (style) {},
            ),
          ))
        ],
      ),
    );
  }
}
