import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/widgets/stats_rhythm_section.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  testWidgets('tap on rhythm section opens detail sheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: StatsRhythmSection(
            summary: const StatsRhythmSummary(
              topBucket: 'night',
              topWeekday: DateTime.sunday,
              bucketCounts: {'morning': 1, 'afternoon': 0, 'night': 3},
            ),
            encounters: [
              _encounter('1', 'Alex', DateTime(2026, 6, 20, 9)),
              _encounter('2', 'Alex', DateTime(2026, 6, 22, 21)),
              _encounter('3', 'Sam', DateTime(2026, 6, 22, 22)),
              _encounter('4', 'Alex', DateTime(2026, 6, 28, 23)),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    expect(find.textContaining('current period'), findsWidgets);
    expect(find.textContaining('Sunday'), findsWidgets);
  });
}

Encounter _encounter(String id, String partnerName, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: 8,
  );
}
