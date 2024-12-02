part of '../../flu_editor.dart';

extension assets on String {
  String get imagePng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/$this.png';
  }

  String get imageColorsPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/colors/$this.png';
  }

  String get imageCropPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/crop/$this.png';
  }

  String get imageFiltersPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/filters/$this.png';
  }

  String get imageStickersPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/stickers/$this.png';
  }

  String get imageFontsPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/fonts/$this.png';
  }


  String get imageFramesPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}images/Frames/$this.png';
  }

  String get lutPng {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}luts/$this.png';
  }

  String get shader {
    String _lutsRoot = Platform.environment.containsKey('FLUTTER_TEST')
        ? ''
        : 'packages/flu_editor/';

    return '${_lutsRoot}shaders/$this.frag';
  }
}
