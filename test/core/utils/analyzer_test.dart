import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/core/utils/analyzer.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  test('generateInsights prioritizes up to four varied categories', () async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final insights = Analyzer([
      _encounter('1', DateTime.now().subtract(const Duration(days: 80)), 8, tags: ['tag_date', 'tag_travel'], protected: true),
      _encounter('2', DateTime.now().subtract(const Duration(days: 70)), 8, tags: ['tag_date', 'tag_travel'], protected: true),
      _encounter('3', DateTime.now().subtract(const Duration(days: 60)), 9, tags: ['tag_quickie'], protected: true),
      _encounter('4', DateTime.now().subtract(const Duration(days: 50)), 9, tags: ['tag_quickie'], protected: true),
      _encounter('5', DateTime.now().subtract(const Duration(days: 10)), 8, partner: 'A', protected: false),
      _encounter('6', DateTime.now().subtract(const Duration(days: 8)), 8, partner: 'A', protected: false),
      _encounter('7', DateTime.now().subtract(const Duration(days: 6)), 8, partner: 'A', protected: false),
    ], const []).generateInsights(l10n);

    expect(insights.length, 4);
    expect(insights.any((item) => item.title == 'Best Chemistry'), isTrue);
    expect(insights.any((item) => item.title == 'Protection Recently Dropped'), isTrue);
    expect(insights.any((item) => item.title == 'In the Zone!'), isTrue);
  });

  test('generateInsights prefers the strongest insight inside a category', () async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final insights = Analyzer([
      _encounter('1', DateTime.now().subtract(const Duration(days: 120)), 9, partner: 'Nova', tags: ['tag_date'], protected: true),
      _encounter('2', DateTime.now().subtract(const Duration(days: 110)), 9, partner: 'Nova', tags: ['tag_travel'], protected: true),
      _encounter('3', DateTime.now().subtract(const Duration(days: 100)), 9, partner: 'Nova', tags: ['tag_quickie'], protected: true),
      _encounter('4', DateTime.now().subtract(const Duration(days: 90)), 7, partner: 'Lyra', tags: ['tag_oral'], protected: true),
      _encounter('5', DateTime.now().subtract(const Duration(days: 80)), 7, partner: 'Lyra', tags: ['tag_oral'], protected: true),
      _encounter('6', DateTime.now().subtract(const Duration(days: 10)), 4, partner: 'Nova', protected: false),
      _encounter('7', DateTime.now().subtract(const Duration(days: 8)), 4, partner: 'Nova', protected: false),
      _encounter('8', DateTime.now().subtract(const Duration(days: 6)), 4, partner: 'Nova', protected: false),
    ], const []).generateInsights(l10n);

    expect(insights.any((item) => item.title == 'Best Chemistry'), isTrue);
    expect(insights.any((item) => item.title == 'Average Satisfaction'), isFalse);
  });
}

Encounter _encounter(
  String id,
  DateTime date,
  int rating, {
  String partner = 'Partner',
  List<String> tags = const [],
  bool protected = true,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partner,
    orgasmCount: 1,
    rating: rating,
    tags: tags,
    protected: protected,
  );
}
