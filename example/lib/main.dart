import 'dart:convert';
import 'dart:io';

import 'package:flu_editor/models/effect_data.dart';
import 'package:flu_editor_example/route_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flu_editor/flu_editor.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

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
          debugPrint('get vip status: $isVipUser');
          return isVipUser;
        },
        vipActionCb: () {
          debugPrint('go Sub');
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
        loadWidgetCb: (islight) => Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: islight ? Colors.white : Colors.black,
              ),
            ),
        toastActionCb: (msg) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg))),
        effectsCb: (page) async => await _fetchPF(),
        saveEffectCb: (effect) async {
          debugPrint('保存配方：${effect.toJson()}');
          return await true;
        },
        deleteEffectCb: (id) async {
          debugPrint('删除配方：$id');
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
