import 'package:notch_app/features/feature/insights/services/stats_models.dart';

class StatsPeriodRangeService {
  const StatsPeriodRangeService._();

  static ({DateTime start, DateTime end}) range(
    StatPeriod period, {
    DateTime? now,
  }) {
    final anchor = now ?? DateTime.now();
    final end = DateTime(anchor.year, anchor.month, anchor.day);
    switch (period) {
      case StatPeriod.month:
        return (start: end.subtract(const Duration(days: 29)), end: end);
      case StatPeriod.sixMonths:
        return (start: end.subtract(const Duration(days: 179)), end: end);
      case StatPeriod.allTime:
        return (start: DateTime(end.year - 1, end.month, end.day), end: end);
    }
  }
}
