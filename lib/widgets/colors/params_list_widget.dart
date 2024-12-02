import 'dart:io';

import 'package:flu_editor/flu_editor.dart';
import 'package:flu_editor/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../net_image.dart';

class ParamsListWidget extends StatefulWidget {
  final double bottom;
  final Function(EffectData effect) applyPf;
  final Function() recover;

  const ParamsListWidget(
      {super.key,
      required this.bottom,
      required this.applyPf,
      required this.recover});

  @override
  State<StatefulWidget> createState() {
    return _ParamsListWidgetState();
  }
}

class _ParamsListWidgetState extends State<ParamsListWidget> {
  int _index = -1;
  int _currentPage = 1;
  List<EffectData> _effects = [];
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadEffects(_currentPage);

    // 添加滚动监听器
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        // 滚动到底部时加载更多
        _loadMoreEffects();
      }
    });
  }

  Future<void> _loadEffects(int page) async {
    List<EffectData> newEffects = await EditorUtil.fetchSavedParamList(page);
    setState(() {
      _effects.addAll(newEffects);
    });
  }

  Future<void> _loadMoreEffects() async {
    setState(() {
      _isLoadingMore = true;
    });
    _currentPage++;
    await _loadEffects(_currentPage);
    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        widget.bottom;

    return Container(
      alignment: Alignment.bottomCenter,
      constraints: BoxConstraints(maxHeight: maxHeight),
      width: 95,
      decoration: BoxDecoration(
        color: const Color(0xff19191A).withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _effects.isNotEmpty
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !_isLoadingMore) {
                  _loadMoreEffects();
                }
                return true;
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Wrap(
                  direction: Axis.vertical,
                  children: _effects
                      .map((item) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 77,
                            height: 77,
                            child: GestureDetector(
                              onTap: () {
                                if (_effects.indexOf(item) != _index) {
                                  widget.applyPf.call(item);
                                  setState(() {
                                    _index = _effects.indexOf(item);
                                  });
                                } else {
                                  setState(() {
                                    _index = -1;
                                  });
                                  widget.recover.call();
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _item(
                                    item, _effects.indexOf(item) == _index),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            )
          : Center(
              child: Text(
                EditorLang.of(context).editor_color_pf_no,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
    );
  }

  Widget _item(EffectData item, bool selected) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _fetchSrc(item),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
              alignment: Alignment.center,
              child: Text(
                item.name,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )),
        Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
                onTap: () async {
                  bool? deleted = await EditorUtil.deleteEffect(item.id);
                  EditorUtil.toastActionCallback?.call(deleted == true
                      ? EditorLang.of(context)
                          .editor_color_delete_pf_successfully
                      : EditorLang.of(context).editor_color_delete_pf_faild);
                  if (deleted == true) {
                    setState(() {
                      _index = -1;
                      _effects.remove(item);
                    });
                  }
                },
                child: Image.asset(
                  'icon_delete_peifang'.imagePng,
                  width: 20,
                ))),
        Visibility(
            visible: selected,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffFF799E), width: 2)),
            ))
      ],
    );
  }

  Widget _fetchSrc(EffectData item) {
    if (item.asset != null) {
      return Image.asset(
        item.image ?? '',
        fit: BoxFit.cover,
      );
    } else if (item.path != null) {
      return Image.file(File(item.path ?? ''), fit: BoxFit.cover);
    }
    return NetImage(
      url: item.image ?? '',
      isLight: true,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
