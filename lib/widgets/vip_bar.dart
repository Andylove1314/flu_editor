import 'package:auto_size_text/auto_size_text.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

class VipBar extends StatelessWidget {
  final bool showVipbg;
  final Function() subAction;

  const VipBar({super.key, this.showVipbg = false, required this.subAction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (showVipbg)
          Container(
            height: 64,
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
                  child: const AutoSizeText(
                    '会员已到期，开通即可使用专享素材功能',
                    maxFontSize: 13,
                    minFontSize: 10,
                    maxLines: 1,
                    style: TextStyle(
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
                      child: const Text(
                        '购买会员',
                        style: TextStyle(
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
            height: 21,
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
