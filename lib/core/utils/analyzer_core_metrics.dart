import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

class AnalyzerCoreMetrics {
  AnalyzerCoreMetrics(this.data);

  final List<Encounter> data;

  String getBestDayOfWeek() {
    if (data.isEmpty) return 'N/A';
    final dayRatings = <String, List<int>>{};
    for (final encounter in data) {
      final dayName = DateFormat('EEEE').format(encounter.date);
      dayRatings.putIfAbsent(dayName, () => []).add(encounter.rating);
    }
    var bestDay = '';
    var bestAverage = 0.0;
    dayRatings.forEach((day, ratings) {
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      if (average > bestAverage) {
        bestAverage = average;
        bestDay = day;
      }
    });
    return bestDay;
  }

  String getProtectionStats() {
    if (data.isEmpty) return '0%';
    final protectedCount = data.where((item) => item.protected).length;
    final percentage = (protectedCount / data.length) * 100;
    return '${percentage.toStringAsFixed(1)}%';
  }

  String getMostFrequentTag() {
    if (data.isEmpty) return 'Ninguno';
    final tagCounts = <String, int>{};
    for (final encounter in data) {
      for (final tag in encounter.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    if (tagCounts.isEmpty) return 'Ninguno';
    final sortedKeys = tagCounts.keys.toList(growable: false)
      ..sort((a, b) => tagCounts[b]!.compareTo(tagCounts[a]!));
    return sortedKeys.first;
  }

  Map<String, dynamic> getBestPartner() {
    if (data.isEmpty) return {'name': 'N/A', 'avg': 0.0};
    final partnerRatings = <String, List<int>>{};
    for (final encounter in data) {
      partnerRatings.putIfAbsent(encounter.partnerName, () => []).add(encounter.rating);
    }
    var bestPartner = '';
    var maxAverage = 0.0;
    partnerRatings.forEach((name, ratings) {
      if (ratings.length < 2) return;
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      if (average > maxAverage) {
        maxAverage = average;
        bestPartner = name;
      }
    });
    if (bestPartner.isEmpty) return {'name': 'N/A', 'avg': 0.0};
    return {'name': bestPartner, 'avg': maxAverage};
  }

  Map<DateTime, int> getHeatmapData() {
    final dataset = <DateTime, int>{};
    for (final encounter in data) {
      final dateOnly = DateTime(
        encounter.date.year,
        encounter.date.month,
        encounter.date.day,
      );
      dataset[dateOnly] = (dataset[dateOnly] ?? 0) + 1;
    }
    return dataset;
  }

  Map<String, double> getTagDistribution() {
    final tagCounts = <String, int>{};
    for (final encounter in data) {
      for (final tag in encounter.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    return tagCounts.map((key, value) => MapEntry(key, value.toDouble()));
  }
}
