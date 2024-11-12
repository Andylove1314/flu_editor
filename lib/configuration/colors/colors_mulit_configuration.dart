part of '../../../flu_editor.dart';

/// Describes brightness, saturation, contrast, sharpen, shadow, temperature, noise, exposure, vibrance, highlight, white balance, and vignette manipulation
class ColorsMulitConfiguration extends ShaderConfiguration {
  final NumberParameter _brightness;
  final NumberParameter _saturation;
  final NumberParameter _contrast;
  final NumberParameter _sharpen;
  final NumberParameter _shadow;
  final NumberParameter _temperature;
  final NumberParameter _noise;
  final NumberParameter _exposure;
  final NumberParameter _vibrance;
  final NumberParameter _highlight;
  final NumberParameter _redBalance;
  final NumberParameter _greenBalance;
  final NumberParameter _blueBalance;
  final NumberParameter _centerX;
  final NumberParameter _centerY;
  final NumberParameter _start;
  final NumberParameter _end;

  ColorsMulitConfiguration({
    required double brightness,
    required double brightnessMin,
    required double brightnessMax,
    required double saturation,
    required double saturationMin,
    required double saturationMax,
    required double contrast,
    required double contrastMin,
    required double contrastMax,
    required double sharpen,
    required double sharpenMin,
    required double sharpenMax,
    required double shadow,
    required double shadowMin,
    required double shadowMax,
    required double temperature,
    required double temperatureMin,
    required double temperatureMax,
    required double noise,
    required double noiseMin,
    required double noiseMax,
    required double exposure,
    required double exposureMin,
    required double exposureMax,
    required double vibrance,
    required double vibranceMin,
    required double vibranceMax,
    required double highlight,
    required double highlightMin,
    required double highlightMax,
    required double wbRed,
    required double wbRedMin,
    required double wbRedMax,
    required double wbGreen,
    required double wbGreenMin,
    required double wbGreenMax,
    required double wbBlue,
    required double wbBlueMin,
    required double wbBlueMax,
    required double vigX,
    required double vigY,
    required double vigStart,
    required double vigEnd,
    required double vigXMin,
    required double vigYMin,
    required double vigStartMin,
    required double vigEndMin,
    required double vigXMax,
    required double vigYMax,
    required double vigStartMax,
    required double vigEndMax,
  })  : _brightness = ShaderRangeNumberParameter(
          'Brightness',
          '亮度',
          brightness,
          0,
          min: brightnessMin,
          max: brightnessMax,
        ),
        _saturation = ShaderRangeNumberParameter(
          'Saturation',
          '饱和度',
          saturation,
          1,
          min: saturationMin,
          max: saturationMax,
        ),
        _contrast = ShaderRangeNumberParameter(
          'Contrast',
          '对比度',
          contrast,
          2,
          min: contrastMin,
          max: contrastMax,
        ),
        _sharpen = ShaderRangeNumberParameter(
          'Sharpen',
          '锐化',
          sharpen,
          3,
          min: sharpenMin,
          max: sharpenMax,
        ),
        _shadow = ShaderRangeNumberParameter(
          'Shadow',
          '阴影',
          shadow,
          4,
          min: shadowMin,
          max: shadowMax,
        ),
        _temperature = ShaderRangeNumberParameter(
          'Temperature',
          '色温',
          temperature,
          5,
          min: temperatureMin,
          max: temperatureMax,
        ),
        _noise = ShaderRangeNumberParameter(
          'Noise',
          '噪点',
          noise,
          6,
          min: noiseMin,
          max: noiseMax,
        ),
        _exposure = ShaderRangeNumberParameter(
          'Exposure',
          '曝光',
          exposure,
          7,
          min: exposureMin,
          max: exposureMax,
        ),
        _vibrance = ShaderRangeNumberParameter(
          'Vibrance',
          '鲜艳度',
          vibrance,
          8,
          min: vibranceMin,
          max: vibranceMax,
        ),
        _highlight = ShaderRangeNumberParameter(
          'Highlight',
          '高光',
          highlight,
          9,
          min: highlightMin,
          max: highlightMax,
        ),
        _redBalance = ShaderRangeNumberParameter(
          'Red',
          '红色',
          wbRed,
          10,
          min: wbRedMin,
          max: wbRedMax,
        ),
        _greenBalance = ShaderRangeNumberParameter(
          'Green',
          '绿色',
          wbGreen,
          11,
          min: wbGreenMin,
          max: wbGreenMax,
        ),
        _blueBalance = ShaderRangeNumberParameter(
          'Blue',
          '蓝色',
          wbBlue,
          12,
          min: wbBlueMin,
          max: wbBlueMax,
        ),
        _centerX = ShaderRangeNumberParameter(
          'CenterX',
          '左右',
          vigX,
          13,
          min: vigXMin,
          max: vigXMax,
        ),
        _centerY = ShaderRangeNumberParameter(
          'CenterY',
          '上下',
          vigY,
          14,
          min: vigYMin,
          max: vigYMax,
        ),
        _start = ShaderRangeNumberParameter(
          'Start',
          '大小',
          vigStart,
          15,
          min: vigStartMin,
          max: vigStartMax,
        ),
        _end = ShaderRangeNumberParameter(
          'End',
          '外延',
          vigEnd,
          16,
          min: vigEndMin,
          max: vigEndMax,
        ),
        super([
          brightness,
          saturation,
          contrast,
          sharpen,
          shadow,
          temperature,
          noise,
          exposure,
          vibrance,
          highlight,
          wbRed,
          wbGreen,
          wbBlue,
          vigX,
          vigY,
          vigStart,
          vigEnd,
        ]);

  set brightness(double value) {
    _brightness.value = value;
    _brightness.update(this);
  }

  set saturation(double value) {
    _saturation.value = value;
    _saturation.update(this);
  }

  set contrast(double value) {
    _contrast.value = value;
    _contrast.update(this);
  }

  set sharpen(double value) {
    _sharpen.value = value;
    _sharpen.update(this);
  }

  set shadow(double value) {
    _shadow.value = value;
    _shadow.update(this);
  }

  set temperature(double value) {
    _temperature.value = value;
    _temperature.update(this);
  }

  set noise(double value) {
    _noise.value = value;
    _noise.update(this);
  }

  set exposure(double value) {
    _exposure.value = value;
    _exposure.update(this);
  }

  set vibrance(double value) {
    _vibrance.value = value;
    _vibrance.update(this);
  }

  set highlight(double value) {
    _highlight.value = value;
    _highlight.update(this);
  }

  set redBalance(double value) {
    _redBalance.value = value;
    _redBalance.update(this);
  }

  set greenBalance(double value) {
    _greenBalance.value = value;
    _greenBalance.update(this);
  }

  set blueBalance(double value) {
    _blueBalance.value = value;
    _blueBalance.update(this);
  }

  set centerX(double value) {
    _centerX.value = value;
    _centerX.update(this);
  }

  set centerY(double value) {
    _centerY.value = value;
    _centerY.update(this);
  }

  set start(double value) {
    _start.value = value;
    _start.update(this);
  }

  set end(double value) {
    _end.value = value;
    _end.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters => [
        _brightness,
        _saturation,
        _contrast,
        _sharpen,
        _shadow,
        _temperature,
        _noise,
        _exposure,
        _vibrance,
        _highlight,
        _redBalance,
        _greenBalance,
        _blueBalance,
        _centerX,
        _centerY,
        _start,
        _end,
      ];
}
