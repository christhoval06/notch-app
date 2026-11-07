import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/l10n/app_localizations.dart';

enum ChallengeCategory {
  foundation,
  social,
  events,
  relationships,
  mood,
  skill,
  legacy,
}

class ChallengeCategorySectionModel {
  const ChallengeCategorySectionModel({
    required this.category,
    required this.challenges,
  });

  final ChallengeCategory category;
  final List<Challenge> challenges;
}

class ChallengeCategoryService {
  const ChallengeCategoryService._();

  static List<ChallengeCategorySectionModel> buildSections(
    List<Challenge> challenges,
  ) {
    final buckets = <ChallengeCategory, List<Challenge>>{};
    for (final challenge in challenges) {
      final category = _categoryFor(challenge);
      buckets.putIfAbsent(category, () => <Challenge>[]).add(challenge);
    }
    return ChallengeCategory.values
        .where(buckets.containsKey)
        .map(
          (category) => ChallengeCategorySectionModel(
            category: category,
            challenges: buckets[category]!,
          ),
        )
        .toList();
  }

  static String label(AppLocalizations l10n, ChallengeCategory category) {
    switch (category) {
      case ChallengeCategory.foundation:
        return l10n.challengeCategoryFoundation;
      case ChallengeCategory.social:
        return l10n.challengeCategorySocial;
      case ChallengeCategory.events:
        return l10n.challengeCategoryEvents;
      case ChallengeCategory.relationships:
        return l10n.challengeCategoryRelationships;
      case ChallengeCategory.mood:
        return l10n.challengeCategoryMood;
      case ChallengeCategory.skill:
        return l10n.challengeCategorySkill;
      case ChallengeCategory.legacy:
        return l10n.challengeCategoryLegacy;
    }
  }

  static IconData icon(ChallengeCategory category) {
    switch (category) {
      case ChallengeCategory.foundation:
        return Icons.flag_outlined;
      case ChallengeCategory.social:
        return Icons.groups_rounded;
      case ChallengeCategory.events:
        return Icons.local_activity_outlined;
      case ChallengeCategory.relationships:
        return Icons.favorite_outline;
      case ChallengeCategory.mood:
        return Icons.emoji_emotions_outlined;
      case ChallengeCategory.skill:
        return Icons.auto_fix_high_outlined;
      case ChallengeCategory.legacy:
        return Icons.history_edu_outlined;
    }
  }

  static ChallengeCategory _categoryFor(Challenge challenge) {
    const socialIds = {
      'single_partner_season',
      'loyal_month',
      'single_partner_100',
      'single_partner_500',
      'steady_bond_50',
      'social_circle_3',
      'quality_network_3',
      'safe_network_3',
      'weekend_run_2',
      'social_weekend_3',
      'constellation_10',
    };
    const eventIds = {'event_mix_3', 'getaway_duo_2'};
    const relationshipIds = {'connection_arc_3', 'date_night_2'};
    const moodIds = {'mood_spectrum_3', 'high_spirits_3'};
    const skillIds = {'skill_mix_3', 'pleasure_crafter_3'};
    if (socialIds.contains(challenge.id)) return ChallengeCategory.social;
    if (eventIds.contains(challenge.id)) return ChallengeCategory.events;
    if (relationshipIds.contains(challenge.id)) {
      return ChallengeCategory.relationships;
    }
    if (moodIds.contains(challenge.id)) return ChallengeCategory.mood;
    if (skillIds.contains(challenge.id)) return ChallengeCategory.skill;
    if (challenge.family == ChallengeFamily.historical) {
      return ChallengeCategory.legacy;
    }
    return ChallengeCategory.foundation;
  }
}
