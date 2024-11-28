part of '../../../flu_editor.dart';

/// Describes vignette manipulations with fixed black color
class VignetteShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _centerX;
  final NumberParameter _centerY;
  final NumberParameter _start;
  final NumberParameter _end;

  VignetteShaderConfiguration2({
    required double centerX,
    required double centerY,
    required double start,
    required double end,
    required double xmin,
    required double ymin,
    required double startmin,
    required double endmin,
    required double xmax,
    required double ymax,
    required double startmax,
    required double endmax,
  })  : _centerX = ShaderRangeNumberParameter(
          'CenterX',
          EditorLang.current.editor_color_yying_zy,
          centerX, // 中心点X的默认值
          0,
          min: xmin,
          max: xmax, // 中心点的X轴范围0.0 - 1.0
        ),
        _centerY = ShaderRangeNumberParameter(
          'CenterY',
          EditorLang.current.editor_color_yying_sx,
          centerY, // 中心点Y的默认值
          1,
          min: ymin,
          max: ymax, // 中心点的Y轴范围0.0 - 1.0
        ),
        _start = ShaderRangeNumberParameter(
          'Start',
          EditorLang.current.editor_color_yying_dx,
          start, // 默认开始值
          2,
          min: startmin,
          max: startmax, // 开始值范围
        ),
        _end = ShaderRangeNumberParameter(
          'End',
          EditorLang.current.editor_color_yying_wy,
          end, // 默认结束值
          3,
          min: endmin,
          max: endmax, // 结束值范围
        ),
        super([
          centerX, // centerX
          centerY, // centerY
          start, // start
          end // end
        ]);

  /// Updates the [centerX] value.
  set centerX(double value) {
    _centerX.value = value;
    _centerX.update(this);
  }

  /// Updates the [centerY] value.
  set centerY(double value) {
    _centerY.value = value;
    _centerY.update(this);
  }

  /// Updates the [start] value.
  set start(double value) {
    _start.value = value;
    _start.update(this);
  }

  /// Updates the [end] value.
  set end(double value) {
    _end.value = value;
    _end.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_centerX, _centerY, _start, _end];
}
