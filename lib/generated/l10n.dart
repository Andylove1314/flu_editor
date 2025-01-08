// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class EditorLang {
  EditorLang();

  static EditorLang? _current;

  static EditorLang get current {
    assert(_current != null,
        'No instance of EditorLang was loaded. Try to initialize the EditorLang delegate before accessing EditorLang.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<EditorLang> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = EditorLang();
      EditorLang._current = instance;

      return instance;
    });
  }

  static EditorLang of(BuildContext context) {
    final instance = EditorLang.maybeOf(context);
    assert(instance != null,
        'No instance of EditorLang present in the widget tree. Did you add EditorLang.delegate in localizationsDelegates?');
    return instance!;
  }

  static EditorLang? maybeOf(BuildContext context) {
    return Localizations.of<EditorLang>(context, EditorLang);
  }

  /// `图片编辑`
  String get editor_name {
    return Intl.message(
      '图片编辑',
      name: 'editor_name',
      desc: '',
      args: [],
    );
  }

  /// `程度`
  String get editor_intensity {
    return Intl.message(
      '程度',
      name: 'editor_intensity',
      desc: '',
      args: [],
    );
  }

  /// `裁剪`
  String get editor_crop {
    return Intl.message(
      '裁剪',
      name: 'editor_crop',
      desc: '',
      args: [],
    );
  }

  /// `原图`
  String get editor_crop_orignal {
    return Intl.message(
      '原图',
      name: 'editor_crop_orignal',
      desc: '',
      args: [],
    );
  }

  /// `自由`
  String get editor_crop_freedom {
    return Intl.message(
      '自由',
      name: 'editor_crop_freedom',
      desc: '',
      args: [],
    );
  }

  /// `旋转`
  String get editor_rotate {
    return Intl.message(
      '旋转',
      name: 'editor_rotate',
      desc: '',
      args: [],
    );
  }

  /// `水平翻转`
  String get editor_rotate_lr {
    return Intl.message(
      '水平翻转',
      name: 'editor_rotate_lr',
      desc: '',
      args: [],
    );
  }

  /// `垂直翻转`
  String get editor_rotate_tb {
    return Intl.message(
      '垂直翻转',
      name: 'editor_rotate_tb',
      desc: '',
      args: [],
    );
  }

  /// `左转90°`
  String get editor_rotate_l90 {
    return Intl.message(
      '左转90°',
      name: 'editor_rotate_l90',
      desc: '',
      args: [],
    );
  }

  /// `右转90°`
  String get editor_rotate_r90 {
    return Intl.message(
      '右转90°',
      name: 'editor_rotate_r90',
      desc: '',
      args: [],
    );
  }

  /// `复位`
  String get editor_restore {
    return Intl.message(
      '复位',
      name: 'editor_restore',
      desc: '',
      args: [],
    );
  }

  /// `调色`
  String get editor_color {
    return Intl.message(
      '调色',
      name: 'editor_color',
      desc: '',
      args: [],
    );
  }

  /// `删除配方成功`
  String get editor_color_delete_pf_successfully {
    return Intl.message(
      '删除配方成功',
      name: 'editor_color_delete_pf_successfully',
      desc: '',
      args: [],
    );
  }

  /// `删除配方失败`
  String get editor_color_delete_pf_faild {
    return Intl.message(
      '删除配方失败',
      name: 'editor_color_delete_pf_faild',
      desc: '',
      args: [],
    );
  }

  /// `配方`
  String get editor_color_pf {
    return Intl.message(
      '配方',
      name: 'editor_color_pf',
      desc: '',
      args: [],
    );
  }

  /// `暂无配方`
  String get editor_color_pf_no {
    return Intl.message(
      '暂无配方',
      name: 'editor_color_pf_no',
      desc: '',
      args: [],
    );
  }

  /// `亮度`
  String get editor_color_ld {
    return Intl.message(
      '亮度',
      name: 'editor_color_ld',
      desc: '',
      args: [],
    );
  }

  /// `饱和度`
  String get editor_color_bhd {
    return Intl.message(
      '饱和度',
      name: 'editor_color_bhd',
      desc: '',
      args: [],
    );
  }

  /// `对比度`
  String get editor_color_dbd {
    return Intl.message(
      '对比度',
      name: 'editor_color_dbd',
      desc: '',
      args: [],
    );
  }

  /// `高光`
  String get editor_color_gg {
    return Intl.message(
      '高光',
      name: 'editor_color_gg',
      desc: '',
      args: [],
    );
  }

  /// `阴影`
  String get editor_color_yy {
    return Intl.message(
      '阴影',
      name: 'editor_color_yy',
      desc: '',
      args: [],
    );
  }

  /// `色温`
  String get editor_color_sw {
    return Intl.message(
      '色温',
      name: 'editor_color_sw',
      desc: '',
      args: [],
    );
  }

  /// `晕影`
  String get editor_color_yying {
    return Intl.message(
      '晕影',
      name: 'editor_color_yying',
      desc: '',
      args: [],
    );
  }

  /// `锐化`
  String get editor_color_rh {
    return Intl.message(
      '锐化',
      name: 'editor_color_rh',
      desc: '',
      args: [],
    );
  }

  /// `噪点`
  String get editor_color_zd {
    return Intl.message(
      '噪点',
      name: 'editor_color_zd',
      desc: '',
      args: [],
    );
  }

  /// `鲜艳度`
  String get editor_color_xyd {
    return Intl.message(
      '鲜艳度',
      name: 'editor_color_xyd',
      desc: '',
      args: [],
    );
  }

  /// `白平衡`
  String get editor_color_bph {
    return Intl.message(
      '白平衡',
      name: 'editor_color_bph',
      desc: '',
      args: [],
    );
  }

  /// `红色`
  String get editor_color_bph_red {
    return Intl.message(
      '红色',
      name: 'editor_color_bph_red',
      desc: '',
      args: [],
    );
  }

  /// `绿色`
  String get editor_color_bph_green {
    return Intl.message(
      '绿色',
      name: 'editor_color_bph_green',
      desc: '',
      args: [],
    );
  }

  /// `蓝色`
  String get editor_color_bph_blue {
    return Intl.message(
      '蓝色',
      name: 'editor_color_bph_blue',
      desc: '',
      args: [],
    );
  }

  /// `曝光`
  String get editor_color_bg {
    return Intl.message(
      '曝光',
      name: 'editor_color_bg',
      desc: '',
      args: [],
    );
  }

  /// `滤镜`
  String get editor_filter {
    return Intl.message(
      '滤镜',
      name: 'editor_filter',
      desc: '',
      args: [],
    );
  }

  /// `贴纸`
  String get editor_sticker {
    return Intl.message(
      '贴纸',
      name: 'editor_sticker',
      desc: '',
      args: [],
    );
  }

  /// `文字`
  String get editor_text {
    return Intl.message(
      '文字',
      name: 'editor_text',
      desc: '',
      args: [],
    );
  }

  /// `字体`
  String get editor_text_font {
    return Intl.message(
      '字体',
      name: 'editor_text_font',
      desc: '',
      args: [],
    );
  }

  /// `样式`
  String get editor_text_style {
    return Intl.message(
      '样式',
      name: 'editor_text_style',
      desc: '',
      args: [],
    );
  }

  /// `透明`
  String get editor_text_style_alpha {
    return Intl.message(
      '透明',
      name: 'editor_text_style_alpha',
      desc: '',
      args: [],
    );
  }

  /// `粗体`
  String get editor_text_style_ct {
    return Intl.message(
      '粗体',
      name: 'editor_text_style_ct',
      desc: '',
      args: [],
    );
  }

  /// `斜体`
  String get editor_text_style_xt {
    return Intl.message(
      '斜体',
      name: 'editor_text_style_xt',
      desc: '',
      args: [],
    );
  }

  /// `下划线`
  String get editor_text_style_xhx {
    return Intl.message(
      '下划线',
      name: 'editor_text_style_xhx',
      desc: '',
      args: [],
    );
  }

  /// `对齐`
  String get editor_text_align {
    return Intl.message(
      '对齐',
      name: 'editor_text_align',
      desc: '',
      args: [],
    );
  }

  /// `字间距`
  String get editor_text_align_ws {
    return Intl.message(
      '字间距',
      name: 'editor_text_align_ws',
      desc: '',
      args: [],
    );
  }

  /// `行间距`
  String get editor_text_align_ls {
    return Intl.message(
      '行间距',
      name: 'editor_text_align_ls',
      desc: '',
      args: [],
    );
  }

  /// `居左`
  String get editor_text_align_left {
    return Intl.message(
      '居左',
      name: 'editor_text_align_left',
      desc: '',
      args: [],
    );
  }

  /// `居中`
  String get editor_text_align_center {
    return Intl.message(
      '居中',
      name: 'editor_text_align_center',
      desc: '',
      args: [],
    );
  }

  /// `居右`
  String get editor_text_align_right {
    return Intl.message(
      '居右',
      name: 'editor_text_align_right',
      desc: '',
      args: [],
    );
  }

  /// `边框`
  String get editor_frame {
    return Intl.message(
      '边框',
      name: 'editor_frame',
      desc: '',
      args: [],
    );
  }

  /// `购买会员`
  String get editor_vip_action {
    return Intl.message(
      '购买会员',
      name: 'editor_vip_action',
      desc: '',
      args: [],
    );
  }

  /// `放弃效果`
  String get editor_vip_cancel {
    return Intl.message(
      '放弃效果',
      name: 'editor_vip_cancel',
      desc: '',
      args: [],
    );
  }

  /// `会员已到期，开通即可使用专享素材功能`
  String get editor_vip_limited_1 {
    return Intl.message(
      '会员已到期，开通即可使用专享素材功能',
      name: 'editor_vip_limited_1',
      desc: '',
      args: [],
    );
  }

  /// `您使用了VIP滤镜，请在开通会员后保存滤镜效果？`
  String get editor_vip_limited_2 {
    return Intl.message(
      '您使用了VIP滤镜，请在开通会员后保存滤镜效果？',
      name: 'editor_vip_limited_2',
      desc: '',
      args: [],
    );
  }

  /// `是否保存编辑的效果后退出？`
  String get editor_exit_tip {
    return Intl.message(
      '是否保存编辑的效果后退出？',
      name: 'editor_exit_tip',
      desc: '',
      args: [],
    );
  }

  /// `不保存`
  String get editor_exit_no {
    return Intl.message(
      '不保存',
      name: 'editor_exit_no',
      desc: '',
      args: [],
    );
  }

  /// `保存`
  String get editor_exit_save {
    return Intl.message(
      '保存',
      name: 'editor_exit_save',
      desc: '',
      args: [],
    );
  }

  /// `您使用了VIP素材，请在开通会员后保存效果？`
  String get editor_vip_limited_3 {
    return Intl.message(
      '您使用了VIP素材，请在开通会员后保存效果？',
      name: 'editor_vip_limited_3',
      desc: '',
      args: [],
    );
  }

  /// `透明度`
  String get editor_text_style_alpha_2 {
    return Intl.message(
      '透明度',
      name: 'editor_text_style_alpha_2',
      desc: '',
      args: [],
    );
  }

  /// `左右`
  String get editor_color_yying_zy {
    return Intl.message(
      '左右',
      name: 'editor_color_yying_zy',
      desc: '',
      args: [],
    );
  }

  /// `上下`
  String get editor_color_yying_sx {
    return Intl.message(
      '上下',
      name: 'editor_color_yying_sx',
      desc: '',
      args: [],
    );
  }

  /// `大小`
  String get editor_color_yying_dx {
    return Intl.message(
      '大小',
      name: 'editor_color_yying_dx',
      desc: '',
      args: [],
    );
  }

  /// `外延`
  String get editor_color_yying_wy {
    return Intl.message(
      '外延',
      name: 'editor_color_yying_wy',
      desc: '',
      args: [],
    );
  }

  /// `模糊`
  String get editor_blur {
    return Intl.message(
      '模糊',
      name: 'editor_blur',
      desc: '',
      args: [],
    );
  }

  /// `色调`
  String get editor_color_sd {
    return Intl.message(
      '色调',
      name: 'editor_color_sd',
      desc: '',
      args: [],
    );
  }

  /// `应用调色效果前是否要保存配方下次一键调用`
  String get editor_color_effect_save_tip {
    return Intl.message(
      '应用调色效果前是否要保存配方下次一键调用',
      name: 'editor_color_effect_save_tip',
      desc: '',
      args: [],
    );
  }

  /// `不保存配方`
  String get editor_color_effect_save_no {
    return Intl.message(
      '不保存配方',
      name: 'editor_color_effect_save_no',
      desc: '',
      args: [],
    );
  }

  /// `保存配方`
  String get editor_color_effect_save_action {
    return Intl.message(
      '保存配方',
      name: 'editor_color_effect_save_action',
      desc: '',
      args: [],
    );
  }

  /// `配方名称`
  String get editor_color_effect_name {
    return Intl.message(
      '配方名称',
      name: 'editor_color_effect_name',
      desc: '',
      args: [],
    );
  }

  /// `请输入配方名称`
  String get editor_color_effect_save_action_tip {
    return Intl.message(
      '请输入配方名称',
      name: 'editor_color_effect_save_action_tip',
      desc: '',
      args: [],
    );
  }

  /// `保存配方成功`
  String get editor_color_save_pf_successfully {
    return Intl.message(
      '保存配方成功',
      name: 'editor_color_save_pf_successfully',
      desc: '',
      args: [],
    );
  }

  /// `保存配方失败`
  String get editor_color_save_pf_faild {
    return Intl.message(
      '保存配方失败',
      name: 'editor_color_save_pf_faild',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<EditorLang> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<EditorLang> load(Locale locale) => EditorLang.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
