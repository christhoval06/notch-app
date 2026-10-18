import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/insights/services/insights_view_model.dart';

class InsightsMetricsService {
  const InsightsMetricsService._();

  static double protectionRate(List<Encounter> encounters) {
    if (encounters.isEmpty) return 0;
    return encounters.where((item) => item.protected).length /
        encounters.length;
  }

  static double averageRating(List<Encounter> encounters) {
    return encounters.isEmpty
        ? 0.0
        : encounters.map((item) => item.rating).average;
  }

  static DateTime latestEncounter(List<Encounter> encounters) {
    return encounters
        .map((item) => item.date)
        .reduce((a, b) => a.isAfter(b) ? a : b);
  }

  static int? recoveryMonths(List<HealthLog> healthLogs, DateTime now) {
    if (healthLogs.isEmpty) return null;
    final latest = healthLogs.sorted((a, b) => b.date.compareTo(a.date)).first;
    return (now.difference(latest.date).inDays / 30).floor();
  }

  static HealthLog? latestHealthLog(List<HealthLog> healthLogs) {
    if (healthLogs.isEmpty) return null;
    return healthLogs.sorted((a, b) => b.date.compareTo(a.date)).first;
  }

  static InsightsTone latestHealthTone(List<HealthLog> healthLogs) {
    final latest = latestHealthLog(healthLogs);
    if (latest == null) return InsightsTone.neutral;
    final result = latest.result.toLowerCase();
    if (result.contains('positivo') ||
        result.contains('positive') ||
        result.contains('pend')) {
      return InsightsTone.caution;
    }
    return InsightsTone.positive;
  }
}
