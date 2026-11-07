import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_protection_detail_service.dart';

void main() {
  test('build returns protection detail summary', () {
    final summary = StatsProtectionDetailService.build(
      encounters: [
        _encounter('1', 'Alex', DateTime(2026, 6, 20, 21), protected: false),
        _encounter('2', 'Alex', DateTime(2026, 6, 22, 22), protected: false),
        _encounter('3', 'Sam', DateTime(2026, 6, 25, 15), protected: true),
        _encounter('4', 'Alex', DateTime(2026, 6, 28, 23), protected: false),
      ],
    );

    expect(summary.protectionRate, closeTo(0.25, 0.01));
    expect(summary.unprotectedCount, 3);
    expect(summary.lastUnprotectedPartnerName, 'Alex');
    expect(summary.lastUnprotectedDate, DateTime(2026, 6, 28, 23));
    expect(summary.topRiskPartnerName, 'Alex');
    expect(summary.recentUnprotectedEncounters, hasLength(3));
  });
}

Encounter _encounter(
  String id,
  String partnerName,
  DateTime date, {
  required bool protected,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: 8,
    protected: protected,
  );
}
