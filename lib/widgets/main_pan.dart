import 'package:flutter/material.dart';

import '../models/action_data.dart';
import '../utils/constant.dart';

class MainPan extends StatefulWidget {
  final Function(ActionData data)? onClick;
  final panHeight;

  const MainPan({this.onClick, required this.panHeight});

  @override
  State<MainPan> createState() => _MainPanState();
}

class _MainPanState extends State<MainPan> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.panHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: const Color(0xff19191A).withOpacity(0.1))
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          scrollDirection: Axis.horizontal,
          // 设置为横向滚动
          itemCount: mainActions.length,
          itemBuilder: _item,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 10,
            );
          },
        ));
  }

  Widget _item(BuildContext context, int index) {
    ActionData data = mainActions[index];
    return IconButton(
        onPressed: () {
          widget.onClick?.call(data);
        },
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              data.icon,
              width: 21,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              data.name,
              style: const TextStyle(
                  color: Color(0xff1E1925),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            )
          ],
        ));
  }
}
