import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsMonthlyActivityChart extends StatelessWidget {
  const StatsMonthlyActivityChart({super.key, required this.monthlyData});

  final List<StatsMonthlyDatum> monthlyData;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsActivityTrendTitle),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: BarChart(_buildData(context)),
            ),
          ),
        ),
      ],
    );
  }

  BarChartData _buildData(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: _maxY,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => scheme.surfaceContainerHighest,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => _bottomTitle(context, value),
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: _barGroups(context),
    );
  }

  Widget _bottomTitle(BuildContext context, double value) {
    final index = value.toInt();
    if (index < 0 || index >= monthlyData.length) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        monthlyData[index].label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 10,
        ),
      ),
    );
  }

  double get _maxY {
    final max = monthlyData.fold<int>(0, (current, item) => item.value > current ? item.value : current);
    return (max + 2).toDouble();
  }

  List<BarChartGroupData> _barGroups(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return List.generate(monthlyData.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: monthlyData[index].value.toDouble(),
            color: scheme.primary,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _maxY,
              color: scheme.surface,
            ),
          ),
        ],
      );
    });
  }
}
