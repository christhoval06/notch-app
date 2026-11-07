import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';
import 'package:notch_app/features/insights/services/stats_premium_models.dart';

class StatsPremiumSignalService {
  const StatsPremiumSignalService._();

  static StatsPremiumMetricData consistency(
    List<Encounter> current,
    List<Encounter> previous,
  ) {
    final activeDays = current
        .map((item) => DateTime(item.date.year, item.date.month, item.date.day))
        .toSet()
        .length;
    final previousDays = previous
        .map((item) => DateTime(item.date.year, item.date.month, item.date.day))
        .toSet()
        .length;
    final spanDays = current.isEmpty ? 0 : _spanDays(current);
    final score = spanDays == 0
        ? 0.0
        : (activeDays / (spanDays < 7 ? 7 : spanDays)) * 100;
    return StatsPremiumMetricData(
      id: 'consistency',
      score: score.clamp(0, 100).toDouble(),
      trend: _trend(activeDays.toDouble(), previousDays.toDouble()),
      currentValue: activeDays,
      previousValue: previousDays,
      auxiliaryValue: spanDays,
      tone: score >= 60 ? StatsSignalTone.strong : StatsSignalTone.balanced,
    );
  }

  static StatsPremiumMetricData quality(
    List<Encounter> current,
    List<Encounter> previous,
  ) {
    final currentAvg = current.isEmpty
        ? 0.0
        : current.map((item) => item.rating).average;
    final previousAvg = previous.isEmpty
        ? 0.0
        : previous.map((item) => item.rating).average;
    return StatsPremiumMetricData(
      id: 'quality',
      score: (currentAvg * 10).clamp(0, 100).toDouble(),
      trend: _trend(currentAvg, previousAvg),
      currentValue: currentAvg,
      previousValue: previousAvg,
      tone: currentAvg >= 8
          ? StatsSignalTone.strong
          : currentAvg >= 6
          ? StatsSignalTone.balanced
          : StatsSignalTone.caution,
    );
  }

  static StatsPremiumMetricData partnerMode(
    List<Encounter> current,
    List<Encounter> previous,
  ) {
    final currentGroups = groupBy(
      current,
      (Encounter item) => item.partnerName,
    );
    final previousGroups = groupBy(
      previous,
      (Encounter item) => item.partnerName,
    );
    final currentTop = currentGroups.entries
        .sorted((a, b) => b.value.length.compareTo(a.value.length))
        .firstOrNull;
    final previousTop = previousGroups.entries
        .sorted((a, b) => b.value.length.compareTo(a.value.length))
        .firstOrNull;
    final currentShare = current.isEmpty
        ? 0.0
        : (currentTop?.value.length ?? 0) / current.length;
    final previousShare = previous.isEmpty
        ? 0.0
        : (previousTop?.value.length ?? 0) / previous.length;
    final partners = currentGroups.keys.length;
    return StatsPremiumMetricData(
      id: 'partner_mode',
      score: (currentShare * 100).clamp(0, 100).toDouble(),
      trend: _trend(currentShare, previousShare),
      currentValue: partners,
      previousValue: previousGroups.keys.length,
      contextLabel: currentTop?.key,
      auxiliaryValue: (currentShare * 100).round(),
      tone: partners <= 1
          ? StatsSignalTone.strong
          : partners == 2
          ? StatsSignalTone.balanced
          : StatsSignalTone.caution,
    );
  }

  static StatsPremiumMetricData protection(
    StatsProtectionSummary summary,
    List<Encounter> previous,
  ) {
    final previousRate = previous.isEmpty
        ? summary.protectionRate
        : previous.where((item) => item.protected).length / previous.length;
    return StatsPremiumMetricData(
      id: 'protection',
      score: (summary.protectionRate * 100).toDouble(),
      trend: _trend(summary.protectionRate, previousRate),
      currentValue: (summary.protectionRate * 100).round(),
      previousValue: (previousRate * 100).round(),
      contextLabel: summary.lastUnprotectedPartnerName,
      tone: summary.tone == StatsProtectionTone.caution
          ? StatsSignalTone.caution
          : StatsSignalTone.balanced,
    );
  }

  static StatsPremiumMetricData rhythm(
    StatsRhythmSummary summary,
    List<Encounter> current,
  ) {
    final topCount = summary.bucketCounts[summary.topBucket] ?? 0;
    final share = current.isEmpty ? 0.0 : topCount / current.length;
    return StatsPremiumMetricData(
      id: 'rhythm',
      score: (share * 100).toDouble(),
      trend: share >= 0.55 ? StatsTrend.up : StatsTrend.neutral,
      currentValue: (share * 100).round(),
      previousValue: 0,
      contextLabel: summary.topBucket,
      auxiliaryValue: topCount,
      tone: share >= 0.55 ? StatsSignalTone.strong : StatsSignalTone.balanced,
    );
  }

  static int _spanDays(List<Encounter> encounters) {
    final sorted = encounters.map((item) => item.date).sorted();
    return sorted.last.difference(sorted.first).inDays + 1;
  }

  static StatsTrend _trend(num current, num previous) {
    if (current == previous) return StatsTrend.neutral;
    return current > previous ? StatsTrend.up : StatsTrend.down;
  }
}
