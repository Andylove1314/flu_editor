import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../flu_editor.dart';

class NetImage extends StatelessWidget {
  final String url;
  bool isLight;
  BoxFit fit;
  double? width;
  double? height;

  NetImage(
      {required this.url,
      this.isLight = false,
      this.fit = BoxFit.cover,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      fit: fit,
      width: width,
      height: height,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            // 返回一个加载动画
            return EditorUtil.loadingWidget(context, isLight: isLight);
          case LoadState.completed:
            // 图片加载完成，显示图片
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              fit: BoxFit.cover,
            );
          case LoadState.failed:
            // 图片加载失败，显示一个占位图或错误提示
            return const Center(
              child: Icon(Icons.error, color: Colors.red),
            );
          default:
            return Container();
        }
      },
    );
  }
}
