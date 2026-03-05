import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';

import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/features/feature/gamification/services/abstinence_service.dart';

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
      id: 'abstinence_bronze',
      name: 'Abstinencia Bronce',
      description: 'Alcanza 7 días de abstinencia.',
      icon: '🥉',
      event: AchievementEvent.appStarted,
      condition: (data) {
        final allEncounters = data['allEncounters'] as List<Encounter>;
        return AbstinenceService.longestAbstinenceDays(allEncounters) >= 7;
      },
    ),
    Achievement(
      id: 'abstinence_silver',
      name: 'Abstinencia Plata',
      description: 'Alcanza 14 días de abstinencia.',
      icon: '🥈',
      event: AchievementEvent.appStarted,
      condition: (data) {
        final allEncounters = data['allEncounters'] as List<Encounter>;
        return AbstinenceService.longestAbstinenceDays(allEncounters) >= 14;
      },
    ),
    Achievement(
      id: 'abstinence_gold',
      name: 'Abstinencia Oro',
      description: 'Alcanza 30 días de abstinencia.',
      icon: '🥇',
      event: AchievementEvent.appStarted,
      condition: (data) {
        final allEncounters = data['allEncounters'] as List<Encounter>;
        return AbstinenceService.longestAbstinenceDays(allEncounters) >= 30;
      },
    ),
    Achievement(
      id: 'abstinence_diamond',
      name: 'Abstinencia Diamante',
      description: 'Alcanza 60 días de abstinencia.',
      icon: '💎',
      event: AchievementEvent.appStarted,
      condition: (data) {
        final allEncounters = data['allEncounters'] as List<Encounter>;
        return AbstinenceService.longestAbstinenceDays(allEncounters) >= 60;
      },
    ),
    Achievement(
      id: 'monk_mode',
      name: 'Modo Monje',
      description: 'Mantén 100% de abstinencia durante el mes actual.',
      icon: '👑',
      event: AchievementEvent.appStarted,
      condition: (data) {
        final monthlyEncounters = data['monthlyEncounters'] as List<Encounter>;
        final now = data['now'] as DateTime;
        return monthlyEncounters.isEmpty && now.day >= 7;
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

  static Future<void> processAppStarted() async {
    final now = DateTime.now();
    final currentMonthId = DateFormat('yyyy-MM').format(now);
    final encounterBox = Hive.box<Encounter>('encounters');
    final allEncounters = encounterBox.values.toList();
    final monthlyEncounters = allEncounters
        .where((e) => DateFormat('yyyy-MM').format(e.date) == currentMonthId)
        .toList();

    await processEvent(
      event: AchievementEvent.appStarted,
      data: {
        'allEncounters': allEncounters,
        'monthlyEncounters': monthlyEncounters,
        'now': now,
      },
    );
  }

  static Future<void> recalculateAllDBAchievements() async {
    // 1. OBTENER Y ORDENAR TODOS LOS DATOS
    final encounterBox = Hive.box<Encounter>('encounters');
    final healthBox = Hive.box<HealthLog>('health_logs');

    // Ordenamos los encuentros cronológicamente, del más antiguo al más reciente
    final allEncounters = encounterBox.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final allHealthLogs = healthBox.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    // 2. RESETEAR EL PROGRESO
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');
    GlobalProgress globalProgress = globalProgressBox.isNotEmpty
        ? globalProgressBox.getAt(0)!
        : GlobalProgress();

    globalProgress.unlockedOnceAchievements.clear();
    for (var progress in monthlyProgressBox.values) {
      progress.unlockedBadges.clear();
    }

    // 3. SIMULAR EL HISTORIAL PASO A PASO

    // --- FASE 1: RE-EVALUAR LOGROS BASADOS EN ENCUENTROS ---
    for (int i = 0; i < allEncounters.length; i++) {
      final currentEncounter = allEncounters[i];
      final monthId = DateFormat('yyyy-MM').format(currentEncounter.date);

      // Obtenemos o creamos el progreso para el mes de este encuentro
      MonthlyProgress progressOfMonth;
      try {
        progressOfMonth = monthlyProgressBox.values.firstWhere(
          (p) => p.monthId == monthId,
        );
      } catch (e) {
        progressOfMonth = MonthlyProgress(
          monthId: monthId,
          xp: 0,
          unlockedBadges: [],
        );
        await monthlyProgressBox.add(progressOfMonth);
      }

      // Preparamos los datos del "estado del mundo" en este punto del tiempo
      final encountersUpToThisPoint = allEncounters.sublist(0, i + 1);
      final monthlyUpToThisPoint = encountersUpToThisPoint
          .where((e) => DateFormat('yyyy-MM').format(e.date) == monthId)
          .toList();

      final dataForThisStep = {
        'newEncounter': currentEncounter,
        'allEncounters': encountersUpToThisPoint,
        'monthlyEncounters': monthlyUpToThisPoint,
        'streaks': GamificationEngine.calculateStreaks(
          encounterBox,
        ), // Simplificado
        'level': GamificationEngine.getCurrentLevel(progressOfMonth.xp),
      };

      // Verificamos todos los logros de tipo 'encounterSaved'
      final relevantAchievements = _achievements.where(
        (a) => a.event == AchievementEvent.encounterSaved,
      );
      for (var achievement in relevantAchievements) {
        bool alreadyUnlocked = false;
        if (achievement.type == AchievementType.once) {
          alreadyUnlocked = globalProgress.unlockedOnceAchievements.contains(
            achievement.id,
          );
        } else {
          alreadyUnlocked = progressOfMonth.unlockedBadges.contains(
            achievement.id,
          );
        }

        if (!alreadyUnlocked && achievement.condition(dataForThisStep)) {
          if (achievement.type == AchievementType.once) {
            globalProgress.unlockedOnceAchievements.add(achievement.id);
          } else {
            progressOfMonth.unlockedBadges.add(achievement.id);
          }
        }
      }
    }

    // --- FASE 2: RE-EVALUAR LOGROS BASADOS EN SALUD ---
    // (Esta lógica es más simple porque el logro 'health_champion' es solo sobre el primero)
    final healthAchievements = _achievements.where(
      (a) => a.event == AchievementEvent.healthLogSaved,
    );
    for (var achievement in healthAchievements) {
      if (achievement.condition({'allHealthLogs': allHealthLogs})) {
        if (!globalProgress.unlockedOnceAchievements.contains(achievement.id)) {
          globalProgress.unlockedOnceAchievements.add(achievement.id);
        }
      }
    }

    // 4. GUARDAR TODOS LOS CAMBIOS
    if (globalProgressBox.isNotEmpty)
      await globalProgress.save();
    else
      await globalProgressBox.add(globalProgress);
    for (var progress in monthlyProgressBox.values) await progress.save();
    await processAppStarted();

    print("--- Re-cálculo de logros completado ---");
  }

  static Future<void> recalculateAllAchievements() async {
    print("--- Iniciando re-cálculo de todos los logros ---");

    // 1. OBTENER Y ORDENAR TODOS LOS DATOS
    final encounterBox = Hive.box<Encounter>('encounters');
    final healthBox = Hive.box<HealthLog>('health_logs');

    // Ordenamos los encuentros cronológicamente, del más antiguo al más reciente
    final allEncounters = encounterBox.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final allHealthLogs = healthBox.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    // 2. RESETEAR EL PROGRESO
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');
    GlobalProgress globalProgress = globalProgressBox.isNotEmpty
        ? globalProgressBox.getAt(0)!
        : GlobalProgress();

    globalProgress.unlockedOnceAchievements.clear();
    for (var progress in monthlyProgressBox.values) {
      progress.unlockedBadges.clear();
    }

    // 3. SIMULAR EL HISTORIAL PASO A PASO

    // --- FASE 1: RE-EVALUAR LOGROS BASADOS EN ENCUENTROS ---
    for (int i = 0; i < allEncounters.length; i++) {
      final currentEncounter = allEncounters[i];
      final monthId = DateFormat('yyyy-MM').format(currentEncounter.date);

      // Obtenemos o creamos el progreso para el mes de este encuentro
      MonthlyProgress progressOfMonth;
      try {
        progressOfMonth = monthlyProgressBox.values.firstWhere(
          (p) => p.monthId == monthId,
        );
      } catch (e) {
        progressOfMonth = MonthlyProgress(
          monthId: monthId,
          xp: 0,
          unlockedBadges: [],
        );
        await monthlyProgressBox.add(progressOfMonth);
      }

      // Preparamos los datos del "estado del mundo" en este punto del tiempo
      final encountersUpToThisPoint = allEncounters.sublist(0, i + 1);
      final monthlyUpToThisPoint = encountersUpToThisPoint
          .where((e) => DateFormat('yyyy-MM').format(e.date) == monthId)
          .toList();

      final dataForThisStep = {
        'newEncounter': currentEncounter,
        'allEncounters': encountersUpToThisPoint,
        'monthlyEncounters': monthlyUpToThisPoint,
        'streaks': GamificationEngine.calculateStreaks(
          encounterBox,
        ), // Simplificado
        'level': GamificationEngine.getCurrentLevel(progressOfMonth.xp),
      };

      // Verificamos todos los logros de tipo 'encounterSaved'
      final relevantAchievements = _achievements.where(
        (a) => a.event == AchievementEvent.encounterSaved,
      );
      for (var achievement in relevantAchievements) {
        bool alreadyUnlocked = false;
        if (achievement.type == AchievementType.once) {
          alreadyUnlocked = globalProgress.unlockedOnceAchievements.contains(
            achievement.id,
          );
        } else {
          alreadyUnlocked = progressOfMonth.unlockedBadges.contains(
            achievement.id,
          );
        }

        if (!alreadyUnlocked && achievement.condition(dataForThisStep)) {
          if (achievement.type == AchievementType.once) {
            globalProgress.unlockedOnceAchievements.add(achievement.id);
          } else {
            progressOfMonth.unlockedBadges.add(achievement.id);
          }
        }
      }
    }

    // --- FASE 2: RE-EVALUAR LOGROS BASADOS EN SALUD ---
    // (Esta lógica es más simple porque el logro 'health_champion' es solo sobre el primero)
    final healthAchievements = _achievements.where(
      (a) => a.event == AchievementEvent.healthLogSaved,
    );
    for (var achievement in healthAchievements) {
      if (achievement.condition({'allHealthLogs': allHealthLogs})) {
        if (!globalProgress.unlockedOnceAchievements.contains(achievement.id)) {
          globalProgress.unlockedOnceAchievements.add(achievement.id);
        }
      }
    }

    // 4. GUARDAR TODOS LOS CAMBIOS
    if (globalProgressBox.isNotEmpty)
      await globalProgress.save();
    else
      await globalProgressBox.add(globalProgress);
    for (var progress in monthlyProgressBox.values) await progress.save();
    await processAppStarted();

    print("--- Re-cálculo de logros completado ---");
  }
}
