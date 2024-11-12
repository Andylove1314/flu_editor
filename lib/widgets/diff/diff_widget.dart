import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// 图片diff
class FadeBeforeAfter extends StatefulWidget {
  Widget before;
  Widget after;
  double preBordRadius;
  double? diffActionLeft;
  double? diffActionTop;
  double? diffActionRight;
  double? diffActionBottom;
  Color diffBg;
  EdgeInsets contentMargin;
  EdgeInsets actionMargin;

  FadeBeforeAfter(
      {required this.before,
      required this.after,
      this.preBordRadius = 0.0,
      this.diffActionLeft,
      this.diffActionTop,
      this.diffActionRight,
      this.diffActionBottom,
      this.diffBg = Colors.black,
      this.contentMargin = EdgeInsets.zero,
      this.actionMargin = EdgeInsets.zero});

  @override
  State<StatefulWidget> createState() {
    return _FadeBeforeAfterState();
  }
}

class _FadeBeforeAfterState extends State<FadeBeforeAfter>
    with TickerProviderStateMixin {
  late AnimationController fixedLook;

  @override
  void initState() {
    fixedLook = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    fixedLook.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    fixedLook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.preBordRadius)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: <Widget>[
            PhotoView.customChild(
                backgroundDecoration: BoxDecoration(color: widget.diffBg),
                minScale: 1.0,
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: widget.contentMargin,
                      child: widget.before,
                    ),
                    Container(
                      margin: widget.contentMargin,
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                            parent: fixedLook, curve: Curves.linear),
                        child: Container(
                          color: widget.diffBg,
                          alignment: Alignment.center,
                          child: widget.after,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    )
                  ],
                )),

            ///预览按钮
            Positioned(
              left: widget.diffActionLeft,
              top: widget.diffActionTop,
              right: widget.diffActionRight,
              bottom: widget.diffActionBottom,
              child: Container(
                margin: widget.actionMargin,
                child: GestureDetector(
                  child: diffAction(),
                  onTapDown: (down) {
                    setState(() {
                      fixedLook.reverse(from: 1.0);
                    });
                  },
                  onTapUp: (up) {
                    setState(() {
                      fixedLook.forward(from: 0.0);
                    });
                  },
                ),
              ),
            )
          ],
        ));

    return content;
  }

  /// diff 按钮
  Widget diffAction() {
    return Image.asset(
      'icon_diff_edit'.imagePng,
      width: 46,
      height: 46,
      fit: BoxFit.fill,
    );
  }
}
