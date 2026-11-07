import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/insights/services/insights_metrics_service.dart';
import 'package:notch_app/features/insights/services/insights_view_model.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class InsightsWatchoutService {
  const InsightsWatchoutService._();

  static InsightsEditorialBlockData watchout(
    List<Encounter> encounters,
    List<HealthLog> healthLogs,
    AppLocalizations l10n,
    DateTime now,
  ) {
    final protection = InsightsMetricsService.protectionRate(encounters);
    final avgRating = InsightsMetricsService.averageRating(encounters);
    if (InsightsMetricsService.latestHealthTone(healthLogs) ==
        InsightsTone.caution) {
      return InsightsEditorialBlockData(
        label: l10n.insightsWatchoutLabel,
        headline: l10n.insightsWatchoutHealthHeadline,
        body: l10n.insightsWatchoutHealthBody,
        detail: l10n.insightsWatchoutHealthDetail,
        recommendation: l10n.insightsWatchoutHealthRecommendation,
        icon: Icons.health_and_safety_outlined,
        tone: InsightsTone.caution,
      );
    }
    if (protection < 0.6 && encounters.isNotEmpty) {
      return InsightsEditorialBlockData(
        label: l10n.insightsWatchoutLabel,
        headline: l10n.insightsWatchoutProtectionHeadline,
        body: l10n.insightsWatchoutProtectionBody((protection * 100).round()),
        detail: l10n.insightsWatchoutProtectionDetail,
        recommendation: l10n.insightsWatchoutProtectionRecommendation,
        icon: Icons.shield_outlined,
        tone: InsightsTone.caution,
      );
    }
    final gap = encounters.isEmpty
        ? 0
        : now
              .difference(InsightsMetricsService.latestEncounter(encounters))
              .inDays;
    return InsightsEditorialBlockData(
      label: l10n.insightsWatchoutLabel,
      headline: avgRating < 6
          ? l10n.insightsWatchoutQualityHeadline
          : l10n.insightsWatchoutGapHeadline,
      body: avgRating < 6
          ? l10n.insightsWatchoutQualityBody
          : l10n.insightsWatchoutGapBody(gap),
      detail: avgRating < 6
          ? l10n.insightsWatchoutQualityDetail
          : l10n.insightsWatchoutGapDetail,
      recommendation: avgRating < 6
          ? l10n.insightsWatchoutQualityRecommendation
          : l10n.insightsWatchoutGapRecommendation,
      icon: avgRating < 6 ? Icons.trending_down : Icons.schedule_outlined,
      tone: avgRating < 6 ? InsightsTone.caution : InsightsTone.neutral,
    );
  }

  static List<InsightsRiskSignalData> riskSignals(
    List<Encounter> encounters,
    List<HealthLog> healthLogs,
    AppLocalizations l10n,
    DateTime now,
  ) {
    final protection = InsightsMetricsService.protectionRate(encounters);
    final avgRating = InsightsMetricsService.averageRating(encounters);
    final recoveryMonths = InsightsMetricsService.recoveryMonths(
      healthLogs,
      now,
    );
    return [
      InsightsRiskSignalData(
        label: l10n.insightsRiskProtection,
        value: protection >= 0.8
            ? l10n.insightsRiskLow
            : protection >= 0.6
            ? l10n.insightsRiskGuarded
            : l10n.insightsRiskHigh,
        tone: protection >= 0.8
            ? InsightsTone.positive
            : protection >= 0.6
            ? InsightsTone.neutral
            : InsightsTone.caution,
      ),
      InsightsRiskSignalData(
        label: l10n.insightsRiskRecovery,
        value: recoveryMonths == null || recoveryMonths < 6
            ? l10n.insightsRiskLow
            : recoveryMonths < 9
            ? l10n.insightsRiskGuarded
            : l10n.insightsRiskHigh,
        tone: recoveryMonths == null || recoveryMonths < 6
            ? InsightsTone.positive
            : recoveryMonths < 9
            ? InsightsTone.neutral
            : InsightsTone.caution,
      ),
      InsightsRiskSignalData(
        label: l10n.insightsRiskVariability,
        value: avgRating >= 8
            ? l10n.insightsRiskLow
            : avgRating >= 6
            ? l10n.insightsRiskGuarded
            : l10n.insightsRiskHigh,
        tone: avgRating >= 8
            ? InsightsTone.positive
            : avgRating >= 6
            ? InsightsTone.neutral
            : InsightsTone.caution,
      ),
    ];
  }
}
