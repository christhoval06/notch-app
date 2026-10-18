import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/health/services/health_passport_summary_service.dart';

void main() {
  group('HealthPassportSummaryService.build', () {
    test('returns an empty summary when there are no logs', () {
      final summary = HealthPassportSummaryService.build(
        logs: const [],
        now: DateTime(2026, 6, 30),
      );

      expect(summary.latestLog, isNull);
      expect(summary.elapsedMonths, 0);
      expect(summary.followUpRecommendation, FollowUpRecommendation.none);
    });

    test('uses the latest log and calculates elapsed months', () {
      final summary = HealthPassportSummaryService.build(
        logs: [
          _log(DateTime(2026, 1, 10), 'Older'),
          _log(DateTime(2026, 4, 15), 'Latest'),
          _log(DateTime(2026, 3, 20), 'Middle'),
        ],
        now: DateTime(2026, 6, 30),
      );

      expect(summary.latestLog?.testType, 'Latest');
      expect(summary.elapsedMonths, 2);
      expect(summary.followUpRecommendation, FollowUpRecommendation.upToDate);
    });

    test('marks follow-up as overdue when six months have elapsed', () {
      final summary = HealthPassportSummaryService.build(
        logs: [_log(DateTime(2025, 12, 30), 'Routine')],
        now: DateTime(2026, 6, 30),
      );

      expect(summary.elapsedMonths, 6);
      expect(summary.followUpRecommendation, FollowUpRecommendation.overdue);
    });

    test('does not count a partial month across a day boundary', () {
      final summary = HealthPassportSummaryService.build(
        logs: [_log(DateTime(2026, 1, 31), 'Boundary')],
        now: DateTime(2026, 2, 1),
      );

      expect(summary.elapsedMonths, 0);
      expect(summary.followUpRecommendation, FollowUpRecommendation.upToDate);
    });
  });
}

HealthLog _log(DateTime date, String testType) {
  return HealthLog(date: date, testType: testType, result: 'Normal');
}
