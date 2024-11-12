part of '../../../flu_editor.dart';

/// 阴影效果的 Shader 配置
class ShadowShaderConfiguration extends ShaderConfiguration {
  final NumberParameter _shadowStrength;

  ShadowShaderConfiguration(
      {required double shadow, required double shadowMin, required double shadowMax})
      : _shadowStrength = ShaderRangeNumberParameter(
          'Shadow', // 对应 GLSL 中的变量名
          '程度', // 参数显示名称
          shadow, // 初始值
          0, // 索引位置（在参数列表中的位置）
          min: shadowMin, // 最小值
          max: shadowMax, // 最大值
        ),
        super([shadow]); // 调用父类构造器时传入初始参数

  /// 更新阴影强度
  set shadowStrength(double value) {
    _shadowStrength.value = value;
    _shadowStrength.update(this); // 更新当前配置
  }

  @override
  List<ConfigurationParameter> get parameters => [_shadowStrength]; // 返回参数列表
}
