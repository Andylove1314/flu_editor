part of 'font_bloc.dart';

abstract class FontSourceImageState extends Equatable {
  final FontDetail fontDetail;

  const FontSourceImageState(this.fontDetail);

  @override
  List<Object?> get props => [fontDetail];
}

class FontSourceImageInitial extends FontSourceImageState {
  const FontSourceImageInitial(super.fontDetail);

  @override
  List<Object?> get props => [...super.props];
}

class FontSourceImageCaching extends FontSourceImageState {
  FontSourceImageCaching(
    super.fontDetail,
  );

  @override
  List<Object?> get props => [...super.props];
}

class FontSourceImageCached extends FontSourceImageState {
  String path;

  FontSourceImageCached(super.fontDetail, this.path);

  @override
  List<Object?> get props => [...super.props, path];
}
