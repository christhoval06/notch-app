import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/services/stats_premium_models.dart';
import 'package:notch_app/features/insights/services/stats_story_service.dart';

enum StatPeriod { month, sixMonths, allTime }

enum StatsTrend { up, down, neutral }

enum StatsComparisonState { baseline, up, down, stable }

class StatsMonthlyDatum {
  const StatsMonthlyDatum({required this.label, required this.value});

  final String label;
  final int value;
}

class StatsRankData {
  const StatsRankData({required this.rawLevelName, required this.totalXp});

  final String rawLevelName;
  final int totalXp;
}

class StatsHeroMetric {
  const StatsHeroMetric({
    required this.id,
    required this.currentValue,
    required this.previousValue,
    required this.deltaLabel,
    required this.trend,
  });

  final String id;
  final num currentValue;
  final num previousValue;
  final String deltaLabel;
  final StatsTrend trend;
}

class StatsViewModel {
  const StatsViewModel({
    required this.encounters,
    required this.activitySummary,
    required this.monthlyData,
    required this.heatmapData,
    required this.highestRank,
    required this.heroMetrics,
    required this.comparisonState,
    required this.storyCards,
    required this.premiumIntelligence,
    required this.topPartners,
    required this.tagInsights,
    required this.protectionSummary,
    required this.rhythmSummary,
  });

  final List<Encounter> encounters;
  final StatsActivitySummary activitySummary;
  final List<StatsMonthlyDatum> monthlyData;
  final Map<DateTime, int> heatmapData;
  final StatsRankData highestRank;
  final List<StatsHeroMetric> heroMetrics;
  final StatsComparisonState comparisonState;
  final List<StatsStoryCardData> storyCards;
  final StatsPremiumIntelligence premiumIntelligence;
  final List<StatsPartnerSummary> topPartners;
  final List<StatsTagInsight> tagInsights;
  final StatsProtectionSummary protectionSummary;
  final StatsRhythmSummary rhythmSummary;

  bool get hasData => encounters.isNotEmpty;
}
