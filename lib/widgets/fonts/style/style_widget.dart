import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/models/action_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class StyleWidget extends StatefulWidget {
  /// 初始化参数
  bool? bold;
  bool? italic;
  bool? underline;

  StyleWidget(
      {super.key,
      required this.onBold,
      required this.onUnderline,
      required this.onItalic,
      this.bold,
      this.italic,
      this.underline});

  final Function(bool bold) onBold;
  final Function(bool underline) onUnderline;
  final Function(bool italic) onItalic;

  @override
  State<StatefulWidget> createState() => _StyleWidgetState();
}

class _StyleWidgetState extends State<StyleWidget> {
  bool _bold = false;
  bool _italic = false;
  bool _underline = false;

  @override
  void initState() {
    _bold = widget.bold ?? false;
    _italic = widget.italic ?? false;
    _underline = widget.underline ?? false;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StyleWidget oldWidget) {
    if (widget.bold == null) {
      setState(() {
        _bold = false;
      });
    }
    if (widget.italic == null) {
      setState(() {
        _italic = false;
      });
    }
    if (widget.underline == null) {
      setState(() {
        _underline = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

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
