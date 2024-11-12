part of 'cut_cubit.dart';

abstract class CutState extends Equatable {
  const CutState();

  @override
  List<Object?> get props => [];
}

class CutInitState extends CutState {
  const CutInitState();

  @override
  List<Object?> get props => [...super.props];
}

class CutStatusSliderState extends CutState {
  final bool showSli;
  final bool showfw;

  const CutStatusSliderState(this.showSli, this.showfw);

  @override
  List<Object?> get props => [...super.props, showSli, showfw];
}

class CutImageReadyState extends CutState {
  final img.Image cutImage;
  final Uint8List cutImageByte;

  const CutImageReadyState(this.cutImage, this.cutImageByte);

  @override
  List<Object?> get props => [...super.props, cutImage, cutImageByte];
}
