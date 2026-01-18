import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/services/achievement_engine.dart';
import '../models/encounter.dart';
import '../models/monthly_progress.dart';

class GamificationEngine {
  // 1. SISTEMA DE NIVELES (Ranks)
  static const List<Map<String, dynamic>> levels = [
    // Nivel Inicial: Aprendizaje y descubrimiento
    {
      'name': 'Iniciado I',
      'xp': 0,
      'desc': 'El primer paso en el camino del autoconocimiento íntimo.',
    },
    {
      'name': 'Iniciado II',
      'xp': 100,
      'desc': 'Comienzas a reconocer patrones y a entender tus ritmos.',
    },
    {
      'name': 'Iniciado III',
      'xp': 250,
      'desc': 'La curiosidad se convierte en un hábito de registro consciente.',
    },

    // Nivel Intermedio: Práctica y consistencia
    {
      'name': 'Practicante I',
      'xp': 500,
      'desc': 'La disciplina del registro revela sus primeros frutos.',
    },
    {
      'name': 'Practicante II',
      'xp': 800,
      'desc': 'Desarrollas una mayor conciencia de tus deseos y límites.',
    },
    {
      'name': 'Practicante III',
      'xp': 1200,
      'desc':
          'La consistencia demuestra un compromiso con tu bienestar sexual.',
    },

    // Nivel Avanzado: Habilidad y conocimiento
    {
      'name': 'Adepto I',
      'xp': 1700,
      'desc':
          'Dominas las herramientas y comienzas a experimentar con confianza.',
    },
    {
      'name': 'Adepto II',
      'xp': 2300,
      'desc': 'Tu entendimiento de la dinámica íntima se profundiza.',
    },
    {
      'name': 'Adepto III',
      'xp': 3000,
      'desc':
          'La calidad de tus experiencias se vuelve tan importante como la cantidad.',
    },

    // Nivel Experto: Refinamiento y destreza
    {
      'name': 'Virtuoso I',
      'xp': 4000,
      'desc': 'Tus acciones son intencionadas y tus registros, detallados.',
    },
    {
      'name': 'Virtuoso II',
      'xp': 5500,
      'desc':
          'Inspiras confianza y demuestras una gran habilidad comunicativa.',
    },
    {
      'name': 'Virtuoso III',
      'xp': 7500,
      'desc': 'La intimidad se convierte en una forma de arte que dominas.',
    },

    // Nivel de Maestría: Profundo entendimiento
    {
      'name': 'Conocedor I',
      'xp': 10000,
      'desc': 'Posees un conocimiento profundo de ti mismo y de tus parejas.',
    },
    {
      'name': 'Conocedor II',
      'xp': 13000,
      'desc':
          'Tu experiencia te permite anticipar y crear momentos inolvidables.',
    },
    {
      'name': 'Conocedor III',
      'xp': 17000,
      'desc': 'Eres un referente de madurez y salud sexual.',
    },

    // Niveles Legendarios: La cúspide
    {
      'name': 'Maestro',
      'xp': 22000,
      'desc':
          'Has alcanzado la cima del autoconocimiento y la maestría íntima.',
    },
    {
      'name': 'Gran Maestro',
      'xp': 30000,
      'desc':
          'Tu viaje inspira a otros. Has trascendido el simple acto físico.',
    },
    {
      'name': 'Leyenda',
      'xp': 40000,
      'desc': 'Tu legado está escrito en las estrellas de la intimidad.',
    },
  ];

  // static const List<Map<String, dynamic>> levels = [
  //     // Nivel Inicial
  //     {'name': 'Aspirante I', 'xp': 0},
  //     {'name': 'Aspirante II', 'xp': 100},
  //     {'name': 'Aspirante III', 'xp': 250},

  //     // Nivel Intermedio
  //     {'name': 'Explorador I', 'xp': 500},
  //     {'name': 'Explorador II', 'xp': 800},
  //     {'name': 'Explorador III', 'xp': 1200},

  //     // Nivel Avanzado
  //     {'name': 'Conquistador I', 'xp': 1700},
  //     {'name': 'Conquistador II', 'xp': 2300},
  //     {'name': 'Conquistador III', 'xp': 3000},

  //     // Nivel Experto
  //     {'name': 'Titán I', 'xp': 4000},
  //     {'name': 'Titán II', 'xp': 5500},
  //     {'name': 'Titán III', 'xp': 7500},

  //     // Nivel de Maestría
  //     {'name': 'Semidiós I', 'xp': 10000},
  //     {'name': 'Semidiós II', 'xp': 13000},
  //     {'name': 'Semidiós III', 'xp': 17000},

  //     // Niveles Finales
  //     {'name': 'Deidad', 'xp': 22000},
  //     {'name': 'Ícono', 'xp': 30000},
  //     {'name': 'Leyenda Viviente', 'xp': 40000},
  //   ];

  static const List<int> streakMilestones = [
    3,
    5,
    7,
    10,
    14,
    21,
    30,
    50,
    75,
    100,
  ];

  static Map<String, int> getNextStreakMilestone(int currentStreak) {
    // Encuentra el primer hito que es mayor que la racha actual
    for (int milestone in streakMilestones) {
      if (currentStreak < milestone) {
        return {'milestone': milestone, 'remaining': milestone - currentStreak};
      }
    }
    // Si ya se superaron todos, devolvemos el último hito
    return {'milestone': streakMilestones.last, 'remaining': 0};
  }

  // 3. OBTENER EL PROGRESO DEL MES ACTUAL (Lógica de Reset)
  static Future<MonthlyProgress> getCurrentMonthlyProgress() async {
    final box = Hive.box<MonthlyProgress>('monthly_progress');
    final currentMonthId = DateFormat('yyyy-MM').format(DateTime.now());

    try {
      // Intentamos encontrar el progreso de este mes
      return box.values.firstWhere((p) => p.monthId == currentMonthId);
    } catch (e) {
      // SI NO SE ENCUENTRA, ¡ES UN MES NUEVO!
      // Guardamos el rango final del mes anterior si existe
      await _archiveLastMonthRank();

      // Creamos el progreso nuevo (reseteado a cero)
      final newProgress = MonthlyProgress(
        monthId: currentMonthId,
        xp: 0,
        unlockedBadges: [],
      );
      await box.add(newProgress);
      return newProgress;
    }
  }

  // 4. PROCESAR NUEVO ENCUENTRO
  static Future<List<Achievement>> processEncounter(
    Encounter newEncounter,
  ) async {
    final progress = await getCurrentMonthlyProgress();
    final encounterBox = Hive.box<Encounter>('encounters');

    // 1. CALCULAR XP
    int xpGained = 50 + (newEncounter.rating * 10);
    if (newEncounter.protected) xpGained += 20;
    progress.xp += xpGained;
    await progress.save();

    // 2. DISPARAR EVENTO DE LOGRO
    final allEncounters = encounterBox.values.toList()..add(newEncounter);
    final currentMonth = DateTime.now();
    final List<Encounter> monthlyEncounters = allEncounters
        .where(
          (e) =>
              e.date.year == currentMonth.year &&
              e.date.month == currentMonth.month,
        )
        .toList();

    final streaksData = calculateStreaks(encounterBox);
    final levelData = getCurrentLevel(progress.xp);

    // Preparamos los datos que las reglas podrían necesitar
    final data = {
      'newEncounter': newEncounter,
      'allEncounters': allEncounters,
      'monthlyEncounters': monthlyEncounters,
      'streaks': streaksData,
      'level': levelData,
    };

    // Devolvemos la lista de logros desbloqueados
    return await AchievementEngine.processEvent(
      event: AchievementEvent.encounterSaved,
      data: data,
    );
  }

  // 5. HELPER PARA SABER SI UN BADGE YA ESTÁ DESBLOQUEADO EN EL MES
  static bool _hasBadge(MonthlyProgress p, String id) =>
      p.unlockedBadges.contains(id);

  // 6. HELPER PARA OBTENER EL NIVEL ACTUAL
  static Map<String, dynamic> getCurrentLevel(int xp) {
    for (int i = levels.length - 1; i >= 0; i--) {
      if (xp >= (levels[i]['xp'] as int)) {
        var current = levels[i];
        var next = (i + 1 < levels.length) ? levels[i + 1] : null;

        double progress = 0.0;
        if (next != null) {
          int range = (next['xp'] as int) - (current['xp'] as int);
          int achieved = xp - (current['xp'] as int);
          progress = range > 0 ? (achieved / range) : 1.0;
        } else {
          progress = 1.0; // Max level
        }

        return {
          'name': current['name'],
          'progress': progress.clamp(0.0, 1.0), // Asegurar que esté entre 0 y 1
          'next_xp': next != null ? next['xp'] : xp,
          'current_total_xp': xp,
        };
      }
    }
    return levels[0]; // Default al nivel más bajo
  }

  // 7. HELPER PARA ARCHIVAR EL RANGO DEL MES PASADO
  static Future<void> _archiveLastMonthRank() async {
    final box = Hive.box<MonthlyProgress>('monthly_progress');
    final encounterBox = Hive.box<Encounter>('encounters');
    final lastMonth = DateTime.now().subtract(
      const Duration(days: 15),
    ); // Un día del mes pasado
    final lastMonthId = DateFormat('yyyy-MM').format(lastMonth);

    try {
      final lastProgress = box.values.firstWhere(
        (p) => p.monthId == lastMonthId,
      );
      // Si no tiene rango final, se lo asignamos
      if (lastProgress.finalRank == null) {
        lastProgress.finalRank = getCurrentLevel(lastProgress.xp)['name'];
      }

      if (lastProgress.longestStreakOfMonth == null) {
        final streaksOfLastMonth = calculateStreaks(
          encounterBox,
          monthId: lastMonthId,
        );
        lastProgress.longestStreakOfMonth = streaksOfLastMonth['longest'];
      }

      await lastProgress.save();
    } catch (e) {
      // No había progreso el mes pasado, no hacemos nada
    }
  }

  static Map<String, int> calculateStreaks(
    Box<Encounter> encounterBox, {
    String? monthId,
  }) {
    var encounters = encounterBox.values;

    // Si se proporciona un monthId, filtramos los encuentros solo para ese mes
    if (monthId != null) {
      final monthDate = DateFormat('yyyy-MM').parse(monthId);
      encounters = encounters
          .where(
            (e) =>
                e.date.year == monthDate.year &&
                e.date.month == monthDate.month,
          )
          .toList();
    }

    // El resto de la lógica es la misma que antes
    if (encounters.isEmpty) return {'current': 0, 'longest': 0};

    final uniqueDays = encounters
        .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
        .toSet()
        .toList();
    uniqueDays.sort();

    if (uniqueDays.isEmpty) return {'current': 0, 'longest': 0};

    int currentStreak = 1;
    int longestStreak = 1;

    for (int i = 1; i < uniqueDays.length; i++) {
      if (uniqueDays[i].difference(uniqueDays[i - 1]).inDays == 1) {
        currentStreak++;
      } else {
        if (currentStreak > longestStreak) longestStreak = currentStreak;
        currentStreak = 1;
      }
    }
    if (currentStreak > longestStreak) longestStreak = currentStreak;

    // La 'racha actual' solo tiene sentido si no estamos filtrando por un mes pasado
    if (monthId == null) {
      final lastDay = uniqueDays.last;
      final today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      if (today.difference(lastDay).inDays > 1) {
        currentStreak = 0;
      }
    } else {
      currentStreak = 0; // No hay 'racha actual' para un mes pasado
    }

    return {'current': currentStreak, 'longest': longestStreak};
  }
}
