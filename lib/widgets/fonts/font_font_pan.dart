import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import '../vip_bar.dart';
import 'font_class_widget.dart';
import 'font_list.dart';

class FontFontPan extends StatefulWidget {
  FontDetail? fontDetail;

  final Function(
      {FontDetail? item,
      String? ttfPath,
      String? imgPath,
      bool? showVipPop}) onChanged;

  FontFontPan({super.key, required this.onChanged, this.fontDetail});

  @override
  State<StatefulWidget> createState() => _FontFontPanState();
}

class _FontFontPanState extends State<FontFontPan>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool vipSticker = false;

  int position = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: EditorUtil.fontList.length, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          position = _tabController.index;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    bool showVipBg =
        vipSticker && !(EditorUtil.vipStatusCallback?.call() ?? false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VipBar(
          showVipbg: showVipBg,
          barHeight: 50,
          borderHeight: 10,
          subAction: () {
            EditorUtil.vipActionCallback?.call();
          },
        ),
        Container(
          color: Colors.white,
          child: FontClassWidget(
            position: position,
            tabController: _tabController,
            tags: EditorUtil.fontList
                .map((item) => item.groupName ?? '')
                .toList(),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: TabBarView(
              controller: _tabController,
              children: EditorUtil.fontList
                  .map((item) => FontList(
                  fontDetail: widget.fontDetail,
                      fons: item.list ?? [],
                      onChanged: (
                          {FontDetail? item,
                          String? ttfPath,
                          String? imgPath}) {
                        setState(() {
                          vipSticker = item?.isVipFont ?? false;
                        });
                        widget.onChanged(
                            item: item,
                            ttfPath: ttfPath,
                            imgPath: imgPath,
                            showVipPop: showVipBg);
                      }))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
