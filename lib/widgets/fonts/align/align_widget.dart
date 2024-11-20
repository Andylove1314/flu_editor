import 'package:flu_editor/models/action_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class AlignWidget extends StatefulWidget {
  const AlignWidget({super.key, required this.onSelect});

  final Function(int style) onSelect;

  @override
  State<StatefulWidget> createState() => _AlignWidgetState();
}

class _AlignWidgetState extends State<AlignWidget> {
  ActionData? _currentItem;

  @override
  void initState() {
    _currentItem = fontAlignActions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: fontAlignActions.map((item) => _item(context, item)).toList(),
      ),
    );
  }

  Widget _item(BuildContext context, ActionData item) {
    bool selected = _currentItem == item;

    return GestureDetector(
      onTap: () {
        if (_currentItem == item) {
          return;
        }

        setState(() {
          _currentItem = item;
        });
        widget.onSelect.call(item.type);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            (selected ? item.selectedIcon : item.icon) ?? '',
            fit: BoxFit.fill,
            width: 33,
            height: 33,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            item.name,
            style: const TextStyle(
                color: Color(0xff646466),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
