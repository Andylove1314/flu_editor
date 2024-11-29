part of '../../flu_editor.dart';

class EffectData {
  String name;
  String? url;
  String params;
  final id;
  String? path;

  Map<String, dynamic> get paramGroup => jsonDecode(params);

  EffectData(
      {required this.name, required this.params, this.url, this.id, this.path});

// 从 JSON 创建 EffectData 实例
  EffectData.fromJson(Map json)
      : name = json['name'] as String,
        url = json['url'] as String,
        params = json['params'] as String,
        path = json['path'],
        id = json['id']; // id 可以是任意类型

  // 将 EffectData 实例转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'path': path,
      'params': params,
      'id': id,
    };
  }
}
