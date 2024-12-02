import 'package:flu_editor/widgets/stickers/sticker_widget.dart';
import 'package:flutter/material.dart';

import '../../flu_editor.dart';

class StickersList extends StatefulWidget {
  final List<StickDetail> sts;

  final Function({StickDetail? item, String? path}) onChanged;
  Function()? onScrollNext;
  Function()? onScrollPre;

  StickDetail? usingDetail;

  StickersList(
      {super.key,
      required this.sts,
      required this.onChanged,
      this.usingDetail});

  @override
  State<StickersList> createState() => _StickersListState();
}

class _StickersListState extends State<StickersList> {
  late ScrollController _scrollController;

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
        height: 160,
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          physics: const BouncingScrollPhysics(),
          // 设置为横向滚动
          itemCount: widget.sts.length,
          itemBuilder: (c, i) {
            StickDetail item = widget.sts[i];
            bool vipSticker = item.isVipSticker;
            Widget child = Stack(
              children: [
                StickerWidget(
                  stickerDetail: item,
                  onSelect: (st, path) {
                    if (st == null) {
                      return;
                    }
                    widget.onChanged.call(item: item, path:path);
                  },
                  // ),
                ),
                if (vipSticker)
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
