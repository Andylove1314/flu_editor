import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_icon.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

import '../slider_aloha_parameter.dart';

class StikerView extends StatefulWidget {
  double stvWidth;
  double stvHeight;
  Widget bgChild;

  Function(LindiController stickerController) onInited;

  StikerView(
      {super.key,
      required this.bgChild,
      required this.stvWidth,
      required this.stvHeight,
      required this.onInited});

  @override
  State<StatefulWidget> createState() {
    return _StikerViewState();
  }
}

class _StikerViewState extends State<StikerView> {
  late LindiController _controller;

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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SliderAlphaParameterWidget(
            initValue: 1.0,
            onChanged: (double value) {
              debugPrint('alpha = $value');
            },
          ),
        )
      ],
    );
  }
}
