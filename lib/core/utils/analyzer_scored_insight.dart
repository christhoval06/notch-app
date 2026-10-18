import 'package:notch_app/data/models/insight.dart';

class ScoredInsight {
  const ScoredInsight({
    required this.insight,
    required this.category,
    required this.score,
  });

  final Insight insight;
  final String category;
  final double score;

  static double compose({
    required double impact,
    required double confidence,
    required double recency,
    required double novelty,
  }) {
    return _clamp(impact) * 0.45 +
        _clamp(confidence) * 0.25 +
        _clamp(recency) * 0.20 +
        _clamp(novelty) * 0.10;
  }

  static double _clamp(double value) {
    return value.clamp(0, 100).toDouble();
  }
}
