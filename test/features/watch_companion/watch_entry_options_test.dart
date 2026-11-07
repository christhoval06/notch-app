import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/watch_companion/services/watch_snapshot_service.dart';
import 'package:notch_app/features/watch_companion/services/watch_entry_options_service.dart';
import 'package:notch_app/l10n/app_localizations_en.dart';
import 'package:notch_app/l10n/app_localizations_es.dart';

void main() {
  final now = DateTime(2026, 11, 7, 12);
  final entries = List.generate(
    100,
    (i) => Encounter(
      id: '$i',
      date: now.subtract(Duration(hours: i)),
      partnerName: 'Sample $i',
      rating: 8,
      orgasmCount: 1,
      protected: true,
    ),
  );
  test('snapshot exports bounded recent names and localized entry choices', () {
    final map = WatchSnapshotService.build(
      now: now,
      encounters: entries,
      monthlyProgress: [],
      l10n: AppLocalizationsEs(),
      generation: 'g',
      revision: 1,
    ).toMap();
    final names = map['partnerNames'] as List?;
    expect(names, isNotNull);
    expect(names, hasLength(50));
    expect(names!.first, 'Sample 0');
    expect(utf8.encode(jsonEncode(names)).length, lessThanOrEqualTo(8192));
    expect(map['moodOptions'], contains('🥰'));
    expect(
      map['tagOptions'],
      contains(equals({'key': 'tag_hotel', 'label': 'Hotel'})),
    );
    final en = WatchSnapshotService.build(
      now: now,
      encounters: [],
      monthlyProgress: [],
      l10n: AppLocalizationsEn(),
      generation: 'g',
      revision: 1,
    ).toMap();
    expect(en['partnerNames'], isEmpty);
    expect(
      en['tagOptions'],
      contains(equals({'key': 'tag_date', 'label': 'Date Night'})),
    );
  });
  test(
    'partner suggestions merge saved names without duplicates or invalid names',
    () {
      final names = WatchEntryOptionsService.partnerNames(
        entries.take(1).toList(),
        [' @Saved ', 'Sample 0', '', 'x' * 81],
      );
      expect(names, ['Sample 0', 'Saved']);
    },
  );
  test('multibyte partner names stay within the transport budget', () {
    final names = WatchEntryOptionsService.partnerNames([], [
      for (var i = 0; i < 100; i++) '${'界' * 75}$i',
    ]);
    expect(names, isNotEmpty);
    expect(utf8.encode(jsonEncode(names)).length, lessThanOrEqualTo(8192));
    final options = WatchEntryOptionsService.build(names, AppLocalizationsEs());
    expect(utf8.encode(jsonEncode(options)).length, lessThan(16384));
  });
}
