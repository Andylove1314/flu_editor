part of 'source_image_bloc.dart';

class SourceImageReady extends Equatable {
  final String afterPath;
  TextureSource? textureSource;

  SourceImageReady(this.afterPath, {this.textureSource});

  @override
  List<Object?> get props => [afterPath, textureSource];
}
