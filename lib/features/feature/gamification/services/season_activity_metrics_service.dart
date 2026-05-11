import 'package:notch_app/data/models/encounter.dart';

class SeasonActivityMetrics {
  const SeasonActivityMetrics({
    required this.nightShare,
    required this.peakHour,
    required this.weeklyChangePercent,
    required this.totalEncounters,
    required this.peakWindowStartHour,
    required this.peakWindowShare,
  });

  final double nightShare;
  final int? peakHour;
  final double? weeklyChangePercent;
  final int totalEncounters;
  final int? peakWindowStartHour;
  final double peakWindowShare;
}

class SeasonActivityMetricsService {
  static SeasonActivityMetrics build({
    required List<Encounter> allEncounters,
    required String monthId,
  }) {
    final seasonEncounters = allEncounters
        .where((e) => _monthId(e.date) == monthId)
        .toList();

    if (seasonEncounters.isEmpty) {
      return const SeasonActivityMetrics(
        nightShare: 0,
        peakHour: null,
        weeklyChangePercent: null,
        totalEncounters: 0,
        peakWindowStartHour: null,
        peakWindowShare: 0,
      );
    }

    final nightCount = seasonEncounters.where((e) {
      final h = e.date.hour;
      return h >= 22 || h < 2;
    }).length;

    final hourMap = <int, int>{};
    for (final e in seasonEncounters) {
      final hour = e.date.hour;
      hourMap[hour] = (hourMap[hour] ?? 0) + 1;
    }

    int? peakHour;
    var peakCount = 0;
    hourMap.forEach((hour, count) {
      if (count > peakCount) {
        peakCount = count;
        peakHour = hour;
      }
    });

    int? peakWindowStartHour;
    var peakWindowCount = 0;
    for (var start = 0; start < 24; start++) {
      var count = 0;
      for (var i = 0; i < 4; i++) {
        final hour = (start + i) % 24;
        count += hourMap[hour] ?? 0;
      }
      if (count > peakWindowCount) {
        peakWindowCount = count;
        peakWindowStartHour = start;
      }
    }

    final sortedByDate = seasonEncounters
      ..sort((a, b) => b.date.compareTo(a.date));
    final latestDate = sortedByDate.first.date;
    final thisWeekStart = latestDate.subtract(
      Duration(days: latestDate.weekday - 1),
    );
    final previousWeekStart = thisWeekStart.subtract(const Duration(days: 7));
    final previousWeekEnd = thisWeekStart.subtract(const Duration(seconds: 1));

    final thisWeekCount = sortedByDate
        .where((e) => !e.date.isBefore(thisWeekStart))
        .length;
    final prevWeekCount = sortedByDate
        .where((e) =>
            !e.date.isBefore(previousWeekStart) &&
            !e.date.isAfter(previousWeekEnd))
        .length;

    double? weeklyChangePercent;
    if (prevWeekCount > 0) {
      weeklyChangePercent = ((thisWeekCount - prevWeekCount) / prevWeekCount) * 100;
    } else if (thisWeekCount > 0) {
      weeklyChangePercent = 100;
    } else {
      weeklyChangePercent = 0;
    }

    return SeasonActivityMetrics(
      nightShare: nightCount / seasonEncounters.length,
      peakHour: peakHour,
      weeklyChangePercent: weeklyChangePercent,
      totalEncounters: seasonEncounters.length,
      peakWindowStartHour: peakWindowStartHour,
      peakWindowShare: peakWindowCount / seasonEncounters.length,
    );
  }

  static String _monthId(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }
}
