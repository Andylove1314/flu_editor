import 'package:flu_editor/blocs/font_added_bloc/font_added_bloc.dart';
import 'package:flu_editor/blocs/sticker_added_bloc/sticker_added_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_icon.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

import '../slider_aloha_parameter.dart';
import 'font_added_widget.dart';

class FontPreView extends StatefulWidget {
  double stvWidth;
  double stvHeight;
  Widget bgChild;

  Size fontStickerSize;

  String? addFontStickerPath;
  int addCount;

  Function(LindiController stickerController) onInited;

  FontPreView(
      {super.key,
      required this.bgChild,
      required this.stvWidth,
      required this.stvHeight,
      required this.fontStickerSize,
      required this.onInited,
      required this.addFontStickerPath,
      required this.addCount});

  @override
  State<StatefulWidget> createState() {
    return _FontPreViewState();
  }
}

class _FontPreViewState extends State<FontPreView> {
  ///贴纸控制器
  late LindiController _controller;

  /// 当前贴纸
  int currentIndex = -1;
  List<GlobalKey> _fontKeys = [];
  List<double> _fontOpacitys = [];

  /// 当前sticker cubit
  FontAddedCubit? get sticker {
    if (currentIndex == -1) {
      return null;
    }

    BuildContext? con = _fontKeys[currentIndex].currentContext;
    if (con == null) {
      return null;
    }
    return con.read<FontAddedCubit>();
  }

  @override
  void didUpdateWidget(covariant FontPreView oldWidget) {
    if (widget.addCount != oldWidget.addCount) {
      _addSticker(widget.addFontStickerPath);
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
        _fontKeys.removeAt(currentIndex);
        _fontOpacitys.removeAt(currentIndex);
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

    debugPrint("opacitys: ${_fontOpacitys}");
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
              children: _fontOpacitys
                  .map((opacity) => SliderAlphaParameterWidget(
                        value: opacity,
                        onChanged: (double value) {
                          /// 更新sticker opacity
                          sticker?.updateOpacity(value);

                          /// 更新slider opacity
                          _fontOpacitys[currentIndex] = value;
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
    _fontKeys.add(newKey);

    /// add sticker opacity
    double newOpacity = 1.0;
    _fontOpacitys.add(newOpacity);

    /// 新添加的sticker index
    int newIndex = _fontOpacitys.length - 1;

    /// add bloc sticker widget
    Widget newChild = SizedBox(
      width: widget.fontStickerSize.width,
      height: widget.fontStickerSize.height,
      child: BlocProvider(
        create: (BuildContext context) {
          ///初始化 透明度
          double initOpacity = 1.0;
          if (newIndex >= 0 && newIndex < _fontOpacitys.length) {
            initOpacity = _fontOpacitys[newIndex];
          } else {
            newIndex = newIndex - 1;
            initOpacity = _fontOpacitys[newIndex];
          }
          return FontAddedCubit(FontAddedState(initOpacity));
        },
        child: BlocBuilder<FontAddedCubit, FontAddedState>(
            builder: (cubit, state) {
          ///slider 调节 透明度
          return FontAddedWidget(
              fontStickerPath: path ?? '',
              initOpacity: state.opacity,
              fontStickerKey: newKey);
        }),
      ),
    );
    _controller.add(newChild);
  }
}
