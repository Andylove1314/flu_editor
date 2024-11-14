import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../flu_editor.dart';

part 'sticker_state.dart';

class StickerSourceImageCubit extends Cubit<StickerSourceImageState> {

  StickerSourceImageCubit(StickDetail stickDetail)
      : super(StickerSourceImageInitial(stickDetail)) {
    loadFiles(stickDetail);
  }

  @override
  Stream<StickerSourceImageState> get stream => super.stream.doOnListen(() {
        if (state is StickerSourceImageInitial) {}
      });

  /// 导入滤镜底图
  Future<void> loadFiles(StickDetail stickDetail) async {
    ImageCacheManager imageCacheManager = DefaultCacheManager();

  }

}
