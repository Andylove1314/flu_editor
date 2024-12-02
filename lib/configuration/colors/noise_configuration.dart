part of '../../../flu_editor.dart';

/// 噪点效果的 Shader 配置
class NoiseShaderConfiguration extends ShaderConfiguration {
  final NumberParameter _noiseStrength;

  NoiseShaderConfiguration(
      {required double noise, required double noiseMin, required double noiseMax})
      : _noiseStrength = ShaderRangeNumberParameter(
          'Noise', // 对应 GLSL 中的变量名
          EditorLang.current.editor_intensity, // 参数显示名称
          noise, // 初始值
          0, // 参数索引
          min: noiseMin, // 最小值
          max: noiseMax, // 最大值
        ),
        super([noise]); // 传递初始参数值

  /// 更新噪点强度
  set noiseStrength(double value) {
    _noiseStrength.value = value;
    _noiseStrength.update(this); // 更新配置
  }

  @override
  List<ConfigurationParameter> get parameters => [_noiseStrength]; // 返回参数列表
}
