part of '../../../flu_editor.dart';

/// Describes brightness manipulations
class BrightnessShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _brightness;

  BrightnessShaderConfiguration2(
      {required double brightness,
        required double brightnessMin,
        required double brightnessMax})
      : _brightness = ShaderRangeNumberParameter(
          'Brightness',
          EditorLang.current.editor_intensity,
          brightness,
          0,
          min: brightnessMin,
          max: brightnessMax,
        ),
        super([brightness]);

  /// Updates the [brightness] value.
  ///
  /// The [value] must be in -1.0 and 1.0 range.
  set brightness(double value) {
    _brightness.value = value;
    _brightness.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_brightness];
}
