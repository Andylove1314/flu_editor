import 'dart:io';

import 'package:flu_editor/widgets/parameters_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

import '../blocs/edtor_home_cubit.dart';
import '../blocs/source_image_bloc/source_image_bloc.dart';
import '../flu_editor.dart';
import '../generated/l10n.dart';
import '../models/action_data.dart';
import '../utils/constant.dart';
import '../widgets/colors/colors_pan.dart';
import '../widgets/colors/params_list_widget.dart';
import '../widgets/custom_widget.dart';
import '../widgets/diff/diff_widget.dart';

class EditorColorsPage extends StatefulWidget {
  const EditorColorsPage({super.key});

  @override
  State<EditorColorsPage> createState() => _EditorColorsPageState();
}

class _EditorColorsPageState extends State<EditorColorsPage> {
  late ColorsMulitConfiguration _currentConfig;

  ActionData? _currentAction;

  Map<String, dynamic> _currentParamMap = {};

  @override
  void initState() {
    _currentConfig = ColorsMulitConfiguration(
      /////////////////////////////////#init#/////////////////////////////
      brightness: colorParamInitValues['Brightness'] ?? 0.0,
      saturation: colorParamInitValues['Saturation'] ?? 0.0,
      contrast: colorParamInitValues['Contrast'] ?? 0.0,
      sharpen: colorParamInitValues['Sharpen'] ?? 0.0,
      shadow: colorParamInitValues['Shadow'] ?? 0.0,
      temperature: colorParamInitValues['Temperature'] ?? 0.0,
      noise: colorParamInitValues['Noise'] ?? 0.0,
      exposure: colorParamInitValues['Exposure'] ?? 0.0,
      vibrance: colorParamInitValues['Vibrance'] ?? 0.0,
      highlight: colorParamInitValues['Highlight'] ?? 0.0,
      wbRed: colorParamInitValues['Red'] ?? 0.0,
      wbGreen: colorParamInitValues['Green'] ?? 0.0,
      wbBlue: colorParamInitValues['Blue'] ?? 0.0,
      vigX: colorParamInitValues['CenterX'] ?? 0.0,
      vigY: colorParamInitValues['CenterY'] ?? 0.0,
      vigStart: colorParamInitValues['Start'] ?? 0.0,
      vigEnd: colorParamInitValues['End'] ?? 0.0,
      // hue: _paramInitValues['Hue'] ?? 0.0,
      /////////////////////////////////#min#/////////////////////////////
      brightnessMin: colorParamMinValues['BrightnessMin'] ?? 0.0,

      /// ok
      saturationMin: colorParamMinValues['SaturationMin'] ?? 0.0,

      /// ok
      contrastMin: colorParamMinValues['ContrastMin'] ?? 0.0,

      /// ok
      sharpenMin: colorParamMinValues['SharpenMin'] ?? 0.0,

      ///ok
      shadowMin: colorParamMinValues['ShadowMin'] ?? 0.0,

      ///ok
      temperatureMin: colorParamMinValues['TemperatureMin'] ?? 0.0,

      ///ok
      noiseMin: colorParamMinValues['NoiseMin'] ?? 0.0,

      ///ok
      exposureMin: colorParamMinValues['ExposureMin'] ?? 0.0,

      /// ok
      vibranceMin: colorParamMinValues['VibranceMin'] ?? 0.0,

      ///ok
      highlightMin: colorParamMinValues['HighlightMin'] ?? 0.0,

      ///ok
      wbRedMin: colorParamMinValues['RedMin'] ?? 0.0,

      ///ok
      wbGreenMin: colorParamMinValues['GreenMin'] ?? 0.0,

      ///ok
      wbBlueMin: colorParamMinValues['BlueMin'] ?? 0.0,

      ///ok
      vigXMin: colorParamMinValues['CenterXMin'] ?? 0.0,

      ///ok
      vigYMin: colorParamMinValues['CenterYMin'] ?? 0.0,

      ///ok
      vigStartMin: colorParamMinValues['StartMin'] ?? 0.0,

      ///ok
      vigEndMin: colorParamMinValues['EndMin'] ?? 0.0,

      ///ok
      // hueMin: colorParamMinValues['HueMin'] ?? 0.0,
      /////////////////////////////////#max#/////////////////////////////
      brightnessMax: colorParamMaxValues['BrightnessMax'] ?? 0.0,

      /// ok
      saturationMax: colorParamMaxValues['SaturationMax'] ?? 0.0,

      /// ok
      contrastMax: colorParamMaxValues['ContrastMax'] ?? 0.0,

      /// ok
      sharpenMax: colorParamMaxValues['SharpenMax'] ?? 0.0,

      ///ok
      shadowMax: colorParamMaxValues['ShadowMax'] ?? 0.0,

      ///ok
      temperatureMax: colorParamMaxValues['TemperatureMax'] ?? 0.0,

      ///ok
      noiseMax: colorParamMaxValues['NoiseMax'] ?? 0.0,

      ///ok
      exposureMax: colorParamMaxValues['ExposureMax'] ?? 0.0,

      /// ok
      vibranceMax: colorParamMaxValues['VibranceMax'] ?? 0.0,

      ///ok
      highlightMax: colorParamMaxValues['HighlightMax'] ?? 0.0,

      wbRedMax: colorParamMaxValues['RedMax'] ?? 0.0,

      ///ok
      wbGreenMax: colorParamMaxValues['GreenMax'] ?? 0.0,

      ///ok
      wbBlueMax: colorParamMaxValues['BlueMax'] ?? 0.0,

      ///ok
      vigXMax: colorParamMaxValues['CenterXMax'] ?? 0.0,

      ///ok
      vigYMax: colorParamMaxValues['CenterYMax'] ?? 0.0,

      ///ok
      vigStartMax: colorParamMaxValues['StartMax'] ?? 0.0,

      ///ok
      vigEndMax: colorParamMaxValues['EndMax'] ?? 0.0,

      ///ok
      // hueMax: colorParamMaxValues['HueMax'] ?? 0.0,
    );

    super.initState();
  }

  @override
  void dispose() {
    _currentConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<SourceImageCubit, SourceImageReady>(
              builder: (context, state) {
                return FadeBeforeAfter(
                  before: Image.file(File(state.afterPath),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain),
                  after: (state.textureSource != null)
                      ? ImageShaderPreview(
                          texture: state.textureSource!,
                          configuration: _currentConfig,
                        )
                      : EditorUtil.loadingWidget(context),
                  diffActionTop: MediaQuery.of(context).padding.top + 20,
                  diffActionRight: 9.0,
                  contentMargin: const EdgeInsets.only(bottom: 100),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// colors
                ..._currentConfig.colorsEffectChildren((e) {
                  e.update(_currentConfig);
                  setState(() {});
                  _saveCurrentEffectParam();
                },
                    paramMap: colorParamInitValues,
                    paramNames: _currentAction?.params ?? []),
                ColorsPan(
                  tags: _genConfig(),
                  sourceFiltersConfig: _currentConfig,
                  onClick: (action) async {
                    setState(() {
                      _currentAction = action;
                    });
                    if (action.params == null) {
                      bool? logined = (await EditorUtil.isLogined()) ?? false;

                      if (!logined) {
                        return;
                      }
                      _showEffects();
                    }
                  },
                  onEffectSave: () async {
                    showSaveEffectPop(context, _currentConfig,
                        context.read<SourceImageCubit>().state.textureSource!,
                        onSave: (saveEffect, name) async {
                      EditorUtil.showLoadingdialog(context);

                      await Future.delayed(const Duration(milliseconds: 500));
                      String effectImagePath =
                          await EditorUtil.exportImage(context, _currentConfig);

                      if (EditorUtil.editorType == null) {
                        /// 更新 home after
                        EditorUtil.homeCubit?.emit(
                          EditorHomeState(effectImagePath),
                        );
                      } else {
                        if (EditorUtil.singleEditorSavetoAlbum) {
                          EditorUtil.saveCallback?.call(effectImagePath);
                        }
                        EditorUtil.clearTmpObject(effectImagePath);
                      }

                      Navigator.pop(context);
                      if (saveEffect) {
                        bool? logined = (await EditorUtil.isLogined()) ?? false;

                        if (!logined) {
                          return;
                        }

                        bool? successed = await EditorUtil.saveColorEffectParam(
                            _currentConfig.parameters, effectImagePath, name);
                        EditorUtil.toastActionCallback?.call(successed == true
                            ? EditorLang.of(context)
                                .editor_color_save_pf_successfully
                            : EditorLang.of(context)
                                .editor_color_save_pf_faild);
                      }
                      Navigator.pop(context);
                    }, onCancel: () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  void _showEffects() {
    showDialog(
        context: context,
        useSafeArea: false,
        barrierColor: Colors.transparent,
        builder: (c) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 13,
                    bottom: 184,
                    child: ParamsListWidget(
                      bottom: 184,
                      applyPf: (effect) {
                        for (ConfigurationParameter p
                            in _currentConfig.parameters) {
                          (p as NumberParameter).value =
                              effect.paramGroup[p.name] ?? 0.0;
                          p.update(_currentConfig);
                        }
                        setState(() {});
                      },
                      recover: () {
                        if (_currentParamMap.isEmpty) {
                          for (ConfigurationParameter p
                              in _currentConfig.parameters) {
                            (p as NumberParameter).value =
                                colorParamInitValues[p.name] ?? 0.0;
                            p.update(_currentConfig);
                          }
                        } else {
                          for (ConfigurationParameter p
                              in _currentConfig.parameters) {
                            (p as NumberParameter).value =
                                _currentParamMap[p.name] ?? 0.0;
                            p.update(_currentConfig);
                          }
                        }

                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  List<ActionData> _genConfig() {
    for (ActionData item in colorActions) {
      item.configs = _currentConfig
          .currentParameter(item.params ?? [])
          .cast<NumberParameter>();
    }
    return colorActions;
  }

  void _saveCurrentEffectParam() {
    for (var param in _currentConfig.parameters) {
      _currentParamMap[param.name] = (param as NumberParameter).value * 1.0;
    }
  }
}
