import 'package:notch_app/core/utils/analyzer_core_metrics.dart';
import 'package:notch_app/core/utils/analyzer_insight_service.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class Analyzer {
  Analyzer(this.data, this.healthData);

  final List<Encounter> data;
  final List<HealthLog> healthData;

  AnalyzerCoreMetrics get _metrics => AnalyzerCoreMetrics(data);
  AnalyzerInsightService get _insights => AnalyzerInsightService(data, healthData);

  String getBestDayOfWeek() => _metrics.getBestDayOfWeek();
  String getProtectionStats() => _metrics.getProtectionStats();
  String getMostFrequentTag() => _metrics.getMostFrequentTag();
  Map<String, dynamic> getBestPartner() => _metrics.getBestPartner();
  Map<DateTime, int> getHeatmapData() => _metrics.getHeatmapData();
  Map<String, double> getTagDistribution() => _metrics.getTagDistribution();
  List<Insight> generateInsights(AppLocalizations l10n) => _insights.generate(l10n);
}
