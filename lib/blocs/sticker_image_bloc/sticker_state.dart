part of 'sticker_bloc.dart';

abstract class StickerSourceImageState extends Equatable {
  final StickDetail stickerDetail;

  const StickerSourceImageState(this.stickerDetail);

  @override
  List<Object?> get props => [stickerDetail];
}

class StickerSourceImageInitial extends StickerSourceImageState {
  const StickerSourceImageInitial(super.stickerDetail);

  @override
  List<Object?> get props => [...super.props];
}

class StickerSourceImageCaching extends StickerSourceImageState {
  StickerSourceImageCaching(
    super.stickerDetail,
  );

  @override
  List<Object?> get props => [...super.props];
}

class StickerSourceImageCached extends StickerSourceImageState {
  String path;

  StickerSourceImageCached(super.stickerDetail, this.path);

  @override
  List<Object?> get props => [...super.props, path];
}
