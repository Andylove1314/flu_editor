import 'package:flutter/material.dart';

class FrameBgContainerWidget extends StatelessWidget {
  final double frameLeft;
  final double frameTop;
  final double frameRight;
  final double frameBottom;
  final Color bgColor;
  final double containerW;
  final double containerH;

  const FrameBgContainerWidget(
      {super.key,
      required this.frameLeft,
      required this.frameTop,
      required this.frameRight,
      required this.frameBottom,
      required this.containerW,
      required this.containerH,
      this.bgColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HollowClipper(
          left: frameLeft,
          top: frameTop,
          right: frameRight,
          bottom: frameBottom), // 自定义剪裁路径
      child: Container(
        width: containerW,
        height: containerH,
        color: bgColor,
      ),
    );
  }
}

class HollowClipper extends CustomClipper<Path> {
  final double left;
  final double top;
  final double right;
  final double bottom;

  HollowClipper(
      {required this.left,
      required this.top,
      required this.right,
      required this.bottom});

  @override
  Path getClip(Size size) {
    // 定义一个矩形路径
    Path outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 定义一个内部镂空的矩形路径
    Path innerPath = Path()
      ..addRect(
          Rect.fromLTRB(left, top, size.width - right, size.height - bottom));

    // 使用 Path.combine 进行路径的合并，将内部的矩形镂空
    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
