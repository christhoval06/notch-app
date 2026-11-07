import 'package:notch_app/data/models/encounter.dart';

class ChallengeHistoricalProgressService {
  const ChallengeHistoricalProgressService._();

  static int qualityStreak(
    List<Encounter> encounters, {
    required int minimumRating,
  }) {
    final sorted = [...encounters]..sort((a, b) => a.date.compareTo(b.date));
    var streak = 0;
    var best = 0;
    for (final entry in sorted) {
      if (entry.rating >= minimumRating) {
        streak++;
        if (streak > best) best = streak;
      } else {
        streak = 0;
      }
    }
    return best;
  }
}
