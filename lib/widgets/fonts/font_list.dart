import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import 'font_widget.dart';

class FontList extends StatefulWidget {
  final List<FontDetail> fons;

  final Function({FontDetail? item, String? path}) onChanged;
  Function()? onScrollNext;
  Function()? onScrollPre;

  FontDetail? usingDetail;

  FontList(
      {super.key,
      required this.fons,
      required this.onChanged,
      this.usingDetail});

  @override
  State<FontList> createState() => _FrameListState();
}

class _FrameListState extends State<FontList> {
  late ScrollController _scrollController;
  int currentIndex = -1;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent + 40) {
        } else if (_scrollController.position.pixels <=
            _scrollController.position.minScrollExtent - 40) {}
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 180,
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          physics: const BouncingScrollPhysics(),
          // 设置为横向滚动
          itemCount: widget.fons.length,
          itemBuilder: (c, i) {
            bool selected = currentIndex == i;
            FontDetail item = widget.fons[i];
            bool vipFont = item.isVipFont;
            Widget child = Stack(
              children: [
                FontWidget(
                  fontDetail: item,
                  onSelect: (st, path) {
                    if (st == null) {
                      return;
                    }
                    widget.onChanged.call(item: item, path: path);
                    setState(() {
                      currentIndex = i;
                    });
                  },
                  // ),
                ),
                if (vipFont)
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
                  border: Border.all(
                      color: selected
                          ? const Color(0xffFF4679)
                          : const Color(0xffF4F4F4),
                      width: 1),
                  borderRadius: BorderRadius.circular(7.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: child,
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (110/53),
              crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 6),
        ));
  }
}
