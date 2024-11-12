import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/widgets/back_pop_widget.dart';
import 'package:flu_editor/widgets/save_tip_pop_widget.dart';
import 'package:flu_editor/widgets/vip_pop_widget.dart';
import 'package:flutter/material.dart';

/// save 按钮
Widget saveAction({Function()? action}) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    child: IconButton(
      onPressed: action,
      icon: Opacity(
        opacity: action == null ? 0.5 : 1.0,
        child: Image.asset(
          'icon_save'.imagePng,
          width: 21,
        ),
      ),
    ),
  );
}

void showSaveEffectPop(BuildContext context, ShaderConfiguration config, TextureSource texture,
    {required Function(bool saveEffect, String name) onSave, required Function() onCancel}) {
  showDialog(
      context: context,
      builder: (c) {
        return Material(
          color: Colors.transparent,
          child: SaveTipPopWidget(
            configuration: config,
            textureSource: texture,
            onSave: onSave,
            onCancel: onCancel,
          ),
        );
      });
}

void showSaveImagePop(BuildContext context,
    {required Function() onSave, required Function() onCancel}) {
  showDialog(
      context: context,
      builder: (c) {
        return Material(
          color: Colors.transparent,
          child: BackTipPopWidget(
            onSave: onSave,
            onCancel: onCancel,
          ),
        );
      });
}

void showVipPop(BuildContext context,
    {required Function() onSave, required Function() onCancel}) {
  showDialog(
      context: context,
      builder: (c) {
        return Material(
          color: Colors.transparent,
          child: VipTipPopWidget(
            onSave: onSave,
            onCancel: onCancel,
          ),
        );
      });
}
