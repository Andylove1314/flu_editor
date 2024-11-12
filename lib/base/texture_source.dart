
part of '../flu_editor.dart';

class TextureSource {
  final Image image;
  final int width;
  final int height;
  final Map<String, IfdTag>? exif;

  Size get size => Size(width.toDouble(), height.toDouble());

  double get aspectRatio => width / height;

  TextureSource._(this.image, this.width, this.height, [this.exif]);

  static Future<TextureSource> fromAsset(
    String asset, {
    TileMode tmx = TileMode.repeated,
    TileMode tmy = TileMode.repeated,
    TargetImageSize? targetSize,
  }) async {
    if (kIsWeb) {
      final data = await rootBundle.load(asset);
// coverage:ignore-start
      return fromMemory(
        data.buffer.asUint8List(),
        tmx: tmx,
        tmy: tmy,
        targetSize: targetSize,
      );
// coverage:ignore-end
    }
    final buffer = await ImmutableBuffer.fromAsset(asset);
    final data = await rootBundle.load(asset);
    final exif = await readExifFromBytes(data.buffer.asInt8List());
// coverage:ignore-start
    return await _fromImmutableBuffer(
      buffer,
      tmx,
      tmy,
      exif: exif,
      targetSize: targetSize,
    );
// coverage:ignore-end
  }

  static Future<TextureSource> fromFile(
    File file, {
    TileMode tmx = TileMode.repeated,
    TileMode tmy = TileMode.repeated,
    TargetImageSize? targetSize,
  }) async {
    if (kIsWeb) {
      final data = await file.readAsBytes();
      return await fromMemory(
        data,
        tmx: tmx,
        tmy: tmy,
        targetSize: targetSize,
      );
    }
    final buffer = await ImmutableBuffer.fromFilePath(file.path);
    final exif = await readExifFromFile(file);
    return _fromImmutableBuffer(
      buffer,
      tmx,
      tmy,
      exif: exif,
      targetSize: targetSize,
    );
  }

  static Future<TextureSource> fromMemory(
    Uint8List data, {
    TileMode tmx = TileMode.repeated,
    TileMode tmy = TileMode.repeated,
    TargetImageSize? targetSize,
  }) async {
    final buffer = await ImmutableBuffer.fromUint8List(data);
    final exif = await readExifFromBytes(data);

    return await _fromImmutableBuffer(
      buffer,
      tmx,
      tmy,
      exif: exif,
      targetSize: targetSize,
    );
  }

  static TextureSource fromImage(
    Image image, {
    TileMode tmx = TileMode.repeated,
    TileMode tmy = TileMode.repeated,
    Map<String, IfdTag>? exif,
    TargetImageSize? targetSize,
  }) {
    return TextureSource._(
      image,
      image.width,
      image.height,
      exif,
    );
  }

  static Future<TextureSource> _fromImmutableBuffer(
    ImmutableBuffer buffer,
    TileMode tmx,
    TileMode tmy, {
    Map<String, IfdTag>? exif,
    TargetImageSize? targetSize,
  }) async {
    final codec = await PaintingBinding.instance.instantiateImageCodecWithSize(
      buffer,
      getTargetSize: (width, height) {
        final size = targetSize;
        if (size == null) {
          return TargetImageSize(width: width, height: height);
        }
        final w = size.width;
        final h = size.height;
        if (w == null || h == null) {
          return TargetImageSize(width: width, height: height);
        }
        if (w >= width || h >= height) {
          return TargetImageSize(width: width, height: height);
        }
        final scale = min(width / w, height / h);

        return TargetImageSize(
          width: (width / scale).toInt(),
          height: (height / scale).toInt(),
        );
      },
    );
    final frameInfo = await codec.getNextFrame();

    return fromImage(frameInfo.image as Image, tmx: tmx, tmy: tmy, exif: exif);
  }
}
