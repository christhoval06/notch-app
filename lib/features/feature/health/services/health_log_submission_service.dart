import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/repositories/health_log_repository.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/feature/health/services/notification_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HealthLogSubmissionResult {
  const HealthLogSubmissionResult({
    required this.savedMessage,
    this.unlockedMessage,
  });

  final String savedMessage;
  final String? unlockedMessage;
}

class HealthLogSubmissionService {
  const HealthLogSubmissionService._();

  static Future<HealthLogSubmissionResult> submit({
    required AppLocalizations l10n,
    required DateTime date,
    required String testType,
    required String result,
  }) async {
    final log = HealthLog(date: date, testType: testType, result: result);
    await HealthLogRepository.add(log);
    await NotificationService().scheduleCheckupReminder(months: 6);

    final unlocked = await AchievementEngine.processEvent(
      event: AchievementEvent.healthLogSaved,
      data: {'allHealthLogs': HealthLogRepository.getAll()},
    );

    final unlockedMessage = unlocked.isEmpty
        ? null
        : l10n.dataAchievementUnlocked(
            localizeAchievementName(
              l10n,
              unlocked.first.id,
              unlocked.first.name,
            ),
          );

    return HealthLogSubmissionResult(
      savedMessage: l10n.healthSavedReminder,
      unlockedMessage: unlockedMessage,
    );
  }
}
