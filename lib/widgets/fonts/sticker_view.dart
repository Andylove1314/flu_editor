import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_icon.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

class StikerView extends StatefulWidget {
  Widget bgChild;

  Function(LindiController stickerController) onInited;

  StikerView({super.key, required this.bgChild, required this.onInited});

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
            icon: Icons.done,
            alignment: Alignment.topRight,
            onTap: () {
              _controller.selectedWidget!.done();
            }),
        LindiStickerIcon(
            icon: Icons.lock_open,
            lockedIcon: Icons.lock,
            alignment: Alignment.topCenter,
            type: IconType.lock,
            onTap: () {
              _controller.selectedWidget!.lock();
            }),
        LindiStickerIcon(
            icon: Icons.close,
            alignment: Alignment.topLeft,
            onTap: () {
              _controller.selectedWidget!.delete();
            }),
        LindiStickerIcon(
            icon: Icons.edit,
            alignment: Alignment.centerLeft,
            onTap: () {
              _controller.selectedWidget!
                  .edit(const Icon(Icons.star, size: 50, color: Colors.yellow));
            }),
        LindiStickerIcon(
            icon: Icons.layers,
            alignment: Alignment.centerRight,
            onTap: () {
              _controller.selectedWidget!.stack();
            }),
        LindiStickerIcon(
            icon: Icons.flip,
            alignment: Alignment.bottomLeft,
            onTap: () {
              _controller.selectedWidget!.flip();
            }),
        LindiStickerIcon(
            icon: Icons.crop_free,
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
    return LindiStickerWidget(
      controller: _controller,
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: widget.bgChild),
    );
  }
}
