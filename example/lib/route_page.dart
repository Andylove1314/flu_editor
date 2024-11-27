import 'dart:io';

import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget {

  String title;
  String? savedPath;
  RoutePage({super.key, required this.title, this.savedPath});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: widget.savedPath != null ? Image.file(File(widget.savedPath ?? '')) : const SizedBox()
      ),
    );
  }
}
