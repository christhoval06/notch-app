import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/gamification/presentation/pages/share_preview_page.dart';
import 'package:notch_app/features/gamification/services/trophy_room_view_model_service.dart';
import 'package:notch_app/features/gamification/widgets/show_trophy_badge_info_sheet.dart';
import 'package:notch_app/features/gamification/widgets/trophy_room_content.dart';
import 'package:notch_app/features/gamification/widgets/trophy_room_empty_state.dart';
import 'package:notch_app/features/path/presentation/pages/path_page.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyRoomView extends StatefulWidget {
  const TrophyRoomView({super.key});

  @override
  State<TrophyRoomView> createState() => _TrophyRoomViewState();
}

class _TrophyRoomViewState extends State<TrophyRoomView> {
  String? _selectedMonthId;
  late final ValueNotifier<int> _updateNotifier;
  late final Listenable _combinedListenable;

  @override
  void initState() {
    super.initState();
    _combinedListenable = Listenable.merge([
      Hive.box<MonthlyProgress>('monthly_progress').listenable(),
      Hive.box<Encounter>('encounters').listenable(),
    ]);
    _updateNotifier = ValueNotifier(0);
    _combinedListenable.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _combinedListenable.removeListener(_onDataChanged);
    _updateNotifier.dispose();
    super.dispose();
  }

  void _onDataChanged() => _updateNotifier.value++;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _updateNotifier,
      builder: (context, _, _) {
        final progressBox = Hive.box<MonthlyProgress>('monthly_progress');
        if (progressBox.isEmpty) return const TrophyRoomEmptyState();
        final encounterBox = Hive.box<Encounter>('encounters');
        final globalBox = Hive.box<GlobalProgress>('global_progress');
        final globalProgress = globalBox.isNotEmpty
            ? globalBox.getAt(0)!
            : GlobalProgress();
        final model = TrophyRoomViewModelService.build(
          monthlyEntries: progressBox.values,
          allEncounters: encounterBox.values.toList(),
          globalProgress: globalProgress,
          selectedMonthId: _selectedMonthId,
        );
        _selectedMonthId = model.selectedMonthId;

        return TrophyRoomContent(
          monthIds: model.monthIds,
          selectedMonthId: model.selectedMonthId,
          onMonthChanged: (value) => setState(() => _selectedMonthId = value),
          onLevelTap: () {
            if (!model.isCurrentMonth) return;
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PathScreen()),
            );
          },
          progress: model.progress,
          globalProgress: model.globalProgress,
          monthlyEntries: progressBox.values,
          allEncounters: model.allEncounters,
          isCurrentMonth: model.isCurrentMonth,
          currentStreak: model.currentStreak,
          seasonBestStreak: model.seasonBestStreak,
          allTimeBestStreak: model.allTimeBestStreak,
          seasonalAbstinenceRecord: model.seasonalAbstinenceRecord,
          historicalAbstinenceRecord: model.historicalAbstinenceRecord,
          activityMetrics: model.activityMetrics,
          unlockedCount: model.unlockedCount,
          allCount: model.allCount,
          onBadgeTap:
              (id, name, description, icon, unlocked, seasonal, months) =>
                  showTrophyBadgeInfoSheet(
                    context,
                    id,
                    name,
                    description,
                    icon,
                    unlocked,
                    seasonal,
                    months,
                  ),
          onShareTap: () => _navigateToSharePreview(model.progress),
        );
      },
    );
  }

  void _navigateToSharePreview(MonthlyProgress progress) {
    final currentMonth = DateFormat('yyyy-MM').parse(progress.monthId);
    final totalEncounters = Hive.box<Encounter>('encounters').values.where((
      entry,
    ) {
      return entry.date.year == currentMonth.year &&
          entry.date.month == currentMonth.month;
    }).length;
    final levelData = GamificationEngine.getCurrentLevel(progress.xp);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SharePreviewScreen(
          rankName: localizeLevelName(
            AppLocalizations.of(context),
            levelData['name'] as String,
          ),
          currentXp: progress.xp,
          progressToNextLevel: levelData['progress'],
          totalEncountersThisMonth: totalEncounters,
        ),
      ),
    );
  }
}
