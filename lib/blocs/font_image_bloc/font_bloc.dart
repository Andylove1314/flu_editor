import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../flu_editor.dart';

part 'font_state.dart';

class FontSourceImageCubit extends Cubit<FontSourceImageState> {
  final ImageCacheManager _imageCacheManager = DefaultCacheManager();

  FontSourceImageCubit(FontDetail fontDetail)
      : super(FontSourceImageInitial(fontDetail)) {
    _checkCache(fontDetail);
  }

  @override
  Stream<FontSourceImageState> get stream => super.stream.doOnListen(() {
        if (state is FontSourceImageInitial) {}
      });

  /// 缓存font
  Future<String> cacheFont(FontDetail fontDetail) async {
    emit(
      FontSourceImageCaching(fontDetail),
    );
    FileInfo ttf = await _imageCacheManager.downloadFile(fontDetail.file ?? '',
        key: fontDetail.file ?? '');
    File ttfFile = ttf.file;
    debugPrint('ttf download= ${ttfFile.path}');

    emit(
      FontSourceImageCached(
        fontDetail,
        ttfFile.path,
      ),
    );
    return ttfFile.path;
  }

  Future<void> _checkCache(FontDetail fontDetail) async {
    File file = await _imageCacheManager.getSingleFile('${fontDetail.file}',
        key: fontDetail.file ?? '');
    debugPrint('local ttf = ${file.path}');
    if (file.path.isNotEmpty) {
      emit(
        FontSourceImageCached(
          fontDetail,
          file.path,
        ),
      );
    }
  }
}
