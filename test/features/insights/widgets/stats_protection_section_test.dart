import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/widgets/stats_protection_section.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  testWidgets('tap on protection section opens detail sheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: StatsProtectionSection(
            summary: StatsProtectionSummary(
              protectionRate: 0.75,
              protectedCount: 3,
              unprotectedCount: 1,
              tone: StatsProtectionTone.stable,
              lastUnprotectedPartnerName: 'Alex',
              lastUnprotectedDate: DateTime(2026, 6, 28, 23),
            ),
            encounters: [
              _encounter('1', 'Alex', DateTime(2026, 6, 20, 21), protected: false),
              _encounter('2', 'Alex', DateTime(2026, 6, 22, 22), protected: true),
              _encounter('3', 'Sam', DateTime(2026, 6, 25, 15), protected: true),
              _encounter('4', 'Alex', DateTime(2026, 6, 28, 23), protected: true),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    expect(find.textContaining('current period'), findsWidgets);
    expect(find.textContaining('Alex'), findsWidgets);
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
