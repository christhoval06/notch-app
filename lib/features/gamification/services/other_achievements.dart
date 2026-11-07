import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/gamification/services/achievement_lifecycle_rule_service.dart';
import 'package:notch_app/features/gamification/services/achievement_models.dart';

final List<Achievement> otherAchievements = [
  Achievement(
    id: 'health_champion',
    name: 'Campeón de la Salud',
    description: 'Registra tu primer chequeo en el Health Passport.',
    icon: '✅',
    event: AchievementEvent.healthLogSaved,
    condition: (data) => AchievementLifecycleRuleService.hasFirstHealthLog(
      data['allHealthLogs'] as List<HealthLog>,
    ),
    type: AchievementType.once,
  ),
  Achievement(
    id: 'archivist',
    name: 'Archivista',
    description: 'Realiza tu primer Backup de datos.',
    icon: '💾',
    event: AchievementEvent.backupCreated,
    condition: (_) => AchievementLifecycleRuleService.hasCreatedBackup(),
    type: AchievementType.once,
  ),
];
