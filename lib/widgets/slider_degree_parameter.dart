import 'package:flutter/material.dart';

import 'custom_thumb_shape.dart';
import 'custom_track_shape.dart';

///角度调节（+-45°）
class SliderDegreeParameterWidget extends StatefulWidget {
  double degree;
  final Function(double value) onChanged;
  final int showNumber;

  SliderDegreeParameterWidget(
      {super.key, required this.degree, required this.onChanged, this.showNumber = 90});

  @override
  State<StatefulWidget> createState() {
    return _SliderDegreeParameterWidgetState();
  }
}

class _SliderDegreeParameterWidgetState
    extends State<SliderDegreeParameterWidget> {
  final _thumbSize = 22.0;

  var _value;

  @override
  void initState() {
    _value = widget.degree;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SliderDegreeParameterWidget oldWidget) {
    if (widget.degree != oldWidget.degree) {
      setState(() {
        _value = widget.degree;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: SliderTheme(
          data: SliderThemeData(
            trackShape: CustomTrackShape(thumbSize: _thumbSize),
            thumbShape: CustomThumbShape(
                thumbSize: _thumbSize, text: '${_value.toStringAsFixed(0)}°'),
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
            divisions: widget.showNumber,
            label: '${_value.toStringAsFixed(0)}°',
            value: _value,
            max: 45.0,
            min: -45.0,
            onChanged: (value) {
              widget.onChanged.call(value);
              setState(() {
                _value = value;
              });
            },
          )),
    );
  }
}
