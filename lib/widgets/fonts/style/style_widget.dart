import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/models/action_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class StyleWidget extends StatefulWidget {
  const StyleWidget(
      {super.key,
      required this.onBold,
      required this.onUnderline,
      required this.onItalic});

  final Function(bool bold) onBold;
  final Function(bool underline) onUnderline;
  final Function(bool italic) onItalic;

  @override
  State<StatefulWidget> createState() => _StyleWidgetState();
}

class _StyleWidgetState extends State<StyleWidget> {
  bool _bold = false;
  bool _underline = false;
  bool _italic = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: fontStyleActions.map((item) => _item(context, item)).toList(),
      ),
    );
  }

  Widget _item(BuildContext context, ActionData item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (item.type == 0) {
            _bold = !_bold;
            widget.onBold(_bold);
          } else if (item.type == 1) {
            _italic = !_italic;
            widget.onItalic(_italic);
          } else if (item.type == 2) {
            _underline = !_underline;
            widget.onUnderline(_underline);
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _icon(
            item,
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

  Widget _icon(ActionData item) {
    if (item.type == 0) {
      return Image.asset(
        (_bold ? item.selectedIcon : item.icon) ?? '',
        fit: BoxFit.fill,
        width: 33,
        height: 33,
      );
    }
    if (item.type == 1) {
      return Image.asset(
        (_italic ? item.selectedIcon : item.icon) ?? '',
        fit: BoxFit.fill,
        width: 33,
        height: 33,
      );
    }
    if (item.type == 2) {
      return Image.asset(
        (_underline ? item.selectedIcon : item.icon) ?? '',
        fit: BoxFit.fill,
        width: 33,
        height: 33,
      );
    }

    return const SizedBox();
  }
}
