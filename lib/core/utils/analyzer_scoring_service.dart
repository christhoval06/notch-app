import 'package:notch_app/core/utils/analyzer_scored_insight.dart';
import 'package:notch_app/core/utils/analyzer_scoring_metrics.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/insight.dart';

class AnalyzerScoringService {
  AnalyzerScoringService(this.data, this.healthData);

  final List<Encounter> data;
  final List<HealthLog> healthData;

  AnalyzerScoringMetrics get _metrics => AnalyzerScoringMetrics(data);

  ScoredInsight score(String category, Insight insight) {
    final values = _extractNumbers(insight.description);
    return ScoredInsight(
      insight: insight,
      category: category,
      score: switch (category) {
        'summary' => _summaryScore(insight.description, values),
        'context' => _contextScore(values),
        'health' => _healthScore(values),
        'trend' => _trendScore(values),
        _ => _genericScore(values),
      },
    );
  }

  double _summaryScore(String description, List<double> values) {
    final base = ScoredInsight.compose(
      impact: _primaryValue(values) * 10,
      confidence: data.length * 14,
      recency: _metrics.recentActivityScore(),
      novelty: 55 + _multiValueBonus(values),
    );
    return _withBonus(base, _metrics.bestPartnerBonus(description, values));
  }

  double _contextScore(List<double> values) {
    return ScoredInsight.compose(
      impact: _primaryValue(values) * 9 + _valueSpread(values) * 6,
      confidence: data.length * 12,
      recency: _metrics.recentActivityScore(),
      novelty: 65 + _multiValueBonus(values),
    );
  }

  double _healthScore(List<double> values) {
    return ScoredInsight.compose(
      impact: _healthImpact(values),
      confidence: data.length * 8 + (healthData.isNotEmpty ? 20 : 0),
      recency: _metrics.recentActivityScore() + 10,
      novelty: 60 + _multiValueBonus(values),
    );
  }

  double _trendScore(List<double> values) {
    final base = ScoredInsight.compose(
      impact: _primaryValue(values) * 12 + _valueSpread(values) * 4,
      confidence: data.length * 12,
      recency: 90,
      novelty: 62 + _multiValueBonus(values),
    );
    return _withBonus(base, _metrics.streakBonus(values));
  }

  double _genericScore(List<double> values) {
    return ScoredInsight.compose(
      impact: _primaryValue(values) * 10,
      confidence: data.length * 10,
      recency: _metrics.recentActivityScore(),
      novelty: 50 + _multiValueBonus(values),
    );
  }

  double _healthImpact(List<double> values) {
    if (values.length >= 2) {
      return _valueSpread(values) * 1.4;
    }
    return _primaryValue(values) * 10;
  }

  double _primaryValue(List<double> values) {
    return values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b);
  }

  double _valueSpread(List<double> values) {
    if (values.length < 2) return 0;
    final sorted = [...values]..sort();
    return sorted.last - sorted.first;
  }

  double _multiValueBonus(List<double> values) {
    return (values.length - 1).clamp(0, 4) * 5;
  }

  double _withBonus(double score, double bonus) {
    return (score + bonus).clamp(0, 100).toDouble();
  }

  List<double> _extractNumbers(String text) {
    return RegExp(r'(\d+(?:\.\d+)?)')
        .allMatches(text)
        .map((match) => double.parse(match.group(1)!))
        .toList();
  }
}
