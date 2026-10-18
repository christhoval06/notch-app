import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_lifecycle_rule_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';

final List<Achievement> appLifecycleAchievements = [
  Achievement(
    id: 'abstinence_bronze',
    name: 'Abstinencia Bronce',
    description: 'Alcanza 7 días de abstinencia en el mes actual.',
    icon: '🥉',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasMonthlyAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 7,
    ),
  ),
  Achievement(
    id: 'abstinence_silver',
    name: 'Abstinencia Plata',
    description: 'Alcanza 14 días de abstinencia en el mes actual.',
    icon: '🥈',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasMonthlyAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 14,
    ),
  ),
  Achievement(
    id: 'abstinence_gold',
    name: 'Abstinencia Oro',
    description: 'Alcanza 30 días de abstinencia en el mes actual.',
    icon: '🥇',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasMonthlyAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 30,
    ),
  ),
  Achievement(
    id: 'abstinence_master_45',
    name: 'Abstinencia 45',
    description: 'Alcanza 45 días históricos de abstinencia.',
    icon: '🧱',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasHistoricalAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 45,
    ),
  ),
  Achievement(
    id: 'abstinence_diamond',
    name: 'Abstinencia Diamante',
    description: 'Alcanza 60 días históricos de abstinencia.',
    icon: '💎',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasHistoricalAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 60,
    ),
  ),
  Achievement(
    id: 'abstinence_master_90',
    name: 'Abstinencia 90',
    description: 'Alcanza 90 días históricos de abstinencia.',
    icon: '🌌',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasHistoricalAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 90,
    ),
  ),
  Achievement(
    id: 'abstinence_master_120',
    name: 'Abstinencia 120',
    description: 'Alcanza 120 días históricos de abstinencia.',
    icon: '🏔️',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasHistoricalAbstinenceMilestone(
      allEncounters: data['allEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
      milestoneDays: 120,
    ),
  ),
  Achievement(
    id: 'monk_mode',
    name: 'Modo Monje',
    description: 'Mantén 100% de abstinencia durante el mes actual.',
    icon: '👑',
    event: AchievementEvent.appStarted,
    condition: (data) => AchievementLifecycleRuleService.hasMonkMode(
      allEncounters: data['allEncounters'] as List<Encounter>,
      monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
      now: data['now'] as DateTime,
    ),
  ),
];
