import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';
import 'package:notch_app/features/insights/widgets/stats_heatmap_card.dart';
import 'package:notch_app/features/insights/widgets/stats_activity_summary.dart';
import 'package:notch_app/features/insights/widgets/stats_monthly_activity_chart.dart';

class StatsActivitySection extends StatelessWidget {
  const StatsActivitySection({
    super.key,
    required this.period,
    required this.activitySummary,
    required this.encounters,
    required this.monthlyData,
    required this.heatmapData,
  });

  final StatPeriod period;
  final StatsActivitySummary activitySummary;
  final List<Encounter> encounters;
  final List<StatsMonthlyDatum> monthlyData;
  final Map<DateTime, int> heatmapData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsActivitySummaryCard(
          period: period,
          summary: activitySummary,
        ),
        const SizedBox(height: 18),
        StatsHeatmapCard(
          encounters: encounters,
          heatmapData: heatmapData,
          period: period,
        ),
        const SizedBox(height: 28),
        StatsMonthlyActivityChart(monthlyData: monthlyData),
      ],
    );
  }
}
