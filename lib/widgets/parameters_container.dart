import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

import 'slider_number_parameter.dart';

extension ParametersContainer on FilterConfiguration {
  ///当前color 参数列表
  List<ConfigurationParameter> currentParameter(List<String> names) {
    return parameters
        .where((parameter) => names.contains(parameter.name))
        .toList();
  }

  /// 参数设置widget
  Iterable<Widget> colorsEffectChildren(
      void Function(ConfigurationParameter) onChanged,
      {required Map<String, double> paramMap,
      required List<String> paramNames}) {
    /// ...colors widget
    final params = currentParameter(paramNames)
        .whereNot((e) => e.hidden)
        .whereNot((e) => e is NumberParameter && e is! RangeNumberParameter)
        .whereNot((e) => e is DataParameter)
        .whereNot((e) => e is ColorParameter)
        .whereNot((e) => e is OptionStringParameter)
        .map((e) {
      if (e is RangeNumberParameter) {
        return SliderNumberParameterWidget(
          initValue: paramMap[e.name] ?? 0.0,
          showNumber: 50,
          parameter: e,
          showUndoNext: true,
          onChanged: () {
            onChanged.call(e);
          },
        );
      }
      return Text('Unknown: ${e.name}');
    });

    return [
      ...params,
    ];
  }

  /// 参数设置widget
  Iterable<Widget> filtersDataChildren(
      void Function(ConfigurationParameter) onChanged,
      {required Map<String, double> paramMap,
      required List<String> paramNames}) {
    /// ...filters data widget
    final datas = currentParameter(paramNames).whereType().map(
      (e) {
        if (e is RangeNumberParameter) {
          return SliderNumberParameterWidget(
            initValue: paramMap[e.name] ?? 0.0,
            parameter: e,
            showUndoNext: false,
            onChanged: () {
              onChanged.call(e);
            },
          );
        }
        return const SizedBox();
      },
    );

    return [...datas];
  }
}
