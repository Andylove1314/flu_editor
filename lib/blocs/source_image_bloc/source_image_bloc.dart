import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'source_image_state.dart';

class SourceImageCubit extends Cubit<SourceImageReady> {
  SourceImageCubit(String afterPath) : super(SourceImageReady(afterPath)) {
    _loadSourceImage(afterPath);
  }

  Future<void> _loadSourceImage(String afterPath) async {
    Uint8List fbyte = await EditorUtil.loadSourceImage(afterPath);
    final texture = await TextureSource.fromMemory(fbyte);
    emit(
      SourceImageReady(
        afterPath,
        textureSource: texture,
      ),
    );
  }
}
