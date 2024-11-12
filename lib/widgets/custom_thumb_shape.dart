import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  Function(double size)? onThumbSizeChange;
  double thumbSize;
  String text; // 要显示在 thumb 上的文字
  Color borderColor; // 边框颜色
  double borderWidth; // 边框宽度

  CustomThumbShape({
    this.onThumbSizeChange,
    required this.thumbSize,
    this.text = '',
    this.borderColor =  const Color(0xff656566),
    this.borderWidth = 1.0, // 默认为 2.0 的边框宽度
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    onThumbSizeChange?.call(thumbSize); // 通过回调返回 thumb 大小
    return Size(thumbSize, thumbSize); // 返回 thumb 的尺寸
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor // 使用自定义的边框颜色
      ..strokeWidth = borderWidth // 使用自定义的边框宽度
      ..style = PaintingStyle.stroke;

    // 画 thumb 圆圈
    context.canvas.drawCircle(center, thumbSize / 2, fillPaint);

    // 画 thumb 的边框
    context.canvas.drawCircle(center, (thumbSize / 2) + (borderWidth / 2), borderPaint);

    // 设置文字样式
    TextSpan span = TextSpan(
      style: const TextStyle(
        fontSize: 9, // 文字大小根据 thumb 大小调整
        color: Color(0xff19191A),
        fontWeight: FontWeight.bold,
      ),
      text: text,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // 布局文字
    tp.layout();

    // 计算文字的绘制位置，确保文字居中在 thumb 中
    Offset textOffset = Offset(
      center.dx - (tp.width / 2),
      center.dy - (tp.height / 2),
    );

    // 绘制文字
    tp.paint(context.canvas, textOffset);
  }
}
