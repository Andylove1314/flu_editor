part of 'font_added_bloc.dart';

// Equatable 是 Flutter 中的一个库，主要用于简化类的相等性比较，特别是在使用 Bloc 等状态管理工具时，帮助你减少样板代码。当你定义一个继承自 Equatable 的类时，它会自动根据你指定的属性进行比较，避免手动编写 == 运算符和 hashCode 方法。
//
// Equatable 的主要作用和优势：
// 简化相等性判断： Equatable 可以根据类的属性自动生成相等性判断逻辑。当你重写 props 属性时，Equatable 会自动为你比较这些属性，判断两个对象是否相等，而不需要手动编写 == 运算符和 hashCode 方法。
//
// 在状态管理中用于避免不必要的重建： 在 Bloc、Cubit 或其他类似的状态管理库中，组件通常会根据状态的变化进行重建。如果新状态与旧状态相同，则不需要触发重建。通过 Equatable，可以确保状态对象在属性不变的情况下被认为是相等的，从而避免不必要的重建和重绘。
//
// 减少样板代码： 在没有 Equatable 的情况下，你需要为每个类重写 == 和 hashCode，这样比较麻烦且容易出错。Equatable 提供了一种更简洁的方式，只需定义哪些属性参与相等性比较即可。

/// todo 移除 Equatable继承，实时修改参数
class FontAddedState {
  final String text;
  String? font;
  String? color;
  double? opacity;
  bool? bold;
  bool? italic;
  bool? underline;
  TextAlign? textAlign;
  double? worldSpace;
  double? lineSpace;

  FontAddedState(this.text,
      {this.font,
      this.color,
      this.opacity,
      this.bold,
      this.italic,
      this.underline,
      this.textAlign,
      this.worldSpace,
      this.lineSpace});

  @override
  List<Object?> get props => [
        text,
        font,
        opacity,
        bold,
        italic,
        underline,
        textAlign,
        worldSpace,
        lineSpace
      ];
}
