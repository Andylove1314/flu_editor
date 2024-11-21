import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'font_added_state.dart';

class FontAddedCubit extends Cubit<FontAddedState> {
  FontAddedCubit(super.initialState) {
    debugPrint('FontAddedCubit create');
  }

  void updateParam(String text,
      {String? font,
      Color? color,
      double? opacity,
      bool? bold,
      bool? italic,
      bool? underline,
      TextAlign? textAlign,
      double? worldSpace,
      double? lineSpace}) {
    debugPrint('updateParam $color');
    emit(FontAddedState(text,
        font: font,
        opacity: opacity,
        color: color,
        bold: bold,
        italic: italic,
        underline: underline,
        textAlign: textAlign,
        worldSpace: worldSpace,
        lineSpace: lineSpace));
  }
}
