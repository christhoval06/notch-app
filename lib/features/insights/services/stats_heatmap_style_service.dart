import 'package:flutter/material.dart';

class StatsHeatmapStyle {
  const StatsHeatmapStyle({
    required this.data,
    required this.colorsets,
  });

  final Map<DateTime, int> data;
  final Map<int, Color> colorsets;
}

class StatsHeatmapStyleService {
  const StatsHeatmapStyleService._();

  static StatsHeatmapStyle build({
    required Map<DateTime, int> data,
    required ColorScheme scheme,
    DateTime? selectedDate,
  }) {
    final maxValue = data.values.fold<int>(0, (max, value) => value > max ? value : max);
    final selectedValue = selectedDate == null ? null : maxValue + 1;
    final styledData = Map<DateTime, int>.from(data);
    if (selectedDate != null && styledData.containsKey(selectedDate)) {
      styledData[selectedDate] = selectedValue!;
    }
    return StatsHeatmapStyle(
      data: styledData,
      colorsets: _colors(
        scheme: scheme,
        maxValue: maxValue,
        selectedValue: selectedValue,
      ),
    );
  }

  static Map<int, Color> _colors({
    required ColorScheme scheme,
    required int maxValue,
    required int? selectedValue,
  }) {
    final colors = <int, Color>{};
    final stops = [
      (1, scheme.primary.withValues(alpha: 0.18)),
      ((maxValue * 0.34).ceil(), scheme.primary.withValues(alpha: 0.34)),
      ((maxValue * 0.58).ceil(), scheme.primary.withValues(alpha: 0.56)),
      (maxValue, scheme.primary.withValues(alpha: 0.88)),
    ];
    for (final (threshold, color) in stops) {
      colors[threshold < 1 ? 1 : threshold] = color;
    }
    if (selectedValue != null) {
      colors[selectedValue] = scheme.tertiary;
    }
    return colors;
  }
}
