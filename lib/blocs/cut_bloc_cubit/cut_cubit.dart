import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../flu_editor.dart';

part 'cut_state.dart';

class CutCubit extends Cubit<CutState> {
  CutCubit(String afterPath) : super(const CutInitState()) {
    _fetchCutImage(afterPath);
  }

  bool showSli = false;
  bool showfw = false;

  img.Image? cutImage;
  Uint8List? cutImageByte;

  void showStatus(bool showRs, bool showFw) {
    showSli = showRs;
    showfw = showFw;
    emit(CutStatusSliderState(showRs, showFw));
  }

  Future<void> _fetchCutImage(String afterPath) async {
    List datas = await EditorUtil.fileToUint8ListAndImage(afterPath);
    cutImage = datas[0];
    cutImageByte = datas[1];
    emit(CutImageReadyState(datas[0], datas[1]));
  }
}
