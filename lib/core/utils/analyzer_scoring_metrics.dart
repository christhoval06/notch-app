import 'package:notch_app/data/models/encounter.dart';

class AnalyzerScoringMetrics {
  AnalyzerScoringMetrics(this.data);

  final List<Encounter> data;

  double bestPartnerBonus(String description, List<double> values) {
    final average = _bestPartnerAverage();
    if (average == null) return 0;
    final mentionsPartner = data
        .map((item) => item.partnerName)
        .where((name) => name.isNotEmpty)
        .any(description.contains);
    if (!mentionsPartner) return 0;
    return (_matchesMetric(_primaryValue(values), average) ? 18 : 10).toDouble();
  }

  double streakBonus(List<double> values) {
    final streak = _currentHighRatingStreak();
    if (streak < 3) return 0;
    return _matchesMetric(_primaryValue(values), streak.toDouble()) ? 24 : 0;
  }

  double recentActivityScore() {
    if (data.isEmpty) return 40;
    final latest = data
        .map((item) => item.date)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    final days = DateTime.now().difference(latest).inDays;
    if (days <= 7) return 95;
    if (days <= 30) return 85;
    if (days <= 90) return 70;
    return 55;
  }

  double? _bestPartnerAverage() {
    final grouped = <String, List<int>>{};
    for (final item in data) {
      grouped.putIfAbsent(item.partnerName, () => []).add(item.rating);
    }
    double? best;
    for (final ratings in grouped.values) {
      if (ratings.length < 3) continue;
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      if (best == null || average > best) best = average;
    }
    return best;
  }

  int _currentHighRatingStreak() {
    final sorted = [...data]..sort((a, b) => b.date.compareTo(a.date));
    var streak = 0;
    for (final item in sorted) {
      if (item.rating < 8) break;
      streak++;
    }
    return streak;
  }

  double _primaryValue(List<double> values) {
    return values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b);
  }

  bool _matchesMetric(double value, double metric) {
    return (value - metric).abs() <= 0.6;
  }
}
