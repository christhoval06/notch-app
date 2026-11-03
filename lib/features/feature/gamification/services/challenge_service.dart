import 'package:hive/hive.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_progress_service.dart';
import 'package:notch_app/features/feature/gamification/services/lifetime_challenge_catalog.dart';
import 'package:notch_app/features/feature/gamification/services/seasonal_challenge_catalog.dart';

class ChallengeService {
  const ChallengeService._();

  static List<Challenge> getSeasonalChallenges() => seasonalChallenges;

  static List<Challenge> getHistoricalChallenges() => lifetimeChallenges;

  static List<Challenge> getChallengesWithProgress() => [
    ...getSeasonalChallenges(),
    ...getHistoricalChallenges(),
  ];

  static Challenge? getFeaturedChallenge() {
    final allEncounters = Hive.box<Encounter>('encounters').values.toList();
    return ChallengeProgressService.pickFeaturedChallenge(
      getChallengesWithProgress(),
      allEncounters,
    );
  }
}
