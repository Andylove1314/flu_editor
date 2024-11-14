part of 'frame_bloc.dart';

abstract class FrameSourceImageState extends Equatable {
  final FrameDetail frameDetail;

  const FrameSourceImageState(this.frameDetail);

  @override
  List<Object?> get props => [frameDetail];
}

class FrameSourceImageInitial extends FrameSourceImageState {
  const FrameSourceImageInitial(super.frameDetail);

  @override
  List<Object?> get props => [...super.props];
}

class FrameSourceImageCaching extends FrameSourceImageState {
  FrameSourceImageCaching(
    super.frameDetail,
  );

  @override
  List<Object?> get props => [...super.props];
}

class FrameSourceImageCached extends FrameSourceImageState {
  String path;

  FrameSourceImageCached(super.frameDetail, this.path);

  @override
  List<Object?> get props => [...super.props, path];
}
