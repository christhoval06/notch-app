import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/analyzer.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/insights/services/insights_metrics_service.dart';
import 'package:notch_app/features/feature/insights/services/insights_view_model.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class InsightsEditorialService {
  const InsightsEditorialService._();

  static InsightsHeroData hero(
    List<Encounter> encounters,
    List<HealthLog> healthLogs,
    AppLocalizations l10n,
  ) {
    final protection = InsightsMetricsService.protectionRate(encounters);
    final avgRating = InsightsMetricsService.averageRating(encounters);
    if (encounters.isEmpty && healthLogs.isEmpty) {
      return InsightsHeroData(
        eyebrow: l10n.insightsHeroEyebrow,
        title: l10n.insightsHeroEmptyTitle,
        summary: l10n.insightsHeroEmptyBody,
        primaryChip: l10n.insightsHeroChipStarting,
        secondaryChip: l10n.insightsHeroChipNoSignals,
        tone: InsightsTone.neutral,
      );
    }
    if (InsightsMetricsService.latestHealthTone(healthLogs) ==
        InsightsTone.caution) {
      return InsightsHeroData(
        eyebrow: l10n.insightsHeroEyebrow,
        title: l10n.insightsHeroHealthTitle,
        summary: l10n.insightsHeroHealthBody,
        primaryChip: l10n.insightsHeroProtectionChip(
          (protection * 100).round(),
        ),
        secondaryChip: l10n.insightsHeroHealthLogsChip(healthLogs.length),
        tone: InsightsTone.caution,
      );
    }
    if (protection >= 0.8) {
      return InsightsHeroData(
        eyebrow: l10n.insightsHeroEyebrow,
        title: l10n.insightsHeroProtectionTitle,
        summary: l10n.insightsHeroProtectionBody((protection * 100).round()),
        primaryChip: l10n.insightsHeroQualityChip(avgRating.toStringAsFixed(1)),
        secondaryChip: l10n.insightsHeroEncountersChip(encounters.length),
        tone: InsightsTone.positive,
      );
    }
    return InsightsHeroData(
      eyebrow: l10n.insightsHeroEyebrow,
      title: l10n.insightsHeroRhythmTitle,
      summary: l10n.insightsHeroRhythmBody(avgRating.toStringAsFixed(1)),
      primaryChip: l10n.insightsHeroProtectionChip((protection * 100).round()),
      secondaryChip: l10n.insightsHeroEncountersChip(encounters.length),
      tone: avgRating >= 7 ? InsightsTone.positive : InsightsTone.neutral,
    );
  }

  static InsightsEditorialBlockData bestPattern(
    List<Encounter> encounters,
    Analyzer analyzer,
    AppLocalizations l10n,
  ) {
    final bestPartner = analyzer.getBestPartner();
    if ((bestPartner['name'] as String) != 'N/A') {
      return InsightsEditorialBlockData(
        label: l10n.insightsBestPatternLabel,
        headline: l10n.insightsBestPatternPartnerHeadline(
          bestPartner['name'] as String,
        ),
        body: l10n.insightsBestPatternPartnerBody(
          (bestPartner['avg'] as double).toStringAsFixed(1),
        ),
        detail: l10n.insightsBestPatternPartnerDetail(
          bestPartner['name'] as String,
        ),
        recommendation: l10n.insightsBestPatternPartnerRecommendation,
        icon: Icons.favorite_outline,
        tone: InsightsTone.positive,
      );
    }
    return InsightsEditorialBlockData(
      label: l10n.insightsBestPatternLabel,
      headline: l10n.insightsBestPatternRhythmHeadline(
        analyzer.getBestDayOfWeek(),
      ),
      body: l10n.insightsBestPatternRhythmBody(analyzer.getMostFrequentTag()),
      detail: l10n.insightsBestPatternRhythmDetail(analyzer.getBestDayOfWeek()),
      recommendation: l10n.insightsBestPatternRhythmRecommendation,
      icon: Icons.auto_awesome_outlined,
      tone: encounters.isEmpty ? InsightsTone.neutral : InsightsTone.positive,
    );
  }

  static InsightsEditorialBlockData healthSnapshot(
    List<HealthLog> healthLogs,
    AppLocalizations l10n,
    DateTime now,
  ) {
    final latest = InsightsMetricsService.latestHealthLog(healthLogs);
    if (latest == null) {
      return InsightsEditorialBlockData(
        label: l10n.insightsHealthSnapshotLabel,
        headline: l10n.insightsHealthSnapshotEmptyHeadline,
        body: l10n.insightsHealthSnapshotEmptyBody,
        detail: l10n.insightsHealthSnapshotEmptyDetail,
        recommendation: l10n.insightsHealthSnapshotEmptyRecommendation,
        icon: Icons.monitor_heart_outlined,
        tone: InsightsTone.neutral,
      );
    }
    return InsightsEditorialBlockData(
      label: l10n.insightsHealthSnapshotLabel,
      headline: l10n.insightsHealthSnapshotHeadline(
        latest.result,
        latest.testType,
      ),
      body: l10n.insightsHealthSnapshotBody(
        InsightsMetricsService.recoveryMonths(healthLogs, now) ?? 0,
      ),
      detail: l10n.insightsHealthSnapshotDetail(latest.testType),
      recommendation: l10n.insightsHealthSnapshotRecommendation,
      icon: Icons.fact_check_outlined,
      tone: InsightsMetricsService.latestHealthTone(healthLogs),
    );
  }
}
