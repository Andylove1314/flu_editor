import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'font_added_state.dart';

class FontAddedCubit extends Cubit<FontAddedState> {
  FontAddedCubit(super.initialState) {
    debugPrint('FontAddedCubit create');
  }


  void updateParam() {
    debugPrint('updateParam');
    emit(FontAddedState());
  }
}
