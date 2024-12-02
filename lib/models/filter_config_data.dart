part of '../../flu_editor.dart';

class FilterData {
  int? id;
  String? groupName;
  int? status;
  List<FilterDetail>? list;

  FilterData({this.id, this.groupName, this.status, this.list});

  /// fromJson 方法
  FilterData.fromJson(Map json) {
    if (json.isNotEmpty) {
      id = json['id'] as int?;
      groupName = json['groupName'] as String?;
      status = json['status'] as int?;
      list = (json['list'] as List<dynamic>?)
          ?.map((e) => FilterDetail.fromJson(e as Map<String, dynamic>))
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
      data['list'] = list?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterDetail {
  int? id;
  String? name;
  int? classId;
  String? filterImage;
  int? vip;
  int? status;
  String? className;
  String? image;
  int? groupId;
  num noise;
  var lutFrom = 2;// 0 asset, 1 file, 2 url
  var imgFrom = 2;// 0 asset, 1 file, 2 url

  bool get isVipFilter => vip == 1;

  FilterDetail(
      {this.id,
      this.name,
      this.classId,
      this.filterImage,
      this.vip,
      this.status,
      this.className,
      this.image,
      this.groupId,
      this.noise = 0.0,
      this.lutFrom = 2,
      this.imgFrom = 2});

  /// fromJson 方法
  FilterDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        classId = json['classId'] as int?,
        filterImage = json['filterImage'] as String?,
        vip = json['vip'] as int?,
        status = json['status'] as int?,
        className = json['className'] as String?,
        image = json['image'] as String?,
        groupId = json['groupId'] as int?,
        noise = json['noise'] ?? 0.0;

  /// toJson 方法
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['classId'] = classId;
    data['filterImage'] = filterImage;
    data['vip'] = vip;
    data['status'] = status;
    data['className'] = className;
    data['image'] = image;
    data['groupId'] = groupId;
    data['noise'] = noise;
    return data;
  }
}
