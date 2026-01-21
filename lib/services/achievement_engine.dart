import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/models/global_progress.dart';
import 'package:notch_app/models/monthly_progress.dart';

import '../models/encounter.dart';
import '../models/health_log.dart';
import '../utils/gamification_engine.dart';

// --- 1. DEFINICIÓN DE EVENTOS ---
// Representan acciones clave en la app que pueden desbloquear logros.
enum AchievementEvent {
  appStarted, // Podríamos usarlo para un logro de "Bienvenida"
  encounterSaved,
  healthLogSaved,
  backupCreated,
}

enum AchievementType {
  once, // Solo se puede ganar una vez en la vida
  seasonal, // Se puede ganar cada mes
}

// --- 2. CLASE QUE REPRESENTA UN ÚNICO LOGRO ---
class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;
  final AchievementEvent event; // ¿A qué evento reacciona este logro?
  final bool Function(Map<String, dynamic> data)
  condition; // La condición para desbloquearlo
  final AchievementType type;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.event,
    required this.condition,
    this.type = AchievementType.seasonal,
  });
}

// --- 3. EL MOTOR DE LOGROS ---
class AchievementEngine {
  // --- LISTA MAESTRA DE TODOS LOS LOGROS DE LA APP ---
  // Para añadir un nuevo logro, solo tienes que agregarlo a esta lista.
  static final List<Achievement> _achievements = [
    // --- Logros de Encuentros (Reaccionan a 'encounterSaved') ---
    Achievement(
      id: 'rookie',
      name: 'El Debut',
      description: 'Registra tu primer encuentro.',
      icon: '🌱',
      event: AchievementEvent.encounterSaved,
      condition: (data) =>
          (data['allEncounters'] as List<Encounter>).length == 1,
      type: AchievementType.once,
    ),
    Achievement(
      id: 'legend',
      name: 'Legendario',
      description: 'Logra una calificación perfecta de 10/10.',
      icon: '🦄',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final newEncounter = data['newEncounter'] as Encounter;
        return newEncounter.rating == 10;
      },
    ),
    Achievement(
      id: 'sprinter',
      name: 'Sprinter',
      description: '3 encuentros en menos de 24 horas.',
      icon: '⚡',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final monthly = data['monthlyEncounters'] as List<Encounter>;
        return monthly.length >= 3 &&
            monthly[0].date.difference(monthly[2].date).inHours < 24;
      },
    ),
    Achievement(
      id: 'safe_player',
      name: 'Jugador Seguro',
      description: 'Racha de 10 encuentros protegidos.',
      icon: '🛡️',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final monthly = data['monthlyEncounters'] as List<Encounter>;
        return monthly.length >= 10 &&
            monthly.take(10).every((e) => e.protected);
      },
    ),
    Achievement(
      id: 'hat_trick',
      name: 'Hat-Trick',
      description: '3 orgasmos o más en un solo encuentro.',
      icon: '⚽',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final newEncounter = data['newEncounter'] as Encounter;
        return newEncounter.orgasmCount >= 3;
      },
    ),
    Achievement(
      id: 'marathoner',
      name: 'Maratonista',
      description: '5 encuentros en un fin de semana (Vie-Dom) en un mes.',
      icon: '🏃‍♂️',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final monthly = data['monthlyEncounters'] as List<Encounter>;
        final weekendCount = monthly.where((e) => e.date.weekday >= 5).length;
        return weekendCount >= 5;
      },
    ),
    Achievement(
      id: 'renaissance_man',
      name: 'Hombre Renacentista',
      description: 'Actividad en cada día de la semana en un mes.',
      icon: '🎨',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final monthly = data['monthlyEncounters'] as List<Encounter>;
        return monthly.map((e) => e.date.weekday).toSet().length == 7;
      },
    ),
    Achievement(
      id: 'fire_streak',
      name: 'Racha de Fuego',
      description: 'Mantén una racha de 7 días seguidos.',
      icon: '🔥',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final streaks = data['streaks'] as Map<String, int>;
        return (streaks['current'] ?? 0) >= 7 || (streaks['longest'] ?? 0) >= 7;
      },
    ),
    Achievement(
      id: 'top_critic',
      name: 'Crítico Exigente',
      description: '5 encuentros seguidos con calificación de 9+.',
      icon: '🧐',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final monthly = data['monthlyEncounters'] as List<Encounter>;
        return monthly.length >= 5 &&
            monthly.take(5).every((e) => e.rating >= 9);
      },
    ),
    Achievement(
      id: 'grand_master',
      name: 'Gran Maestro',
      description: 'Alcanza el rango "Gran Maestro" en una temporada.',
      icon: '🏛️',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final level = data['level'] as Map<String, dynamic>;
        return level != null && level['name'] == 'Gran Maestro';
      },
    ),
    Achievement(
      id: 'explorer',
      name: 'Explorador',
      description: 'Usa 5 etiquetas diferentes en un mes.',
      icon: '🧭',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final monthly = data['monthlyEncounters'] as List<Encounter>;
        return monthly.expand((e) => e.tags).toSet().length >= 5;
      },
    ),
    Achievement(
      id: 'globetrotter',
      name: 'Trotamundos',
      description: 'Registra un encuentro con la etiqueta "Viaje".',
      icon: '🌍',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final newEncounter = data['newEncounter'] as Encounter;
        return newEncounter.tags.contains('tag_travel');
      },
    ),
    Achievement(
      id: 'night_owl',
      name: 'Noctámbulo',
      description: '10 encuentros registrados después de la medianoche.',
      icon: '🦉',
      event: AchievementEvent.encounterSaved,
      condition: (data) {
        final allEncounters = data['allEncounters'] as List<Encounter>;
        return allEncounters
                .where((e) => e.date.hour >= 0 && e.date.hour < 6)
                .length >=
            10;
      },
    ),

    // --- Logros de Salud (Reaccionan a 'healthLogSaved') ---
    Achievement(
      id: 'health_champion',
      name: 'Campeón de la Salud',
      description: 'Registra tu primer chequeo en el Health Passport.',
      icon: '✅',
      event: AchievementEvent.healthLogSaved,
      condition: (data) {
        final healthLogs = data['allHealthLogs'] as List<HealthLog>;
        return healthLogs.length == 1;
      },
      type: AchievementType.once,
    ),

    // --- Logros de Datos (Reaccionan a 'backupCreated') ---
    Achievement(
      id: 'archivist',
      name: 'Archivista',
      description: 'Realiza tu primer Backup de datos.',
      icon: '💾',
      event: AchievementEvent.backupCreated,
      condition: (data) {
        // Para este evento, la condición es siempre verdadera la primera vez que se dispara
        return true;
      },
      type: AchievementType.once,
    ),
  ];

  // --- FUNCIÓN PÚBLICA PARA PROCESAR EVENTOS ---
  static Future<List<Achievement>> processEvent({
    required AchievementEvent event,
    Map<String, dynamic> data = const {},
  }) async {
    final monthlyProgress =
        await GamificationEngine.getCurrentMonthlyProgress();
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');

    List<Achievement> unlockedAchievements = [];

    GlobalProgress globalProgress = globalProgressBox.isNotEmpty
        ? globalProgressBox.getAt(0)!
        : GlobalProgress();

    // Filtramos los logros que reaccionan a este evento y que aún no han sido desbloqueados este mes
    // final relevantAchievements = _achievements
    //     .where(
    //       (ach) =>
    //           ach.event == event && !progress.unlockedBadges.contains(ach.id),
    //     )
    //     .toList();

    final relevantAchievements = _achievements
        .where((ach) => ach.event == event)
        .toList();

    for (var achievement in relevantAchievements) {
      bool alreadyUnlocked = false;

      // --- LA LÓGICA CLAVE ---
      if (achievement.type == AchievementType.once) {
        // Si es de tipo "una vez", comprobamos en el progreso GLOBAL
        alreadyUnlocked = globalProgress.unlockedOnceAchievements.contains(
          achievement.id,
        );
      } else {
        // Si es de temporada, comprobamos en el progreso MENSUAL
        alreadyUnlocked = monthlyProgress.unlockedBadges.contains(
          achievement.id,
        );
      }

      if (!alreadyUnlocked && achievement.condition(data)) {
        unlockedAchievements.add(achievement);

        // Guardamos el ID en el lugar correcto
        if (achievement.type == AchievementType.once) {
          globalProgress.unlockedOnceAchievements = List<String>.from(
            globalProgress.unlockedOnceAchievements,
          )..add(achievement.id);
        } else {
          monthlyProgress.unlockedBadges = List<String>.from(
            monthlyProgress.unlockedBadges,
          )..add(achievement.id);
        }
      }
    }

    if (unlockedAchievements.isNotEmpty) {
      await monthlyProgress.save();
      if (globalProgressBox.isNotEmpty) {
        await globalProgress.save();
      } else {
        await globalProgressBox.add(globalProgress);
      }
    }

    return unlockedAchievements;
  }

  // Helper para la UI: obtener la lista de todos los logros para el TrophyRoom
  static List<Achievement> getAllAchievements() => _achievements;

  static Future<void> recalculateAllAchievements() async {
    print("--- Iniciando re-cálculo de todos los logros ---");

    // 1. OBTENER LAS BASES DE DATOS
    final encounterBox = Hive.box<Encounter>('encounters');
    final healthBox = Hive.box<HealthLog>('health_logs');
    // ... (añade aquí otras cajas si son necesarias para futuros logros)

    final allEncounters = encounterBox.values.toList();
    final allHealthLogs = healthBox.values.toList();

    // No podemos simular el evento de backup, ya que no es un dato guardado

    // 2. OBTENER EL PROGRESO GLOBAL Y DE TODOS LOS MESES
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');

    GlobalProgress globalProgress = globalProgressBox.isNotEmpty
        ? globalProgressBox.getAt(0)!
        : GlobalProgress();

    // Limpiamos los logros para empezar de cero
    globalProgress.unlockedOnceAchievements = [];
    for (var progress in monthlyProgressBox.values) {
      progress.unlockedBadges = [];
    }

    // 3. ITERAR SOBRE CADA LOGRO Y VERIFICAR SU CONDICIÓN
    for (final achievement in _achievements) {
      bool unlocked = false;

      // Preparamos los datos según el evento que el logro espera
      Map<String, dynamic> data = {};

      switch (achievement.event) {
        case AchievementEvent.appStarted:
          // Los logros de 'appStarted' no se pueden re-calcular con datos pasados.
          // Simplemente continuamos con el siguiente logro.
          continue;
        case AchievementEvent.encounterSaved:
          // Para logros de encuentro, iteramos sobre cada encuentro
          for (int i = 0; i < allEncounters.length; i++) {
            final currentEncounter = allEncounters[i];

            // Reconstruimos el estado de los datos como si acabáramos de guardar este encuentro
            final encountersUpToThisPoint = allEncounters.sublist(0, i + 1);
            final monthlyEncounters = encountersUpToThisPoint
                .where(
                  (e) =>
                      e.date.year == currentEncounter.date.year &&
                      e.date.month == currentEncounter.date.month,
                )
                .toList();

            // NOTA: Para las rachas y el nivel, esto puede ser computacionalmente caro.
            // Por ahora, lo simplificaremos. Una versión más avanzada podría ser más eficiente.

            data = {
              'newEncounter': currentEncounter,
              'allEncounters': encountersUpToThisPoint,
              'monthlyEncounters': monthlyEncounters,
              'streaks': GamificationEngine.calculateStreaks(encounterBox),
              'level': <String, dynamic>{'name': '', 'progress': 0.0},
            };

            if (achievement.condition(data)) {
              unlocked = true;
              break; // Una vez desbloqueado, no necesitamos seguir verificando este logro
            }
          }
          break;

        case AchievementEvent.healthLogSaved:
          data = {'allHealthLogs': allHealthLogs};
          if (achievement.condition(data)) {
            unlocked = true;
          }
          break;

        case AchievementEvent.backupCreated:
          // No se puede re-calcular, se salta
          continue;
      }

      // 4. SI SE DESBLOQUEÓ, GUARDAMOS EN EL LUGAR CORRECTO
      if (unlocked) {
        if (achievement.type == AchievementType.once) {
          if (!globalProgress.unlockedOnceAchievements.contains(
            achievement.id,
          )) {
            globalProgress.unlockedOnceAchievements.add(achievement.id);
          }
        } else {
          // Para logros de temporada, lo añadimos a CADA mes donde se cumplió
          // Esta es una simplificación. Una lógica más precisa podría ser compleja.
          // Por ahora, lo añadiremos al progreso del mes más reciente donde se cumplió.
          final relevantMonthId = DateFormat(
            'yyyy-MM',
          ).format(allEncounters.last.date);
          try {
            final progress = monthlyProgressBox.values.firstWhere(
              (p) => p.monthId == relevantMonthId,
            );
            if (!progress.unlockedBadges.contains(achievement.id)) {
              progress.unlockedBadges.add(achievement.id);
            }
          } catch (e) {}
        }
      }
    }

    // 5. GUARDAR TODOS LOS CAMBIOS
    if (globalProgressBox.isNotEmpty) {
      await globalProgress.save();
    } else {
      await globalProgressBox.add(globalProgress);
    }

    for (var progress in monthlyProgressBox.values) {
      await progress.save();
    }

    print("--- Re-cálculo de logros completado ---");
  }
}
