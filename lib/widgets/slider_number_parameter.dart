import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

import 'custom_thumb_shape.dart';
import 'custom_track_shape.dart';

class SliderNumberParameterWidget extends StatelessWidget {
  final RangeNumberParameter parameter;
  final VoidCallback onChanged;
  final bool showUndoNext;

  final double initValue;

  final int showNumber;

  const SliderNumberParameterWidget(
      {super.key,
      required this.parameter,
      required this.onChanged,
      required this.initValue,
      this.showUndoNext = false,
      this.showNumber = 100});

  final _thumbSize = 22.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            parameter.displayName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(color: Color(0xff656566), blurRadius: 30)]),
          ),
          const SizedBox(
            width: 11,
          ),
          Expanded(
            child: SliderTheme(
                data: SliderThemeData(
                  trackShape: CustomTrackShape(thumbSize: _thumbSize),
                  thumbShape: CustomThumbShape(
                      thumbSize: _thumbSize,
                      text: (parameter.value.toDouble() *
                              (showNumber /
                                  (parameter.max?.toDouble() ??
                                      double.infinity)))
                          .toStringAsFixed(0)),
                  thumbColor: Colors.white,
                  activeTrackColor: Colors.white.withOpacity(0.8),
                  inactiveTrackColor: Colors.white.withOpacity(0.8),
                  secondaryActiveTrackColor: Colors.white.withOpacity(0.8),
                  valueIndicatorTextStyle: const TextStyle(
                    color: Color(0xff656566), // 设置标签的文字颜色
                    fontSize: 12, // 设置文字大小
                    fontWeight: FontWeight.w600
                  ),
                  valueIndicatorColor: Colors.white,
                ),
                child: Slider(
                  divisions: 2 * showNumber,
                  label: (parameter.value.toDouble() *
                      (showNumber /
                          (parameter.max?.toDouble() ??
                              double.infinity))).toStringAsFixed(0),
                  value: parameter.value.toDouble(),
                  max: parameter.max?.toDouble() ?? double.infinity,
                  min: parameter.min?.toDouble() ?? double.minPositive,
                  onChanged: (value) {
                    debugPrint('设置${parameter.name}值：$value');
                    parameter.value = value;
                    onChanged.call();
                  },
                )),
          ),
          showUndoNext
              ? IconButton(
                  onPressed: () {
                    debugPrint('当前${parameter.name}值：${parameter.value}');
                    debugPrint('恢复${parameter.name}初始值：$initValue');
                    parameter.value = initValue;
                    onChanged.call();
                  },
                  icon: Image.asset(
                    'icon_cancel_edit'.imagePng,
                    width: 21,
                  ))
              : const SizedBox(
                  width: 18,
                )
        ],
      ),
    );
  }
}
