part of '../../../flu_editor.dart';

/// Describes highlight manipulations
class HighlightShaderConfiguration extends ShaderConfiguration {
  final NumberParameter _highlightStrength;

  HighlightShaderConfiguration(
      {required double highlight,
        required double highlightMin,
        required double highlightMax})
      : _highlightStrength = ShaderRangeNumberParameter(
          'Highlight',
          EditorLang.current.editor_intensity,
          highlight,
          0,
          min: highlightMin, // 不调整高光
          max: highlightMax, // 增加高光强度
        ),
        super([highlight]);

  /// 更新高光强度
  set highlightStrength(double value) {
    _highlightStrength.value = value;
    _highlightStrength.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_highlightStrength];
}
