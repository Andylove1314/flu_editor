import 'package:flu_editor/widgets/slider_normal_parameter.dart';
import 'package:flutter/material.dart';

import 'align/align_widget.dart';

class FontAlignPan extends StatefulWidget {
  /// algin 0 居左 1 居中 2 居右
  final Function(double worldSpace) onWorldSpaceChanged;
  final Function(double lineSpace) onLineSpaceChanged;
  final Function(int type) onAlignChanged;

  FontAlignPan(
      {super.key,
      required this.onWorldSpaceChanged,
      required this.onLineSpaceChanged,
      required this.onAlignChanged});

  @override
  State<StatefulWidget> createState() => _FontAlginPanState();
}

class _FontAlginPanState extends State<FontAlignPan>
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
            padding: const EdgeInsets.only(top: 33, bottom: 20),
            child: SliderNormalParameterWidget(
              initValue: 0.15,
              max: 0.2,
              min: 0.1,
              value: 0.15,
              name: '字间距',
              onChanged: (double value) {
                debugPrint('worldspace: $value');
                widget.onWorldSpaceChanged.call(value);
              },
            ),
          ),
          SliderNormalParameterWidget(
            initValue: 0.15,
            max: 0.2,
            min: 0.1,
            value: 0.15,
            name: '行间距',
            onChanged: (double value) {
              debugPrint('linespace: $value');
              widget.onLineSpaceChanged.call(value);
            },
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: AlignWidget(
              onSelect: (type) {
                debugPrint('alignttype: $type');
                widget.onAlignChanged.call(type);
              },
            ),
          ))
        ],
      ),
    );
  }
}
