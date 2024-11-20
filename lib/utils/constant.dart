import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/models/effect_data.dart';
import 'package:flutter/cupertino.dart';

import '../models/action_data.dart';

typedef VipStatusCallback = bool Function();
typedef VipActionCallback = void Function();
typedef SaveCallback = void Function(String tmpPath);
typedef LoadingWidgetCallback = Widget Function(bool isLight, double size, double stroke);
typedef ToastActionCallback = void Function(String msg);
typedef SaveEffectCallback = Future<bool> Function(EffectData effect);
typedef DeleteEffectCallback = Future<bool> Function(dynamic effectId);
typedef EffectsCallback = Future<List<EffectData>> Function(int page);
typedef FiltersCallback = Future<List<FilterData>> Function();
typedef StickersCallback = Future<List<StickerData>> Function();
typedef FontsCallback = Future<List<FontsData>> Function();
typedef FramesCallback = Future<List<FrameData>> Function();
typedef CloseEditorCallback = void Function(String lastImage);

final mainActions = [
  ActionData(type: 0, name: '裁剪', icon: 'icon_caijian_edit@3x'.imagePng),
  ActionData(type: 1, name: '颜色', icon: 'icon_color_edit@3x'.imagePng),
  ActionData(type: 2, name: '滤镜', icon: 'icon_lut_edit@3x'.imagePng),
  // ActionData(type: 3, name: '模糊', icon: 'icon_blur_edit@3x'.imagePng),
  ActionData(type: 4, name: '贴纸', icon: 'icon_tiezhi_edit@3x'.imagePng),
  ActionData(type: 5, name: '文字', icon: 'icon_word_edit@3x'.imagePng),
  ActionData(type: 6, name: '边框', icon: 'icon_biankuang_edit@3x'.imagePng)
];

final Map<String, double> filterParamInitValues = {
  'Intensity': 1.0, // 滤镜初始化强度
  'Noise': 0.0, // 噪声初始化强度
};

final Map<String, double> filterParamMinValues = {
  'IntensityMin': 0.0, // 滤镜最小强度
  'NoiseMin': 0.0, // 噪声最小强度
};

final Map<String, double> filterParamMaxValues = {
  'IntensityMax': 1.0, // 滤镜最大强度
  'NoiseMax': 0.2, // 噪声最大强度
};

final colorActions = [
  ActionData(
      type: 0,
      name: '配方',
      icon: 'icon_pf_n'.imageColorsPng,
      selectedIcon: 'icon_pf_s'.imageColorsPng),
  ActionData(
      type: 1,
      name: '亮度',
      icon: 'icon_ld_n'.imageColorsPng,
      selectedIcon: 'icon_ld_s'.imageColorsPng,
      params: ['Brightness']),
  ActionData(
      type: 2,
      name: '饱和度',
      icon: 'icon_bhd_n'.imageColorsPng,
      selectedIcon: 'icon_bhd_s'.imageColorsPng,
      params: ['Saturation']),
  ActionData(
      type: 3,
      name: '对比度',
      icon: 'icon_dbd_n'.imageColorsPng,
      selectedIcon: 'icon_dbd_s'.imageColorsPng,
      params: ['Contrast']),
  ActionData(
      type: 4,
      name: '高光',
      icon: 'icon_gg_n'.imageColorsPng,
      selectedIcon: 'icon_gg_s'.imageColorsPng,
      params: ['Highlight']),
  ActionData(
      type: 5,
      name: '阴影',
      icon: 'icon_yy_n'.imageColorsPng,
      selectedIcon: 'icon_yy_s'.imageColorsPng,
      params: ['Shadow']),
  // ActionData(
  //     type: 6,
  //     name: '色调',
  //     icon: 'icon_sd_n'.imageColorsPng,
  //     selectedIcon: 'icon_sd_s'.imageColorsPng,
  //     params: ['Hue']),
  ActionData(
      type: 6,
      name: '色温',
      icon: 'icon_sw_n'.imageColorsPng,
      selectedIcon: 'icon_sw_s'.imageColorsPng,
      params: ['Temperature']),
  ActionData(
      type: 7,
      name: '晕影',
      icon: 'icon_yuny_n'.imageColorsPng,
      selectedIcon: 'icon_yuny_s'.imageColorsPng,
      params: ['Start']), //'CenterX', 'CenterY', ｜ 'End'
  ActionData(
      type: 8,
      name: '锐化',
      icon: 'icon_rh_n'.imageColorsPng,
      selectedIcon: 'icon_rh_s'.imageColorsPng,
      params: ['Sharpen']),
  ActionData(
      type: 9,
      name: '噪点',
      icon: 'icon_zd_n'.imageColorsPng,
      selectedIcon: 'icon_zd_s'.imageColorsPng,
      params: ['Noise']),
  ActionData(
      type: 10,
      name: '鲜艳度',
      icon: 'icon_xyd_n'.imageColorsPng,
      selectedIcon: 'icon_xyd_s'.imageColorsPng,
      params: ['Vibrance']),
  ActionData(
      type: 11,
      name: '白平衡',
      icon: 'icon_bph_n'.imageColorsPng,
      selectedIcon: 'icon_bph_s'.imageColorsPng,
      params: ['Red', 'Green', 'Blue']),
  ActionData(
      type: 12,
      name: '曝光',
      icon: 'icon_bgd_n'.imageColorsPng,
      selectedIcon: 'icon_bgd_s'.imageColorsPng,
      params: ['Exposure'])
];

/// colors 参数初始值
final Map<String, double> colorParamInitValues = {
  'Brightness': 0.0, // 亮度初始值，控制图像整体的亮度
  'Saturation': 1.0, // 饱和度初始值，控制颜色的浓度
  'Contrast': 1.0, // 对比度初始值，调整图像的明暗对比
  'Sharpen': 0.0, // 锐化初始值，增强图像的细节边缘
  'Shadow': 0.0, // 阴影初始值，控制图像中阴影区域的细节
  'Temperature': 0.0, // 色温初始值，控制图像的色调
  'Noise': 0.0, // 噪点初始值，增加图像中的颗粒感
  'Exposure': 0.0, // 曝光度初始值，用于调整图像的亮度
  'Vibrance': 0.0, // 鲜艳度初始值，控制颜色的鲜艳程度
  'Highlight': 0.0, // 高光初始值，控制图像中亮部的处理
  'Red': 1.0, // 白平衡中红色通道的初始值
  'Green': 1.0, // 白平衡中绿色通道的初始值
  'Blue': 1.0, // 白平衡中蓝色通道的初始值
  'CenterX': 0.5, // 暗角中心X轴位置初始值
  'CenterY': 0.5, // 暗角中心Y轴位置初始值
  'Start': 0.0, // 暗角渐变起始位置初始值
  'End': 1.0, // 暗角渐变结束位置初始值
  // 'Hue': 0.0 // 色调初始值，调整图像的整体色调
};

/// colors 参数最小值
final Map<String, double> colorParamMinValues = {
  'BrightnessMin': -0.23, // 亮度最小值，控制图像整体的亮度
  'SaturationMin': 0.0, // 饱和度最小值，控制颜色的浓度
  'ContrastMin': 0.7, // 对比度最小值，调整图像的明暗对比
  'SharpenMin': 0.0, // 锐化最小值，增强图像的细节边缘
  'ShadowMin': 0.0, // 阴影最小值，控制图像中阴影区域的细节
  'TemperatureMin': -0.5, // 色温最小值，控制图像的色调
  'NoiseMin': 0.0, // 噪点最小值，增加图像中的颗粒感
  'ExposureMin': -0.4, // 曝光度最小值，用于调整图像的亮度
  'VibranceMin': -0.5, // 鲜艳度最小值，控制颜色的鲜艳程度
  /// 使用亮度参数-0.15 todo
  'HighlightMin': -0.15, // 高光最小值，控制图像中亮部的处理
  'RedMin': 0.5, // 白平衡中红色通道的最小值
  'GreenMin': 0.5, // 白平衡中绿色通道的最小值
  'BlueMin': 0.5, // 白平衡中蓝色通道的最小值
  'CenterXMin': 0.0, // 暗角中心X轴位置最小值
  'CenterYMin': 0.0, // 暗角中心Y轴位置最小值
  'StartMin': 0.0, // 暗角渐变起始位置最小值
  'EndMin': 0.0, // 暗角渐变结束位置最小值
  // 'HueMin': 0.0 // 色调最小值，调整图像的整体色调
};

/// colors 参数最大值
final Map<String, double> colorParamMaxValues = {
  'BrightnessMax': 0.23, // 亮度最大值，控制图像整体的亮度
  'SaturationMax': 2.0, // 饱和度最大值，控制颜色的浓度
  'ContrastMax': 1.4, // 对比度最大值，调整图像的明暗对比
  'SharpenMax': 0.5, // 锐化最大值，增强图像的细节边缘
  'ShadowMax': 1.0, // 阴影最大值，控制图像中阴影区域的细节
  'TemperatureMax': 0.5, // 色温最大值，控制图像的色调
  'NoiseMax': 0.1, // 噪点最大值，增加图像中的颗粒感
  'ExposureMax': 1.0, // 曝光度最大值，用于调整图像的亮度
  'VibranceMax': 0.5, // 鲜艳度最大值，控制颜色的鲜艳程度
  /// 使用亮度参数0.15 todo
  'HighlightMax': 0.15, // 高光最大值，控制图像中亮部的处理
  'RedMax': 1.5, // 白平衡中红色通道的最大值
  'GreenMax': 1.5, // 白平衡中绿色通道的最大值
  'BlueMax': 1.5, // 白平衡中蓝色通道的最大值
  'CenterXMax': 1.0, // 暗角中心X轴位置最大值
  'CenterYMax': 1.0, // 暗角中心Y轴位置最大值
  'StartMax': 1.0, // 暗角渐变起始位置最大值
  'EndMax': 1.0, // 暗角渐变结束位置最大值
  // 'HueMax': 1.0 // 色调初最大值，调整图像的整体色调
};

final cutActions = [
  ActionData(type: 0, name: '裁剪', icon: '', subActions: _cropCropActions),
  ActionData(type: 1, name: '旋转', icon: '', subActions: _cropRotateActions),
];

final _cropCropActions = [
  ActionData(
      type: 0,
      name: '原图',
      icon: 'icon_yuantu_n'.imageCropPng,
      selectedIcon: 'icon_yuantu_s'.imageCropPng,
      cropRatio: -1.0),
  ActionData(
      type: 1,
      name: '自由',
      icon: 'icon_dengbi_n'.imageCropPng,
      selectedIcon: 'icon_dengbi_s'.imageCropPng),
  ActionData(
      type: 2,
      name: '1:1',
      icon: 'icon_11_n'.imageCropPng,
      selectedIcon: 'icon_11_s'.imageCropPng,
      cropRatio: 1.0),
  ActionData(
      type: 3,
      name: '3:4',
      icon: 'icon_34_n'.imageCropPng,
      selectedIcon: 'icon_34_s'.imageCropPng,
      cropRatio: 3 / 4),
  ActionData(
      type: 4,
      name: '4:3',
      icon: 'icon_43_n'.imageCropPng,
      selectedIcon: 'icon_43_s'.imageCropPng,
      cropRatio: 4 / 3),
  ActionData(
      type: 5,
      name: '9:16',
      icon: 'icon_916_n'.imageCropPng,
      selectedIcon: 'icon_916_s'.imageCropPng,
      cropRatio: 9 / 16),
  ActionData(
      type: 6,
      name: '16:9',
      icon: 'icon_169_n'.imageCropPng,
      selectedIcon: 'icon_169_s'.imageCropPng,
      cropRatio: 16 / 9)
];

final _cropRotateActions = [
  ActionData(type: 10, name: '水平翻转', icon: 'icon_zyfz_n'.imageCropPng),
  ActionData(type: 11, name: '垂直翻转', icon: 'icon_sxfz_n'.imageCropPng),
  ActionData(
      type: 12,
      name: '左转90°',
      icon: 'icon_zxz_n'.imageCropPng,
      rotateAngle: -90.0),
  ActionData(
      type: 13,
      name: '右转90°',
      icon: 'icon_yxz_n'.imageCropPng,
      rotateAngle: 90.0),
];

final fontActions = [
  ActionData(type: 0, name: '字体', icon: ''),
  ActionData(type: 1, name: '样式', icon: '', subActions: fontStyleActions),
  ActionData(type: 2, name: '对齐', icon: '', subActions: fontAlignActions),
];

final fontStyleActions = [
  ActionData(
      type: 0,
      name: '粗体',
      icon: 'icon_coarse_n@3x'.imageFontsPng,
      selectedIcon: 'icon_coarse_s@3x'.imageFontsPng),
  ActionData(
      type: 1,
      name: '斜体',
      icon: 'icon_inclined_n@3x'.imageFontsPng,
      selectedIcon: 'icon_inclined_s@3x'.imageFontsPng),
  ActionData(
      type: 2,
      name: '下划线',
      icon: 'icon_underline_n@3x'.imageFontsPng,
      selectedIcon: 'icon_underline_s@3x'.imageFontsPng),
];

final fontAlignActions = [
  ActionData(
      type: 0,
      name: '居左',
      icon: 'icon_leftalignment_n@3x'.imageFontsPng,
      selectedIcon: 'icon_leftalignment_s@3x'.imageFontsPng),
  ActionData(
      type: 1,
      name: '居中',
      icon: 'icon_midst_n@3x'.imageFontsPng,
      selectedIcon: 'icon_midst_s@3x'.imageFontsPng),
  ActionData(
      type: 2,
      name: '居右',
      icon: 'icon_rightalignment_n@3x'.imageFontsPng,
      selectedIcon: 'icon_rightalignment_s@3x'.imageFontsPng),
];
