import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../flu_editor.dart';

part 'editor_home_state.dart';

class EditorHomeCubit extends Cubit<EditorHomeState> {
  bool saved = false;

  EditorHomeCubit(String orignalPath) : super(EditorHomeState(orignalPath));

  void saveImage() {
    EditorUtil.saveCallback?.call(this.state.afterPath);
    saved = true;
  }

  Future<void> toEditor(BuildContext context, int type) async {
    saved = false;
    if (type == 0) {
      EditorUtil.goCropPage(context, this.state.afterPath);
    } else if (type == 1) {
      EditorUtil.goColorsPage(context, this.state.afterPath);
    } else if (type == 2) {
      if (EditorUtil.filterList.isEmpty) {
        await EditorUtil.fetchFilterList(context);
      }
      EditorUtil.goFilterPage(context, this.state.afterPath);
    } else if (type == 3) {
      // ... todo
    } else if (type == 4) {
      if (EditorUtil.stickerList.isEmpty) {
        await EditorUtil.fetchStickerList(context);
      }
      EditorUtil.goStickerPage(context, this.state.afterPath);
    } else if (type == 5) {
      if (EditorUtil.fontList.isEmpty) {
        await EditorUtil.fetchFontList(context);
      }
    } else if (type == 6) {
      if (EditorUtil.frameList.isEmpty) {
        await EditorUtil.fetchFrameList(context);
      }
    }
  }
}
