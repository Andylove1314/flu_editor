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

class _FadeBeforeAfterState extends State<FadeBeforeAfter> {
  int position = 1;

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
                child: IndexedStack(
                  index: position,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: widget.contentMargin,
                      child: widget.before,
                    ),
                    Container(
                      margin: widget.contentMargin,
                      color: widget.diffBg,
                      alignment: Alignment.center,
                      child: widget.after,
                      width: double.infinity,
                      height: double.infinity,
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
                width: 46,
                height: 46,
                alignment: Alignment.center,
                margin: widget.actionMargin,
                child: Listener(
                  onPointerDown: (event) {
                    debugPrint('onPointerDown');
                    setState(() {
                      position = 0;
                    });
                  },
                  onPointerUp: (event) {
                    debugPrint('onPointerUp');
                    setState(() {
                      position = 1;
                    });
                  },
                  child: diffAction(),
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
