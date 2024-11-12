import 'package:flutter/material.dart';

class CustomTrackShape extends SliderTrackShape {
  final double activeTrackHeight; // Active track 的高度
  final double inactiveTrackHeight; // Inactive track 的高度
  final double borderWidth; // borderWidth
  final Color borderColor;
  final double thumbSize; // thumbSize

  CustomTrackShape(
      {this.activeTrackHeight = 4.0,
      this.inactiveTrackHeight = 4.0,
      this.borderWidth = 1.0,
      required this.thumbSize,
      this.borderColor = const Color(0xff656566)});

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Paint activePaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.white
      ..style = PaintingStyle.fill;

    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor // 描边颜色
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth; // 设置描边宽度

    // 计算 active track 的矩形
    final Rect activeTrackRect = Rect.fromLTRB(
      0,
      thumbCenter.dy - activeTrackHeight / 2,
      thumbCenter.dx,
      thumbCenter.dy + activeTrackHeight / 2,
    );

    // 计算 inactive track 的矩形
    final Rect inactiveTrackRect = Rect.fromLTRB(
      thumbCenter.dx,
      thumbCenter.dy - inactiveTrackHeight / 2,
      parentBox.size.width,
      thumbCenter.dy + inactiveTrackHeight / 2,
    );

    // 绘制带圆角的 active track 和边框
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          activeTrackRect, Radius.circular(activeTrackHeight)),
      activePaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          activeTrackRect, Radius.circular(activeTrackHeight)),
      borderPaint,
    );

    // 绘制带圆角的 inactive track 和边框
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          inactiveTrackRect, Radius.circular(activeTrackHeight)),
      inactivePaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          inactiveTrackRect, Radius.circular(activeTrackHeight)),
      borderPaint,
    );
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // 根据 Slider 的大小计算出 preferred rect
    return Rect.fromLTRB(
      thumbSize / 2 - 1,
      parentBox.size.height,
      parentBox.size.width - (thumbSize / 2 - 1),
      activeTrackHeight > inactiveTrackHeight
          ? activeTrackHeight
          : inactiveTrackHeight,
    );
  }
}
