import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../flu_editor.dart';

part 'sticker_state.dart';

class StickerSourceImageCubit extends Cubit<StickerSourceImageState> {
  final ImageCacheManager _imageCacheManager = DefaultCacheManager();

  StickerSourceImageCubit(StickDetail stickDetail)
      : super(StickerSourceImageInitial(stickDetail)) {
    _checkCache(stickDetail);
  }

  @override
  Stream<StickerSourceImageState> get stream => super.stream.doOnListen(() {
        if (state is StickerSourceImageInitial) {}
      });

  /// 缓存sticker
  Future<String> cacheSticker(StickDetail stickDetail) async {
    emit(
      StickerSourceImageCaching(stickDetail),
    );

    FileInfo imgInfo =
        await _imageCacheManager.downloadFile(stickDetail.image ?? '');
    File img = imgInfo.file;

    emit(
      StickerSourceImageCached(
        stickDetail,
        img.path,
      ),
    );
    return img.path;
  }

  Future<void> _checkCache(StickDetail stickDetail) async {
    FileInfo? fileInfo =
        await _imageCacheManager.getFileFromCache('${stickDetail.image}');
    if (fileInfo != null) {
      emit(
        StickerSourceImageCached(
          stickDetail,
          fileInfo.file.path,
        ),
      );
    }
  }
}
