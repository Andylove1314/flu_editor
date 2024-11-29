import 'dart:io';

import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/frame_image_bloc/frame_bloc.dart';
import '../net_image.dart';

class FrameWidget extends StatelessWidget {
  FrameDetail frameDetail;

  Function(FrameDetail? item, String? framePath)? onSelect;

  FrameWidget({super.key, required this.frameDetail, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        _fetchSrc(),
        BlocProvider(
          create: (context) => FrameSourceImageCubit(frameDetail),
          child: BlocBuilder<FrameSourceImageCubit, FrameSourceImageState>(
              builder: (context, state) {
            Widget icon = Image.asset(
              width: 12,
              'icon_cloud'.imagePng,
              fit: BoxFit.fitWidth,
            );

            if (state is FrameSourceImageCaching) {
              icon = SizedBox(
                width: 12,
                height: 12,
                child:
                    EditorUtil.loadingWidget(context, isLight: false, size: 12),
              );
            } else if (state is FrameSourceImageCached) {
              icon = const SizedBox();
            }

            return GestureDetector(
              onTap: () {
                debugPrint('000000');
                if (state is FrameSourceImageCached) {
                  debugPrint('cached: ${state.path}');
                  onSelect?.call(frameDetail, state.path);
                } else {
                  context
                      .read<FrameSourceImageCubit>()
                      .cacheFrame(frameDetail)
                      .then((path) {
                    debugPrint('cached: $path');
                    onSelect?.call(frameDetail, path);
                  });
                }
              },
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(bottom: 3, right: 3),
                child: icon,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _fetchSrc() {
    if (frameDetail.imgFrom == 0) {
      return Image.asset(
        frameDetail.image ?? '',
        fit: BoxFit.contain,
      );
    } else if (frameDetail.imgFrom == 1) {
      return Image.file(
        File(frameDetail.image ?? ''),
        fit: BoxFit.contain,
      );
    }
    return NetImage(
      url: frameDetail.image ?? '',
      fit: BoxFit.contain,
    );
  }
}
