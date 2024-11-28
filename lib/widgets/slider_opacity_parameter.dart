import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import 'custom_thumb_shape.dart';
import 'custom_track_shape.dart';

///透明度调节（100）
class SliderOpacityParameterWidget extends StatefulWidget {
  final Function(double value) onChanged;
  final double initValue;
  final double value;
  final int showNumber;

  SliderOpacityParameterWidget(
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
    extends State<SliderOpacityParameterWidget> {
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
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
             EditorLang.current.editor_text_style_alpha_2,
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
                    thumbShape:
                        CustomThumbShape(thumbSize: _thumbSize, text: ''),
                    // (_value * (showNumber/1.0)).toStringAsFixed(0)
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.white.withOpacity(0.8),
                    inactiveTrackColor: Colors.white.withOpacity(0.8),
                    secondaryActiveTrackColor: Colors.white.withOpacity(0.8),
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
                  ))),
          IconButton(
              onPressed: () {
                setState(() {
                  _value = widget.initValue;
                });
                widget.onChanged.call(_value);
              },
              icon: Image.asset(
                'icon_cancel_edit'.imagePng,
                width: 21,
              ))
        ],
      ),
    );
  }
}
