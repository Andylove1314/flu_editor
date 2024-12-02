part of '../../../flu_editor.dart';

/// Describes white balance manipulations 白平衡
class WhiteBalanceShaderConfiguration2 extends ShaderConfiguration {
  final NumberParameter _redBalance;
  final NumberParameter _greenBalance;
  final NumberParameter _blueBalance;

  WhiteBalanceShaderConfiguration2({
    required double red,
    required double redMin,
    required double redMax,
    required double green,
    required double greenMin,
    required double greenMax,
    required double blue,
    required double blueMin,
    required double blueMax,
  })  : _redBalance = ShaderRangeNumberParameter(
          'Red',
          EditorLang.current.editor_color_bph_red,
          red,
          0,
          min: redMin,
          max: redMax,
        ),
        _greenBalance = ShaderRangeNumberParameter(
          'Green',
          EditorLang.current.editor_color_bph_green,
          green,
          1,
          min: greenMin,
          max: greenMax,
        ),
        _blueBalance = ShaderRangeNumberParameter(
          'Blue',
          EditorLang.current.editor_color_bph_blue,
          blue,
          2,
          min: blueMin,
          max: blueMax,
        ),
        super([red, green, blue]); // 默认值为1.0，即不调整

  /// Updates the [redBalance] value.
  set redBalance(double value) {
    _redBalance.value = value;
    _redBalance.update(this);
  }

  /// Updates the [greenBalance] value.
  set greenBalance(double value) {
    _greenBalance.value = value;
    _greenBalance.update(this);
  }

  /// Updates the [blueBalance] value.
  set blueBalance(double value) {
    _blueBalance.value = value;
    _blueBalance.update(this);
  }

  @override
  List<ConfigurationParameter> get parameters =>
      [_redBalance, _greenBalance, _blueBalance];
}
