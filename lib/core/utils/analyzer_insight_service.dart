import 'package:notch_app/core/utils/analyzer_context_insights.dart';
import 'package:notch_app/core/utils/analyzer_health_insights.dart';
import 'package:notch_app/core/utils/analyzer_scored_insight.dart';
import 'package:notch_app/core/utils/analyzer_scoring_service.dart';
import 'package:notch_app/core/utils/analyzer_summary_insights.dart';
import 'package:notch_app/core/utils/analyzer_trend_insights.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AnalyzerInsightService {
  static const _maxInsights = 4;

  AnalyzerInsightService(this.data, this.healthData);

  final List<Encounter> data;
  final List<HealthLog> healthData;

  List<Insight> generate(AppLocalizations l10n) {
    final scoring = AnalyzerScoringService(data, healthData);
    final categories = [
      _score('summary', AnalyzerSummaryInsights(data).build(l10n), scoring),
      _score('context', AnalyzerContextInsights(data).build(l10n), scoring),
      _score(
        'health',
        AnalyzerHealthInsights(data, healthData).build(l10n),
        scoring,
      ),
      _score('trend', AnalyzerTrendInsights(data, healthData).build(l10n), scoring),
    ];
    final selected = categories
        .where((insights) => insights.isNotEmpty)
        .map(_pickStrongest)
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return selected.take(_maxInsights).map((item) => item.insight).toList();
  }

  List<ScoredInsight> _score(
    String category,
    List<Insight> insights,
    AnalyzerScoringService scoring,
  ) {
    return insights.map((insight) => scoring.score(category, insight)).toList();
  }

  ScoredInsight _pickStrongest(List<ScoredInsight> insights) {
    final sorted = [...insights]
      ..sort((a, b) => b.score.compareTo(a.score));
    return sorted.first;
  }
}
