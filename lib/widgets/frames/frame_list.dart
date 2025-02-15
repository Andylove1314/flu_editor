import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import 'frame_widget.dart';

class FrameList extends StatefulWidget {
  final List<FrameDetail> sts;

  final Function({FrameDetail? item, String? path}) onChanged;
  Function()? onScrollNext;
  Function()? onScrollPre;

  FrameDetail? usingDetail;

  FrameList(
      {super.key,
      required this.sts,
      required this.onChanged,
      this.usingDetail});

  @override
  State<FrameList> createState() => _FrameListState();
}

class _FrameListState extends State<FrameList> {
  int currentIndex = -1;

  @override
  void initState() {
    if (widget.sts.contains(widget.usingDetail)) {
      currentIndex = widget.sts.indexOf(widget.usingDetail!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 170,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          physics: const BouncingScrollPhysics(),
          // 设置为横向滚动
          itemCount: widget.sts.length,
          itemBuilder: (c, i) {
            bool selected = currentIndex == i;
            FrameDetail item = widget.sts[i];
            bool vipFrame = item.isVipFrame;
            Widget child = Stack(
              children: [
                FrameWidget(
                  frameDetail: item,
                  onSelect: (st, path) {
                    if (st == null || currentIndex == i) {
                      return;
                    }
                    widget.onChanged.call(item: item, path: path);
                    setState(() {
                      currentIndex = i;
                    });
                  },
                  // ),
                ),
                if (vipFrame)
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
                  ),
              ],
            );

            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: (item.color != null &&
                          '${item.color}'.isNotEmpty &&
                          '${item.color}' != 'null')
                      ? Color(int.parse(item.color)) // example: 0xffababab
                      : Colors.transparent,
                  border: Border.all(
                      color: selected
                          ? const Color(0xffFF4679)
                          : const Color(0xffF4F4F4),
                      width: 1),
                  borderRadius: BorderRadius.circular(4.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: child,
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 11, crossAxisSpacing: 11),
        ));
  }
}
