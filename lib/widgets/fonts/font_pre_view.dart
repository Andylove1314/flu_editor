
import 'package:flu_editor/blocs/font_added_bloc/font_added_bloc.dart';
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

  String content;

  Function(LindiController stickerController) onInited;

  Function()? onInputContent;

  FontPreView(
      {super.key,
      required this.bgChild,
      required this.stvWidth,
      required this.stvHeight,
      required this.fontStickerSize,
      required this.onInited,
      required this.content,
      this.font = '',
      this.opacity = 1.0,
      this.color = Colors.white,
      this.textAlign = TextAlign.left,
      this.bold = false,
      this.italic = false,
      this.underline = false,
      this.worldSpace = 1.0,
      this.lineSpace = 1.0,
      this.onInputContent});

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
    if (widget.content != oldWidget.content ||
        widget.font != oldWidget.font ||
        widget.opacity != oldWidget.opacity ||
        widget.color != oldWidget.color ||
        widget.textAlign != oldWidget.textAlign ||
        widget.bold != oldWidget.bold ||
        widget.italic != oldWidget.italic ||
        widget.underline != oldWidget.underline ||
        widget.worldSpace != oldWidget.worldSpace ||
        widget.lineSpace != oldWidget.lineSpace) {
      _changeSticker(widget.content ?? '',
          font: widget.font,
          opacity: widget.opacity,
          color: widget.color,
          bold: widget.bold,
          italic: widget.italic,
          underline: widget.underline,
          textAlign: widget.textAlign,
          worldSpace: widget.worldSpace,
          lineSpace: widget.lineSpace);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    debugPrint('init FontPreView');
    _controller = LindiController(
      borderColor: Colors.white,
      insidePadding: 13,
      maxScale: 10,
      minScale: 0.3,
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
              widget.onInputContent?.call();
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
  void _changeSticker(String text,
      {String? font,
      Color? color,
      double? opacity,
      bool? bold,
      bool? italic,
      bool? underline,
      TextAlign? textAlign,
      double? worldSpace,
      double? lineSpace}) {
    /// add bloc sticker widget
    if (_controller.widgets.isEmpty) {
      debugPrint('add sticker');
      Widget newChild = Center(
        child: BlocProvider(
          create: (c) {
            return FontAddedCubit(FontAddedState(
              widget.content,
              font: widget.font ?? '',
              opacity: widget.opacity,
              color: widget.color,
              bold: widget.bold,
              italic: widget.italic,
              underline: widget.underline,
              textAlign: widget.textAlign,
              worldSpace: widget.worldSpace,
              lineSpace: widget.lineSpace,
            ));
          },
          child: BlocBuilder<FontAddedCubit, FontAddedState>(
              builder: (c, state) {
                debugPrint('更新参数');
                return GestureDetector(onTap: (){
                  widget.onInputContent?.call();
                }, child: FontAddedWidget(
                  stickerKey: _stickerKey,
                  text: state.text,
                  font: state.font ?? '',
                  opacity: state.opacity,
                  color: state.color,
                  bold: state.bold,
                  italic: state.italic,
                  underline: state.underline,
                  textAlign: state.textAlign,
                  worldSpace: state.worldSpace,
                  lineSpace: state.lineSpace,
                ),);
              }),
        ),
      );
      _controller.add(newChild);
    } else {
      sticker?.updateParam(text,
          font: font,
          opacity: opacity,
          color: color,
          bold: bold,
          italic: italic,
          underline: underline,
          textAlign: textAlign,
          worldSpace: worldSpace,
          lineSpace: lineSpace);
    }
  }
}
