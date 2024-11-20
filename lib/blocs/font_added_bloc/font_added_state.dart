part of 'font_added_bloc.dart';

class FontAddedState extends Equatable {
  final double opacity;

  const FontAddedState(this.opacity);

  @override
  List<Object?> get props => [opacity];
}
