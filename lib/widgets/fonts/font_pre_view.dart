import 'package:flu_editor/blocs/font_added_bloc/font_added_bloc.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_icon.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

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

  /// 当前贴纸key
  late GlobalKey _textKey;

  /// 当前sticker cubit
  FontAddedCubit? get textSticker {
    BuildContext? con = _textKey?.currentContext;
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
    debugPrint('init FontPreView');
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
            icon: Icons.edit,
            alignment: Alignment.topRight,
            onTap: () {
              EditorUtil.showToast('弹出键盘，修改文字');
            }),
        LindiStickerIcon(
            icon: Icons.cached,
            alignment: Alignment.bottomRight,
            type: IconType.resize),
      ],
    );
    _controller.onPositionChange((index) {});

    widget.onInited.call(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('StikerView build');

    return SizedBox(
      width: widget.stvWidth,
      height: widget.stvHeight,
      child: LindiStickerWidget(
        controller: _controller,
        child: widget.bgChild,
      ),
    );
  }

  /// add sticker
  void _addSticker(String? path) {
    /// add bloc sticker widget
    if (_controller.widgets.isEmpty) {
      _textKey = GlobalKey();
      debugPrint('add sticker');
      Widget newChild = SizedBox(
        width: widget.fontStickerSize.width,
        height: widget.fontStickerSize.height,
        child: Center(
          child: BlocProvider(
            create: (BuildContext context) {
              /// 初始化透明度
              double init = 1.0;
              return FontAddedCubit(FontAddedState(init));
            },
            child: BlocBuilder<FontAddedCubit, FontAddedState>(
                builder: (cubit, state) {
              ///slider 调节 透明度
              return FontAddedWidget(
                fontStickerKey: _textKey,
                text: '你我当年',
                font: path ?? '',
                opacity: state.opacity,
              );
            }),
          ),
        ),
      );
      _controller.add(newChild);
    }
  }
}
