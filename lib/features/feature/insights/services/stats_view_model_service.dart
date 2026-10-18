import 'package:collection/collection.dart';
import 'package:notch_app/core/utils/analyzer.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/features/feature/insights/services/stats_activity_summary_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_filter_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_overview_metrics_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_partner_summary_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_premium_intelligence_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_protection_summary_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_summary_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_tag_summary_service.dart';

class StatsViewModelService {
  const StatsViewModelService._();

  static StatsViewModel build(StatPeriod period) {
    return buildFromData(
      period: period,
      encounters: EncounterRepository.getAll(),
      highestRank: StatsOverviewMetricsService.highestRank(),
    );
  }

  static StatsViewModel buildFromData({
    required StatPeriod period,
    required List<Encounter> encounters,
    required StatsRankData highestRank,
    DateTime? now,
  }) {
    final filtered = StatsFilterService.filter(
      encounters: encounters,
      period: period,
      segment: StatsSegment.all,
      now: now,
    );
    final analyzer = Analyzer(filtered.current, []);
    final avgRating = filtered.current.isEmpty
        ? 0.0
        : filtered.current.map((item) => item.rating).average;
    final protectionSummary = StatsProtectionSummaryService.build(
      current: filtered.current,
      previous: filtered.previous,
    );
    final rhythmSummary = StatsRhythmSummaryService.build(filtered.current);

    return StatsViewModel(
      encounters: filtered.current,
      activitySummary: StatsActivitySummaryService.build(
        filtered.current,
        now: now,
      ),
      monthlyData: StatsOverviewMetricsService.monthlyData(
        filtered.current,
        now ?? DateTime.now(),
      ),
      heatmapData: analyzer.getHeatmapData(),
      highestRank: highestRank,
      heroMetrics: StatsOverviewMetricsService.heroMetrics(
        filtered.current,
        filtered.previous,
        avgRating,
      ),
      comparisonState: StatsOverviewMetricsService.summaryState(
        filtered.current.length,
        filtered.previous.length,
      ),
      storyCards: StatsStoryService.build(
        current: filtered.current,
        previous: filtered.previous,
      ),
      premiumIntelligence: StatsPremiumIntelligenceService.build(
        current: filtered.current,
        previous: filtered.previous,
        protectionSummary: protectionSummary,
        rhythmSummary: rhythmSummary,
      ),
      topPartners: StatsPartnerSummaryService.build(filtered.current),
      tagInsights: StatsTagSummaryService.build(filtered.current),
      protectionSummary: protectionSummary,
      rhythmSummary: rhythmSummary,
    );
  }
}
