class GamificationLevelService {
  const GamificationLevelService._();

  static const List<Map<String, dynamic>> levels = [
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
    for (final milestone in streakMilestones) {
      if (currentStreak < milestone) {
        return {'milestone': milestone, 'remaining': milestone - currentStreak};
      }
    }
    return {'milestone': streakMilestones.last, 'remaining': 0};
  }

  static Map<String, dynamic> getCurrentLevel(int xp) {
    for (int i = levels.length - 1; i >= 0; i--) {
      if (xp >= (levels[i]['xp'] as int)) {
        final current = levels[i];
        final next = (i + 1 < levels.length) ? levels[i + 1] : null;
        final progress = next == null
            ? 1.0
            : (((xp - (current['xp'] as int)) /
                      ((next['xp'] as int) - (current['xp'] as int))))
                  .clamp(0.0, 1.0);
        return {
          'name': current['name'],
          'progress': progress,
          'next_xp': next != null ? next['xp'] : xp,
          'current_total_xp': xp,
        };
      }
    }
    return levels.first;
  }
}
