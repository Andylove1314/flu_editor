import 'package:extended_image/extended_image.dart';
import 'package:flu_editor/blocs/sticker_image_bloc/sticker_bloc.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/frame_image_bloc/frame_bloc.dart';

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
        ExtendedImage.network(
          frameDetail.image ?? '',
          fit: BoxFit.contain,
        ),
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
}
