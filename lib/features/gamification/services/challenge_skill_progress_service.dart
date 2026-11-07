import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

const seasonalSkillTags = <String>{
  'tag_oral',
  'tag_anal',
  'tag_toys',
  'tag_kinky',
  'tag_vanilla',
  'tag_domsub',
  'tag_massage',
};

class ChallengeSkillProgressService {
  const ChallengeSkillProgressService._();

  static int seasonalSkillTagCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonal(encounters, now)
        .expand((entry) => entry.tags)
        .where(seasonalSkillTags.contains)
        .toSet()
        .length;
  }

  static int seasonalHighRatingSkillCount(
    List<Encounter> encounters, {
    required DateTime now,
    required int minimumRating,
  }) {
    return _seasonal(encounters, now)
        .where((entry) => entry.rating >= minimumRating)
        .where((entry) => entry.tags.any(seasonalSkillTags.contains))
        .length;
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
