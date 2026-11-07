import 'package:notch_app/features/watch_companion/services/watch_entry_options_service.dart';
import 'package:notch_app/core/constants/watch_protocol.dart';
import 'package:notch_app/core/utils/gamification_level_service.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/home/services/home_abstinence_view_model_service.dart';
import 'package:notch_app/features/watch_companion/services/watch_snapshot.dart';
import 'package:notch_app/l10n/app_localizations.dart';

abstract final class WatchSnapshotService {
  static WatchSnapshot build({
    required DateTime now,
    required List<Encounter> encounters,
    required List<MonthlyProgress> monthlyProgress,
    required AppLocalizations l10n,
    required String generation,
    required int revision,
    List<String>? partnerNames,
  }) {
    final monthId = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final current = encounters
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .toList();
    final progress = monthlyProgress
        .where((p) => p.monthId == monthId)
        .firstOrNull;
    final xp = progress?.xp ?? 0;
    final level = GamificationLevelService.getCurrentLevel(xp);
    final abstinence = HomeAbstinenceViewModelService.build(
      encounters: encounters,
      monthlyEntries: monthlyProgress,
      now: now,
    );
    final latest = encounters.isEmpty
        ? null
        : encounters.map((e) => e.date).reduce((a, b) => a.isAfter(b) ? a : b);
    return WatchSnapshot({
      'schemaVersion': WatchProtocol.version,
      'kind': 'snapshot',
      'state': 'active',
      ...WatchEntryOptionsService.build(
        partnerNames ?? WatchEntryOptionsService.partnerNames(encounters, []),
        l10n,
      ),
      'generation': generation,
      'revision': revision,
      'generatedAtMs': now.millisecondsSinceEpoch,
      'locale': l10n.localeName,
      'monthId': monthId,
      'zeroState': abstinence.showZeroState,
      if (!abstinence.showZeroState && latest != null)
        'abstinenceReferenceMs': latest.millisecondsSinceEpoch,
      'levelName': localizeLevelName(l10n, level['name'] as String),
      'xp': xp,
      'progress': level['progress'] ?? 0.0,
      'nextXp': level['next_xp'] ?? 100,
      'entryCount': current.length,
      if (current.isNotEmpty) ...{
        'averageRating':
            current.fold(0, (sum, e) => sum + e.rating) / current.length,
        'protectionRate':
            current.where((e) => e.protected).length / current.length,
      },
    });
  }
}
