import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';

enum StatsSegment { all, partner, tags, protection, dayTime }

class StatsFilterResult {
  const StatsFilterResult({
    required this.current,
    required this.previous,
  });

  final List<Encounter> current;
  final List<Encounter> previous;
}

class StatsFilterService {
  const StatsFilterService._();

  static const _allSelection = 'all';

  static StatsFilterResult filter({
    required List<Encounter> encounters,
    required StatPeriod period,
    required StatsSegment segment,
    DateTime? now,
    String? selection,
  }) {
    final anchor = now ?? DateTime.now();
    return StatsFilterResult(
      current: _applySegment(
        periodSlice(encounters, period, anchor),
        segment,
        selection,
      ),
      previous: _applySegment(
        _previousSlice(encounters, period, anchor),
        segment,
        selection,
      ),
    );
  }

  static List<Encounter> periodSlice(
    List<Encounter> encounters,
    StatPeriod period,
    DateTime anchor,
  ) {
    if (period == StatPeriod.allTime) return encounters;
    final days = period == StatPeriod.month ? 30 : 180;
    final start = anchor.subtract(Duration(days: days));
    return encounters.where((item) => item.date.isAfter(start)).toList();
  }

  static List<Encounter> _previousSlice(
    List<Encounter> encounters,
    StatPeriod period,
    DateTime anchor,
  ) {
    if (period == StatPeriod.allTime) return const [];
    final days = period == StatPeriod.month ? 30 : 180;
    final end = anchor.subtract(Duration(days: days));
    final start = end.subtract(Duration(days: days));
    return encounters
        .where((item) => item.date.isAfter(start) && !item.date.isAfter(end))
        .toList();
  }

  static List<Encounter> _applySegment(
    List<Encounter> encounters,
    StatsSegment segment,
    String? selection,
  ) {
    if (selection == null || selection == _allSelection) {
      return encounters;
    }
    switch (segment) {
      case StatsSegment.all:
        return encounters;
      case StatsSegment.partner:
        return encounters.where((item) => item.partnerName == selection).toList();
      case StatsSegment.tags:
        return encounters.where((item) => item.tags.contains(selection)).toList();
      case StatsSegment.protection:
        final isProtected = selection == 'protected';
        return encounters.where((item) => item.protected == isProtected).toList();
      case StatsSegment.dayTime:
        return encounters.where((item) => _bucket(item.date.hour) == selection).toList();
    }
  }

  static String _bucket(int hour) {
    if (hour < 12) return 'morning';
    if (hour < 18) return 'afternoon';
    return 'night';
  }
}
