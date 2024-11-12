import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../flu_editor.dart';

part 'editor_home_state.dart';

class EditorHomeCubit extends Cubit<EditorHomeState> {

  bool saved = false;

  EditorHomeCubit(String orignalPath):
        super(EditorHomeState(orignalPath));

  void saveImage() {
    EditorUtil.saveCallback?.call(this.state.afterPath);
    saved = true;
  }

  void toEditor(BuildContext context, int type) {
    saved = false;
    if (type == 0) {
      EditorUtil.goCropPage(context, this.state.afterPath);
    } else if (type == 1) {
      EditorUtil.goColorsPage(context, this.state.afterPath);
    } else if (type == 2) {
      EditorUtil.goFilterPage(context, this.state.afterPath);
    }else if(type == 3){
      // ... todo
    }
  }
}
