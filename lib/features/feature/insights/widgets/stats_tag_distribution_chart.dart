import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsTagDistributionChart extends StatelessWidget {
  const StatsTagDistributionChart({super.key, required this.distribution});

  final Map<String, double> distribution;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsActivityDistribution),
        const SizedBox(height: 30),
        SizedBox(
          height: 200,
          child: distribution.isEmpty
              ? Center(child: Text(l10n.statsNoTagData))
              : PieChart(PieChartData(sections: _buildSections(context))),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildSections(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = [
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      scheme.primaryContainer,
      scheme.error,
    ];
    var colorIndex = 0;
    return distribution.entries.map((entry) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: tagLabelFromLanguageCode(entry.key, currentLang),
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: scheme.onPrimary,
          shadows: [Shadow(color: scheme.scrim, blurRadius: 2)],
        ),
      );
    }).toList();
  }
}
