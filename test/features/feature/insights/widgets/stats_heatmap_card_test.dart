import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_heatmap_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  testWidgets('builds heatmap card across supported periods', (tester) async {
    final data = {
      DateTime(2026, 7, 4): 2,
      DateTime(2026, 6, 20): 1,
      DateTime(2026, 3, 10): 3,
      DateTime(2025, 8, 15): 1,
    };
    final encounters = [
      Encounter(
        id: '1',
        date: DateTime(2026, 7, 4, 21),
        partnerName: 'Partner A',
        orgasmCount: 2,
        rating: 9,
        tags: const ['tag_travel'],
      ),
    ];

    for (final period in StatPeriod.values) {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: StatsHeatmapCard(
              encounters: encounters,
              heatmapData: data,
              period: period,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(StatsHeatmapCard), findsOneWidget);
      expect(find.textContaining('Activity'), findsWidgets);
    }
  });
}
