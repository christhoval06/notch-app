import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/watch_companion/services/watch_command.dart';

void main() {
  final now = DateTime.utc(2026, 12, 1);
  Map<String, Object?> payload() => {
    'schemaVersion': 1,
    'kind': 'entry',
    'generation': 'generation-1',
    'id': 'ab6aaf9e-d56d-4ee7-a63c-0443e09c8793',
    'capturedAtMs': DateTime.utc(2026, 11, 30, 23).millisecondsSinceEpoch,
    'partnerLabel': ' @Sample ',
    'rating': 8,
    'orgasmCount': 1,
    'protected': true,
  };
  test('preserves a delayed instant and normalizes the partner', () {
    final command = WatchCommand.fromMap(payload());
    expect(command.validate(now), isNull);
    expect(command.partnerLabel, 'Sample');
    expect(command.capturedAt.toUtc(), DateTime.utc(2026, 11, 30, 23));
    expect(WatchCommand.fromMap(command.toMap()).toMap(), command.toMap());
  });
  test('rejects every constrained field boundary', () {
    for (final entry in <String, List<Object?>>{
      'schemaVersion': [0, 2],
      'rating': [0, 11, 1.5],
      'orgasmCount': [-1, 100],
      'partnerLabel': ['', ' ' * 2, 'x' * 81],
      'protected': [null, 'yes'],
      'id': ['', 'not-a-uuid'],
    }.entries) {
      for (final invalid in entry.value) {
        final value = payload()..[entry.key] = invalid;
        expect(
          () => WatchCommand.fromMap(value),
          throwsFormatException,
          reason: '${entry.key}: $invalid',
        );
      }
    }
  });
  test('permits five minute skew but rejects later timestamps', () {
    final atLimit = payload()
      ..['capturedAtMs'] = now
          .add(const Duration(minutes: 5))
          .millisecondsSinceEpoch;
    expect(WatchCommand.fromMap(atLimit).validate(now), isNull);
    atLimit['capturedAtMs'] = (atLimit['capturedAtMs'] as int) + 1;
    expect(WatchCommand.fromMap(atLimit).validate(now), 'future_time');
  });
}
