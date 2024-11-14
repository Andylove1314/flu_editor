import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../flu_editor.dart';

part 'frame_state.dart';

class FrameSourceImageCubit extends Cubit<FrameSourceImageState> {
  final ImageCacheManager _imageCacheManager = DefaultCacheManager();

  FrameSourceImageCubit(FrameDetail frameDetail)
      : super(FrameSourceImageInitial(frameDetail)) {
    _checkCache(frameDetail);
  }

  @override
  Stream<FrameSourceImageState> get stream => super.stream.doOnListen(() {
        if (state is FrameSourceImageInitial) {}
      });

  /// 缓存frame
  Future<String> cacheFrame(FrameDetail stickDetail) async {
    emit(
      FrameSourceImageCaching(stickDetail),
    );

    File file = await _imageCacheManager.getSingleFile(stickDetail.image ?? '');
    Uint8List fbyte = (await EditorUtil.fileToUint8ListAndImage(file.path))[1];
    File cached = await _imageCacheManager.putFile(
        '${stickDetail.image}_${stickDetail.id}', fbyte,
        maxAge: const Duration(days: 100));

    emit(
      FrameSourceImageCached(
        stickDetail,
        cached.path,
      ),
    );
    return cached.path;
  }

  Future<void> _checkCache(FrameDetail frameDetail) async {
    File file = await _imageCacheManager
        .getSingleFile('${frameDetail.image}_${frameDetail.id}');
    if (file.path.isNotEmpty) {
      emit(
        FrameSourceImageCached(
          frameDetail,
          file.path,
        ),
      );
    }
  }
}
