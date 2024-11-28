part of '../../../flu_editor.dart';

/// Describes lookup table manipulations
class SquareLookupTableShaderConfiguration2 extends ShaderConfiguration {
  final RangeNumberParameter _intensity;
  final DataParameter _cubeData;

  DataParameter get lutParamter => _cubeData;

  SquareLookupTableShaderConfiguration2({required double lookup,
    required double lookupMin,
    required double lookupMax})
      : _intensity = ShaderRangeNumberParameter(
    'Intensity',
    EditorLang.current.editor_intensity, // 参数显示名称
    lookup,
    0,
    min: lookupMin,
    max: lookupMax,
  ),
        _cubeData = ShaderTextureParameter('inputTextureCubeData', 'LUT'),
        super([lookup]);

  Future<void> setLutImage(Uint8List value) async {
    _cubeData.data = value;
    _cubeData.asset = null;
    _cubeData.file = null;
    await _cubeData.update(this);
  }

  Future<void> setLutAsset(String value) async {
    _cubeData.data = null;
    _cubeData.asset = value;
    _cubeData.file = null;
    await _cubeData.update(this);
  }

  Future<void> setLutFile(File value) async {
    _cubeData.data = null;
    _cubeData.asset = null;
    _cubeData.file = value;
    await _cubeData.update(this);
  }

  /// Updates the [intensity] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set intensity(double value) {
    _intensity.value = value;
    _intensity.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _cubeData];
}

/// 滤镜和噪点效果的 Shader 配置
class SquareLookupTableNoiseShaderConfiguration extends ShaderConfiguration {
  final NumberParameter _intensity;
  final DataParameter _cubeData;
  final NumberParameter _noiseStrength;

  DataParameter get lutParamter => _cubeData;

  NumberParameter get noiseParamter => _noiseStrength;

  NumberParameter get lutIntensity => _intensity;

  SquareLookupTableNoiseShaderConfiguration({required double lookup,
    required double lookupMin,
    required double lookupMax,
    required double noise,
    required double noiseMin,
    required double noiseMax})
      : _intensity = ShaderRangeNumberParameter(
    'Intensity', // 对应 GLSL 中的滤镜强度
    EditorLang.current.editor_intensity,// 参数显示名称
    lookup, // 初始值
    0, // 参数索引
    min: lookupMin,
    max: lookupMax,
  ),
        _cubeData = ShaderTextureParameter('inputTextureCubeDataL', 'LUT'),
        _noiseStrength = ShaderRangeNumberParameter(
          'Noise', // 对应 GLSL 中的噪点强度
          EditorLang.current.editor_color_zd,
          noise,
          1,
          min: noiseMin,
          max: noiseMax,
        ),
        super([lookup, noise]);

  Future<void> setLutImage(Uint8List value) async {
    _cubeData.data = value;
    _cubeData.asset = null;
    _cubeData.file = null;
    await _cubeData.update(this);
  }

  Future<void> setLutAsset(String value) async {
    _cubeData.data = null;
    _cubeData.asset = value;
    _cubeData.file = null;
    await _cubeData.update(this);
  }

  Future<void> setLutFile(File value) async {
    _cubeData.data = null;
    _cubeData.asset = null;
    _cubeData.file = value;
    await _cubeData.update(this);
  }

  /// 更新滤镜强度
  set intensity(double value) {
    _intensity.value = value;
    _intensity.update(this);
  }

  /// 更新噪点强度
  set noiseStrength(double value) {
    _noiseStrength.value = value;
    _noiseStrength.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_intensity, _cubeData, _noiseStrength];
}

/// Describes HALD lookup table manipulations
class HALDLookupTableShaderConfiguration2 extends ShaderConfiguration {
  final RangeNumberParameter _intensity;
  final DataParameter _cubeData;

  HALDLookupTableShaderConfiguration2({required double lookup,
    required double lookupMin,
    required double lookupMax})
      : _intensity = ShaderRangeNumberParameter(
    'Intensity', // 对应 GLSL 中的滤镜强度
    EditorLang.current.editor_intensity,// 参数显示名称
    lookup,
    0,
    min: lookupMin,
    max: lookupMax,
  ),
        _cubeData = ShaderTextureParameter('inputTextureCubeData', 'HALD LUT'),
        super([lookup]);

  Future<void> setLutImage(Uint8List value) async {
    _cubeData.data = value;
    _cubeData.asset = null;
    _cubeData.file = null;
    await _cubeData.update(this);
  }

  Future<void> setLutAsset(String value) async {
    _cubeData.data = null;
    _cubeData.asset = value;
    _cubeData.file = null;
    await _cubeData.update(this);
  }

  Future<void> setLutFile(File value) async {
    _cubeData.data = null;
    _cubeData.asset = null;
    _cubeData.file = value;
    await _cubeData.update(this);
  }

  /// Updates the [intensity] value.
  ///
  /// The [value] must be in 0.0 and 1.0 range.
  set intensity(double value) {
    _intensity.value = value;
    _intensity.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [_intensity, _cubeData];
}
