import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/gamification/services/challenge_partner_progress_service.dart';
import 'package:notch_app/features/gamification/services/challenge_progress_service.dart';
import 'package:notch_app/features/gamification/services/historical_expansion_challenges.dart';

final List<Challenge> lifetimeChallenges = [
  Challenge(
    id: 'epic_morning',
    title: 'Muy Buenos Días',
    description: 'Acumula 50 encuentros con la etiqueta "Mañanero".',
    icon: Icons.wb_sunny,
    goal: 50,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) => encounters
        .where((e) => e.tags.contains('tag_morning'))
        .length
        .toDouble(),
  ),
  Challenge(
    id: 'frequent_flyer',
    title: 'Viajero Frecuente',
    description: 'Acumula 15 encuentros con la etiqueta "Viaje".',
    icon: Icons.flight_takeoff,
    goal: 15,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) => encounters
        .where((e) => e.tags.contains('tag_travel'))
        .length
        .toDouble(),
  ),
  Challenge(
    id: 'star_collector',
    title: 'Coleccionista de Estrellas',
    description: 'Logra 100 encuentros con calificación de 8 o más.',
    icon: Icons.stars,
    goal: 100,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) =>
        encounters.where((e) => e.rating >= 8).length.toDouble(),
  ),
  Challenge(
    id: 'centurion',
    title: 'El Centurión',
    description: 'Registra tus primeros 100 encuentros en total.',
    icon: Icons.shield,
    goal: 100,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) => encounters.length.toDouble(),
  ),
  Challenge(
    id: 'legendary_guardian',
    title: 'Guardián Legendario',
    description:
        'Mantén una tasa de protección del 95%+ sobre al menos 50 encuentros.',
    icon: Icons.health_and_safety,
    goal: 95,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.legendaryHistorical,
    progressCalculator: (encounters) =>
        ChallengeProgressService.protectionRatePercent(
          encounters,
          minimumEncounters: 50,
        ),
  ),
  Challenge(
    id: 'guardian_of_safety',
    title: 'Guardián de la Seguridad',
    description: 'Logra una racha de 15 encuentros seguidos usando protección.',
    icon: Icons.health_and_safety,
    goal: 15,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) =>
        ChallengeProgressService.longestProtectedStreak(encounters).toDouble(),
  ),
  Challenge(
    id: 'single_partner_100',
    title: 'Una Misma Historia',
    description: 'Acumula 100 encuentros con una sola pareja.',
    icon: Icons.favorite,
    goal: 100,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.historicalSinglePartnerProgress(
          encounters,
        ).toDouble(),
  ),
  Challenge(
    id: 'single_partner_500',
    title: 'Vínculo Legendario',
    description: 'Acumula 500 encuentros con una sola pareja.',
    icon: Icons.workspace_premium,
    goal: 500,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.legendaryHistorical,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.historicalSinglePartnerProgress(
          encounters,
        ).toDouble(),
  ),
  Challenge(
    id: 'polymath',
    title: 'El Polímata',
    description: 'Usa cada una de las etiquetas disponibles al menos una vez.',
    icon: Icons.psychology,
    goal: tagKeys.length,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) =>
        encounters.expand((e) => e.tags).toSet().length.toDouble(),
  ),
  ...historicalExpansionChallenges,
];
