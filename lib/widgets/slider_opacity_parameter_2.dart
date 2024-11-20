import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

import 'custom_thumb_shape.dart';
import 'custom_track_shape.dart';

///透明度调节（100）
class SliderOpacityParameterWidget2 extends StatefulWidget {
  final Function(double value) onChanged;
  final double initValue;
  final double value;
  final int showNumber;

  SliderOpacityParameterWidget2(
      {super.key,
      required this.onChanged,
      this.initValue = 1.0,
      required this.value,
      this.showNumber = 100});

  @override
  State<StatefulWidget> createState() {
    return _SliderOpacityParameterWidgetState();
  }
}

class _SliderOpacityParameterWidgetState
    extends State<SliderOpacityParameterWidget2> {
  final _thumbSize = 22.0;

  var _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '透明',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xff19191A)),
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
                        text: '',
                        borderColor: const Color(0xff19191A),
                        borderWidth: 3),
                    // (_value * (showNumber/1.0)).toStringAsFixed(0)
                    thumbColor: Colors.white,
                    activeTrackColor: const Color(0xff19191A),
                    inactiveTrackColor: const Color(0xff19191A),
                    secondaryActiveTrackColor: const Color(0xff19191A),
                    valueIndicatorTextStyle: const TextStyle(
                        color: Color(0xff656566), // 设置标签的文字颜色
                        fontSize: 12, // 设置文字大小
                        fontWeight: FontWeight.w600),
                    valueIndicatorColor: Colors.white,
                  ),
                  child: Slider(
                    divisions: widget.showNumber,
                    value: _value,
                    max: 1.0,
                    min: 0.0,
                    onChanged: (value) {
                      widget.onChanged.call(value);
                      setState(() {
                        _value = value;
                      });
                    },
                  )))
        ],
      ),
    );
  }
}
