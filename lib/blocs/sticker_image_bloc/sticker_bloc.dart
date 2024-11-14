import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

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

    File file = await _imageCacheManager.getSingleFile(stickDetail.image ?? '');
    Uint8List fbyte = (await EditorUtil.fileToUint8ListAndImage(file.path))[1];
    File cached = await _imageCacheManager.putFile(
        '${stickDetail.image}_${stickDetail.id}', fbyte,
        maxAge: const Duration(days: 100));

    emit(
      StickerSourceImageCached(
        stickDetail,
        cached.path,
      ),
    );
    return cached.path;
  }

  Future<void> _checkCache(StickDetail stickDetail) async {
    File file = await _imageCacheManager
        .getSingleFile('${stickDetail.image}_${stickDetail.id}');
    if (file.path.isNotEmpty) {
      emit(
        StickerSourceImageCached(
          stickDetail,
          file.path,
        ),
      );
    }
  }
}
