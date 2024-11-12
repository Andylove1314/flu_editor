import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flu_editor_platform_interface.dart';

/// An implementation of [FluEditorPlatform] that uses method channels.
class MethodChannelFluEditor extends FluEditorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flu_editor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
