import 'dart:convert';
import 'package:notch_app/core/constants/encounter_options.dart';
import 'package:notch_app/core/constants/watch_protocol.dart';
import 'package:notch_app/core/utils/translations.dart' show tagLabelFromL10n;
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

abstract final class WatchEntryOptionsService {
  static List<String> partnerNames(
    List<Encounter> encounters,
    Iterable<String> savedNames,
  ) {
    final recent = [...encounters]..sort((a, b) => b.date.compareTo(a.date));
    final saved = savedNames.toList()..sort();
    final result = <String>[];
    final seen = <String>{};
    for (final raw in [...recent.map((e) => e.partnerName), ...saved]) {
      final name = raw.trim().replaceFirst(RegExp(r'^[@＠]'), '').trim();
      if (name.isEmpty ||
          name.length > WatchProtocol.maxPartnerLength ||
          !seen.add(name)) {
        continue;
      }
      if (utf8.encode(jsonEncode([...result, name])).length >
          WatchProtocol.partnerSuggestionsBytes) {
        continue;
      }
      result.add(name);
      if (result.length == WatchProtocol.maxPartnerSuggestions) break;
    }
    return List.unmodifiable(result);
  }

  static Map<String, Object?> build(
    List<String> names,
    AppLocalizations l10n,
  ) => {
    'partnerNames': names,
    'moodOptions': moodEmojis,
    'tagOptions': [
      for (final key in tagKeys)
        {'key': key, 'label': tagLabelFromL10n(l10n, key)},
    ],
  };
}
