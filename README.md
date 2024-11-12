
# **flu_editor**

![Banner](https://example.com/banner-image.png)

`flu_editor` 是一个用于照片和视频的颜色滤镜编辑插件。


| 功能   | 状态   | 备注   |
| ------ | ------ | ------ |
| 滤镜   | 已完成 |       |
| 裁剪   | 已完成 |       |
| 颜色   | 已完成 |       |
| 文字   | 开发中 |       |
| 边框   | 开发中 |       |
| 贴纸   | 开发中 |       |
| 模糊   | 开发中 |       |


## 入门

这是 Flutter 插件包的模板项目，其中包含 Android 和 iOS 的平台特定代码。

有关 Flutter 开发的详细信息，请参阅 [在线文档](https://docs.flutter.dev)，该文档提供了开发教程、示例、移动开发指南和完整的
API 参考。

## 功能概述

`flu_editor` 提供了多种图像编辑功能，以下是工具类的功能概述：

### EditorUtil 工具类

- **页面切换动画**：提供页面切换时的淡入淡出动画，切换持续时间为 200 毫秒。
- **效果临时目录**：定义保存临时编辑效果的目录路径 `/tmpEffectDir`。
- **业务回调**：支持多种业务回调函数，包括 VIP 状态、保存、加载、提示、效果保存与删除等。

### 页面导航功能

- `goFilterPage`：跳转到滤镜编辑页面。
- `goColorsPage`：跳转到颜色调整页面。
- `goCropPage`：跳转到裁剪页面。
- `pushHome`：跳转到编辑器主页，支持传入原始图片路径、滤镜列表并执行回调函数。

### 滤镜初始化

- `_initFilters`：初始化滤镜配置，包括插入空滤镜（无滤镜选项），并将滤镜列表保存到内存中。

### 颜色组合滤镜

- `_registerMultGlsl`：注册滤镜和颜色调整 GLSL 着色器，包括无滤镜效果、噪声滤镜和颜色组合调整滤镜。

### 图像导出

- `exportImage`：导出应用了滤镜的图片，返回保存的图片路径。

### 文件处理功能

- `fileToUint8ListAndImage`：将文件转换为 Uint8List 和 Image 对象，支持后台处理以提高性能。

### 图片裁剪

- `cropImage`：裁剪图片，支持旋转和翻转等裁剪参数，裁剪后保存并更新编辑页面。

### 临时文件管理

- `_createTmp`：在临时目录中创建文件，用于保存编辑后的图片或效果。

### 加载对话框和提示信息

- `showLoadingdialog`：显示加载对话框。
- `loadingWidget`：定义加载进度指示器。
- `showToast`：显示提示信息。

### 保存与删除滤镜效果

- `saveColorEffectParam`：保存颜色效果的参数配置。
- `fetchSavedParamList`：获取已保存的效果列表。
- `deleteEffect`：删除已保存的效果。

### 临时对象清理

- `clearTmpObject`：清理所有回调函数和临时数据。

### 图像加载

- `loadSourceImage`：从文件路径加载图片。

## 使用示例

以下是如何使用 `flu_editor` 进行图像编辑的示例：

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _fluEditorPlugin = FluEditor();
  String _currentImage = '';
  bool isVipUser = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _fluEditorPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('FluEditorApp'),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pickImage(context);
                    },
                    child: Container(
                        width: double.infinity,
                        color: Colors.grey,
                        child: Stack(alignment: Alignment.center, children: [
                          _currentImage.isEmpty
                              ? const SizedBox()
                              : Image.file(File(_currentImage)),
                          Container(
                            height: 200,
                            width: 200,
                            color: Colors.white.withOpacity(0.4),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '添加照片',
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ])),
                  )),
              const SizedBox(
                height: 20,
              ),
              Material(
                child: SizedBox(
                  width: 200,
                  child: FilledButton(
                      onPressed: () async {
                        if (_currentImage.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('请选择图片！')));
                          return;
                        }
                        _goEditor(context);
                      },
                      child: const Text('编辑照片')),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    _currentImage = image?.path ?? '';
    setState(() {});
  }

  Future<void> _goEditor(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.black,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '加载滤镜中',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    List<FilterData> groups = await _fetchLJ();

    Navigator.pop(context);

    EditorUtil.pushHome(context,
        orignal: _currentImage,
        fs: groups,
        vipStatusCb: () {
          return isVipUser;
        },
        vipActionCb: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const RoutePage();
            },
          ));
        },
        saveCb: (path) {
          GallerySaver.saveImage(path, albumName: 'Flu-Editor');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('保存成功: $path')));
        },
        loadWidgetCb: (islight) =>
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: islight ? Colors.white : Colors.black,
              ),
            ),
        toastActionCb: (msg) =>
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg))),
        effectsCb: (page) async => await _fetchPF(),
        saveEffectCb: (effect) async {
          return await true;
        },
        deleteEffectCb: (id) async {
          return await true;
        });
  }

  Future<List<EffectData>> _fetchPF() async {
    return await [
      EffectData.fromJson({
        'name': 'test',
        'image':
        'https://nwdnui.oss-cn-beijing.aliyuncs.com/user/effectSave/da2752d15d0e48359bbc42c7ec845d3d/1730962077026793.jpg',
        'id': 0,
        'params': jsonEncode({
          "Brightness": 0.14719999999999997,
          "Saturation": 1.0,
          "Contrast": 1.0,
          "Sharpen": 0.0,
          "Shadow": 0.0,
          "Temperature": 0.0,
          "Noise": 0.0,
          "Exposure": 0.0,
          "Vibrance": 0.0,
          "Highlight": 0.0,
          "Red": 1.0,
          "Green": 1.0,
          "Blue": 1.0,
          "CenterX": 0.5,
          "CenterY": 0.5,
          "Start": 1.0,
          "End": 1.0
        })
      })
    ];
  }

  Future<List<FilterData>> _fetchLJ() async {
    FilterDetail detail1 = FilterDetail();
    detail1.id = 1;
    detail1.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/90ad4f7bbd3243c285d4f8aaff5123be.jpg';
    detail1.filterImage =
    'luts/01-x.png';
    detail1.name = '滤镜1';
    detail1.noise = 0.2;
    detail1.vip = 1;
    detail1.lutFrom = 0;

    FilterDetail detail2 = FilterDetail();
    detail2.id = 2;
    detail2.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/90ad4f7bbd3243c285d4f8aaff5123be.jpg';
    detail2.filterImage =
    'luts/03-x.png';
    detail2.name = '滤镜2';
    detail2.lutFrom = 0;

    FilterData group1 = FilterData();
    group1.groupName = '分类1';

    group1.list = [detail1, detail2];

    return [group1];
  }
}
```

## 结语

通过使用 flu_editor，开发者可以轻松实现图像和视频编辑功能，提供了强大的滤镜、裁剪、颜色调整和效果保存等功能。

```

```
