import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class ColorWidget extends StatefulWidget {
  String? colorHex;

  ColorWidget({super.key, required this.onSelect, this.colorHex});

  final Function(String colorStr) onSelect;

  @override
  State<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  String _color = colorStrs[1];

  @override
  void initState() {
    _color = widget.colorHex ?? _color;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ColorWidget oldWidget) {
    if (widget.colorHex == null) {
      setState(() {
        _color = colorStrs[1];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: _item,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 15,
        ),
        itemCount: colorStrs.length,
      ),
    );
  }

  Widget _item(BuildContext context, int index) {
    bool selected = _color == colorStrs[index];
    String colorStr = colorStrs[index];

    if (colorStr.isEmpty) {
      return SizedBox(
        width: 24,
        height: 24,
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _color = colorStrs[1];
              });
              widget.onSelect.call(_color);
            },
            icon: Image.asset(
              'icon_cancle_color@3x'.imageFontsPng,
              fit: BoxFit.fill,
            )),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _color = colorStr;
        });
        widget.onSelect.call(colorStr);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                border: index == 1
                    ? Border.all(color: const Color(0xffE1E2E6), width: 2)
                    : null,
                color: Color(int.parse(colorStr)),
                borderRadius: BorderRadius.circular(25)),
          ),
          if (selected)
            index == 1
                ? Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffE1E2E6), width: 2),
                        borderRadius: BorderRadius.circular(12)),
                  )
                : Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        borderRadius: BorderRadius.circular(25)),
                  )
        ],
      ),
    );
  }
}
