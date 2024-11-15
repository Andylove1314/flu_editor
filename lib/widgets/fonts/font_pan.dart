import 'package:flu_editor/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import '../confirm_bar.dart';
import '../vip_bar.dart';
import 'font_class_widget.dart';
import 'font_list.dart';

class FontPan extends StatefulWidget {
  final List<FontsData> fons;

  FontDetail? usingDetail;

  final Function({FontDetail? item, String? path}) onChanged;

  final Function() onEffectSave;

  FontPan(
      {super.key,
      required this.fons,
      required this.onChanged,
      required this.onEffectSave,
      this.usingDetail});

  @override
  State<FontPan> createState() => _FramePanState();
}

class _FramePanState extends State<FontPan>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool vipSticker = false;

  int position = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.fons.length, vsync: this, initialIndex: 0)
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
          child: FontClassWidget(
            position: position,
            tabController: _tabController,
            tags: widget.fons,
          ),
        ),
        Container(
          color: Colors.white,
          height: 180,
          child: TabBarView(
            controller: _tabController,
            children: widget.fons
                .map((item) => FontList(
                    usingDetail: widget.usingDetail,
                fons: item.list ?? [],
                    onChanged: ({FontDetail? item, String? path}) {
                      setState(() {
                        vipSticker = item?.isVipFont ?? false;
                      });
                      widget.onChanged(item: item, path: path);
                    }))
                .toList(),
          ),
        ),
        ConfirmBar(
          content: const Text('字体'),
          cancel: () {
            Navigator.of(context).pop();
          },
          confirm: () async {
            if (showVipBg) {
              showVipPop(context, content: '您使用了VIP素材，请在开通会员后保存效果？',
                  onSave: () {
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
