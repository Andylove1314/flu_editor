# **flu_editor**

## Language: English | [中文](https://github.com/Andylove1314/flu_editors/blob/1.0.4/README.md)

![Banner](https://github.com/Andylove1314/flu_editors/blob/1.0.0/editor_banner.png)

`flu_editor` is a color filter editing plugin for photos and videos.

| Feature | Status      | Remarks |
|---------|-------------|---------|
| Crop    | Completed   |         |
| Color   | Completed   |         |
| Filter  | Completed   |         |
| Blur    | In Progress |         |
| Sticker | Completed   |         |
| Text    | Completed   |         |
| Frame   | Completed   |         |

## Getting Started

This is a template project for a Flutter plugin, which includes platform-specific code for both
Android and iOS.

For more detailed information on Flutter development, refer to
the [official documentation](https://docs.flutter.dev)，which includes development tutorials,
examples, mobile development guidelines, and the full API reference.

## Features Overview

`flu_editor` provides a variety of image editing features. Below is an overview of the utility
classes:

### EditorUtil Utility Class

### Navigation Instructions

- `goFluEditor`：Navigate to the editor page.
- **Parameter Descriptions**：
    - `context`：The current context, typically using BuildContext to start the editor.
    - `orignal`：The original image path to be edited.
    - `type`：The edit type (null means enter the home page).
    - `singleEditorSave`：Go to a specific editing page. Whether the image is saved to the album when
      closed.
    - `vipStatusCb`：A callback function to return whether the user is a VIP.
    - `vipActionCb`：A callback function to navigate to the subscription page when the user is not a
      VIP.
    - `saveCb`：A callback function to save the edited image, with the save path as a parameter.
    - `loadWidgetCb`：A callback to show a loading animation, with islight (whether it's light mode),
      size (progress bar size), and stroke (progress bar width).
    - `toastActionCb`：A callback to display a custom toast message (e.g., "Save successful").
    - `effectsCb`：A callback to retrieve and process filter recipes.
    - `saveEffectCb`：A callback to save a custom filter recipe.
    - `deleteEffectCb`：A callback to delete a saved filter recipe.
    - `filtersCb`：A callback to retrieve the filter list.
    - `stickersCb`：A callback to retrieve the sticker list.
    - `fontsCb`：A callback to retrieve the font list.
    - `framesCb`：A callback to retrieve the frame list.
    - `homeSavedCb`：A callback to save images on the editor home page.
    - `bannerAdWidgetCb`：banner ad callback.
    - `nativeAdWidgetCb`：native ad callback.
    - `adShowWidgetCb`：ad show callback.

- `Internal Page Routes`：
- **The specific function areas to enter from the editor homepage (do not call directly from the
  app, navigate through goFluEditor(type)).**：

    - `goCropPage`：Navigate to the crop page.
    - `goColorsPage`：Navigate to the crop page.
    - `goFilterPage`：Navigate to the filter edit page.
    - `goStickerPage`：Navigate to the sticker edit page.
    - `goFontPage`：Navigate to the font edit page.
    - `goFramePage`：Navigate to the frame edit page.

### Multi-Language Configuration

- **Add the following delegates and supported locales in MaterialApp**：

```dart

MaterialApp(
localizationsDelegates: const [
GlobalMaterialLocalizations.delegate,
GlobalWidgetsLocalizations.delegate,
GlobalCupertinoLocalizations.delegate,
EditorLang.delegate
],
supportedLocales: [...EditorLang.delegate.supportedLocales],
)

```

## Screenshots

<table>
  <tr>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screen_Recording_20241127_115015%2012.10.21.gif">
        <img src="screenshots/Screen_Recording_20241127_115015%2012.10.21.gif" alt="Screenshot 0" width="250" style="display: block; margin: 10px auto;"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-114447.jpg">
        <img src="screenshots/Screenshot_20241127-114447.jpg" alt="Screenshot 1" width="250" style="margin: 10px;"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-165709.jpg">
        <img src="screenshots/Screenshot_20241127-165709.jpg" alt="Screenshot 2" width="250" style="margin: 10px;"/>
      </a>
    </td>
  </tr>

  <tr>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-114514.jpg">
        <img src="screenshots/Screenshot_20241127-114514.jpg" alt="Screenshot 3" width="250" style="margin: 10px;"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-114536.jpg">
        <img src="screenshots/Screenshot_20241127-114536.jpg" alt="Screenshot 4" width="250" style="margin: 10px;"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-164212.jpg">
        <img src="screenshots/Screenshot_20241127-164212.jpg" alt="Screenshot 5" width="250" style="margin: 10px;"/>
      </a>
    </td>
  </tr>

  <tr>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-114559.jpg">
        <img src="screenshots/Screenshot_20241127-114559.jpg" alt="Screenshot 6" width="250" style="margin: 10px;"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-114641.jpg">
        <img src="screenshots/Screenshot_20241127-114641.jpg" alt="Screenshot 7" width="250" style="margin: 10px;"/>
      </a>
    </td>
    <td>
      <a href="https://github.com/Andylove1314/flu_editors/blob/1.0.1-release/screenshots/Screenshot_20241127-114710.jpg">
        <img src="screenshots/Screenshot_20241127-114710.jpg" alt="Screenshot 8" width="250" style="margin: 10px;"/>
      </a>
    </td>
  </tr>

</table>

## Usage Example

Below is an example of how to use flu_editor for image editing:

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

  /// 当前输入图
  String _currentImage = '';

  bool isVipUser = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _fluEditorPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        EditorLang.delegate
      ],
      supportedLocales: [...EditorLang.delegate.supportedLocales],
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
                  child: Container(
                      width: double.infinity,
                      color: Colors.grey,
                      child: Stack(alignment: Alignment.center, children: [
                        _currentImage.isEmpty
                            ? const SizedBox()
                            : Image.file(File(_currentImage)),
                        GestureDetector(
                          onTap: () {
                            _pickImage(context);
                          },
                          child: Container(
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
                                  'Add photo',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]))),
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
                              const SnackBar(content: Text('Add photo pleasen!')));
                          return;
                        }
                        _goEditor(context);
                      },
                      child: const Text('Go Editor')),
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

    if (image == null) {
      return;
    }

    _currentImage = image?.path ?? '';
    setState(() {});
  }

  Future<void> _goEditor(BuildContext context) async {
    EditorUtil.goFluEditor(context,
        orignal: _currentImage,
        vipStatusCb: () {
          debugPrint('get vip status: $isVipUser');
          return isVipUser;
        },
        vipActionCb: () {
          debugPrint('go Sub');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return RoutePage(title: 'Sub page',);
            },
          ));
        },
        saveCb: (path) async {
          GallerySaver.saveImage(path, albumName: 'Flu-Editor');
        },
        loadWidgetCb: (islight, size, stroke) =>
            Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: islight ? Colors.white : Colors.black,
                strokeWidth: stroke,
              ),
            ),
        toastActionCb: (msg) =>
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg))),
        effectsCb: (page) async => await _fetchPF(),
        saveEffectCb: (effect) async {
          debugPrint('Save pf：${effect.toJson()}');
          return await true;
        },
        deleteEffectCb: (id) async {
          debugPrint('Delete：$id');
          return await true;
        },
        filtersCb: () => _fetchLJ(),
        stickersCb: () => _fetchStickers(),
        fontsCb: () => _fetchFonts(),
        framesCb: () => _fetchFrames(),
        homeSavedCb: (context, after) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return RoutePage(savedPath: after, title: 'Saved page',);
            },
          ));
        });
  }

  Future<List<EffectData>> _fetchPF() async {
    return await [
      EffectData.fromJson({
        'name': 'test',
        'url':
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
    detail1.filterImage = 'luts/01-x.png';
    detail1.name = 'class1';
    detail1.noise = 0.2;
    detail1.vip = 1;
    detail1.lutFrom = 0;

    FilterDetail detail2 = FilterDetail();
    detail2.id = 2;
    detail2.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/90ad4f7bbd3243c285d4f8aaff5123be.jpg';
    detail2.filterImage = 'luts/03-x.png';
    detail2.name = 'class2';
    detail2.lutFrom = 0;

    FilterData group1 = FilterData();
    group1.groupName = 'class1';

    group1.list = [detail1, detail2];

    return [group1];
  }

  Future<List<StickerData>> _fetchStickers() async {
    StickDetail detail1 = StickDetail();
    detail1.id = 1;
    detail1.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/e71b319ebce14952a87a40a03f8e7404.png';
    detail1.name = 'sticker1';
    detail1.vip = 0;

    StickDetail detail2 = StickDetail();
    detail2.id = 1;
    detail2.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/1f0ceb1952a44a4ebd0a8c419a105545.png';
    detail2.name = 'sticker2';
    detail2.vip = 0;

    StickerData group1 = StickerData();
    group1.groupName = 'class1';
    group1.groupImage =
    'https://nwdnui.bigwinepot.com/ui/index/icon/318fa7a144af47f29adbdc73cb7e78b5.png';

    group1.list = [detail1, detail2];

    return [group1];
  }

  Future<List<FontsData>> _fetchFonts() async {
    FontDetail detail1 = FontDetail();
    detail1.id = 1;
    detail1.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/ca9f5c3e742d49c2bafa28c8808a2280.jpg';
    detail1.file =
    'https://nwdnui.bigwinepot.com/ui/index/icon/7be3f3395e5c49b3aec36071c9bacc03.ttf';
    detail1.name = 'font1';
    detail1.vip = 0;

    FontDetail detail2 = FontDetail();
    detail2.id = 2;
    detail2.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/8a2058f31d384c0d952f21661b8f4a3e.jpg';
    detail2.file =
    'https://nwdnui.bigwinepot.com/ui/index/icon/f5d6dbf7914d45eababc0cd395b973ed.ttf';
    detail2.name = 'font2';
    detail2.vip = 0;

    FontsData group1 = FontsData();
    group1.groupName = 'Sample';

    group1.list = [detail1, detail2];

    return [group1];
  }

  Future<List<FrameData>> _fetchFrames() async {
    FrameDetail detail1 = FrameDetail();
    detail1.id = 1;
    detail1.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/6c923546f7ff46d9bf613808b9bce72d.png';
    detail1.name = 'frame1';
    detail1.vip = 0;
    FrameSize size = FrameSize();
    size.frameWidth = 560;
    size.frameHeight = 1000;
    size.frameLeft = 94.0;
    size.frameTop = 142.0;
    size.frameRight = 88.0;
    size.frameBottom = 114.0;
    detail1.params = size;

    FrameDetail detail2 = FrameDetail();
    detail2.id = 2;
    detail2.image =
    'https://nwdnui.bigwinepot.com/ui/index/icon/e0ee85fe76e34fd093729428757e0401.png';
    detail2.name = 'frame2';
    detail2.vip = 0;
    FrameSize size2 = FrameSize();
    size2.frameWidth = 672;
    size2.frameHeight = 1000;
    size2.frameLeft = 136.0;
    size2.frameTop = 154.0;
    size2.frameRight = 136.0;
    size2.frameBottom = 156.0;
    detail2.params = size2;

    FrameData group1 = FrameData();
    group1.groupName = 'Sample';

    group1.list = [detail1, detail2];

    return [group1];
  }
}

```

## Acknowledgements

- **We would like to thank the Flutter team for their excellent development framework and tools.**：
- **Thanks to all the open-source contributors who have made this plugin possible.**：
- **Special thanks to the community for providing valuable feedback and support.**：

- plugin_platform_interface: ^2.0.2
- flutter_gpu_filters_interface: ^0.0.18
- exif: ^3.3.0
- collection: ^1.16.0

- flutter_bloc: ^8.1.6
- equatable: ^2.0.5
- rxdart: ^0.27.7

- flutter_cache_manager: ^3.4.1
- photo_view: ^0.15.0

- auto_size_text: ^3.0.0
- image: ^4.3.0
- extended_image: ^9.0.4
- image_cropper: ^8.0.2
- vibration: ^2.0.1
- haptic_feedback: ^0.5.1+1
- lindi_sticker_widget: ^1.0.1
- crypto: ^3.0.6

## License

MIT License. See [LICENSE](https://github.com/Andylove1314/flu_editors/blob/main/LICENSE) for details.

## Conclusion

By using `flu_editor`, developers can easily implement image and video editing features, offering
powerful capabilities such as filters, cropping, color adjustments, and effect saving.

