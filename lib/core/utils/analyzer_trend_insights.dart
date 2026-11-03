import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AnalyzerTrendInsights {
  AnalyzerTrendInsights(this.data, this.healthData);

  final List<Encounter> data;
  final List<HealthLog> healthData;

  List<Insight> build(AppLocalizations l10n) {
    final insights = <Insight>[];
    _add(insights, _frequencyTrend(l10n));
    _add(insights, _qualityStreak(l10n));
    _add(insights, _healthLogReminder(l10n));
    _add(insights, _bestDayOfWeek(l10n));
    _add(insights, _protectionStats(l10n));
    _add(insights, _mostFrequentTag(l10n));
    return insights;
  }

  Insight? _frequencyTrend(AppLocalizations l10n) {
    final now = DateTime.now();
    final currentCount = data.where((item) => item.date.year == now.year && item.date.month == now.month).length;
    final lastMonth = now.subtract(const Duration(days: 30));
    final lastCount = data.where((item) => item.date.year == lastMonth.year && item.date.month == lastMonth.month).length;
    if (lastCount < 2 || currentCount < 2) return null;
    final diff = (currentCount - lastCount) / lastCount * 100;
    if (diff.abs() <= 20) return null;
    return Insight(
      title: l10n.insightRhythmChangeTitle,
      description: l10n.insightRhythmChangeDescription(
        diff > 0 ? l10n.insightIncreased : l10n.insightDecreased,
        diff.abs().toStringAsFixed(0),
      ),
      icon: Icons.trending_up,
      color: diff > 0 ? AppColors.success : AppColors.warning,
    );
  }

  Insight? _qualityStreak(AppLocalizations l10n) {
    var streak = 0;
    final sorted = List<Encounter>.from(data)..sort((a, b) => b.date.compareTo(a.date));
    for (final encounter in sorted) {
      if (encounter.rating < 8) break;
      streak++;
    }
    if (streak < 3) return null;
    return Insight(
      title: l10n.insightInTheZoneTitle,
      description: l10n.insightInTheZoneDescription(streak.toString()),
      icon: Icons.military_tech,
      color: AppColors.warning,
    );
  }

  Insight? _healthLogReminder(AppLocalizations l10n) {
    if (healthData.isEmpty) return null;
    final lastLog = healthData.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    final monthsSince = DateTime.now().difference(lastLog.date).inDays / 30;
    if (monthsSince < 6) return null;
    return Insight(
      title: l10n.insightHealthCheckTitle,
      description: l10n.insightHealthCheckDescription,
      icon: Icons.local_hospital,
      color: AppColors.seedBlue,
    );
  }

  Insight? _bestDayOfWeek(AppLocalizations l10n) {
    if (data.length < 5) return null;
    final dayRatings = <int, List<int>>{};
    for (final encounter in data) {
      dayRatings.putIfAbsent(encounter.date.weekday, () => []).add(encounter.rating);
    }
    var bestDay = 0;
    var bestAverage = 0.0;
    dayRatings.forEach((day, ratings) {
      if (ratings.length < 2) return;
      final average = ratings.average;
      if (average > bestAverage) {
        bestAverage = average;
        bestDay = day;
      }
    });
    if (bestDay == 0) return null;
    final dayNames = [
      '',
      l10n.insightDayMonday,
      l10n.insightDayTuesday,
      l10n.insightDayWednesday,
      l10n.insightDayThursday,
      l10n.insightDayFriday,
      l10n.insightDaySaturday,
      l10n.insightDaySunday,
    ];
    return Insight(
      title: l10n.insightGoldenDayTitle,
      description: l10n.insightGoldenDayDescription(
        dayNames[bestDay],
        bestAverage.toStringAsFixed(1),
      ),
      icon: Icons.calendar_today,
      color: AppColors.warning,
    );
  }

  Insight? _protectionStats(AppLocalizations l10n) {
    if (data.length < 3) return null;
    final protectedCount = data.where((item) => item.protected).length;
    final percentage = (protectedCount / data.length) * 100;
    return Insight(
      title: l10n.insightProtectionStatsTitle,
      description: l10n.insightProtectionStatsDescription(
        percentage.toStringAsFixed(0),
      ),
      icon: Icons.security,
      color: AppColors.success,
    );
  }

  Insight? _mostFrequentTag(AppLocalizations l10n) {
    final tagCounts = <String, int>{};
    for (final encounter in data) {
      for (final tag in encounter.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    if (tagCounts.isEmpty) return null;
    final mostFrequentTag = (tagCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key;
    return Insight(
      title: l10n.insightDominantStyleTitle,
      description: l10n.insightDominantStyleDescription(
        tagLabelFromL10n(l10n, mostFrequentTag),
      ),
      icon: Icons.local_offer,
      color: Colors.purpleAccent,
    );
  }

  void _add(List<Insight> insights, Insight? insight) {
    if (insight != null) insights.add(insight);
  }
}
