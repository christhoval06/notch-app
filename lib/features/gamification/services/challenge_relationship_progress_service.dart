import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

const seasonalRelationshipTags = <String>{
  'tag_date',
  'tag_anniversary',
  'tag_ons',
  'tag_fwb',
  'tag_reconciliation',
};

const seasonalRomanceTags = <String>{'tag_date', 'tag_anniversary'};

class ChallengeRelationshipProgressService {
  const ChallengeRelationshipProgressService._();

  static int seasonalRelationshipTagCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonal(encounters, now)
        .expand((entry) => entry.tags)
        .where(seasonalRelationshipTags.contains)
        .toSet()
        .length;
  }

  static int seasonalRomanceEncounterCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonal(
      encounters,
      now,
    ).where((entry) => entry.tags.any(seasonalRomanceTags.contains)).length;
  }

  static Iterable<Encounter> _seasonal(
    List<Encounter> encounters,
    DateTime now,
  ) {
    final monthId = DateFormat('yyyy-MM').format(now);
    return encounters.where(
      (entry) => DateFormat('yyyy-MM').format(entry.date) == monthId,
    );
  }
}
