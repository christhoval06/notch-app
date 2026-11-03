import 'package:notch_app/data/models/health_log.dart';

enum FollowUpRecommendation { none, upToDate, overdue }

class HealthPassportSummary {
  const HealthPassportSummary({
    required this.latestLog,
    required this.elapsedMonths,
    required this.followUpRecommendation,
  });

  final HealthLog? latestLog;
  final int elapsedMonths;
  final FollowUpRecommendation followUpRecommendation;

  bool get hasLogs => latestLog != null;
}

class HealthPassportSummaryService {
  const HealthPassportSummaryService._();

  static HealthPassportSummary build({
    required List<HealthLog> logs,
    required DateTime now,
  }) {
    if (logs.isEmpty) {
      return const HealthPassportSummary(
        latestLog: null,
        elapsedMonths: 0,
        followUpRecommendation: FollowUpRecommendation.none,
      );
    }

    final latest = logs.reduce((current, candidate) {
      if (candidate.date.isAfter(current.date)) return candidate;
      return current;
    });
    final elapsedMonths = _elapsedMonthsSince(latest.date, now);

    return HealthPassportSummary(
      latestLog: latest,
      elapsedMonths: elapsedMonths,
      followUpRecommendation: elapsedMonths >= 6
          ? FollowUpRecommendation.overdue
          : FollowUpRecommendation.upToDate,
    );
  }

  static int _elapsedMonthsSince(DateTime date, DateTime now) {
    var months = (now.year - date.year) * 12 + (now.month - date.month);
    if (now.day < date.day) months--;
    if (months <= 0) return 0;
    return months;
  }
}
