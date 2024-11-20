import 'package:flutter/material.dart';

class FontStylePan extends StatefulWidget {
  /// style 0 粗体 1 斜体 2 下划线
  final Function({Color? color, double? opacity, int style}) onChanged;

  FontStylePan({super.key, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _FontStylePanState();
}

class _FontStylePanState extends State<FontStylePan>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(color: const Color(0xff19191A).withOpacity(0.1))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      height: 200,
      child: const SizedBox(),
    );
  }
}
