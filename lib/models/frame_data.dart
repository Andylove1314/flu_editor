part of '../../flu_editor.dart';

class FrameData {
  int? id;
  String? groupName;
  int? status;
  List<FrameDetail>? list;

  FrameData({this.id, this.groupName, this.status, this.list});

  /// fromJson 方法
  FrameData.fromJson(Map json) {
    if (json.isNotEmpty) {
      id = json['id'] as int?;
      groupName = json['groupName'] as String?;
      status = json['status'] as int?;
      list = (json['list'] as List<dynamic>?)
          ?.map((e) => FrameDetail.fromJson(e as Map<String, dynamic>))
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

class FrameDetail {
  int? id;
  String? name;
  int? classId;
  int? vip;
  int? status;
  String? className;
  String? image;
  int? groupId;
  var color;
  FrameSize? params;
  var imgFrom = 2;// 0 asset, 1 file, 2 url

  bool get isVipFrame => vip == 1;

  FrameDetail(
      {this.id,
      this.name,
      this.classId,
      this.vip,
      this.status,
      this.className,
      this.image,
      this.groupId,
      this.params,
      this.color});

  /// fromJson 方法
  FrameDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        classId = json['classId'] as int?,
        vip = json['vip'] as int?,
        status = json['status'] as int?,
        className = json['className'] as String?,
        image = json['image'] as String?,
        color = json['color'],
        groupId = json['groupId'] as int?,
        params = FrameSize.fromJson(json['params']);

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
    data['color'] = color;
    data['groupId'] = groupId;
    data['params'] = params?.toJson();
    return data;
  }
}

class FrameSize {
  var frameWidth;
  var frameHeight;
  var frameLeft;
  var frameTop;
  var frameRight;
  var frameBottom;

  FrameSize(
      {this.frameWidth,
      this.frameHeight,
      this.frameLeft,
      this.frameTop,
      this.frameRight,
      this.frameBottom});

  /// fromJson 方法
  FrameSize.fromJson(Map<String, dynamic> json)
      : frameWidth = json['frameWidth'],
        frameHeight = json['frameHeight'],
        frameLeft = json['frameLeft'],
        frameTop = json['frameTop'],
        frameRight = json['frameRight'],
        frameBottom = json['frameBottom'];

  /// toJson 方法
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['frameWidth'] = frameWidth;
    data['frameHeight'] = frameHeight;
    data['frameLeft'] = frameLeft;
    data['frameTop'] = frameTop;
    data['frameRight'] = frameRight;
    data['frameBottom'] = frameBottom;
    return data;
  }
}
