import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmBar extends StatelessWidget {
  final Widget content;

  Function()? cancel;
  Function()? confirm;

  ConfirmBar({super.key, required this.content, this.cancel, this.confirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 74,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 13),
            color: Color(0xffF2F3F7),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: () {
                      cancel?.call();
                    },
                    icon: Image.asset(
                      'icon_quxiao_edit'.imagePng,
                      width: 21,
                    )),
              ),
              Expanded(child: content),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: () {
                      confirm?.call();
                    },
                    icon: Image.asset(
                      'icon_queren_edit'.imagePng,
                      width: 21,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
