import 'package:flutter_test/flutter_test.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/flu_editor_platform_interface.dart';
import 'package:flu_editor/flu_editor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFluEditorPlatform
    with MockPlatformInterfaceMixin
    implements FluEditorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FluEditorPlatform initialPlatform = FluEditorPlatform.instance;

  test('$MethodChannelFluEditor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFluEditor>());
  });

  test('getPlatformVersion', () async {
    FluEditor fluEditorPlugin = FluEditor();
    MockFluEditorPlatform fakePlatform = MockFluEditorPlatform();
    FluEditorPlatform.instance = fakePlatform;

    expect(await fluEditorPlugin.getPlatformVersion(), '42');
  });
}
