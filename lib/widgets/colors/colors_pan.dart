import 'package:flu_editor/widgets/colors/color_class_widget.dart';
import 'package:flu_editor/widgets/confirm_bar.dart';
import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import '../../models/action_data.dart';
import '../../utils/constant.dart';

class ColorsPan extends StatefulWidget {
  final Function(ActionData data)? onClick;
  final ColorsMulitConfiguration sourceFiltersConfig;
  final Function()? onEffectSave;

  List<ActionData>? tags;

  ColorsPan({required this.sourceFiltersConfig, this.onClick, this.onEffectSave, this.tags});

  @override
  State<ColorsPan> createState() => _ColorsPanState();
}

class _ColorsPanState extends State<ColorsPan> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((s){
      widget.onClick?.call(colorActions[1]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: 100,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: const Color(0xff19191A).withOpacity(0.1))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: ColorClassWidget(
              initIndex: 1,
              tags: colorActions,
              onClick: (data) {
                widget.onClick?.call(data);
              },
            )),
        ConfirmBar(
          content: const SizedBox(),
          cancel: () {
            Navigator.of(context).pop();
          },
          confirm: () async {
            widget.onEffectSave?.call();
          },
        )
      ],
    );
  }
}
