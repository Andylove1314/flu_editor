import 'package:extended_image/extended_image.dart';
import 'package:flu_editor/blocs/sticker_image_bloc/sticker_bloc.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StickerWidget extends StatelessWidget {
  StickDetail stickerDetail;

  Function(StickDetail? item)? onSelect;

  StickerWidget({super.key, required this.stickerDetail, this.onSelect});

  @override
  Widget build(BuildContext context) {
    Widget filterPre = BlocProvider(
      create: (context) => StickerSourceImageCubit(stickerDetail),
      child: BlocBuilder<StickerSourceImageCubit, StickerSourceImageState>(
          builder: (context, state) {
        Widget child = EditorUtil.loadingWidget(context, isLight: false);

        child = ExtendedImage.network(
          stickerDetail.image ?? '',
          fit: BoxFit.contain,
        );

        return SizedBox(
          child: GestureDetector(
            onTap: () {
              StickDetail? current =
                  context.read<StickerSourceImageCubit>().state.stickerDetail;
              debugPrint(current?.image ?? '');
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
