
import 'dart:io';
import 'dart:typed_data';

abstract class DataItemMetadata {}

abstract class DataItem {
  String get name;

  String disPlayName;

  final DataItemMetadata? metadata;

  DataItem({this.metadata, this.disPlayName = ''});
}

class AssetDataItem extends DataItem {
  final String asset;

  @override
  String get name => asset.split('/').last.split('.').first;

  AssetDataItem(this.asset, {super.metadata, super.disPlayName});
}

class FileDataItem extends DataItem {
  final File file;

  @override
  String get name => file.path.split('/').last.split('.').first;

  FileDataItem(this.file, {super.metadata, super.disPlayName});
}

class BinaryDataItem extends DataItem {
  final Uint8List bytes;
  @override
  final String name;

  BinaryDataItem(this.name, this.bytes, {super.metadata, super.disPlayName});
}

class ImageAssetDataItem extends AssetDataItem {
  ImageAssetDataItem(super.asset, {super.metadata, super.disPlayName});
}

class ImageFileDataItem extends FileDataItem {
  ImageFileDataItem(super.file, {super.metadata, super.disPlayName});
}

class ImageBinaryDataItem extends BinaryDataItem {
  ImageBinaryDataItem(super.name, super.bytes, {super.metadata, super.disPlayName});
}

class LutAssetDataItem extends ImageAssetDataItem {
  LutAssetDataItem(super.asset, {super.metadata, super.disPlayName});
}

class LutFileDataItem extends ImageFileDataItem {
  LutFileDataItem(super.file, {super.metadata, super.disPlayName});
}

class LutMetadata extends DataItemMetadata {
  final int dimension;
  final int size;
  final int rows;
  final int columns;

  LutMetadata(this.dimension, this.size, this.rows, this.columns);
}

class DefaultDataItem extends DataItem {
  @override
  String get name => '---Default---';
}
