import 'dart:async';
import 'dart:io';

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

  /// 缓存frame, 离线资源不缓存
  Future<String> cacheFrame(FrameDetail frameDetail) async {
    emit(
      FrameSourceImageCaching(frameDetail),
    );

    File img;
    if (frameDetail.imgFrom == 0) {
      img = await EditorUtil.saveAssetToFile(frameDetail.image ?? '');
    } else if (frameDetail.imgFrom == 0) {
      img = File(frameDetail.image ?? '');
    } else {
      FileInfo imgInfo =
          await _imageCacheManager.downloadFile(frameDetail.image ?? '');
      img = imgInfo.file;
    }

    emit(
      FrameSourceImageCached(
        frameDetail,
        img.path,
      ),
    );
    return img.path;
  }

  Future<void> _checkCache(FrameDetail frameDetail) async {
    FileInfo? fileInfo =
        await _imageCacheManager.getFileFromCache('${frameDetail.image}');
    if (fileInfo != null) {
      emit(
        FrameSourceImageCached(
          frameDetail,
          fileInfo.file.path,
        ),
      );
    }
  }
}
