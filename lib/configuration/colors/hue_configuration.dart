part of '../../../flu_editor.dart';

/// Describes hue manipulations
class HueShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _hue;

  HueShaderConfiguration2(
      {required double hue, required double hueMin, required double hueMax})
      : _hue = ShaderRangeNumberParameter(
          'Hue',
          '程度',
          hue,
          0,
          min: hueMin,
          max: hueMax,
        ),
        super([hue]);

  /// 更新 [hue] 值。
  ///
  /// [value] 必须在 -1.0 和 1.0 范围内。
  set hue(double value) {
    _hue.value = value;
    _hue.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_hue];
}
