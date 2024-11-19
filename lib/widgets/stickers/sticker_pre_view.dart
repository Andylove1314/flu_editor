import 'package:flu_editor/blocs/sticker_added_bloc/sticker_added_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_icon.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

import '../slider_aloha_parameter.dart';
import 'sticker_added_widget.dart';

class StikerPreView extends StatefulWidget {
  double stvWidth;
  double stvHeight;
  Widget bgChild;

  double stickerSize;

  String? addStickerPath;
  int addCount;

  Function(LindiController stickerController) onInited;

  StikerPreView(
      {super.key,
      required this.bgChild,
      required this.stvWidth,
      required this.stvHeight,
      required this.stickerSize,
      required this.onInited,
      required this.addStickerPath,
      required this.addCount});

  @override
  State<StatefulWidget> createState() {
    return _StikerViewState();
  }
}

class _StikerViewState extends State<StikerPreView> {
  ///贴纸控制器
  late LindiController _controller;

  /// 当前贴纸
  int currentIndex = -1;
  List<GlobalKey> _stickerKeys = [];
  List<double> _stickerOpacitys = [];

  /// 当前sticker cubit
  StickerAddedCubit? get sticker {
    if (currentIndex == -1) {
      return null;
    }

    BuildContext? con = _stickerKeys[currentIndex].currentContext;
    if (con == null) {
      return null;
    }
    return con.read<StickerAddedCubit>();
  }

  @override
  void didUpdateWidget(covariant StikerPreView oldWidget) {
    if (widget.addCount != oldWidget.addCount) {
      _addSticker(widget.addStickerPath);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    debugPrint('init StikerView');
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
      if (index == currentIndex) {
        return;
      }

      debugPrint(
          "widgets size: ${_controller.widgets.length}, current index: $index");

      if (_controller.deleted) {
        debugPrint(" $currentIndex deleted");
        _stickerKeys.removeAt(currentIndex);
        _stickerOpacitys.removeAt(currentIndex);
      }

      setState(() {
        currentIndex = index;
      });
    });

    widget.onInited.call(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('StikerView build');
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
            child: IndexedStack(
              index: currentIndex,
              children: _stickerOpacitys
                  .map((opacity) => SliderAlphaParameterWidget(
                        value: opacity,
                        onChanged: (double value) {
                          sticker?.updateOpacity(value);
                          _stickerOpacitys[currentIndex] = value;
                        },
                      ))
                  .toList(),
            ),
          )
      ],
    );
  }

  /// add sticker
  void _addSticker(String? path) {
    debugPrint('add sticker');

    /// add sticker key
    GlobalKey newKey = GlobalKey();
    _stickerKeys.add(newKey);
    _stickerOpacitys.add(1.0);
    currentIndex = _stickerKeys.length - 1;

    /// add bloc sticker widget
    _controller.add(SizedBox(
      width: widget.stickerSize,
      height: widget.stickerSize,
      child: BlocProvider(
        create: (BuildContext context) {
          return StickerAddedCubit(
              StickerAddedState(_stickerOpacitys[currentIndex]));
        },
        child: BlocBuilder<StickerAddedCubit, StickerAddedState>(
            builder: (cubit, state) {
          return StickerAddedWidget(
              stickerPath: path ?? '',
              initOpacity: state.opacity,
              stickerKey: newKey);
        }),
      ),
    ));
  }
}
