import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/monthly_progress.dart';

class AchievementAppStartedData {
  const AchievementAppStartedData({
    required this.allEncounters,
    required this.monthlyEncounters,
    required this.now,
  });

  final List<Encounter> allEncounters;
  final List<Encounter> monthlyEncounters;
  final DateTime now;

  Map<String, dynamic> toEventData() {
    return {
      'allEncounters': allEncounters,
      'monthlyEncounters': monthlyEncounters,
      'now': now,
    };
  }
}

class AchievementRebuildData {
  const AchievementRebuildData({
    required this.allEncounters,
    required this.allHealthLogs,
    required this.globalProgressBox,
    required this.monthlyProgressBox,
    required this.globalProgress,
  });

  final List<Encounter> allEncounters;
  final List<HealthLog> allHealthLogs;
  final Box<GlobalProgress> globalProgressBox;
  final Box<MonthlyProgress> monthlyProgressBox;
  final GlobalProgress globalProgress;
}

class AchievementEngineDataService {
  const AchievementEngineDataService._();

  static AchievementAppStartedData loadAppStartedData() {
    final now = DateTime.now();
    final currentMonthId = DateFormat('yyyy-MM').format(now);
    final allEncounters = Hive.box<Encounter>('encounters').values.toList();
    final monthlyEncounters = allEncounters
        .where((encounter) => DateFormat('yyyy-MM').format(encounter.date) == currentMonthId)
        .toList();
    return AchievementAppStartedData(
      allEncounters: allEncounters,
      monthlyEncounters: monthlyEncounters,
      now: now,
    );
  }

  static AchievementRebuildData loadRebuildData() {
    final allEncounters = Hive.box<Encounter>('encounters').values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final allHealthLogs = Hive.box<HealthLog>('health_logs').values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');
    final globalProgress = globalProgressBox.isNotEmpty
        ? globalProgressBox.getAt(0)!
        : GlobalProgress();
    return AchievementRebuildData(
      allEncounters: allEncounters,
      allHealthLogs: allHealthLogs,
      globalProgressBox: globalProgressBox,
      monthlyProgressBox: monthlyProgressBox,
      globalProgress: globalProgress,
    );
  }
}
