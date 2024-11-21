import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

import 'custom_thumb_shape.dart';
import 'custom_track_shape.dart';

///调节
class SliderNormalParameterWidget extends StatefulWidget {
  final Function(double value) onChanged;
  final double initValue;
  final int showNumber;
  final double max;
  final double min;
  String name;

  SliderNormalParameterWidget(
      {super.key,
      required this.onChanged,
      this.initValue = 1.0,
        required this.max,
      required this.min,
        this.name = '',
      this.showNumber = 100});

  @override
  State<StatefulWidget> createState() {
    return _SliderNormalParameterWidgetState();
  }
}

class _SliderNormalParameterWidgetState
    extends State<SliderNormalParameterWidget> {
  final _thumbSize = 22.0;

  var _value;

  @override
  void initState() {
    _value = widget.initValue;
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
          Text(
            widget.name,
            style: const TextStyle(
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
                        text: (_value * (widget.showNumber/1.0)).toStringAsFixed(0),
                        borderColor: const Color(0xff19191A),
                        borderWidth: 3),
                    // (_value * (widget.showNumber/1.0)).toStringAsFixed(0)
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
                    max: widget.max,
                    min: widget.min,
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
