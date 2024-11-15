part of '../../flu_editor.dart';

class StickerData {
  int? id;
  String? groupName;
  String? groupImage;
  int? status;
  List<StickDetail>? list;
  int? vip;


  bool get isVipGroup => vip == 1;

  StickerData({this.id, this.groupName, this.groupImage, this.status, this.list, this.vip});

  /// fromJson 方法
  StickerData.fromJson(Map json) {
    if (json.isNotEmpty) {
      id = json['id'] as int?;
      groupName = json['groupName'] as String?;
      groupImage = json['groupImage'] as String?;
      status = json['status'] as int?;
      vip = json['vip'] as int?;
      list = (json['list'] as List<dynamic>?)
          ?.map((e) => StickDetail.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  /// toJson 方法
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupName'] = groupName;
    data['groupImage'] = groupImage;
    data['status'] = status;
    data['vip'] = vip;
    if (list != null) {
      data['list'] = list?.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class StickDetail {
  int? id;
  String? name;
  int? classId;
  int? vip;
  int? status;
  String? className;
  String? image;
  int? groupId;
  var color;

  bool get isVipSticker => vip == 1;

  StickDetail(
      {this.id,
        this.name,
        this.classId,
        this.vip,
        this.status,
        this.className,
        this.image,
        this.groupId,
      this.color});

  /// fromJson 方法
  StickDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        classId = json['classId'] as int?,
        vip = json['vip'] as int?,
        status = json['status'] as int?,
        className = json['className'] as String?,
        image = json['image'] as String?,
        color = json['color'],
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
    data['image'] = image;
    data['groupId'] = groupId;
    data['color'] = color;
    return data;
  }
}
