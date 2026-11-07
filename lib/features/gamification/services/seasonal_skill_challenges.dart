import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/gamification/services/challenge_skill_progress_service.dart';

final List<Challenge> seasonalSkillChallenges = [
  Challenge(
    id: 'skill_mix_3',
    title: 'Skill Mix',
    description: 'Usa 3 etiquetas de practicas distintas esta temporada.',
    icon: Icons.auto_fix_high_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeSkillProgressService.seasonalSkillTagCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'pleasure_crafter_3',
    title: 'Pleasure Crafter',
    description:
        'Registra 3 encuentros esta temporada con practicas y calificacion de 8 o mas.',
    icon: Icons.workspace_premium_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengeSkillProgressService.seasonalHighRatingSkillCount(
          encounters,
          now: DateTime.now(),
          minimumRating: 8,
        ).toDouble(),
  ),
];
