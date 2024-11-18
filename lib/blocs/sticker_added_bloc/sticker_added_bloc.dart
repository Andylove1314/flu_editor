import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sticker_added_state.dart';

class StickerAddedCubit extends Cubit<StickerAddedState> {
  StickerAddedCubit(super.initialState);

  void updateOpacity(double value) {
    emit(StickerAddedState(value));
  }
}
