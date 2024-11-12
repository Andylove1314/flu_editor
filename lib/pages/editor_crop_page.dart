import 'dart:io';

import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:image/image.dart' as img;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

import '../blocs/cut_bloc_cubit/cut_cubit.dart';
import '../flu_editor.dart';
import '../utils/constant.dart';
import '../widgets/crop/crop_pan.dart';
import '../widgets/slider_degree_parameter.dart';
import 'dart:typed_data';

class EditorCropPage extends StatefulWidget {
  const EditorCropPage({super.key});

  @override
  State<EditorCropPage> createState() => _EditorCropPageState();
}

class _EditorCropPageState extends State<EditorCropPage> {
  final ImageEditorController _imageEditorController = ImageEditorController();

  double _currentAddDegree = 0.0;
  int _currentCropIndex = 1;

  @override
  void initState() {
    _imageEditorController.addListener(() {
      bool changed = _imageEditorController.rotateDegrees != 0 ||
          _imageEditorController.cropAspectRatio != null ||
          (_imageEditorController.editActionDetails?.flipY ?? false);
      context
          .read<CutCubit>()
          .showStatus(context.read<CutCubit>().showSli, changed);
    });
    super.initState();
  }

  @override
  void dispose() {
    _imageEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: BlocBuilder<CutCubit, CutState>(builder: (c, state) {
                if (context.read<CutCubit>().cutImageByte != null) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    child: _croper(context.read<CutCubit>().cutImageByte!),
                  );
                }
                return EditorUtil.loadingWidget(context);
              })),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<CutCubit, CutState>(builder: (c, state) {
              return _pan();
            }),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10),
                child: BlocBuilder<CutCubit, CutState>(builder: (c, state) {
                  return _fwAction();
                }),
              ))
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _croper(Uint8List cutImageByte) {
    ThemeData themeData = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        surface: Colors.white,
      ),
    );

    return Theme(
        data: themeData,
        child: ExtendedImage.memory(
          cutImageByte,
          cacheRawData: true,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          initEditorConfigHandler: (state) {
            return EditorConfig(
                cropRectPadding: const EdgeInsets.all(20),
                cornerSize: const Size(30.0, 4.0),
                cornerColor: Colors.white,
                lineColor: Colors.white,
                lineHeight: 2,
                controller: _imageEditorController);
          },
        ));
  }

  Widget _fwAction() {
    return Visibility(
        visible: context.read<CutCubit>().showfw,
        child: SizedBox(
          height: 25,
          child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0), // 设置圆角半径
                  ),
                ),
              ),
              onPressed: () {
                _currentAddDegree = 0.0;
                _currentCropIndex = 1;
                _imageEditorController.reset();
              },
              child: const Text(
                '复位',
                style: TextStyle(
                    color: Color(0xff1E1925),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )),
        ));
  }

  Widget _slider() {
    return SliderDegreeParameterWidget(
      degree: _currentAddDegree,
      onChanged: (value) async {
        if (Platform.isIOS) {
          Haptics.vibrate(HapticsType.heavy);
        } else {
          if ((await Vibration.hasVibrator()) ?? true) {
            Vibration.vibrate(duration: 15);
          }
        }
        var increment = value - _currentAddDegree;
        _imageEditorController.rotate(degree: increment);
        _currentAddDegree = value;
      },
    );
  }

  Widget _pan() {
    return Column(
      children: [
        Visibility(visible: context.read<CutCubit>().showSli, child: _slider()),
        CropPan(
          classIndex: _currentCropIndex,
          onTab: (tab) {
            context
                .read<CutCubit>()
                .showStatus(tab.type == 1, context.read<CutCubit>().showfw);
          },
          onClick: (type, action) {
            img.Image? cutImage = context.read<CutCubit>().cutImage;
            if (cutImage == null) {
              return;
            }

            if (type == 0) {
              // 裁剪
              var cropRatio;
              if (action.cropRatio == -1) {
                //原图
                cropRatio = cutImage!.width / cutImage!.height;
              } else {
                cropRatio = action.cropRatio;
              }
              _imageEditorController.updateCropAspectRatio(cropRatio);
              _currentCropIndex = cutActions[0].subActions!.indexOf(action);
            } else if (type == 1) {
              //旋转
              if (action.type == 10) {
                // 水平flip
                _imageEditorController.flip();
              } else if (action.type == 11) {
                //垂直flip
                _imageEditorController.rotate(
                    degree: 180.0, rotateCropRect: true);
                _imageEditorController.flip();
              } else {
                // 角度旋转
                _imageEditorController.rotate(
                    degree: action.rotateAngle,
                    rotateCropRect: true,
                    animation: true);
              }
            }
          },
          onConfirm: () async {
            EditorUtil.showLoadingdialog(context);
            await EditorUtil.cropImage(_imageEditorController);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          actionData: cutActions,
        )
      ],
    );
  }
}
