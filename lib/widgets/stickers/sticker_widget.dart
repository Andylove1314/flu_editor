import 'package:flu_editor/blocs/sticker_image_bloc/sticker_bloc.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../net_image.dart';

class StickerWidget extends StatelessWidget {
  StickDetail stickerDetail;

  Function(StickDetail? item, String? stickerPath)? onSelect;

  StickerWidget({super.key, required this.stickerDetail, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        NetImage(
          url: stickerDetail.image ?? '',
          fit: BoxFit.contain,
        ),
        BlocProvider(
          create: (context) => StickerSourceImageCubit(stickerDetail),
          child: BlocBuilder<StickerSourceImageCubit, StickerSourceImageState>(
              builder: (context, state) {
            Widget icon = Image.asset(
              width: 12,
              'icon_cloud'.imagePng,
              fit: BoxFit.fitWidth,
            );

            if (state is StickerSourceImageCaching) {
              icon = SizedBox(
                width: 12,
                height: 12,
                child:
                    EditorUtil.loadingWidget(context, isLight: false, size: 12),
              );
            } else if (state is StickerSourceImageCached) {
              icon = const SizedBox();
            }

            return GestureDetector(
              onTap: () {
                debugPrint('000000');
                if (state is StickerSourceImageCached) {
                  debugPrint('cached: ${state.path}');
                  onSelect?.call(stickerDetail, state.path);
                } else {
                  context
                      .read<StickerSourceImageCubit>()
                      .cacheSticker(stickerDetail)
                      .then((path) {
                    debugPrint('cached: $path');
                    onSelect?.call(stickerDetail, path);
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
