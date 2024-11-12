part of '../../flu_editor.dart';

/// Describes saturation manipulations
class SaturationShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _saturation;

  SaturationShaderConfiguration2(
      {required double saturation,
        required double saturationMin,
        required double saturationMax})
      : _saturation = ShaderRangeNumberParameter(
          'Saturation',
          '程度',
          saturation,
          0,
          min: saturationMin,
          max: saturationMax,
        ),
        super([saturation]);

  /// Updates the [saturation] value.
  ///
  /// The [value] must be in 0.0 and 2.0 range.
  set saturation(double value) {
    _saturation.value = value;
    _saturation.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_saturation];
}
