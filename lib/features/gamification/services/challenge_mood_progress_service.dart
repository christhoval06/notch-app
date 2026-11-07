import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

class ChallengeMoodProgressService {
  const ChallengeMoodProgressService._();

  static int seasonalMoodDiversity(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonal(encounters, now)
        .map((entry) => entry.moodEmoji?.trim() ?? '')
        .where((emoji) => emoji.isNotEmpty)
        .toSet()
        .length;
  }

  static int seasonalHighIntensityMoodCount(
    List<Encounter> encounters, {
    required DateTime now,
    required int minimumRating,
  }) {
    return _seasonal(encounters, now)
        .where((entry) => entry.rating >= minimumRating)
        .where((entry) => (entry.moodEmoji?.trim() ?? '').isNotEmpty)
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
