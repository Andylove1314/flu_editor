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

class StickerSourceImageReady extends StickerSourceImageState {

  StickerSourceImageReady(
    super.stickerDetail,
  );

  @override
  List<Object?> get props => [...super.props];
}
