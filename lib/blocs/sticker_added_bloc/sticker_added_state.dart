part of 'sticker_added_bloc.dart';

class StickerAddedState extends Equatable {
  final double opacity;

  const StickerAddedState(this.opacity);

  @override
  List<Object?> get props => [opacity];
}
