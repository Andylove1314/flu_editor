import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/filter_image_bloc/filter_bloc.dart';
import '../../models/lut_data.dart';
import '../net_image.dart';

class FilterWidget extends StatelessWidget {
  FilterDetail filterDetail;

  Function(DataItem? item)? onSelect;

  FilterWidget({super.key, required this.filterDetail, this.onSelect});

  @override
  Widget build(BuildContext context) {
    Widget filterPre = BlocProvider(
      create: (context) => FilterSourceImageCubit(filterDetail),
      child: BlocBuilder<FilterSourceImageCubit, FilterSourceImageState>(
          builder: (context, state) {
        Widget child = EditorUtil.loadingWidget(context, isLight: false);

        if (state is FilterSourceImageReady && state.filterData != null) {
          child = NetImage(
            url: filterDetail.image ?? '',
            isLight: false,
          );
        }

        return SizedBox(
          height: 73,
          width: 60,
          child: GestureDetector(
            onTap: () {
              DataItem? current =
                  context.read<FilterSourceImageCubit>().filterData;
              debugPrint(current?.disPlayName ?? '');
              onSelect?.call(current);
            },
            child: child,
          ),
        );
      }),
    );
    return filterPre;
  }
}
