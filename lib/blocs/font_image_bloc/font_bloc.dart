import 'dart:async';
import 'dart:io';
import 'package:crypto/crypto.dart'; // 用于计算文件的哈希值
import 'dart:convert';

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
    String cacheKey = _generateMd5(fontDetail.file ?? '');
    FileInfo ttf = await _imageCacheManager.downloadFile(fontDetail.file ?? '',
        key: cacheKey);
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
    String cacheKey = _generateMd5(fontDetail.file ?? '');
    FileInfo? fileInfo = await _imageCacheManager.getFileFromCache(cacheKey);
    String path = fileInfo?.file.path ?? '';
    debugPrint('local ttf = $path');
    if (path.isNotEmpty) {
      debugPrint('$path alreay cached');
      emit(
        FontSourceImageCached(
          fontDetail,
          path,
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

  // 生成文件的 MD5 哈希值
  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
