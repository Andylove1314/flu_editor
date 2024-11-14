import 'package:flu_editor/widgets/custom_widget.dart';
import 'package:flu_editor/widgets/stickers/sticker_class_widget.dart';
import 'package:flu_editor/widgets/stickers/stickers_list.dart';
import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import '../confirm_bar.dart';
import '../vip_bar.dart';

class StickerPan extends StatefulWidget {
  final List<StickerData> sts;

  StickDetail? usingDetail;

  final Function({StickDetail? item, String? path}) onChanged;

  final Function() onEffectSave;

  StickerPan(
      {super.key,
      required this.sts,
      required this.onChanged,
      required this.onEffectSave,
      this.usingDetail});

  @override
  State<StickerPan> createState() => _StickerPanState();
}

class _StickerPanState extends State<StickerPan>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool vipSticker = false;

  int position = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.sts.length, vsync: this, initialIndex: 0)
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
          subAction: () {
            EditorUtil.vipActionCallback?.call();
          },
        ),
        Container(
          color: Colors.white,
          child: StickerClassWidget(
            position: position,
            tabController: _tabController,
            tags: widget.sts,
          ),
        ),
        Container(
          color: Colors.white,
          height: 160,
          child: TabBarView(
            controller: _tabController,
            children: widget.sts
                .map((item) => StickersList(
                    usingDetail: widget.usingDetail,
                    sts: item.list ?? [],
                    onChanged: ({StickDetail? item, String? path}) {
                      setState(() {
                        vipSticker = item?.isVipSticker ?? false;
                      });
                      widget.onChanged(item: item, path: path);
                    }))
                .toList(),
          ),
        ),
        ConfirmBar(
          content: const Center(
            child: Text(
              '贴纸',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xff646466)),
            ),
          ),
          cancel: () {
            Navigator.of(context).pop();
          },
          confirm: () async {
            if (showVipBg) {
              showVipPop(context, content: '您使用了VIP素材，请在开通会员后保存效果？',onSave: () {
                EditorUtil.vipActionCallback?.call();
              }, onCancel: () {});
              return;
            }
            widget.onEffectSave.call();
          },
        )
      ],
    );
  }
}
