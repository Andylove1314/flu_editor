part of '../../flu_editor.dart';

class EditorUtil {
  /// 页面切换动画
  static Duration get _transDur => const Duration(milliseconds: 200);

  ///效果临时目录
  static final _tmpEffectDir = '/tmpEffectDir';

  /// 业务回调
  static VipStatusCallback? vipStatusCallback;
  static VipActionCallback? vipActionCallback;
  static SaveCallback? saveCallback;
  static LoadingWidgetCallback? loadingWidgetCallback;
  static ToastActionCallback? toastActionCallback;
  static SaveEffectCallback? saveEffectCallback;
  static DeleteEffectCallback? deleteEffectCallback;
  static EffectsCallback? effectsCallback;

  static FiltersCallback? filtersCallback;
  static StickersCallback? stickersCallback;
  static FontsCallback? fontsCallback;
  static FramesCallback? framesCallback;
  static CloseEditorCallback? closeEditorCallback;

  static EditorHomeCubit? homeCubit;
  static EditorType? editorType;
  static bool singleEditorSavetoAlbum = true;
  static List<FilterData> filterList = [];
  static List<StickerData> stickerList = [];
  static List<FontsData> fontList = [];
  static List<FrameData> frameList = [];

  static Widget _transAnim(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static void goFilterPage(BuildContext context, String afterPath) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => SourceImageCubit(afterPath),
        child: const EditorFilterPage(),
      ),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goColorsPage(BuildContext context, String afterPath) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => SourceImageCubit(afterPath),
        child: const EditorColorsPage(),
      ),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goCropPage(BuildContext context, String afterPath) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => CutCubit(afterPath),
        child: const EditorCropPage(),
      ),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goStickerPage(BuildContext context, String afterPath) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          EditorStickerPage(afterPath: afterPath),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goFontPage(BuildContext context, String afterPath) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditorFontPage(
        afterPath: afterPath,
      ),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goFramePage(BuildContext context, String afterPath) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditorFramePage(
        afterPath: afterPath,
      ),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goFluEditor(BuildContext context,
      {required String orignal,
      EditorType? type,
      bool singleEditorSave = true,
      VipStatusCallback? vipStatusCb,
      VipActionCallback? vipActionCb,
      SaveCallback? saveCb,
      LoadingWidgetCallback? loadWidgetCb,
      ToastActionCallback? toastActionCb,
      SaveEffectCallback? saveEffectCb,
      DeleteEffectCallback? deleteEffectCb,
      EffectsCallback? effectsCb,
      FiltersCallback? filtersCb,
      StickersCallback? stickersCb,
      FontsCallback? fontsCb,
      FramesCallback? framesCb,
      CloseEditorCallback? closeEditorCb}) async {
    _registerMultGlsl();

    vipStatusCallback = vipStatusCb;
    vipActionCallback = vipActionCb;
    saveCallback = saveCb;
    loadingWidgetCallback = loadWidgetCb;
    toastActionCallback = toastActionCb;
    saveEffectCallback = saveEffectCb;
    deleteEffectCallback = deleteEffectCb;
    effectsCallback = effectsCb;
    filtersCallback = filtersCb;
    stickersCallback = stickersCb;
    fontsCallback = fontsCb;
    framesCallback = framesCb;
    closeEditorCallback = closeEditorCb;

    editorType = type;

    singleEditorSavetoAlbum = singleEditorSave;

    if (EditorType.crop == type) {
      goCropPage(context, orignal);
      return;
    }

    if (EditorType.colors == type) {
      goColorsPage(context, orignal);
      return;
    }

    if (EditorType.filter == type) {
      if (filterList.isEmpty) {
        await EditorUtil.fetchFilterList(context);
      }
      goFilterPage(context, orignal);
      return;
    }

    if (EditorType.blur == type) {
      /// todo
      return;
    }

    if (EditorType.sticker == type) {
      if (fontList.isEmpty) {
        await EditorUtil.fetchStickerList(context);
      }
      goStickerPage(context, orignal);
      return;
    }

    if (EditorType.text == type) {
      if (fontList.isEmpty) {
        await EditorUtil.fetchFontList(context);
      }
      goFontPage(context, orignal);
      return;
    }

    if (EditorType.frame == type) {
      if (fontList.isEmpty) {
        await EditorUtil.fetchFrameList(context);
      }
      goFramePage(context, orignal);
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<EditorHomeCubit>(create: (context) {
              homeCubit = EditorHomeCubit(orignal);
              return homeCubit!;
            }),
            // ...
          ],
          child: EditorHomePage(orignal: orignal),
        );
      },
    ));
  }

  /// 颜色组合滤镜 着色器语言
  static void _registerMultGlsl() {
    /// none
    register<NoneShaderConfiguration>(
      () => FragmentProgram.fromAsset('none2'.shader),
    );

    /// filters
    // register<SquareLookupTableShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('lookup2'.shader),
    // );

    register<SquareLookupTableNoiseShaderConfiguration>(
      () => FragmentProgram.fromAsset('lookup_noise'.shader),
    );

    // register<HALDLookupTableShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('hald_lookup2'.shader),
    // );

    /// colors
    register<ColorsMulitConfiguration>(
      () => FragmentProgram.fromAsset('colors_mulit'.shader),
    );

    // register<SharpenShaderConfiguration>(
    //   () => FragmentProgram.fromAsset('sharpen'.shader),
    // );
    //
    // register<TemperatureShaderConfiguration>(
    //   () => FragmentProgram.fromAsset('temperature'.shader),
    // );
    //
    // register<ShadowShaderConfiguration>(
    //   () => FragmentProgram.fromAsset('shadow'.shader),
    // );
    //
    // register<NoiseShaderConfiguration>(
    //   () => FragmentProgram.fromAsset('noise'.shader),
    // );
    //
    // register<VignetteShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('vignette2'.shader),
    // );
    //
    // register<WhiteBalanceShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('whitebalance2'.shader),
    // );
    //
    // register<VibranceShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('vibrance2'.shader),
    // );
    //
    // register<ContrastShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('contrast2'.shader),
    // );
    //
    // register<ExposureShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('exposure2'.shader),
    // );
    //
    // register<BrightnessShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('brightness2'.shader),
    // );
    //
    // register<SaturationShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('saturation2'.shader),
    // );
    //
    // register<HighlightShaderConfiguration>(
    //   () => FragmentProgram.fromAsset('highlight'.shader),
    // );
    //
    // register<HueShaderConfiguration2>(
    //   () => FragmentProgram.fromAsset('hue2'.shader),
    // );
  }

  static Future<String> exportImage(
      BuildContext context, ShaderConfiguration configuration) async {
    final texture = context.read<SourceImageCubit>().state.textureSource;

    if (texture == null) {
      return '';
    }

    final image = await configuration.export(
      texture,
      Size(texture.width.toDouble(), texture.height.toDouble()),
    );
    final bytes = await image.toByteData();
    if (bytes == null) {
      throw UnsupportedError('Failed to extract bytes for image');
    }

    final image1 = img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: bytes.buffer,
      numChannels: 4,
    );

    File output =
        await _createTmp('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await img.encodeJpgFile(output.path, image1);

    String exportPath = output.path;
    debugPrint('Exported: $exportPath');

    return exportPath;
  }

  static Future<List> fileToUint8ListAndImage(String filePath) async {
    return await compute(_processFile, filePath);
  }

// 用于 isolate 中运行的函数
  static Future<List> _processFile(String filePath) async {
    File file = File(filePath);
    Uint8List fileBytes = await file.readAsBytes();
    img.Image? image = await _uint8ListToImage(fileBytes);
    return [image, fileBytes];
  }

  static Future<img.Image?> _uint8ListToImage(Uint8List uint8List) async {
    // 解码 Uint8List 为 ui.Image
    img.Image? image = await img.decodeImage(uint8List);

    return image;
  }

  static Future<String> cropImage(
      ImageEditorController croperController) async {
    var state = croperController.state;

    if (state == null || state.getCropRect() == null) {
      return '';
    }

    // 仅处理剪裁参数，不涉及 UI 操作
    var cropParams = _prepareCropParams(
      state.rawImageData,
      state.getCropRect()!,
      state.editAction?.rotateDegrees ?? 0.0,
      croperController.editActionDetails?.needFlip ?? false,
    );

    // 在后台 isolate 中执行图片剪裁操作
    var data = await compute(_cropImageWithThread, cropParams);

    File output =
        await _createTmp('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await output.writeAsBytes(data!);

    String exportPath = output.path;
    debugPrint('Exported: $exportPath');

    return exportPath;
  }

  // 图片剪裁所需参数的封装
  static Map<String, dynamic> _prepareCropParams(
      Uint8List imageBytes, Rect cropRect, double degree, bool needFlip) {
    return {
      'imageBytes': imageBytes,
      'rect': cropRect,
      'degree': degree,
      'needFlip': needFlip,
    };
  }

  static Future<Uint8List?> _cropImageWithThread(
      Map<String, dynamic> params) async {
    Uint8List imageBytes = params['imageBytes'];
    Rect rect = params['rect'];
    double degree = params['degree'];
    bool needFlip = params['needFlip'];

    img.Command cropTask = img.Command();
    cropTask.decodeImage(imageBytes);

    cropTask.copyRotate(angle: degree);
    if (needFlip) {
      cropTask.copyFlip(direction: img.FlipDirection.horizontal);
    }
    cropTask.copyCrop(
      x: rect.topLeft.dx.ceil(),
      y: rect.topLeft.dy.ceil(),
      height: rect.height.ceil(),
      width: rect.width.ceil(),
    );

    img.Command encodeTask = img.Command();
    encodeTask.subCommand = cropTask;
    encodeTask.encodeJpg();

    return encodeTask.getBytesThread();
  }

  static Future<File> _createTmp(String name) async {
    final directory = await getTemporaryDirectory();
    final tmpdir = Directory('${directory.path}$_tmpEffectDir');
    if (!(await tmpdir.exists())) {
      await tmpdir.create();
    }

    for (FileSystemEntity entity in tmpdir.listSync()) {
      if (entity is File) {
        // 删除文件
        await entity.delete();
        debugPrint('Deleted file: ${entity.path}');
      } else if (entity is Directory) {
        // 删除子目录及其内容
        await entity.delete(recursive: true);
        debugPrint('Deleted directory: ${entity.path}');
      }
    }

    final output = File(
      '${tmpdir.path}/$name',
    );
    await output.create();

    return output;
  }

  static void showLoadingdialog(BuildContext context, {bool isLight = true}) {
    showDialog(
        context: context,
        builder: (con) => loadingWidget(context, isLight: isLight));
  }

  static Widget loadingWidget(BuildContext context,
      {bool isLight = true, double size = 30.0, double stroke = 2.0}) {
    return Center(
      child: loadingWidgetCallback?.call(isLight, size, stroke) ??
          SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: stroke,
              )),
    );
  }

  static void showToast(String msg) {
    toastActionCallback?.call(msg);
  }

  static Future<bool?> saveColorEffectParam(
      List<ConfigurationParameter> params, String path, String name) async {
    // 创建一个 Map 用于存储参数
    Map<String, dynamic> paramMap = {};
    for (var param in params) {
      paramMap[param.name] = (param as NumberParameter).value * 1.0;
    }

    return await saveEffectCallback?.call(
        EffectData(name: name, image: path, params: jsonEncode(paramMap)));
  }

  static Future<List<EffectData>> fetchSavedParamList(int page) async {
    var effects = await effectsCallback?.call(page) ?? [];

    return effects;
  }

  static Future<bool?> deleteEffect(id) async {
    return await deleteEffectCallback?.call(id);
  }

  static void clearTmpObject(String after) {
    vipStatusCallback = null;
    vipActionCallback = null;
    saveCallback = null;
    loadingWidgetCallback = null;
    toastActionCallback = null;
    saveEffectCallback = null;
    deleteEffectCallback = null;
    effectsCallback = null;

    filtersCallback = null;
    stickersCallback = null;
    fontsCallback = null;

    homeCubit = null;
    filterList.clear();
    stickerList.clear();
    fontList.clear();
    frameList.clear();
    editorType == null;
    singleEditorSavetoAlbum = true;
    closeEditorCallback?.call(after);
    Future.delayed(const Duration(milliseconds: 200), () {
      closeEditorCallback = null;
    });
  }

  static Future<Uint8List> loadSourceImage(String afterPath) async {
    final fbyte = await compute(_loadFileBytes, afterPath);
    return fbyte;
  }

  // 在后台 isolate 执行文件读取操作
  static Future<Uint8List> _loadFileBytes(String filePath) async {
    final file = File(filePath);
    return await file.readAsBytes();
  }

  static Future<List<FilterData>> fetchFilterList(BuildContext context) async {
    showLoadingdialog(context);
    var filters = await filtersCallback?.call() ?? [];

    ///配置滤镜
    filterList = [];
    for (FilterData f in filters) {
      /// 插入空滤镜
      List<FilterDetail> lists = f.list ?? [];
      if (filters.indexOf(f) == 0 && lists.isNotEmpty) {
        lists.insert(
            0,
            FilterDetail(
                id: -1,
                filterImage: 'neutral_color_luts'.lutPng,
                image: lists[0].image,
                name: '无滤镜',
                lutFrom: 0));
      }

      f.list = lists;
      filterList.add(f);
    }
    Navigator.pop(context);
    return filterList;
  }

  static Future<List<StickerData>> fetchStickerList(
      BuildContext context) async {
    showLoadingdialog(context);
    var stickers = await stickersCallback?.call() ?? [];

    stickerList = stickers;
    Navigator.pop(context);

    return stickerList;
  }

  static Future<List<FontsData>> fetchFontList(BuildContext context) async {
    showLoadingdialog(context);
    var fonts = await fontsCallback?.call() ?? [];
    fontList = fonts;
    Navigator.pop(context);
    return fontList;
  }

  static Future<List<FrameData>> fetchFrameList(BuildContext context) async {
    showLoadingdialog(context);
    var frames = await framesCallback?.call() ?? [];
    frameList = frames;
    Navigator.pop(context);
    return frameList;
  }

  static Future<String> addSticker(
      String input, LindiController stickerController) async {
    // 1. 加载 input 原始图片
    var inputBytes = (await fileToUint8ListAndImage(input))[1];
    final ui.Codec codec = await ui.instantiateImageCodec(inputBytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ui.Image baseImage = frame.image;

    // 2. 获取贴纸图片的 Uint8List 数据
    Uint8List? stickerImageBytes = await stickerController.saveAsUint8List();
    if (stickerImageBytes == null) {
      return '';
    }
    final ui.Codec codec2 = await ui.instantiateImageCodec(stickerImageBytes);
    final ui.FrameInfo frame2 = await codec2.getNextFrame();
    final ui.Image stickerImage = frame2.image;
    if (stickerImage == null) {
      return '';
    }

    // 3. 创建画布并合成图片
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final Paint paint = Paint();
    // 在画布上绘制原图
    canvas.drawImage(baseImage, Offset.zero, paint);

    // 将 stickerImage 绘制到 baseImage 上
    canvas.drawImageRect(
      stickerImage,
      Rect.fromLTWH(
          0, 0, stickerImage.width.toDouble(), stickerImage.height.toDouble()),
      // 原始 sticker 的矩形区域
      Rect.fromLTWH(
          0, 0, baseImage.width.toDouble(), baseImage.height.toDouble()),
      // 目标区域（缩放后的矩形）
      Paint(),
    );

    canvas.save();

    // 将画布内容转换为图片
    final ui.Image composedImage = await recorder
        .endRecording()
        .toImage(baseImage.width, baseImage.height);

    // 4. 将合成后的图像转换为 Uint8List
    final ByteData? byteData =
        await composedImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List composedImageBytes = byteData!.buffer.asUint8List();

    // 5. 保存合成后的图片
    File output =
        await _createTmp('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await output.writeAsBytes(composedImageBytes);

    return output.path;
  }

  static Future<String> addFrame(GlobalKey imgkey, String input, String frame,
      double frameAspectRatio) async {
    /// 输入图
    // img.Image inputImage = (await fileToUint8ListAndImage(input))[0];

    /// 生成底图
    // 获取RepaintBoundary对应的RenderObject
    RenderRepaintBoundary boundary =
        imgkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // 渲染为图片
    ui.Image baseImage = await boundary.toImage(pixelRatio: 3.0);

    /// 获取相框图
    var inputBytes = (await fileToUint8ListAndImage(frame))[1];
    final ui.Codec codec = await ui.instantiateImageCodec(inputBytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image frameImage = frameInfo.image;

    /// 获取输入图片的宽高
    final int inputWidth = baseImage.width;
    final int inputHeight = baseImage.height;

    /// 计算画布大小
    double canvasWidth, canvasHeight;
    if (inputWidth / inputHeight > frameAspectRatio) {
      canvasWidth = inputWidth.toDouble();
      canvasHeight = inputWidth / frameAspectRatio;
    } else {
      canvasHeight = inputHeight.toDouble();
      canvasWidth = inputHeight * frameAspectRatio;
    }

    /// 创建画布并绘制图片
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas =
        Canvas(recorder, Rect.fromLTWH(0, 0, canvasWidth, canvasHeight));
    final Paint paint = Paint();

    // 计算居中位置
    double inputOffsetX = (canvasWidth - inputWidth) / 2;
    double inputOffsetY = (canvasHeight - inputHeight) / 2;

    // 绘制输入图片
    canvas.drawImage(baseImage, Offset(inputOffsetX, inputOffsetY), paint);

    // 绘制相框图片
    double frameWidth = frameImage.width.toDouble();
    double frameHeight = frameImage.height.toDouble();

    // 将相框适应到画布大小
    final Rect frameRect = Rect.fromLTWH(0, 0, canvasWidth, canvasHeight);
    final Rect srcRect = Rect.fromLTWH(0, 0, frameWidth, frameHeight);

    canvas.drawImageRect(frameImage, srcRect, frameRect, paint);
    canvas.restore();

    /// 将合成的图片保存为PNG格式
    final ui.Image finalImage = await recorder
        .endRecording()
        .toImage(canvasWidth.toInt(), canvasHeight.toInt());
    final ByteData? byteData =
        await finalImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    /// 保存图片
    File output =
        await _createTmp('${DateTime.now().millisecondsSinceEpoch}.png');
    await output.writeAsBytes(pngBytes);

    return output.path;
  }

  static Future<String> addText(
      String input, LindiController stickerController) async {
    // 1. 加载 input 原始图片
    var inputBytes = (await fileToUint8ListAndImage(input))[1];
    final ui.Codec codec = await ui.instantiateImageCodec(inputBytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ui.Image baseImage = frame.image;

    // 2. 获取贴纸图片的 Uint8List 数据
    Uint8List? stickerImageBytes = await stickerController.saveAsUint8List();
    if (stickerImageBytes == null) {
      return '';
    }
    final ui.Codec codec2 = await ui.instantiateImageCodec(stickerImageBytes);
    final ui.FrameInfo frame2 = await codec2.getNextFrame();
    final ui.Image stickerImage = frame2.image;
    if (stickerImage == null) {
      return '';
    }

    // 3. 创建画布并合成图片
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final Paint paint = Paint();
    // 在画布上绘制原图
    canvas.drawImage(baseImage, Offset.zero, paint);

    // 将 stickerImage 绘制到 baseImage 上
    canvas.drawImageRect(
      stickerImage,
      Rect.fromLTWH(
          0, 0, stickerImage.width.toDouble(), stickerImage.height.toDouble()),
      // 原始 sticker 的矩形区域
      Rect.fromLTWH(
          0, 0, baseImage.width.toDouble(), baseImage.height.toDouble()),
      // 目标区域（缩放后的矩形）
      Paint(),
    );

    canvas.save();

    // 将画布内容转换为图片
    final ui.Image composedImage = await recorder
        .endRecording()
        .toImage(baseImage.width, baseImage.height);

    // 4. 将合成后的图像转换为 Uint8List
    final ByteData? byteData =
        await composedImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List composedImageBytes = byteData!.buffer.asUint8List();

    // 5. 保存合成后的图片
    File output =
        await _createTmp('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await output.writeAsBytes(composedImageBytes);

    return output.path;
  }
}
