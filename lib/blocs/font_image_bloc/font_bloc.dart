import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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
        key: EditorUtil.generateMd5(fontDetail.file ?? ''));
    File ttfFile = ttf.file;
    debugPrint('ttf download= ${ttfFile.path}');

    await _loadFont(ttfFile.path);

    emit(
      FontSourceImageCached(
        fontDetail,
        ttfFile.path,
      ),
    );
    return ttfFile.path;
  }

  Future<void> _checkCache(FontDetail fontDetail) async {
    debugPrint('online ttf = ${fontDetail.file}');
    FileInfo? fileInfo = await _imageCacheManager
        .getFileFromCache(EditorUtil.generateMd5(fontDetail.file ?? ''));
    debugPrint('local ttf = $fileInfo');
    if (fileInfo != null) {
      debugPrint('${fileInfo.file.path} already cached');
      _loadFont(fileInfo.file.path);
      emit(
        FontSourceImageCached(
          fontDetail,
          fileInfo.file.path,
        ),
      );
    }
  }

  /// 加载字体
  Future<void> _loadFont(String path) async {
    FontLoader fontLoader = FontLoader(path);
    fontLoader.addFont(_getFileByteData(path));
    await fontLoader.load();
  }

  // 从文件获取 ByteData
  Future<ByteData> _getFileByteData(String path) async {
    final bytes = await File(path).readAsBytes();
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }
}
