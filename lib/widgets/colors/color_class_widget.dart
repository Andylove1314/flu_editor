import 'package:flu_editor/models/action_data.dart';
import 'package:flu_editor/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

class ColorClassWidget extends StatefulWidget {
  List<ActionData> tags;

  int initIndex;
  bool centerTab;
  bool showRedpoint;

  Function(ActionData action)? onClick;

  ColorClassWidget(
      {super.key,
      this.tags = const [],
      this.onClick,
      this.initIndex = 0,
      this.centerTab = false,
      this.showRedpoint = true});

  @override
  State<StatefulWidget> createState() {
    return _ColorClassWidgetState();
  }
}

class _ColorClassWidgetState extends State<ColorClassWidget>
    with TickerProviderStateMixin {
  late TabController tabController;

  int position = 0;

  @override
  void initState() {
    position = widget.initIndex;
    tabController = TabController(
        length: widget.tags.length, vsync: this, initialIndex: position);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ColorClassWidget oldWidget) {
    if (widget.initIndex != oldWidget.initIndex) {
      setState(() {
        position = widget.initIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: widget.centerTab ? TabAlignment.center : TabAlignment.start,
      controller: tabController,
      tabs: widget.tags.map((e) {
        return _item(context, e, _showEditingFlag(e));
      }).toList(),
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      dividerColor: Colors.transparent,
      indicatorColor: Colors.black,
    );
  }

  Widget _item(BuildContext context, ActionData data, bool showEditing) {
    int index = widget.tags.indexOf(data);
    bool isSelected = position == index;
    return IconButton(
        onPressed: () {
          if (data.selectedIcon != null) {
            setState(() {
              position = index;
            });
          }

          tabController.animateTo(index);
          widget.onClick?.call(widget.tags[index]);
        },
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                isSelected && data.selectedIcon != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 5, right: 5),
                        child: Image.asset(
                          data.selectedIcon ?? '',
                          width: 21,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 5, right: 5),
                        child: Image.asset(
                          data.icon,
                          width: 21,
                        ),
                      ),
                if (showEditing)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6.0)),
                      )),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                data.name,
                style: TextStyle(
                    color: isSelected && data.selectedIcon != null
                        ? const Color(0xffFF799E)
                        : const Color(0xff19191A),
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
            ),
            if (widget.showRedpoint)
              Container(
                width: 4.0,
                height: 4.0,
                margin: const EdgeInsets.only(top: 8, right: 5),
                decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xffFF799E)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0)),
              )
          ],
        ));
  }

  bool _showEditingFlag(ActionData data) {
    bool changed = false;
    List<NumberParameter> paramList = data.configs ?? [];

    for (NumberParameter p in paramList) {
      if (p.value != colorParamInitValues[p.name]) {
        changed = true;
        debugPrint('editing name : ${p.name}');
        break;
      }
    }

    return changed;
  }
}
