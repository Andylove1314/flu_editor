import 'package:flu_editor/blocs/sticker_added_bloc/sticker_added_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_icon.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

import '../slider_aloha_parameter.dart';

class StikerView extends StatefulWidget {
  double stvWidth;
  double stvHeight;
  Widget bgChild;

  List<GlobalKey> stickerKeys;

  Function(LindiController stickerController) onInited;

  StikerView(
      {super.key,
      required this.bgChild,
      required this.stvWidth,
      required this.stvHeight,
      required this.onInited,
      required this.stickerKeys});

  @override
  State<StatefulWidget> createState() {
    return _StikerViewState();
  }
}

class _StikerViewState extends State<StikerView> {
  late LindiController _controller;

  /// 当前贴纸
  int currentIndex = -1;

  @override
  void initState() {
    _controller = LindiController(
      borderColor: Colors.white,
      icons: [
        LindiStickerIcon(
            icon: Icons.close,
            alignment: Alignment.topLeft,
            onTap: () {
              _controller.selectedWidget!.delete();
            }),
        LindiStickerIcon(
            icon: Icons.flip,
            alignment: Alignment.bottomLeft,
            onTap: () {
              _controller.selectedWidget!.flip();
            }),
        LindiStickerIcon(
            icon: Icons.cached,
            alignment: Alignment.bottomRight,
            type: IconType.resize),
      ],
    );
    _controller.onPositionChange((index) {
      debugPrint(
          "widgets size: ${_controller.widgets.length}, current index: $index");
      setState(() {
        currentIndex = index;
      });
    });
    widget.onInited.call(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: widget.stvWidth,
            height: widget.stvHeight,
            child: LindiStickerWidget(
              controller: _controller,
              child: widget.bgChild,
            ),
          ),
        ),
        if (currentIndex != -1)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SliderAlphaParameterWidget(
              initValue: 1.0,
              onChanged: (double value) {
                setState(() {});
                BuildContext? con =
                    widget.stickerKeys[currentIndex].currentContext;
                if (con == null) {
                  return;
                }
                con.read<StickerAddedCubit>().updateOpacity(value);
              },
            ),
          )
      ],
    );
  }
}
