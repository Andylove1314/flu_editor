part of '../../flu_editor.dart';

class FontsData {
  int? id;
  String? groupName;
  int? status;
  List<FontDetail>? list;

  FontsData({this.id, this.groupName, this.status, this.list});

  /// fromJson 方法
  FontsData.fromJson(Map json) {
    if (json.isNotEmpty) {
      id = json['id'] as int?;
      groupName = json['groupName'] as String?;
      status = json['status'] as int?;
      list = (json['list'] as List<dynamic>?)
          ?.map((e) => FontDetail.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  /// toJson 方法
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupName'] = groupName;
    data['status'] = status;
    if (list != null) {
      data['list'] = list?.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class FontDetail {
  int? id;
  String? name;
  int? classId;
  int? vip;
  int? status;
  String? className;
  String? file;
  String? image;
  int? groupId;

  bool get isVipFont => vip == 1;

  FontDetail(
      {this.id,
        this.name,
        this.classId,
        this.vip,
        this.status,
        this.className,
        this.file,
        this.groupId,
      this.image});

  /// fromJson 方法
  FontDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        classId = json['classId'] as int?,
        vip = json['vip'] as int?,
        status = json['status'] as int?,
        className = json['className'] as String?,
        file = json['file'] as String?,
        image = json['image'] as String?,
        groupId = json['groupId'] as int?;

  /// toJson 方法
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['classId'] = classId;
    data['vip'] = vip;
    data['status'] = status;
    data['className'] = className;
    data['file'] = file;
    data['groupId'] = groupId;
    data['image'] = image;
    return data;
  }
}
