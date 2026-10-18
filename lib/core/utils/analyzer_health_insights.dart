import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AnalyzerHealthInsights {
  AnalyzerHealthInsights(this.data, this.healthData);

  final List<Encounter> data;
  final List<HealthLog> healthData;

  List<Insight> build(AppLocalizations l10n) {
    final insights = <Insight>[];
    _add(insights, _protectionRecentlyDropped(l10n));
    _add(insights, _longActivityPause(l10n));
    _add(insights, _healthCheckOverdue(l10n));
    return insights;
  }

  Insight? _protectionRecentlyDropped(AppLocalizations l10n) {
    if (data.length < 6) return null;
    final sorted = [...data]..sort((a, b) => a.date.compareTo(b.date));
    final recent = sorted.sublist(sorted.length - 3);
    final previous = sorted.sublist(0, sorted.length - 3);
    if (previous.length < 3) return null;
    final recentRate = _protectionRate(recent);
    final previousRate = _protectionRate(previous);
    if (previousRate - recentRate < 30) return null;
    return Insight(
      title: l10n.insightProtectionRecentlyDroppedTitle,
      description: l10n.insightProtectionRecentlyDroppedDescription(
        recentRate.toStringAsFixed(0),
        previousRate.toStringAsFixed(0),
      ),
      icon: Icons.shield_outlined,
      color: AppColors.warning,
    );
  }

  Insight? _longActivityPause(AppLocalizations l10n) {
    if (data.isEmpty) return null;
    final latest = data.map((item) => item.date).reduce((a, b) => a.isAfter(b) ? a : b);
    final days = DateTime.now().difference(latest).inDays;
    if (days < 45) return null;
    return Insight(
      title: l10n.insightLongActivityPauseTitle,
      description: l10n.insightLongActivityPauseDescription(days.toString()),
      icon: Icons.hotel_outlined,
      color: AppColors.seedBlue,
    );
  }

  Insight? _healthCheckOverdue(AppLocalizations l10n) {
    if (healthData.isEmpty) return null;
    final lastLog = healthData.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    final months = (DateTime.now().difference(lastLog.date).inDays / 30).floor();
    if (months < 9) return null;
    return Insight(
      title: l10n.insightHealthCheckOverdueTitle,
      description: l10n.insightHealthCheckOverdueDescription(months.toString()),
      icon: Icons.health_and_safety_outlined,
      color: AppColors.seedBlue,
    );
  }

  double _protectionRate(List<Encounter> encounters) {
    final protectedCount = encounters.where((item) => item.protected).length;
    return (protectedCount / encounters.length) * 100;
  }

  void _add(List<Insight> insights, Insight? insight) {
    if (insight != null) insights.add(insight);
  }
}
