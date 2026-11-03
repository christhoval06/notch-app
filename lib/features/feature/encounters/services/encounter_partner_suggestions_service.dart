import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/partner_repository.dart';

class EncounterPartnerSuggestions {
  const EncounterPartnerSuggestions({
    required this.partnerNames,
    required this.usageCounts,
    required this.quickNames,
  });

  final List<String> partnerNames;
  final Map<String, int> usageCounts;
  final List<String> quickNames;
}

class EncounterPartnerSuggestionsService {
  const EncounterPartnerSuggestionsService._();

  static EncounterPartnerSuggestions build() {
    final usageCounts = <String, int>{};
    for (final encounter in EncounterRepository.getAll()) {
      final name = encounter.partnerName.trim();
      if (name.isEmpty) continue;
      usageCounts.update(name, (value) => value + 1, ifAbsent: () => 1);
    }

    final partnerNames = {
      ...PartnerRepository.getAll().map((partner) => partner.name.trim()),
      ...usageCounts.keys,
    }.where((name) => name.isNotEmpty).toList()..sort();

    final quickNames = usageCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return EncounterPartnerSuggestions(
      partnerNames: partnerNames,
      usageCounts: usageCounts,
      quickNames: quickNames.map((entry) => entry.key).toList(),
    );
  }
}
