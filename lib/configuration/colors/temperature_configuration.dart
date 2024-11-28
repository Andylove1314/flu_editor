part of '../../../flu_editor.dart';

/// Describes color temperature manipulations
class TemperatureShaderConfiguration extends ShaderConfiguration {
  final NumberParameter _temperature;

  TemperatureShaderConfiguration(
      {required double temperature,
        required double temperatureMin,
        required double temperatureMax})
      : _temperature = ShaderRangeNumberParameter(
          'Temperature',
          EditorLang.current.editor_intensity,
          temperature,
          0,
          min: temperatureMin, // 色温降低（蓝色增强）
          max: temperatureMax, // 色温升高（红黄色增强）
        ),
        super([temperature]);

  /// Updates the [temperature] value.
  ///
  /// The [value] must be in -1.0 to 1.0 range.
  set temperature(double value) {
    _temperature.value = value;
    _temperature.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_temperature];
}
