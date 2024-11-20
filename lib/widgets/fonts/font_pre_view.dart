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

  String? font;
  Color? color;
  double? opacity;
  bool? bold;
  bool? italic;
  bool? underline;
  TextAlign? textAlign;
  double? worldSpace;
  double? lineSpace;

  Function(LindiController stickerController) onInited;

  FontPreView(
      {super.key,
      required this.bgChild,
      required this.stvWidth,
      required this.stvHeight,
      required this.fontStickerSize,
      required this.onInited,
      this.font = '',
      this.opacity = 1.0,
      this.color = Colors.white,
      this.textAlign = TextAlign.left,
      this.bold = false,
      this.italic = false,
      this.underline = false,
      this.worldSpace = 1.0,
      this.lineSpace = 1.0});

  @override
  State<StatefulWidget> createState() {
    return _FontPreViewState();
  }
}

class _FontPreViewState extends State<FontPreView> {
  ///贴纸控制器
  late LindiController _controller;

  final GlobalKey _stickerKey = GlobalKey();

  /// 当前sticker cubit
  FontAddedCubit? get sticker {
    BuildContext? con = _stickerKey.currentContext;
    if (con == null) {
      return null;
    }
    return con.read<FontAddedCubit>();
  }

  @override
  void didUpdateWidget(covariant FontPreView oldWidget) {
    if (widget.font != oldWidget.font ||
        widget.opacity != oldWidget.opacity ||
        widget.color != oldWidget.color ||
        widget.textAlign != oldWidget.textAlign ||
        widget.bold != oldWidget.bold ||
        widget.italic != oldWidget.italic ||
        widget.underline != oldWidget.underline ||
        widget.worldSpace != oldWidget.worldSpace ||
        widget.lineSpace != oldWidget.lineSpace) {
      _changeSticker();
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
  void _changeSticker() {
    /// add bloc sticker widget
    if (_controller.widgets.isEmpty) {
      debugPrint('add sticker');
      Widget newChild = SizedBox(
        width: widget.fontStickerSize.width,
        height: widget.fontStickerSize.height,
        child: Center(
          child: BlocProvider(
            create: (c) => FontAddedCubit(FontAddedState()),
            child: BlocBuilder<FontAddedCubit, FontAddedState>(
                builder: (c, state) {
                  debugPrint('更新 参数');
              return FontAddedWidget(
                stickerKey: _stickerKey,
                text: '你我当年',
                font: widget.font ?? '',
                opacity: widget.opacity,
                color: widget.color,
                bold: widget.bold,
                italic: widget.italic,
                underline: widget.underline,
                textAlign: widget.textAlign,
                worldSpace: widget.worldSpace,
                lineSpace: widget.lineSpace,
              );
            }),
          ),
        ),
      );
      _controller.add(newChild);
    } else {
      debugPrint('外层修改参数');
      sticker?.updateParam();
    }
  }
}
