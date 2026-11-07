import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/app_clip/services/app_clip_sample_data.dart';

void main() {
  final sample = AppClipSampleData(
    month: DateTime(2026, 11),
    partnerLabel: 'Fictional entry',
  );

  test('selecting dates never leaks entries from a different month', () {
    expect(sample.forDay(DateTime(2026, 11, 4)).single.rating, 8);
    expect(sample.forDay(DateTime(2026, 10, 4)), isEmpty);
    expect(sample.forDay(DateTime(2026, 11, 5)), isEmpty);
  });

  test('insight totals describe the four displayed fictional entries', () {
    expect(sample.encounters, hasLength(4));
    expect(sample.averageRating, 8.5);
    expect(sample.orgasmCount, 4);
    expect(sample.encounters.every((entry) => !entry.isInBox), isTrue);
  });
}
