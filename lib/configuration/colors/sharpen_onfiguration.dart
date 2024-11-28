part of '../../../flu_editor.dart';

/// Describes sharpen manipulations
class SharpenShaderConfiguration extends ShaderConfiguration {
  final NumberParameter _sharpenIntensity;

  SharpenShaderConfiguration(
      {required double sharpen, required double sharpenMin, required double sharpenMax})
      : _sharpenIntensity = ShaderRangeNumberParameter(
          'Sharpen',
          EditorLang.current.editor_intensity,
          sharpen,
          0,
          min: sharpenMin,
          max: sharpenMax, // 锐化强度的范围
        ),
        super([sharpen]);

  /// Updates the [sharpen] value.
  ///
  /// The [value] must be in 0.0 to 2.0 range.
  set sharpen(double value) {
    _sharpenIntensity.value = value;
    _sharpenIntensity.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_sharpenIntensity];
}
