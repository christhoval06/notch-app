import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

enum StatsStoryTone { positive, neutral, caution }

class StatsStoryCardData {
  const StatsStoryCardData({
    required this.id,
    required this.title,
    required this.headline,
    required this.supporting,
    required this.tone,
  });

  final String id;
  final String title;
  final String headline;
  final String supporting;
  final StatsStoryTone tone;
}

class StatsStoryService {
  const StatsStoryService._();

  static List<StatsStoryCardData> build({
    required List<Encounter> current,
    required List<Encounter> previous,
  }) {
    final cards = <StatsStoryCardData>[];
    final bestContext = _bestContext(current);
    if (bestContext != null) cards.add(bestContext);
    final momentum = _momentum(current, previous);
    if (momentum != null) cards.add(momentum);
    final protectionTrend = _protectionTrend(current, previous);
    if (protectionTrend != null) cards.add(protectionTrend);
    final primeTime = _primeTime(current);
    if (primeTime != null) cards.add(primeTime);
    final peakMonth = _peakMonth(current);
    if (peakMonth != null) cards.add(peakMonth);
    return cards;
  }

  static StatsStoryCardData? _bestContext(List<Encounter> current) {
    final scores = <String, List<int>>{};
    for (final encounter in current) {
      for (final tag in encounter.tags) {
        scores.putIfAbsent(tag, () => []).add(encounter.rating);
      }
    }
    final best = scores.entries
        .where((entry) => entry.value.length >= 2)
        .map((entry) => MapEntry(entry.key, entry.value.average))
        .sorted((a, b) => b.value.compareTo(a.value))
        .firstOrNull;
    if (best == null) return null;
    return StatsStoryCardData(
      id: 'best_context',
      title: 'Best context',
      headline: best.key,
      supporting: 'Average rating ${best.value.toStringAsFixed(1)}',
      tone: StatsStoryTone.positive,
    );
  }

  static StatsStoryCardData? _momentum(
    List<Encounter> current,
    List<Encounter> previous,
  ) {
    if (current.isEmpty || previous.isEmpty) return null;
    final delta = current.length - previous.length;
    if (delta == 0) return null;
    return StatsStoryCardData(
      id: 'momentum',
      title: 'Momentum',
      headline: delta > 0 ? 'Activity is up' : 'Activity is down',
      supporting: '${delta.abs()} encounter change vs previous period',
      tone: delta > 0 ? StatsStoryTone.positive : StatsStoryTone.caution,
    );
  }

  static StatsStoryCardData? _protectionTrend(
    List<Encounter> current,
    List<Encounter> previous,
  ) {
    if (current.isEmpty || previous.isEmpty) return null;
    final currentRate = current.where((item) => item.protected).length / current.length;
    final previousRate = previous.where((item) => item.protected).length / previous.length;
    final delta = currentRate - previousRate;
    if (delta.abs() < 0.2) return null;
    return StatsStoryCardData(
      id: 'protection_trend',
      title: 'Protection trend',
      headline: delta > 0 ? 'Protection is up' : 'Protection is down',
      supporting: '${(currentRate * 100).round()}% vs ${(previousRate * 100).round()}%',
      tone: delta > 0 ? StatsStoryTone.positive : StatsStoryTone.caution,
    );
  }

  static StatsStoryCardData? _primeTime(List<Encounter> current) {
    final grouped = groupBy(current, (Encounter item) => '${item.date.weekday}-${_bucket(item.date.hour)}');
    final best = grouped.entries
        .where((entry) => entry.value.length >= 2)
        .map((entry) => MapEntry(entry.key, entry.value.map((item) => item.rating).average))
        .sorted((a, b) => b.value.compareTo(a.value))
        .firstOrNull;
    if (best == null) return null;
    return StatsStoryCardData(
      id: 'prime_time',
      title: 'Prime time',
      headline: best.key,
      supporting: 'Average rating ${best.value.toStringAsFixed(1)}',
      tone: StatsStoryTone.positive,
    );
  }

  static StatsStoryCardData? _peakMonth(List<Encounter> current) {
    final grouped = groupBy(current, (Encounter item) => DateFormat('yyyy-MM').format(item.date));
    final best = grouped.entries
        .where((entry) => entry.value.length >= 2)
        .map((entry) => MapEntry(entry.key, entry.value.map((item) => item.rating).average))
        .sorted((a, b) => b.value.compareTo(a.value))
        .firstOrNull;
    if (best == null) return null;
    return StatsStoryCardData(
      id: 'peak_month',
      title: 'Peak month',
      headline: best.key,
      supporting: 'Average rating ${best.value.toStringAsFixed(1)}',
      tone: StatsStoryTone.positive,
    );
  }

  static String _bucket(int hour) {
    if (hour < 12) return 'morning';
    if (hour < 18) return 'afternoon';
    return 'night';
  }
}
