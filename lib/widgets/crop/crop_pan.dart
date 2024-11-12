import 'package:flutter/material.dart';

import '../../models/action_data.dart';
import '../colors/color_class_widget.dart';
import '../confirm_bar.dart';
import '../filters/filter_class_widget.dart';

class CropPan extends StatefulWidget {
  final Function(int type, ActionData data)? onClick;
  final Function(ActionData tab)? onTab;
  final Function()? onConfirm;

  final List<ActionData> actionData;

  final int classIndex;

  const CropPan(
      {this.onClick,
      required this.actionData,
      this.onConfirm,
      this.onTab,
      this.classIndex = 0});

  @override
  State<CropPan> createState() => _CropPanState();
}

class _CropPanState extends State<CropPan> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int tabPosition = 0;
  int classPosition = 0;

  @override
  void didUpdateWidget(covariant CropPan oldWidget) {
    if (widget.classIndex != oldWidget.classIndex) {
      setState(() {
        classPosition = widget.classIndex;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    classPosition = widget.classIndex;
    _tabController = TabController(
        length: widget.actionData.length, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          tabPosition = _tabController.index;
        });
        widget.onTab?.call(widget.actionData[tabPosition]);
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
            child: TabBarView(
              controller: _tabController,
              children: widget.actionData
                  .map((item) => ColorClassWidget(
                        showRedpoint: false,
                        centerTab: true,
                        initIndex: item.type == 0 ? classPosition : 0,
                        tags: item.subActions ?? [],
                        onClick: (data) {
                          widget.onClick?.call(item.type, data);
                        },
                      ))
                  .toList(),
            )),
        ConfirmBar(
          content: FilterClassWidget(
            centerTab: true,
            position: tabPosition,
            tabController: _tabController,
            tags: widget.actionData.map((a) => a.name).toList(),
          ),
          cancel: () {
            Navigator.of(context).pop();
          },
          confirm: () {
            widget.onConfirm?.call();
          },
        )
      ],
    );
  }
}
