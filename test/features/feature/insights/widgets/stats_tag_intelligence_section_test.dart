import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_tag_intelligence_section.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  testWidgets('tap on tag card opens detail sheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: StatsTagIntelligenceSection(
            tags: [
              const StatsTagInsight(
                tagKey: 'tag_travel',
                count: 2,
                avgRating: 9.5,
                topPartnerName: 'Partner A',
                dominantMood: '🔥',
              ),
            ],
            encounters: [
              _encounter('1', 'Partner A', DateTime(2026, 6, 20, 21), rating: 9, tags: ['tag_travel']),
              _encounter('2', 'Partner A', DateTime(2026, 6, 22, 22), rating: 10, tags: ['tag_travel']),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.textContaining('Travel'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Travel'), findsWidgets);
    expect(find.textContaining('current period'), findsWidgets);
  });
}

Encounter _encounter(
  String id,
  String partnerName,
  DateTime date, {
  int rating = 8,
  List<String> tags = const [],
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: rating,
    tags: tags,
  );
}
