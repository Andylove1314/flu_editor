import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class ColorWidget extends StatefulWidget {

  const ColorWidget({super.key, required this.onSelect});

  final Function(Color color) onSelect;

  @override
  State<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  int _index = 1;

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
    bool selected = _index == index;
    String colorStr = colorStrs[index];

    if (colorStr.isEmpty) {
      return SizedBox(
        width: 24,
        height: 24,
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _index = 1;
              });
            },
            icon: Image.asset(
              'icon_cancle_color@3x'.imageFontsPng,
              fit: BoxFit.fill,
            )),
      );
    }

    Color color = Color(int.parse(colorStr));

    return GestureDetector(
      onTap: () {
        setState(() {
          _index = index;
        });
        widget.onSelect.call(color);
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
                color: color,
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
