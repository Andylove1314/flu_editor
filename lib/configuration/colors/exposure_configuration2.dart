part of '../../../flu_editor.dart';

/// Describes exposure manipulations
class ExposureShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _exposure;

  ExposureShaderConfiguration2(
      {required double exposure,
        required double exposureMin,
        required double exposureMax})
      : _exposure = ShaderRangeNumberParameter(
          'Exposure',
          EditorLang.current.editor_intensity,
          exposure,
          0,
          min: exposureMin,
          max: exposureMax,
        ),
        super([exposure]);

  /// Updates the [exposure] value.
  ///
  /// The [value] must be in -10.0 and 10.0 range.
  set exposure(double value) {
    _exposure.value = value;
    _exposure.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_exposure];
}
