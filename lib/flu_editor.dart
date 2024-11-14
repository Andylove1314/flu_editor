import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flu_editor/pages/editor_colors_page.dart';
import 'package:flu_editor/pages/editor_crop_page.dart';
import 'package:flu_editor/pages/editor_filter_page.dart';
import 'package:flu_editor/pages/editor_font_page.dart';
import 'package:flu_editor/pages/editor_frame_page.dart';
import 'package:flu_editor/pages/editor_home_page.dart';
import 'package:flu_editor/pages/editor_sticker_page.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/cupertino.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;
import 'dart:math';

import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:collection/collection.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flu_editor/blocs/cut_bloc_cubit/cut_cubit.dart';
import 'package:flu_editor/models/effect_data.dart';
import 'package:flu_editor/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

import 'blocs/edtor_home_cubit.dart';
import 'blocs/source_image_bloc/source_image_bloc.dart';
import 'flu_editor_platform_interface.dart';
import 'package:path_provider/path_provider.dart';

part 'package:flu_editor/utils/editor_util.dart';

part 'package:flu_editor/utils/extension_util.dart';

part 'configuration/colors/highlight_configuration.dart';

part 'configuration/colors/hue_configuration.dart';

part 'configuration/colors/colors_mulit_configuration.dart';

part 'configuration/colors/noise_configuration.dart';

part 'configuration/colors/shadow_configuration.dart';

part 'configuration/colors/sharpen_onfiguration.dart';

part 'configuration/colors/temperature_configuration.dart';

part 'configuration/colors/vibrance_configuration.dart';

part 'configuration/colors/vignette_configuration.dart';

part 'configuration/colors/whitebalance_configuration.dart';

part 'configuration/colors/contrast_configuration.dart';

part 'configuration/colors/exposure_configuration2.dart';

part 'configuration/colors/brightness_configuration2.dart';

part 'configuration/colors/saturation_configuration2.dart';

part 'configuration/filters/lookup_configuration2.dart';

part 'models/filter_config_data.dart';
part 'models/sticker_data.dart';
part 'models/font_data.dart';
part 'models/frame_data.dart';

part 'base/configuration.dart';
part 'base/parameters.dart';
part 'base/image_shader_painter.dart';
part 'base/image_shader_preview.dart';
part 'base/pipeline_image_shader_preview.dart';
part 'base/none.dart';
part 'base/texture_source.dart';

Map<Type, Future<FragmentProgram> Function()> _fragmentPrograms = {};

class FluEditor {
  Future<String?> getPlatformVersion() {
    return FluEditorPlatform.instance.getPlatformVersion();
  }
}

void register<T extends ShaderConfiguration>(
    Future<FragmentProgram> Function() fragmentProgramProvider, {
      bool override = false,
    }) {
  if (override) {
    _fragmentPrograms[T] = fragmentProgramProvider;
  } else {
    _fragmentPrograms.putIfAbsent(
      T,
          () => fragmentProgramProvider,
    );
  }
}
