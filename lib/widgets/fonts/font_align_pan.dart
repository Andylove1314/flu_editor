import 'package:flu_editor/widgets/slider_normal_parameter.dart';
import 'package:flutter/material.dart';

import 'align/align_widget.dart';

class FontAlignPan extends StatefulWidget {
  /// 初始化参数
  TextAlign? textAlign;
  double? worldSpace;
  double? lineSpace;

  final Function(double? worldSpace) onWorldSpaceChanged;
  final Function(double? lineSpace) onLineSpaceChanged;
  final Function(TextAlign? align) onAlignChanged;

  FontAlignPan(
      {super.key,
      required this.onWorldSpaceChanged,
      required this.onLineSpaceChanged,
      required this.onAlignChanged,
      this.textAlign,
      this.worldSpace,
      this.lineSpace});

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
              initValue: widget.worldSpace ?? 0.0,
              max: 6.0,
              min: 0.0,
              name: '字间距',
              onChanged: (double value) {
                debugPrint('worldspace: $value');
                widget.onWorldSpaceChanged.call(value);
              },
            ),
          ),
          SliderNormalParameterWidget(
            initValue: widget.lineSpace ?? 0.0,
            max: 6.0,
            min: 0.0,
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
              textAlign: widget.textAlign,
              onAlign: (align) {
                debugPrint('alignttype: $align');
                widget.onAlignChanged.call(align);
              },
            ),
          ))
        ],
      ),
    );
  }
}
