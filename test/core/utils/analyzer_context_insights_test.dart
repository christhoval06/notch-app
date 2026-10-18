import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/core/utils/analyzer_context_insights.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  group('AnalyzerContextInsights', () {
    test('adds an insight for the best recurring tag combination', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerContextInsights([
        _encounter('1', DateTime(2026, 4, 2), 9, tags: ['tag_date', 'tag_travel']),
        _encounter('2', DateTime(2026, 4, 5), 10, tags: ['tag_travel', 'tag_date']),
        _encounter('3', DateTime(2026, 4, 8), 6, tags: ['tag_quickie', 'tag_oral']),
        _encounter('4', DateTime(2026, 4, 12), 7, tags: ['tag_quickie', 'tag_oral']),
      ]).build(l10n);

      final comboInsight = insights.firstWhere((item) => item.title == 'Best Tag Combo');
      expect(comboInsight.description, contains('Date Night'));
      expect(comboInsight.description, contains('Travel'));
    });

    test('adds an insight for the strongest recent month', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final insights = AnalyzerContextInsights([
        _encounter('1', DateTime(2026, 2, 2), 7),
        _encounter('2', DateTime(2026, 3, 5), 8),
        _encounter('3', DateTime(2026, 4, 2), 9),
        _encounter('4', DateTime(2026, 4, 5), 9),
        _encounter('5', DateTime(2026, 4, 8), 10),
        _encounter('6', DateTime(2026, 5, 12), 6),
        _encounter('7', DateTime(2026, 5, 18), 6),
        _encounter('8', DateTime(2026, 5, 22), 6),
        _encounter('9', DateTime(2026, 5, 25), 6),
      ]).build(l10n);

      final monthInsight = insights.firstWhere((item) => item.title == 'Strongest Recent Month');
      expect(monthInsight.description, contains('April 2026'));
      expect(monthInsight.description, contains('3'));
      expect(monthInsight.description, contains('9.3'));
    });
  });
}

Encounter _encounter(
  String id,
  DateTime date,
  int rating, {
  List<String> tags = const [],
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: rating,
    tags: tags,
  );
}
