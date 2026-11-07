import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/gamification/services/challenge_service.dart';

void main() {
  group('ChallengeService classification', () {
    test('keeps guardian of safety as historical', () {
      final seasonalIds = ChallengeService.getSeasonalChallenges()
          .map((challenge) => challenge.id)
          .toSet();
      final historicalIds = ChallengeService.getHistoricalChallenges()
          .map((challenge) => challenge.id)
          .toSet();

      expect(seasonalIds.contains('guardian_of_safety'), isFalse);
      expect(historicalIds.contains('guardian_of_safety'), isTrue);
    });

    test('keeps quality week as seasonal', () {
      final seasonalIds = ChallengeService.getSeasonalChallenges()
          .map((challenge) => challenge.id)
          .toSet();
      final historicalIds = ChallengeService.getHistoricalChallenges()
          .map((challenge) => challenge.id)
          .toSet();

      expect(seasonalIds.contains('quality_week'), isTrue);
      expect(historicalIds.contains('quality_week'), isFalse);
    });

    test('places single partner challenges in the right families', () {
      final seasonalIds = ChallengeService.getSeasonalChallenges()
          .map((challenge) => challenge.id)
          .toSet();
      final historicalIds = ChallengeService.getHistoricalChallenges()
          .map((challenge) => challenge.id)
          .toSet();

      expect(seasonalIds.contains('single_partner_season'), isTrue);
      expect(seasonalIds.contains('loyal_month'), isTrue);
      expect(historicalIds.contains('single_partner_100'), isTrue);
      expect(historicalIds.contains('single_partner_500'), isTrue);
      expect(historicalIds.contains('steady_bond_50'), isTrue);
    });

    test('keeps the new expansion challenges as seasonal', () {
      final seasonalIds = ChallengeService.getSeasonalChallenges()
          .map((challenge) => challenge.id)
          .toSet();
      final historicalIds = ChallengeService.getHistoricalChallenges()
          .map((challenge) => challenge.id)
          .toSet();

      expect(seasonalIds.contains('quality_streak_3'), isTrue);
      expect(seasonalIds.contains('balanced_week'), isTrue);
      expect(seasonalIds.contains('tag_combo_5'), isTrue);
      expect(seasonalIds.contains('social_circle_3'), isTrue);
      expect(seasonalIds.contains('quality_network_3'), isTrue);
      expect(seasonalIds.contains('safe_network_3'), isTrue);
      expect(seasonalIds.contains('weekend_run_2'), isTrue);
      expect(seasonalIds.contains('social_weekend_3'), isTrue);
      expect(seasonalIds.contains('event_mix_3'), isTrue);
      expect(seasonalIds.contains('getaway_duo_2'), isTrue);
      expect(seasonalIds.contains('mood_spectrum_3'), isTrue);
      expect(seasonalIds.contains('high_spirits_3'), isTrue);
      expect(seasonalIds.contains('skill_mix_3'), isTrue);
      expect(seasonalIds.contains('pleasure_crafter_3'), isTrue);
      expect(seasonalIds.contains('connection_arc_3'), isTrue);
      expect(seasonalIds.contains('date_night_2'), isTrue);
      expect(historicalIds.contains('quality_streak_3'), isFalse);
      expect(historicalIds.contains('balanced_week'), isFalse);
      expect(historicalIds.contains('tag_combo_5'), isFalse);
      expect(historicalIds.contains('social_circle_3'), isFalse);
      expect(historicalIds.contains('quality_network_3'), isFalse);
      expect(historicalIds.contains('safe_network_3'), isFalse);
      expect(historicalIds.contains('weekend_run_2'), isFalse);
      expect(historicalIds.contains('social_weekend_3'), isFalse);
      expect(historicalIds.contains('event_mix_3'), isFalse);
      expect(historicalIds.contains('getaway_duo_2'), isFalse);
      expect(historicalIds.contains('mood_spectrum_3'), isFalse);
      expect(historicalIds.contains('high_spirits_3'), isFalse);
      expect(historicalIds.contains('skill_mix_3'), isFalse);
      expect(historicalIds.contains('pleasure_crafter_3'), isFalse);
      expect(historicalIds.contains('connection_arc_3'), isFalse);
      expect(historicalIds.contains('date_night_2'), isFalse);
      expect(historicalIds.contains('quality_streak_5'), isTrue);
      expect(historicalIds.contains('constellation_10'), isTrue);
    });

    test('assigns xp rewards from challenge difficulty tiers', () {
      final seasonal = ChallengeService.getSeasonalChallenges().firstWhere(
        (challenge) => challenge.id == 'single_partner_season',
      );
      final historical = ChallengeService.getHistoricalChallenges().firstWhere(
        (challenge) => challenge.id == 'single_partner_100',
      );
      final legendary = ChallengeService.getHistoricalChallenges().firstWhere(
        (challenge) => challenge.id == 'single_partner_500',
      );
      final loyalMonth = ChallengeService.getSeasonalChallenges().firstWhere(
        (challenge) => challenge.id == 'loyal_month',
      );
      final steadyBond = ChallengeService.getHistoricalChallenges().firstWhere(
        (challenge) => challenge.id == 'steady_bond_50',
      );

      expect(seasonal.xpReward, 120);
      expect(historical.xpReward, 180);
      expect(legendary.xpReward, 250);
      expect(loyalMonth.xpReward, 120);
      expect(steadyBond.xpReward, 250);
    });
  });
}
