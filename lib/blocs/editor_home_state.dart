part of 'edtor_home_cubit.dart';

class EditorHomeState extends Equatable {

  final String afterPath;

  const EditorHomeState(this.afterPath);

  @override
  List<Object?> get props => [afterPath];
}
