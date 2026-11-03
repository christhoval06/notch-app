import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/core/utils/analyzer_partner_insights.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  group('AnalyzerPartnerInsights', () {
    test('adds an insight for the most consistent partner', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerPartnerInsights([
        _encounter('1', DateTime(2026, 4, 2), 8, partner: 'Stable'),
        _encounter('2', DateTime(2026, 4, 5), 8, partner: 'Stable'),
        _encounter('3', DateTime(2026, 4, 8), 8, partner: 'Stable'),
        _encounter('4', DateTime(2026, 4, 12), 6, partner: 'Wild'),
        _encounter('5', DateTime(2026, 4, 18), 10, partner: 'Wild'),
        _encounter('6', DateTime(2026, 4, 22), 7, partner: 'Wild'),
      ]).build(l10n);

      final insight = insights.firstWhere((item) => item.title == 'Most Consistent Partner');
      expect(insight.description, contains('Stable'));
    });

    test('adds an insight for the most unpredictable partner', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerPartnerInsights([
        _encounter('1', DateTime(2026, 4, 2), 8, partner: 'Stable'),
        _encounter('2', DateTime(2026, 4, 5), 8, partner: 'Stable'),
        _encounter('3', DateTime(2026, 4, 8), 8, partner: 'Stable'),
        _encounter('4', DateTime(2026, 4, 12), 4, partner: 'Wild'),
        _encounter('5', DateTime(2026, 4, 18), 10, partner: 'Wild'),
        _encounter('6', DateTime(2026, 4, 22), 5, partner: 'Wild'),
      ]).build(l10n);

      final insight = insights.firstWhere((item) => item.title == 'Most Unpredictable Partner');
      expect(insight.description, contains('Wild'));
    });

    test('adds an insight for the partner with the best recent trend', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerPartnerInsights([
        _encounter('1', DateTime(2026, 1, 2), 6, partner: 'Nova'),
        _encounter('2', DateTime(2026, 2, 5), 6, partner: 'Nova'),
        _encounter('3', DateTime(2026, 4, 8), 9, partner: 'Nova'),
        _encounter('4', DateTime(2026, 5, 12), 9, partner: 'Nova'),
        _encounter('5', DateTime(2026, 1, 18), 8, partner: 'Steady'),
        _encounter('6', DateTime(2026, 2, 22), 8, partner: 'Steady'),
        _encounter('7', DateTime(2026, 4, 10), 8, partner: 'Steady'),
        _encounter('8', DateTime(2026, 5, 14), 8, partner: 'Steady'),
      ]).build(l10n);

      final insight = insights.firstWhere((item) => item.title == 'Best Recent Partner Trend');
      expect(insight.description, contains('Nova'));
      expect(insight.description, contains('3'));
    });

    test('adds an insight for the strongest recent chemistry', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerPartnerInsights([
        _encounter('1', DateTime(2026, 4, 2), 10, partner: 'Spark'),
        _encounter('2', DateTime(2026, 5, 5), 9, partner: 'Spark'),
        _encounter('3', DateTime(2026, 5, 8), 10, partner: 'Spark'),
        _encounter('4', DateTime(2026, 4, 12), 7, partner: 'Calm'),
        _encounter('5', DateTime(2026, 5, 18), 7, partner: 'Calm'),
        _encounter('6', DateTime(2026, 5, 22), 7, partner: 'Calm'),
      ]).build(l10n);

      final insight = insights.firstWhere((item) => item.title == 'Recent Chemistry');
      expect(insight.description, contains('Spark'));
      expect(insight.description, contains('9.7'));
    });
  });
}

Encounter _encounter(String id, DateTime date, int rating, {required String partner}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partner,
    orgasmCount: 1,
    rating: rating,
  );
}
