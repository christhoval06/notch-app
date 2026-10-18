import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

const seasonalEventTags = <String>{
  'tag_date',
  'tag_travel',
  'tag_anniversary',
  'tag_celebration',
  'tag_hotel',
  'tag_car',
  'tag_outdoor',
};

const seasonalGetawayTags = <String>{'tag_travel', 'tag_hotel', 'tag_car'};

class ChallengeEventProgressService {
  const ChallengeEventProgressService._();

  static int seasonalEventTagCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonal(encounters, now)
        .expand((entry) => entry.tags)
        .where(seasonalEventTags.contains)
        .toSet()
        .length;
  }

  static int seasonalGetawayEncounterCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonal(
      encounters,
      now,
    ).where((entry) => entry.tags.any(seasonalGetawayTags.contains)).length;
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
