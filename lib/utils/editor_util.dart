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

  static EditorHomeCubit? _homeCubit;
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
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => SourceImageCubit(afterPath),
        child: const EditorStickerPage(),
      ),
      transitionDuration: _transDur,
      // You can adjust the duration
      transitionsBuilder: _transAnim,
    ));
  }

  static void goFluEditor(BuildContext context,
      {required String orignal,
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
      CloseEditorCallback? closeEditorCb}) {
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

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<EditorHomeCubit>(create: (context) {
              _homeCubit = EditorHomeCubit(orignal);
              return _homeCubit!;
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

    /// 更新 home after
    _homeCubit?.emit(
      EditorHomeState(exportPath),
    );

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

  static Future<void> cropImage(ImageEditorController croperController) async {
    var state = croperController.state;

    if (state == null || state.getCropRect() == null) {
      return;
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

    /// 更新 home after
    _homeCubit?.emit(
      EditorHomeState(exportPath),
    );
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

  static Widget loadingWidget(BuildContext context, {bool isLight = true}) {
    return Center(
      child: loadingWidgetCallback?.call(isLight) ??
          const CircularProgressIndicator(),
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

    _homeCubit = null;
    filterList.clear();
    stickerList.clear();
    fontList.clear();
    frameList.clear();
    closeEditorCallback?.call(after);
    Future.delayed(const Duration(milliseconds: 200), (){
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
}
