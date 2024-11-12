part of '../../../flu_editor.dart';

/// Describes vibrance manipulations 色彩
class VibranceShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _vibrance;

  VibranceShaderConfiguration2(
      {required double vibrance,
        required double vibranceMin,
        required double vibranceMax})
      : _vibrance = ShaderRangeNumberParameter(
          'Vibrance',
          '程度',
          vibrance, // Default value
          0, // Shader location
          min: vibranceMin, // Minimum vibrance value
          max: vibranceMax, // Maximum vibrance value
        ),
        super([vibrance]);

  /// Updates the [vibrance] value.
  set vibrance(double value) {
    _vibrance.value = value;
    _vibrance.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_vibrance];
}
