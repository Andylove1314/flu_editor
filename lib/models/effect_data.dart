part of '../../flu_editor.dart';

class EffectData {
  String name;
  String? image;
  String params;
  final id;
  String? path;
  String? asset;

  Map<String, dynamic> get paramGroup => jsonDecode(params);

  EffectData(
      {required this.name,
      required this.params,
      this.image,
      this.id,
      this.path});

// 从 JSON 创建 EffectData 实例
  EffectData.fromJson(Map json)
      : name = json['name'] as String,
        image = json['image'],
        params = json['params'] as String,
        path = json['path'],
        asset = json['asset'],
        id = json['id']; // id 可以是任意类型

  // 将 EffectData 实例转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'path': path,
      'asset': asset,
      'params': params,
      'id': id,
    };
  }
}
