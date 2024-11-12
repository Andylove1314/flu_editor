import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

class ActionData {
  int type;
  String name;
  String icon;

  /// colors
  String? selectedIcon;
  List<String>? params;

  List<ActionData>? subActions;

  var cropRatio;
  var rotateAngle;

  List<NumberParameter>? configs;

  ActionData(
      {required this.type,
      required this.name,
      required this.icon,
      this.selectedIcon,
      this.params,
      this.subActions,
      this.cropRatio,
      this.rotateAngle});
}
