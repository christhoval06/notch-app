import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/core/utils/analyzer_health_insights.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  group('Analyzer health insights', () {
    test('adds an insight when recent protection drops below historical use', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerHealthInsights([
        _encounter('1', DateTime(2026, 1, 2), 8, protected: true),
        _encounter('2', DateTime(2026, 2, 5), 8, protected: true),
        _encounter('3', DateTime(2026, 3, 8), 8, protected: true),
        _encounter('4', DateTime(2026, 4, 10), 8, protected: true),
        _encounter('5', DateTime(2026, 5, 12), 8, protected: false),
        _encounter('6', DateTime(2026, 5, 18), 8, protected: false),
        _encounter('7', DateTime(2026, 5, 22), 8, protected: false),
      ], const []).build(l10n);

      final protectionInsight = insights.firstWhere(
        (item) => item.title == 'Protection Recently Dropped',
      );
      expect(protectionInsight.description, contains('0%'));
    });

    test('adds an insight when there has been a long pause in activity', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerHealthInsights([
        _encounter('1', DateTime.now().subtract(const Duration(days: 52)), 8),
        _encounter('2', DateTime.now().subtract(const Duration(days: 61)), 7),
        _encounter('3', DateTime.now().subtract(const Duration(days: 74)), 9),
      ], const []).build(l10n);

      final pauseInsight = insights.firstWhere(
        (item) => item.title == 'Long Activity Pause',
      );
      expect(pauseInsight.description, contains('52'));
    });

    test('adds an insight when the health check is overdue by a wide margin', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerHealthInsights(
        [
          _encounter('1', DateTime(2026, 4, 2), 8),
          _encounter('2', DateTime(2026, 5, 5), 8),
        ],
        [
          HealthLog(
            date: DateTime.now().subtract(const Duration(days: 280)),
            testType: 'Panel',
            result: 'Negative',
          ),
        ],
      ).build(l10n);

      final healthInsight = insights.firstWhere(
        (item) => item.title == 'Health Check Overdue',
      );
      expect(healthInsight.description, contains('9'));
    });
  });
}

Encounter _encounter(
  String id,
  DateTime date,
  int rating, {
  bool protected = true,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: rating,
    protected: protected,
  );
}
