import 'package:hive/hive.dart';
import '../models/encounter.dart';
import '../models/user_progress.dart';

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

  // 2. DEFINICIÓN DE TROFEOS
  static const Map<String, Map<String, String>> badges = {
    'legend': {
      'name': 'Legend',
      'desc': 'Logra una calificación perfecta de 10/10.',
      'icon': '🦄',
    },
    'sprinter': {
      'name': 'The Sprinter',
      'desc': '3 encuentros en menos de 24 horas.',
      'icon': '⚡',
    },
    'safe_player': {
      'name': 'Safe Player',
      'desc': 'Racha de 10 encuentros protegidos seguidos.',
      'icon': '🛡️',
    },
    'rookie': {
      'name': 'El Debut',
      'desc': 'Registra tu primer encuentro.',
      'icon': '🌱',
    },
  };

  // 3. PROCESAR UN NUEVO ENCUENTRO
  static Future<String?> processEncounter(Encounter newEncounter) async {
    final progressBox = Hive.box<UserProgress>('user_progress');
    final encounterBox = Hive.box<Encounter>('encounters');

    // Obtener o crear progreso
    UserProgress progress = progressBox.isNotEmpty
        ? progressBox.getAt(0)!
        : UserProgress();

    // A. CALCULAR XP GANADA
    // Base 50xp + (Rating * 10). Ej: Rating 8 = 130xp
    int xpGained = 50 + (newEncounter.rating * 10);
    if (newEncounter.protected) xpGained += 20; // Bonus por cuidarse

    progress.currentXp += xpGained;

    // B. VERIFICAR LOGROS (Condiciones)
    List<String> newBadges = [];
    List<Encounter> allEncounters = encounterBox.values.toList();
    // Añadimos el nuevo temporalmente para el cálculo si aún no se ha guardado en la caja
    if (!allEncounters.contains(newEncounter)) allEncounters.add(newEncounter);

    // Ordenar por fecha reciente
    allEncounters.sort((a, b) => b.date.compareTo(a.date));

    // --- CHECK 1: ROOKIE ---
    if (!_hasBadge(progress, 'rookie')) {
      newBadges.add('rookie');
    }

    // --- CHECK 2: LEGEND (Rating 10) ---
    if (!_hasBadge(progress, 'legend') && newEncounter.rating == 10) {
      newBadges.add('legend');
    }

    // --- CHECK 3: SPRINTER (3 en 24h) ---
    if (!_hasBadge(progress, 'sprinter') && allEncounters.length >= 3) {
      // Tomamos los 3 más recientes
      final first = allEncounters[0].date;
      final third = allEncounters[2].date;
      final difference = first.difference(third).inHours;
      if (difference < 24) {
        newBadges.add('sprinter');
      }
    }

    // --- CHECK 4: SAFE PLAYER (10 seguidos protegidos) ---
    if (!_hasBadge(progress, 'safe_player') && allEncounters.length >= 10) {
      // Miramos los últimos 10
      bool isStreak = true;
      for (int i = 0; i < 10; i++) {
        if (!allEncounters[i].protected) {
          isStreak = false;
          break;
        }
      }
      if (isStreak) newBadges.add('safe_player');
    }

    // C. GUARDAR CAMBIOS
    if (newBadges.isNotEmpty) {
      List<String> currentBadges = List<String>.from(progress.unlockedBadges);

      // Agregamos los nuevos a la copia
      currentBadges.addAll(newBadges);

      // Asignamos la nueva lista al objeto
      progress.unlockedBadges = currentBadges;
    }

    if (progressBox.isNotEmpty) {
      progress.save();
    } else {
      progressBox.add(progress);
    }

    // Retornar mensaje si hubo logros para mostrar SnackBar
    if (newBadges.isNotEmpty) {
      return "¡Logro Desbloqueado: ${badges[newBadges.first]!['name']}!";
    }
    return null; // Nada nuevo
  }

  static bool _hasBadge(UserProgress p, String id) =>
      p.unlockedBadges.contains(id);

  // Helper para la UI: Obtener Nivel actual
  static Map<String, dynamic> getCurrentLevel(int xp) {
    for (int i = levels.length - 1; i >= 0; i--) {
      if (xp >= (levels[i]['xp'] as int)) {
        // Datos del nivel actual
        var current = levels[i];
        // Datos del siguiente nivel (para la barra de progreso)
        var next = (i + 1 < levels.length) ? levels[i + 1] : null;

        double progress = 0.0;
        if (next != null) {
          int range = (next['xp'] as int) - (current['xp'] as int);
          int achieved = xp - (current['xp'] as int);
          progress = achieved / range;
        } else {
          progress = 1.0; // Max level
        }

        return {
          'name': current['name'],
          'progress': progress,
          'next_xp': next != null ? next['xp'] : xp,
          'current_total_xp': xp,
        };
      }
    }
    return levels[0];
  }
}
