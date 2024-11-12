import 'package:flutter/material.dart';

import '../../flu_editor.dart';
import '../../models/lut_data.dart';
import 'filter_widget.dart';

class FiltersList extends StatefulWidget {
  final List<FilterDetail> fds;

  final Function({FilterDetail? item}) onChanged;
  Function()? onScrollNext;
  Function()? onScrollPre;

  final SquareLookupTableNoiseShaderConfiguration sourceFiltersConfig;

  FilterDetail? usingDetail;

  FiltersList(
      {super.key,
      required this.fds,
      required this.sourceFiltersConfig,
      required this.onChanged,
      this.onScrollNext,
      this.onScrollPre,
      this.usingDetail});

  @override
  State<FiltersList> createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  int currentIndex = -1;

  late ScrollController _scrollController;

  @override
  void initState() {
    if (widget.usingDetail == null) {
      currentIndex = 0;
    } else if (widget.fds.contains(widget.usingDetail)) {
      currentIndex = widget.fds.indexOf(widget.usingDetail!);
    }

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent + 40) {
          _onReachedEnd();
        } else if (_scrollController.position.pixels <=
            _scrollController.position.minScrollExtent - 40) {
          _onReachedStart();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 73,
        child: ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          // 设置为横向滚动
          itemCount: widget.fds.length,
          itemBuilder: (c, i) {
            bool selected = currentIndex == i;
            FilterDetail item = widget.fds[i];
            bool vipFilter = item.isVipFilter;

            return Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                      height: 73,
                      width: 60,
                      color: Colors.white,
                      child: FilterWidget(
                        filterDetail: item,
                        onSelect: (fd) {
                          if (fd == null) {
                            return;
                          }
                          _changeFilter(fd, detail: item)
                              .then((s) => widget.onChanged.call(item: item));
                          setState(() {
                            currentIndex = i;
                          });
                        },
                        // ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 15,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(4),
                            bottomLeft: Radius.circular(4))),
                    alignment: Alignment.center,
                    child: Text(
                      item.name ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                if (vipFilter)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.only(topRight: Radius.circular(4)),
                      child: Image.asset(
                        'icon_vip_lvjing'.imageFiltersPng,
                        width: 21,
                      ),
                    ),
                  ),
                IgnorePointer(
                  child: Container(
                    height: 73,
                    width: 60,
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.black.withOpacity(0.6)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                if (selected)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'pic_lvjing_s_edit'.imageFiltersPng,
                        width: 22,
                      ),
                    ),
                  )
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 5,
            );
          },
        ));
  }

  /// 修改滤镜
  Future<void> _changeFilter(DataItem value, {FilterDetail? detail}) async {
    if (value is LutFileDataItem) {
      widget.sourceFiltersConfig.lutParamter.file = value.file;
      widget.sourceFiltersConfig.lutParamter.asset = null;
      widget.sourceFiltersConfig.lutParamter.data = null;
    } else if (value is LutAssetDataItem) {
      widget.sourceFiltersConfig.lutParamter.file = null;
      widget.sourceFiltersConfig.lutParamter.asset = value.asset;
      widget.sourceFiltersConfig.lutParamter.data = null;
    }

    await widget.sourceFiltersConfig.lutParamter
        .update(widget.sourceFiltersConfig);

    /// add noise
    widget.sourceFiltersConfig.noiseStrength = (detail?.noise ?? 0.0) * 1.0;
  }

  void _onReachedEnd() {
    debugPrint('toend');
    widget.onScrollNext?.call();
  }

  void _onReachedStart() {
    debugPrint('tostart');
    widget.onScrollPre?.call();
  }
}
