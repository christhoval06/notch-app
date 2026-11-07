import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:notch_app/features/insights/widgets/stats_heatmap_footer.dart';

class StatsHeatmapPanel extends StatelessWidget {
  const StatsHeatmapPanel({
    super.key,
    required this.periodKey,
    required this.startDate,
    required this.endDate,
    required this.data,
    required this.colorsets,
    required this.textColor,
    required this.surfaceColor,
    required this.borderColor,
    required this.selectedDate,
    required this.selectedCount,
    required this.onTap,
  });

  final Object periodKey;
  final DateTime startDate;
  final DateTime endDate;
  final Map<DateTime, int> data;
  final Map<int, Color> colorsets;
  final Color textColor;
  final Color surfaceColor;
  final Color borderColor;
  final DateTime? selectedDate;
  final int? selectedCount;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(periodKey),
      duration: const Duration(milliseconds: 340),
      tween: Tween(begin: 0.985, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          children: [
            HeatMap(
              startDate: startDate,
              endDate: endDate,
              datasets: data,
              fontSize: 10,
              textColor: textColor,
              colorMode: ColorMode.color,
              scrollable: true,
              borderRadius: 5,
              size: 18,
              showColorTip: false,
              colorTipCount: 0,
              colorsets: colorsets,
              onClick: onTap,
            ),
            const SizedBox(height: 12),
            StatsHeatmapFooter(
              selectedDate: selectedDate,
              selectedCount: selectedCount,
            ),
          ],
        ),
      ),
    );
  }
}
