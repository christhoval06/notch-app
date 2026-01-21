import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/challenge.dart';
import '../models/encounter.dart';
import '../utils/translations.dart';

class ChallengeService {
  // --- LISTA MAESTRA DE TODOS LOS RETOS ---
  // Para añadir un reto, solo tienes que agregarlo a esta lista.
  static final List<Challenge> _challenges = [
    Challenge(
      id: 'morning_master',
      title: 'Maestro Mañanero',
      description: 'Registra 5 encuentros con la etiqueta "Mañanero".',
      icon: Icons.wb_sunny,
      goal: 5,
      progressCalculator: (encounters) {
        return encounters
            .where((e) => e.tags.contains('tag_morning'))
            .length
            .toDouble();
      },
    ),
    Challenge(
      id: 'weekly_explorer',
      title: 'Explorador Semanal',
      description: 'Usa 3 etiquetas diferentes en los últimos 7 días.',
      icon: Icons.explore,
      goal: 3,
      progressCalculator: (encounters) {
        final last7Days = DateTime.now().subtract(const Duration(days: 7));
        final recentEncounters = encounters.where(
          (e) => e.date.isAfter(last7Days),
        );
        return recentEncounters.expand((e) => e.tags).toSet().length.toDouble();
      },
    ),
    Challenge(
      id: 'quality_week',
      title: 'Semana de Calidad',
      description: 'Logra un promedio de 8.0+ en los últimos 7 días.',
      icon: Icons.star_border,
      goal: 8, // El objetivo es 8.0
      progressCalculator: (encounters) {
        final last7Days = DateTime.now().subtract(const Duration(days: 7));
        final recentEncounters = encounters
            .where((e) => e.date.isAfter(last7Days))
            .toList();
        if (recentEncounters.isEmpty) return 0.0;
        final totalRating = recentEncounters
            .map((e) => e.rating)
            .reduce((a, b) => a + b);
        return totalRating / recentEncounters.length;
      },
    ),
    Challenge(
      id: 'safety_champion',
      title: 'Campeón de la Seguridad',
      description: 'Logra 100% de protección en tus últimos 5 encuentros.',
      icon: Icons.security,
      goal: 5,
      progressCalculator: (encounters) {
        if (encounters.length < 5) return 0.0;
        final sorted = List<Encounter>.from(encounters)
          ..sort((a, b) => b.date.compareTo(a.date));
        return sorted.take(5).where((e) => e.protected).length.toDouble();
      },
    ),
    Challenge(
      id: 'prelude_master',
      title: 'Maestro del Preludio',
      description:
          'Promedio de 9.0+ en 5 encuentros seguidos con la etiqueta "Oral".',
      icon: Icons.mic, // Un icono sugerente pero discreto
      goal: 5,
      progressCalculator: (encounters) {
        final sorted = List<Encounter>.from(encounters)
          ..sort((a, b) => b.date.compareTo(a.date));
        final oralEncounters = sorted
            .where((e) => e.tags.contains('tag_oral'))
            .take(5)
            .toList();
        if (oralEncounters.length < 5) return 0.0;

        final avgRating =
            oralEncounters.map((e) => e.rating).reduce((a, b) => a + b) / 5;
        // Devolvemos el número de encuentros si se cumple, para la barra de progreso
        return avgRating >= 9.0 ? 5.0 : 0.0;
      },
    ),
    Challenge(
      id: 'steel_consistency',
      title: 'Constancia de Acero',
      description: 'Registra al menos 8 encuentros en la temporada actual.',
      icon: Icons.event_repeat,
      goal: 8,
      progressCalculator: (encounters) {
        final now = DateTime.now();
        return encounters
            .where((e) => e.date.year == now.year && e.date.month == now.month)
            .length
            .toDouble();
      },
    ),
    Challenge(
      id: 'quality_club',
      title: 'El Club del 9+',
      description: 'Logra 5 encuentros este mes con calificación de 9 o 10.',
      icon: Icons.military_tech,
      goal: 5,
      progressCalculator: (encounters) {
        final now = DateTime.now();
        return encounters
            .where(
              (e) =>
                  e.date.year == now.year &&
                  e.date.month == now.month &&
                  e.rating >= 9,
            )
            .length
            .toDouble();
      },
    ),
    Challenge(
      id: 'guardian_of_safety',
      title: 'Guardián de la Seguridad',
      description:
          'Logra una racha de 15 encuentros seguidos usando protección.',
      icon: Icons.health_and_safety,
      goal: 15,
      progressCalculator: (encounters) {
        if (encounters.length < 15) return 0.0;
        final sorted = List<Encounter>.from(encounters)
          ..sort((a, b) => b.date.compareTo(a.date));
        int streak = 0;
        for (var e in sorted.take(15)) {
          if (e.protected) {
            streak++;
          } else {
            // La racha se rompe, pero para la barra de progreso podemos mostrar hasta dónde llegó
            return streak.toDouble();
          }
        }
        return streak.toDouble();
      },
    ),
    Challenge(
      id: 'perfect_weekend',
      title: 'Fin de Semana Perfecto',
      description:
          'Registra encuentros el Viernes, Sábado y Domingo en un finde, todos con calificación 8+.',
      icon: Icons.celebration,
      goal: 3, // 3 días
      progressCalculator: (encounters) {
        // Esta lógica es más compleja: busca un fin de semana que cumpla la condición
        final weekends = <int, List<Encounter>>{};
        for (var e in encounters) {
          if (e.date.weekday >= 5) {
            // Viernes, Sábado o Domingo
            final weekOfYear = (e.date.day / 7)
                .ceil(); // Agrupar por semana del año
            weekends.putIfAbsent(weekOfYear, () => []).add(e);
          }
        }

        for (var weekend in weekends.values) {
          final days = weekend.map((e) => e.date.weekday).toSet();
          if (days.containsAll([5, 6, 7]) &&
              weekend.every((e) => e.rating >= 8)) {
            return 3.0; // ¡Reto completado!
          }
        }
        // Para el progreso, podríamos mostrar el finde más cercano a completarse
        return 0.0;
      },
    ),
    Challenge(
      id: 'epic_morning',
      title: 'Muy Buenos Días',
      description: 'Acumula 50 encuentros con la etiqueta "Mañanero".',
      icon: Icons.wb_sunny,
      goal: 50,
      progressCalculator: (allEncounters) {
        // Opera sobre todos los datos, sin filtro de tiempo
        return allEncounters
            .where((e) => e.tags.contains('tag_morning'))
            .length
            .toDouble();
      },
    ),
    Challenge(
      id: 'frequent_flyer',
      title: 'Viajero Frecuente',
      description: 'Acumula 15 encuentros con la etiqueta "Viaje".',
      icon: Icons.flight_takeoff,
      goal: 15,
      progressCalculator: (allEncounters) {
        return allEncounters
            .where((e) => e.tags.contains('tag_travel'))
            .length
            .toDouble();
      },
    ),
    Challenge(
      id: 'star_collector',
      title: 'Coleccionista de Estrellas',
      description: 'Logra 100 encuentros con calificación de 8 o más.',
      icon: Icons.stars,
      goal: 100,
      progressCalculator: (allEncounters) {
        return allEncounters.where((e) => e.rating >= 8).length.toDouble();
      },
    ),
    Challenge(
      id: 'centurion',
      title: 'El Centurión',
      description: 'Registra tus primeros 100 encuentros en total.',
      icon: Icons.shield,
      goal: 100,
      progressCalculator: (allEncounters) {
        return allEncounters.length.toDouble();
      },
    ),
    Challenge(
      id: 'legendary_guardian',
      title: 'Guardián Legendario',
      description:
          'Mantén una tasa de protección del 95%+ sobre al menos 50 encuentros.',
      icon: Icons.health_and_safety,
      goal: 95, // El objetivo es el 95%
      progressCalculator: (allEncounters) {
        if (allEncounters.length < 10)
          return 0.0; // Empezar a medir después de 10
        final protectedCount = allEncounters.where((e) => e.protected).length;
        return (protectedCount / allEncounters.length) * 100;
      },
    ),
    Challenge(
      id: 'polymath',
      title: 'El Polímata',
      description:
          'Usa cada una de las etiquetas disponibles al menos una vez.',
      icon: Icons.psychology,
      goal: tagKeys.length,
      progressCalculator: (allEncounters) {
        return allEncounters.expand((e) => e.tags).toSet().length.toDouble();
      },
    ),
  ];

  static List<Challenge> getChallengesWithProgress() {
    final encounterBox = Hive.box<Encounter>('encounters');
    final allEncounters = encounterBox.values.toList();

    // Devolvemos la lista de retos, cada uno sabrá cómo calcular su progreso
    return _challenges;
  }

  static Challenge? getFeaturedChallenge() {
    final challenges = getChallengesWithProgress();
    if (challenges.isEmpty) return null;

    final allEncounters = Hive.box<Encounter>('encounters').values.toList();
    try {
      return challenges.firstWhere(
        (c) => c.getProgressPercent(allEncounters) < 1.0,
      );
    } catch (e) {
      return challenges.first;
    }

    // Opción 2 (Avanzada): El que tenga el mayor porcentaje de progreso
    // challenges.sort((a, b) =>
    //   b.getProgressPercent(allEncounters).compareTo(a.getProgressPercent(allEncounters))
    // );
    // return challenges.first;
  }
}
