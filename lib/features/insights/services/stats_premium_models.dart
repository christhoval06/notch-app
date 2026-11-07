import 'package:notch_app/features/insights/services/stats_models.dart';

enum StatsSignalTone { strong, balanced, caution }

class StatsPremiumMetricData {
  const StatsPremiumMetricData({
    required this.id,
    required this.score,
    required this.trend,
    required this.currentValue,
    required this.previousValue,
    this.contextLabel,
    this.auxiliaryValue,
    this.tone = StatsSignalTone.balanced,
  });

  final String id;
  final double score;
  final StatsTrend trend;
  final num currentValue;
  final num previousValue;
  final String? contextLabel;
  final num? auxiliaryValue;
  final StatsSignalTone tone;
}

class StatsPremiumIntelligence {
  const StatsPremiumIntelligence({
    required this.hero,
    required this.signals,
    required this.stories,
  });

  final StatsPremiumMetricData hero;
  final List<StatsPremiumMetricData> signals;
  final List<StatsPremiumMetricData> stories;
}
