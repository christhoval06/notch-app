import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsStoryPresentation {
  const StatsStoryPresentation({
    required this.title,
    required this.headline,
    required this.supporting,
    required this.details,
  });

  final String title;
  final String headline;
  final String supporting;
  final String details;
}

class StatsStoryCopyService {
  const StatsStoryCopyService._();

  static StatsStoryPresentation present(
    AppLocalizations l10n,
    StatsStoryCardData card,
    String locale,
  ) {
    switch (card.id) {
      case 'best_context':
        final context = tagLabelFromL10n(l10n, card.headline);
        final rating = _number(card.supporting);
        return StatsStoryPresentation(
          title: l10n.statsStoryBestContextTitle,
          headline: context,
          supporting: l10n.statsStoryBestContextSupporting(rating),
          details: l10n.statsStoryBestContextDetails(context),
        );
      case 'momentum':
        final count = _number(card.supporting);
        final isUp = card.headline.contains('up');
        return StatsStoryPresentation(
          title: l10n.statsStoryMomentumTitle,
          headline: isUp
              ? l10n.statsStoryMomentumUpHeadline
              : l10n.statsStoryMomentumDownHeadline,
          supporting: l10n.statsStoryMomentumSupporting(count),
          details: isUp
              ? l10n.statsStoryMomentumUpDetails(count)
              : l10n.statsStoryMomentumDownDetails(count),
        );
      case 'protection_trend':
        final values = _percentages(card.supporting);
        final isUp = card.headline.contains('up');
        return StatsStoryPresentation(
          title: l10n.statsStoryProtectionTrendTitle,
          headline: isUp
              ? l10n.statsStoryProtectionTrendUpHeadline
              : l10n.statsStoryProtectionTrendDownHeadline,
          supporting: l10n.statsStoryProtectionTrendSupporting(
            values.$1,
            values.$2,
          ),
          details: isUp
              ? l10n.statsStoryProtectionTrendUpDetails(values.$1, values.$2)
              : l10n.statsStoryProtectionTrendDownDetails(values.$1, values.$2),
        );
      case 'prime_time':
        final slot = _slot(l10n, card.headline);
        final rating = _number(card.supporting);
        return StatsStoryPresentation(
          title: l10n.statsStoryPrimeTimeTitle,
          headline: slot,
          supporting: l10n.statsStoryPrimeTimeSupporting(rating),
          details: l10n.statsStoryPrimeTimeDetails(slot),
        );
      default:
        final month = _month(card.headline, locale);
        final rating = _number(card.supporting);
        return StatsStoryPresentation(
          title: l10n.statsStoryPeakMonthTitle,
          headline: month,
          supporting: l10n.statsStoryPeakMonthSupporting(rating),
          details: l10n.statsStoryPeakMonthDetails(month),
        );
    }
  }

  static String _number(String value) =>
      RegExp(r'([\d.]+)').firstMatch(value)?.group(1) ?? '0';

  static (String, String) _percentages(String value) {
    final matches = RegExp(r'(\d+)%').allMatches(value).toList();
    return (
      matches.firstOrNull?.group(1) ?? '0',
      matches.length > 1 ? matches[1].group(1)! : '0',
    );
  }

  static String _slot(AppLocalizations l10n, String value) {
    final parts = value.split('-');
    if (parts.length != 2) return value;
    return '${_weekday(l10n, parts.first)} · ${_bucket(l10n, parts.last)}';
  }

  static String _weekday(AppLocalizations l10n, String value) {
    switch (value) {
      case '1':
        return l10n.statsStoryWeekdayMon;
      case '2':
        return l10n.statsStoryWeekdayTue;
      case '3':
        return l10n.statsStoryWeekdayWed;
      case '4':
        return l10n.statsStoryWeekdayThu;
      case '5':
        return l10n.statsStoryWeekdayFri;
      case '6':
        return l10n.statsStoryWeekdaySat;
      default:
        return l10n.statsStoryWeekdaySun;
    }
  }

  static String _bucket(AppLocalizations l10n, String value) {
    switch (value) {
      case 'morning':
        return l10n.statsStoryDayTimeMorning;
      case 'afternoon':
        return l10n.statsStoryDayTimeAfternoon;
      default:
        return l10n.statsStoryDayTimeNight;
    }
  }

  static String _month(String value, String locale) {
    final date = DateFormat('yyyy-MM').parseStrict(value);
    return DateFormat('MMMM yyyy', locale).format(date);
  }
}
