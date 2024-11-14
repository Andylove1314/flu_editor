import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

class FrameClassWidget extends StatefulWidget {
  TabController tabController;
  List<FrameData> tags;
  int position;
  bool centerTab;

  FrameClassWidget(
      {super.key,
      this.tags = const [],
      required this.tabController,
      this.position = 0,
      this.centerTab = false});

  @override
  State<StatefulWidget> createState() {
    return _FrameClassWidgetState();
  }
}

class _FrameClassWidgetState extends State<FrameClassWidget> {
  @override
  Widget build(BuildContext context) {

    return TabBar(
      tabAlignment: widget.centerTab ? TabAlignment.center : TabAlignment.start,
      controller: widget.tabController,
      tabs: widget.tags.map((e) {
        bool selected = widget.tags.indexOf(e) == widget.position;
        return Container(
          padding:
              const EdgeInsets.only(left: 13, right: 13, top: 10, bottom: 2),
          child: Column(
            children: [
              Text(
                e.groupName ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: selected
                        ? const Color(0xff19191A)
                        : const Color(0xff969799)),
              ),
              Container(
                height: 2,
                width: 10,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                    color:
                        selected ? const Color(0xff19191A) : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.5)),
              )
            ],
          ),
        );
      }).toList(),
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      onTap: (index) {
        widget.tabController.animateTo(index);
      },
      dividerColor: Colors.transparent,
      indicatorColor: Colors.black,
    );
  }
}
