part of 'font_added_bloc.dart';

class FontAddedState extends Equatable {
  @override
  List<Object?> get props => [];
}

///字体
class FontAddedFontState extends FontAddedState {
  final String font;

  FontAddedFontState(this.font);

  @override
  List<Object?> get props => [font];
}

///颜色
class FontAddedColorState extends FontAddedState {
  final Color color;

  FontAddedColorState(this.color);

  @override
  List<Object?> get props => [color];
}

///透明度
class FontAddedOpacityState extends FontAddedState {
  final double opacity;

  FontAddedOpacityState(this.opacity);

  @override
  List<Object?> get props => [opacity];
}

///粗体
class FontAddedBoldState extends FontAddedState {
  final bool bold;

  FontAddedBoldState(this.bold);

  @override
  List<Object?> get props => [bold];
}

///斜体
class FontAddedItalicState extends FontAddedState {
  final bool italic;

  FontAddedItalicState(this.italic);

  @override
  List<Object?> get props => [italic];
}

///下划线
class FontAddedUnderlineState extends FontAddedState {
  final bool underline;

  FontAddedUnderlineState(this.underline);

  @override
  List<Object?> get props => [underline];
}

///下划线
class FontAddedTextalignState extends FontAddedState {
  final TextAlign align;

  FontAddedTextalignState(this.align);

  @override
  List<Object?> get props => [align];
}

///字间距
class FontAddedWorldspaceState extends FontAddedState {
  final double worldSpace;

  FontAddedWorldspaceState(this.worldSpace);

  @override
  List<Object?> get props => [worldSpace];
}

///字间距
class FontAddedLinespaceState extends FontAddedState {
  final double lineSpace;

  FontAddedLinespaceState(this.lineSpace);

  @override
  List<Object?> get props => [lineSpace];
}
