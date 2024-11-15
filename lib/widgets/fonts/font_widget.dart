import 'package:extended_image/extended_image.dart';
import 'package:flu_editor/blocs/sticker_image_bloc/sticker_bloc.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/font_image_bloc/font_bloc.dart';
import '../../blocs/frame_image_bloc/frame_bloc.dart';

class FontWidget extends StatelessWidget {
  FontDetail fontDetail;

  Function(FontDetail? item, String? framePath)? onSelect;

  FontWidget({super.key, required this.fontDetail, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        ExtendedImage.network(
          fontDetail.image ?? '',
          fit: BoxFit.fill,
        ),
        BlocProvider(
          create: (context) => FontSourceImageCubit(fontDetail),
          child: BlocBuilder<FontSourceImageCubit, FontSourceImageState>(
              builder: (context, state) {
            Widget icon = Image.asset(
              width: 12,
              'icon_cloud'.imagePng,
              fit: BoxFit.fitWidth,
            );

            if (state is FontSourceImageCaching) {
              icon = SizedBox(
                width: 12,
                height: 12,
                child:
                    EditorUtil.loadingWidget(context, isLight: false, size: 12),
              );
            } else if (state is FontSourceImageCached) {
              icon = const SizedBox();
            }

            return GestureDetector(
              onTap: () {
                debugPrint('000000');
                if (state is FontSourceImageCached) {
                  debugPrint('cached: ${state.path}');
                  onSelect?.call(fontDetail, state.path);
                } else {
                  context
                      .read<FontSourceImageCubit>()
                      .cacheFont(fontDetail)
                      .then((path) {
                    debugPrint('cached: $path');
                    onSelect?.call(fontDetail, path);
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
