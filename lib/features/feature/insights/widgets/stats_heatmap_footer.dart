import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_heatmap_legend.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_heatmap_selection_label.dart';

class StatsHeatmapFooter extends StatelessWidget {
  const StatsHeatmapFooter({
    super.key,
    required this.selectedDate,
    required this.selectedCount,
  });

  final DateTime? selectedDate;
  final int? selectedCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatsHeatmapLegend(),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: selectedCount == null
              ? const SizedBox(key: ValueKey('empty-selection'), height: 20)
              : StatsHeatmapSelectionLabel(
                  key: ValueKey('$selectedDate-$selectedCount'),
                  date: selectedDate!,
                  count: selectedCount!,
                ),
        ),
      ],
    );
  }
}
