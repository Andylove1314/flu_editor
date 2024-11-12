import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../flu_editor.dart';
import '../../models/lut_data.dart';

part 'filter_state.dart';

class FilterSourceImageCubit extends Cubit<FilterSourceImageState> {

  /// 当前滤镜文件
  DataItem? filterData;

  FilterSourceImageCubit(FilterDetail filterDetail)
      : super(FilterSourceImageInitial(filterDetail)) {
    loadFiles(filterDetail);
  }

  @override
  Stream<FilterSourceImageState> get stream => super.stream.doOnListen(() {
        if (state is FilterSourceImageInitial) {}
      });

  /// 导入滤镜底图
  Future<void> loadFiles(FilterDetail filterDetail) async {
    ImageCacheManager imageCacheManager = DefaultCacheManager();

    /// filter
    if (filterDetail.lutFrom == 0) {
      filterData = LutAssetDataItem(filterDetail.filterImage ?? '',
          metadata: LutMetadata(64, 8, 8, 8),
          disPlayName: filterDetail.name ?? '');
    } else if (filterDetail.lutFrom == 1) {
      filterData = LutFileDataItem(File(filterDetail.filterImage ?? ''),
          metadata: LutMetadata(64, 8, 8, 8),
          disPlayName: filterDetail.name ?? '');
    } else {
      File filterCache =
          await imageCacheManager.getSingleFile(filterDetail.filterImage ?? '');

      filterData = LutFileDataItem(filterCache,
          metadata: LutMetadata(64, 8, 8, 8),
          disPlayName: filterDetail.name ?? '');
    }

    emit(
      FilterSourceImageReady(
        filterDetail,
        filterData,
      ),
    );
  }

}
