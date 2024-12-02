import 'package:auto_size_text/auto_size_text.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/generated/l10n.dart';
import 'package:flutter/material.dart';

class VipBar extends StatelessWidget {
  final bool showVipbg;
  final Function() subAction;
  final double barHeight;
  final double borderHeight;

  const VipBar({super.key, this.showVipbg = false, required this.subAction, this.barHeight = 64, this.borderHeight = 21});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (showVipbg)
          Container(
            height: barHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('icon_vip_tip'.imagePng),
                    fit: BoxFit.fill)),
            padding: const EdgeInsets.only(left: 15, right: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: AutoSizeText(
                    EditorLang.of(context).editor_vip_limited_1,
                    maxFontSize: 13,
                    minFontSize: 10,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                )),
                Container(
                  height: 25,
                  margin: const EdgeInsets.only(top: 8),
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 14))),
                      onPressed: () {
                        subAction.call();
                      },
                      child:  Text(
                        EditorLang.of(context).editor_vip_action,
                        style: const TextStyle(
                            color: Color(0xffFF799E),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: borderHeight,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: const Color(0xff19191A).withOpacity(0.1))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
          ),
        )
      ],
    );
  }
}
