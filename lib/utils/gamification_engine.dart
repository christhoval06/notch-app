import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/encounter.dart';
import '../models/monthly_progress.dart';

class GamificationEngine {
  // 1. SISTEMA DE NIVELES (Ranks)
  static const List<Map<String, dynamic>> levels = [
    {'name': 'Cobre I', 'xp': 0},
    {'name': 'Cobre II', 'xp': 100},
    {'name': 'Cobre III', 'xp': 250},
    {'name': 'Plata I', 'xp': 500},
    {'name': 'Plata II', 'xp': 800},
    {'name': 'Plata III', 'xp': 1200},
    {'name': 'Oro I', 'xp': 1700},
    {'name': 'Oro II', 'xp': 2300},
    {'name': 'Oro III', 'xp': 3000},
    {'name': 'Platino I', 'xp': 4000},
    {'name': 'Platino II', 'xp': 5500},
    {'name': 'Platino III', 'xp': 7500},
    {'name': 'Esmeralda I', 'xp': 10000},
    {'name': 'Esmeralda II', 'xp': 13000},
    {'name': 'Esmeralda III', 'xp': 17000},
    {'name': 'Maestro', 'xp': 22000},
    {'name': 'Gran Maestro', 'xp': 30000},
  ];

  // 2. DEFINICIÓN DE TROFEOS (Badges)
  static const Map<String, Map<String, String>> badges = {
    'rookie': {
      'name': 'El Debut',
      'desc': 'Registra tu primer encuentro.',
      'icon': '🌱',
    },
    'legend': {
      'name': 'Legend',
      'desc': 'Logra una calificación perfecta de 10/10 en un mes.',
      'icon': '🦄',
    },
    'sprinter': {
      'name': 'The Sprinter',
      'desc': '3 encuentros en menos de 24 horas en un mes.',
      'icon': '⚡',
    },
    'safe_player': {
      'name': 'Safe Player',
      'desc': 'Racha de 10 encuentros protegidos seguidos en un mes.',
      'icon': '🛡️',
    },
  };

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
  static Future<String?> processEncounter(Encounter newEncounter) async {
    final progress = await getCurrentMonthlyProgress();
    final encounterBox = Hive.box<Encounter>('encounters');

    // A. CALCULAR XP
    int xpGained = 50 + (newEncounter.rating * 10);
    if (newEncounter.protected) xpGained += 20;
    progress.xp += xpGained;

    // B. VERIFICAR LOGROS
    List<String> newBadges = [];

    // --- OBTENEMOS AMBOS TIPOS DE DATOS ---
    // Lista de TODOS los encuentros para logros de "una vez en la vida"
    final List<Encounter> allEncounters = encounterBox.values.toList();

    // Lista de encuentros SOLO de este mes para logros de temporada
    final currentMonth = DateTime.now();
    final List<Encounter> monthlyEncounters = allEncounters
        .where(
          (e) =>
              e.date.year == currentMonth.year &&
              e.date.month == currentMonth.month,
        )
        .toList();

    // Ordenar por fecha reciente (útil para rachas)
    monthlyEncounters.sort((a, b) => b.date.compareTo(a.date));

    // --- INICIO DE LAS COMPROBACIONES ---

    // --- CHECK 1: THE DEBUT (Rookie) ---
    // Se basa en el total de encuentros. Solo se puede ganar una vez.
    if (allEncounters.length == 1 && !_hasBadge(progress, 'rookie')) {
      newBadges.add('rookie');
    }

    // --- CHECK 2: LEGEND (Rating 10) ---
    // Se puede ganar cada mes.
    if (!_hasBadge(progress, 'legend') && newEncounter.rating == 10) {
      newBadges.add('legend');
    }

    // --- CHECK 3: SPRINTER (3 en 24h) ---
    // Se basa en los encuentros del mes actual.
    if (!_hasBadge(progress, 'sprinter') && monthlyEncounters.length >= 3) {
      final first = monthlyEncounters[0].date;
      final third = monthlyEncounters[2].date;
      if (first.difference(third).inHours < 24) {
        newBadges.add('sprinter');
      }
    }

    // --- CHECK 4: SAFE PLAYER (Racha de 10) ---
    // Se basa en los encuentros del mes actual.
    if (!_hasBadge(progress, 'safe_player') && monthlyEncounters.length >= 10) {
      final recentTen = monthlyEncounters.take(10);
      if (recentTen.every((e) => e.protected)) {
        newBadges.add('safe_player');
      }
    }

    // C. GUARDAR CAMBIOS
    if (newBadges.isNotEmpty) {
      progress.unlockedBadges = List<String>.from(progress.unlockedBadges)
        ..addAll(newBadges);
    }
    await progress.save();

    if (newBadges.isNotEmpty) {
      return "¡Logro Desbloqueado: ${badges[newBadges.first]!['name']}!";
    }
    return null;
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
        await lastProgress.save();
      }
    } catch (e) {
      // No había progreso el mes pasado, no hacemos nada
    }
  }
}
