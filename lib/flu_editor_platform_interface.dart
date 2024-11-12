import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flu_editor_method_channel.dart';

abstract class FluEditorPlatform extends PlatformInterface {
  /// Constructs a FluEditorPlatform.
  FluEditorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FluEditorPlatform _instance = MethodChannelFluEditor();

  /// The default instance of [FluEditorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFluEditor].
  static FluEditorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FluEditorPlatform] when
  /// they register themselves.
  static set instance(FluEditorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
