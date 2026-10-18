import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/core/utils/analyzer_partner_insights.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AnalyzerContextInsights {
  AnalyzerContextInsights(this.data);

  final List<Encounter> data;

  List<Insight> build(AppLocalizations l10n) {
    final insights = <Insight>[];
    _add(insights, _bestTagCombo(l10n));
    _add(insights, _strongestRecentMonth(l10n));
    insights.addAll(AnalyzerPartnerInsights(data).build(l10n));
    return insights;
  }

  Insight? _bestTagCombo(AppLocalizations l10n) {
    final grouped = groupBy(
      data.where((item) => item.tags.length >= 2),
      (Encounter item) => ([...item.tags]..sort()).join('|'),
    );
    String? bestKey;
    var bestAverage = 0.0;
    grouped.forEach((key, encounters) {
      if (encounters.length < 2) return;
      final average = encounters.map((item) => item.rating).average;
      if (average > bestAverage) {
        bestAverage = average;
        bestKey = key;
      }
    });
    if (bestKey == null) return null;
    final labels = bestKey!
        .split('|')
        .map((tag) => tagLabelFromL10n(l10n, tag))
        .join(' + ');
    return Insight(
      title: l10n.insightBestTagComboTitle,
      description: l10n.insightBestTagComboDescription(
        labels,
        bestAverage.toStringAsFixed(1),
      ),
      icon: Icons.auto_awesome,
      color: AppColors.seedBlue,
    );
  }

  Insight? _strongestRecentMonth(AppLocalizations l10n) {
    final now = DateTime.now();
    DateTime? bestMonth;
    var bestCount = 0;
    var bestAverage = 0.0;
    var bestScore = 0.0;
    for (var offset = 0; offset < 6; offset++) {
      final month = DateTime(now.year, now.month - offset, 1);
      final encounters = data.where((item) {
        return item.date.year == month.year && item.date.month == month.month;
      }).toList();
      if (encounters.length < 2) continue;
      final average = encounters.map((item) => item.rating).average;
      final score = average * encounters.length;
      if (score > bestScore) {
        bestScore = score;
        bestMonth = month;
        bestCount = encounters.length;
        bestAverage = average;
      }
    }
    if (bestMonth == null) return null;
    final monthLabel = DateFormat('MMMM y', l10n.localeName).format(bestMonth);
    return Insight(
      title: l10n.insightStrongestRecentMonthTitle,
      description: l10n.insightStrongestRecentMonthDescription(
        monthLabel,
        bestCount.toString(),
        bestAverage.toStringAsFixed(1),
      ),
      icon: Icons.calendar_month,
      color: AppColors.warning,
    );
  }

  void _add(List<Insight> insights, Insight? insight) {
    if (insight != null) insights.add(insight);
  }
}
