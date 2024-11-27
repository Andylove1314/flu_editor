import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

import '../net_image.dart';

class StickerClassWidget extends StatefulWidget {
  TabController tabController;
  List<StickerData> tags;
  int position;
  bool centerTab;

  StickerClassWidget(
      {super.key,
      this.tags = const [],
      required this.tabController,
      this.position = 0,
      this.centerTab = false});

  @override
  State<StatefulWidget> createState() {
    return _StickerClassWidgetState();
  }
}

class _StickerClassWidgetState extends State<StickerClassWidget> {
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
              Stack(children: [
                NetImage(
                  url: e.groupImage ?? '',
                  fit: BoxFit.contain,
                  width: 33,
                ),
                if (e.isVipGroup)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(4)),
                      child: Image.asset(
                        'icon_vip_lvjing'.imagePng,
                        width: 21,
                      ),
                    ),
                  )
              ],),
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
