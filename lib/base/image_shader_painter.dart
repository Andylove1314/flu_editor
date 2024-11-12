
part of '../flu_editor.dart';

class ImageShaderPainter extends CustomPainter {
  ImageShaderPainter(
    this._fragmentProgram,
    this._texture,
    this._configuration, {
    this.blendMode = BlendMode.src,
  });

  final BlendMode blendMode;
  final ShaderConfiguration _configuration;
  final TextureSource _texture;
  final FragmentProgram _fragmentProgram;

  @override
  void paint(Canvas canvas, Size size) {
    final aspectParameter =
        _configuration.parameters.whereType<AspectRatioParameter>().firstOrNull;
    if (aspectParameter != null) {
      aspectParameter.value = size;
      aspectParameter.update(_configuration);
    }

    final textures = [
      _texture,
      ..._configuration.parameters
          .whereType<ShaderTextureParameter>()
          .map((e) => e.textureSource)
          .whereType<TextureSource>(),
    ];

    final shader = _fragmentProgram.fragmentShader();

    [..._configuration.numUniforms, size.width, size.height]
        .forEachIndexed((index, value) {
      shader.setFloat(index, value);
    });

    textures.forEachIndexed((index, e) {
      shader.setImageSampler(index, e.image);
    });

    final paint = Paint()..shader = shader;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is ImageShaderPainter &&
        oldDelegate._configuration != _configuration) {
      return true;
    }
    return _configuration.needRedraw;
  }
}
