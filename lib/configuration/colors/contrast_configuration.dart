part of '../../../flu_editor.dart';

/// Describes contrast manipulations
class ContrastShaderConfiguration2 extends ShaderConfiguration {
  final ShaderRangeNumberParameter _contrast;

  ContrastShaderConfiguration2(
      {required double contrast,
        required double contrastMin,
        required double contrastMax})
      : _contrast = ShaderRangeNumberParameter(
          'Contrast',
          EditorLang.current.editor_intensity,
          contrast, // 默认对比度
          0, // GLSL中对比度的location
          min: contrastMin, // 最低对比度
          max: contrastMax, // 最高对比度 (可以根据需求调整)
        ),
        super([contrast]);

  /// Updates the [contrast] value.
  ///
  /// The [value] can range from 0.0 (无对比度) to 4.0 (非常高的对比度).
  set contrast(double value) {
    _contrast.value = value;
    _contrast.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_contrast];
}
