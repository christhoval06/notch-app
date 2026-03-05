import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/presentation/pages/challenges_page.dart';
import 'package:notch_app/features/feature/path/presentation/pages/path_page.dart';
import 'package:notch_app/features/feature/gamification/presentation/pages/share_preview_page.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_service.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/core/utils/level_localization.dart';

class TrophyRoomScreen extends StatefulWidget {
  @override
  _TrophyRoomScreenState createState() => _TrophyRoomScreenState();
}

class _TrophyRoomScreenState extends State<TrophyRoomScreen> {
  String? _selectedMonthId;
  bool _isSharing = false;

  late final ValueNotifier<int> _updateNotifier;
  late final Listenable _combinedListenable;

  @override
  void initState() {
    super.initState();
    // 1. Combinamos los "oyentes" de ambas cajas
    _combinedListenable = Listenable.merge([
      Hive.box<MonthlyProgress>('monthly_progress').listenable(),
      Hive.box<Encounter>('encounters').listenable(),
    ]);

    // 2. Creamos un ValueNotifier que se actualizará
    _updateNotifier = ValueNotifier(0);

    // 3. Cada vez que cualquiera de las cajas cambie, actualizamos el notifier
    _combinedListenable.addListener(_onDataChanged);
  }

  void _onDataChanged() {
    // Simplemente cambiamos el valor para que el ValueListenableBuilder se dispare
    _updateNotifier.value++;
  }

  @override
  void dispose() {
    // Limpiamos todo para evitar fugas de memoria
    _combinedListenable.removeListener(_onDataChanged);
    _updateNotifier.dispose();
    super.dispose();
  }

  Future<void> _shareRank() async {
    setState(() => _isSharing = true);
    // await _shareService.captureAndShareWidget(
    //   context,
    //   widgetKey: _shareCardKey,
    //   text: "¡He alcanzado un nuevo nivel en la app NOTCH! 🏆 #NOTCHapp",
    // );
    setState(() => _isSharing = false);
  }

  void _navigateToSharePreview(MonthlyProgress progress) {
    // Calculamos los datos adicionales que necesitamos
    final encounterBox = Hive.box<Encounter>('encounters');
    final currentMonth = DateFormat('yyyy-MM').parse(progress.monthId);

    final totalEncountersThisMonth = encounterBox.values
        .where(
          (e) =>
              e.date.year == currentMonth.year &&
              e.date.month == currentMonth.month,
        )
        .length;

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
          totalEncountersThisMonth: totalEncountersThisMonth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Escuchamos la caja para que la UI se actualice automáticamente
    return ValueListenableBuilder<int>(
      valueListenable: _updateNotifier,
      builder: (context, _, __) {
        final progressBox = Hive.box<MonthlyProgress>('monthly_progress');
        final encounterBox = Hive.box<Encounter>('encounters');

        return FutureBuilder<MonthlyProgress>(
          future: GamificationEngine.getCurrentMonthlyProgress(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || progressBox.isEmpty) {
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Registra una actividad para empezar la temporada.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              );
            }

            // Lista de meses disponibles para el historial
            final monthIds = progressBox.values.map((p) => p.monthId).toList();
            monthIds.sort((a, b) => b.compareTo(a));
            _selectedMonthId ??= monthIds.first;

            final progress = progressBox.values.firstWhere(
              (p) => p.monthId == _selectedMonthId,
            );
            final isCurrentMonth =
                _selectedMonthId ==
                DateFormat('yyyy-MM').format(DateTime.now());

            final streaksOfSelectedMonth = GamificationEngine.calculateStreaks(
              encounterBox,
              monthId: _selectedMonthId,
            );
            final allTimeStreaks = GamificationEngine.calculateStreaks(
              encounterBox,
            );

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSeasonSelector(monthIds),
                    const SizedBox(height: 25),

                    GestureDetector(
                      onTap: () {
                        if (!isCurrentMonth) {
                          return;
                        }

                        HapticFeedback.lightImpact();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PathScreen()),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: _buildLevelPanel(progress, isCurrentMonth),
                    ),

                    const SizedBox(height: 30),

                    // --- NUEVA SECCIÓN DE RACHAS ---
                    _buildStreaksSection(
                      isCurrentMonth: isCurrentMonth,
                      currentStreak: allTimeStreaks['current']!,
                      seasonBestStreak:
                          progress.longestStreakOfMonth ??
                          streaksOfSelectedMonth['longest']!,
                      allTimeBestStreak: allTimeStreaks['longest']!,
                    ),
                    const SizedBox(height: 25),

                    _buildFeaturedChallengeCard(context),
                    const SizedBox(height: 25),

                    // 3. SECCIÓN DE INSIGNIAS
                    Text(
                      AppLocalizations.of(context).trophyUnlockedBadges,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Builder(
                      builder: (context) {
                        final allCount =
                            AchievementEngine.getAllAchievements().length;
                        final unlockedCount = progress.unlockedBadges.length;
                        return Text(
                          '$unlockedCount / $allCount',
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),

                    // 4. GRID DE TROFEOS
                    _buildBadgesGrid(progress),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildSeasonSelector(List<String> monthIds) {
    final l10n = AppLocalizations.of(context);
    final localeCode = Localizations.localeOf(context).toString();
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedMonthId,
          isExpanded: true,
          dropdownColor: scheme.surfaceContainerHighest,
          icon: Icon(Icons.arrow_drop_down, color: scheme.primary),
          style: TextStyle(color: scheme.onSurface, fontSize: 16),
          items: monthIds.map((id) {
            final date = DateFormat('yyyy-MM').parse(id);
            final formatted = DateFormat('MMMM yyyy', localeCode).format(date);
            final isCurrent =
                id == DateFormat('yyyy-MM').format(DateTime.now());
            return DropdownMenuItem(
              value: id,
              child: Text(
                "${l10n.trophySeasonLabel}: $formatted ${isCurrent ? '(${l10n.trophyCurrentShort})' : ''}",
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedMonthId = value);
          },
        ),
      ),
    );
  }

  Widget _buildLevelPanel(MonthlyProgress progress, bool isCurrentMonth) {
    final levelData = GamificationEngine.getCurrentLevel(progress.xp);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.levelGradientBlue, AppColors.levelGradientMagenta],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.levelGradientMagenta.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isCurrentMonth
                    ? AppLocalizations.of(context).trophyCurrentLevel
                    : AppLocalizations.of(context).trophyFinalRank,
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 2, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Text(
                localizeLevelName(
                  AppLocalizations.of(context),
                  (isCurrentMonth
                          ? levelData['name']
                          : (progress.finalRank ?? levelData['name']))
                      as String,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: scheme.scrim, blurRadius: 5)],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${progress.xp} XP",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Solo mostramos la barra de progreso si es la temporada actual
              if (isCurrentMonth)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: levelData['progress'],
                        minHeight: 12,
                        backgroundColor: scheme.scrim.withValues(alpha: 0.38),
                        color: scheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(
                        context,
                      ).trophyNextLevelInXp(levelData['next_xp'].toString()),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
            ],
          ),
          // Positioned(
          //   top: -15,
          //   right: -15,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black26,
          //           blurRadius: 10,
          //           spreadRadius: 2,
          //         ),
          //       ],
          //     ),
          //     child: _isSharing
          //         ? const Padding(
          //             padding: EdgeInsets.all(12),
          //             child: SizedBox(
          //               width: 24,
          //               height: 24,
          //               child: CircularProgressIndicator(strokeWidth: 2),
          //             ),
          //           )
          //         : IconButton(
          //             icon: const Icon(Icons.share, color: Colors.blueAccent),
          //             onPressed: _shareRank,
          //           ),
          //   ),
          // ),
          if (isCurrentMonth)
            Positioned(
              top: -15,
              right: -15,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.surface,
                  boxShadow: [BoxShadow(color: scheme.scrim, blurRadius: 10)],
                ),
                child: IconButton(
                  icon: Icon(Icons.share, color: scheme.primary),
                  onPressed: () => _navigateToSharePreview(progress),
                ),
              ),
            ),
          // Positioned(
          //   bottom: 10,
          //   right: 15,
          //   child: Row(
          //     children: [
          //       Text(
          //         "Ver Camino",
          //         style: TextStyle(
          //           color: Colors.white.withOpacity(0.6),
          //           fontSize: 10,
          //         ),
          //       ),
          //       const SizedBox(width: 4),
          //       Icon(
          //         Icons.arrow_forward_ios,
          //         color: Colors.white.withOpacity(0.6),
          //         size: 10,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBadgesGrid(MonthlyProgress progress) {
    final scheme = Theme.of(context).colorScheme;
    final allAchievements = AchievementEngine.getAllAchievements();
    final currentMonthId = DateFormat('yyyy-MM').format(DateTime.now());
    final monthlyEntries = Hive.box<MonthlyProgress>('monthly_progress').values;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 por fila para que quepan más
        childAspectRatio: 0.9,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: allAchievements.length,
      itemBuilder: (context, index) {
        final l10n = AppLocalizations.of(context);
        final achievement = allAchievements[index];
        bool unlocked = progress.unlockedBadges.contains(achievement.id);
        final localizedName = localizeAchievementName(
          l10n,
          achievement.id,
          achievement.name,
        );
        final localizedDescription = localizeAchievementDescription(
          l10n,
          achievement.id,
          achievement.description,
        );
        final unlockedSeasonMonthIds = monthlyEntries
            .where((p) => p.unlockedBadges.contains(achievement.id))
            .map((p) => p.monthId)
            .toList()
          ..sort((a, b) {
            if (a == currentMonthId && b != currentMonthId) return -1;
            if (b == currentMonthId && a != currentMonthId) return 1;
            return b.compareTo(a);
          });

        return Tooltip(
          message: localizedDescription,
          child: GestureDetector(
            onTap: () => _showBadgeInfoSheet(
              name: localizedName,
              description: localizedDescription,
              icon: achievement.icon,
              seasonMonthIds: unlockedSeasonMonthIds,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: unlocked
                    ? scheme.surface
                    : scheme.scrim.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: unlocked ? scheme.tertiary : scheme.outlineVariant,
                  width: unlocked ? 2 : 1,
                ),
              ),
              child: Opacity(
                opacity: unlocked ? 1.0 : 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(achievement.icon, style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    Text(
                      localizedName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: unlocked
                            ? scheme.onSurface
                            : scheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    if (!unlocked)
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.lock,
                          size: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showBadgeInfoSheet({
    required String name,
    required String description,
    required String icon,
    required List<String> seasonMonthIds,
  }) async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final localeCode = Localizations.localeOf(context).toString();
    final currentMonthId = DateFormat('yyyy-MM').format(DateTime.now());
    bool showAllSeasons = false;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          final seasonLabels = seasonMonthIds.map((monthId) {
            final date = DateFormat('yyyy-MM').parse(monthId);
            final formatted = DateFormat('MMMM yyyy', localeCode).format(date);
            if (monthId == currentMonthId) {
              return '$formatted (${l10n.trophyCurrentShort})';
            }
            return formatted;
          }).toList();
          final visibleSeasons = showAllSeasons
              ? seasonLabels
              : seasonLabels.take(6).toList();
          final hasOverflow = seasonLabels.length > 6;

          return SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(icon, style: const TextStyle(fontSize: 42)),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.trophyBadgeUnlockedInSeasons(
                      seasonMonthIds.length.toString(),
                    ),
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (seasonLabels.isEmpty)
                    Text(
                      l10n.trophyBadgeNotUnlockedHistory,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    )
                  else
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: visibleSeasons.map((season) {
                        return Chip(label: Text(season));
                      }).toList(),
                    ),
                  if (hasOverflow)
                    TextButton(
                      onPressed: () {
                        setModalState(() => showAllSeasons = !showAllSeasons);
                      },
                      child: Text(
                        showAllSeasons
                            ? l10n.trophyShowLess
                            : l10n.trophyShowMore,
                      ),
                    ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
        },
      ),
    );
  }

  Widget _buildStreaksSection({
    required bool isCurrentMonth,
    required int currentStreak,
    required int seasonBestStreak,
    required int allTimeBestStreak,
  }) {
    final scheme = Theme.of(context).colorScheme;
    // Obtenemos el próximo hito desde el motor
    final nextMilestoneData = GamificationEngine.getNextStreakMilestone(
      currentStreak,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface, // Negro suave
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // 1. Racha Actual (Parte Superior)
          _buildCurrentStreakDisplay(currentStreak),
          const SizedBox(height: 24),

          // 2. Récords (Parte Media)
          Row(
            children: [
              // Récord del Mes
              Expanded(
                child: _buildRecordCard(
                  title: AppLocalizations.of(context).trophyMonthRecord,
                  icon: Icons.military_tech,
                  days: seasonBestStreak,
                  color: scheme.primary, // Azul
                  currentStreak: currentStreak,
                  recordToBeat: allTimeBestStreak,
                ),
              ),
              const SizedBox(width: 16),
              // Récord Histórico
              Expanded(
                child: _buildRecordCard(
                  title: AppLocalizations.of(context).trophyHistorical,
                  icon: Icons.star,
                  days: allTimeBestStreak,
                  color: scheme.tertiary, // Amarillo/Dorado
                  currentStreak: currentStreak,
                  recordToBeat: allTimeBestStreak,
                  isAllTime: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 3. Próximo Hito (Parte Inferior)
          _buildMilestoneProgress(currentStreak, nextMilestoneData),
        ],
      ),
    );
  }

  Widget _buildCurrentStreakDisplay(int currentStreak) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.tertiary.withValues(alpha: 0.15),
            boxShadow: [
              BoxShadow(
                color: scheme.tertiary.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.local_fire_department_rounded,
            color: scheme.tertiary,
            size: 36,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              currentStreak.toString(),
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: scheme.onSurface,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context).trophyDays,
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.onSurfaceVariant,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Text(
          AppLocalizations.of(context).trophyCurrentStreak,
          style: TextStyle(
            fontFamily: 'Lato',
            color: scheme.tertiary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildRecordCard({
    required String title,
    required IconData icon,
    required int days,
    required Color color,
    required int currentStreak,
    required int recordToBeat,
    bool isAllTime = false,
  }) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    String bottomText;
    double progress = 0.0;

    if (isAllTime) {
      if (currentStreak >= recordToBeat && recordToBeat > 0) {
        bottomText = l10n.trophyRecordReached;
        progress = 1.0;
      } else if (recordToBeat > 0) {
        bottomText = l10n.trophyBeatingRecord;
        progress = currentStreak / recordToBeat;
      } else {
        bottomText = l10n.trophyNoRecord;
      }
    } else {
      if (days > 0) {
        progress = days / recordToBeat;
        bottomText = l10n.trophyPercentOfHistorical(
          (progress * 100).toStringAsFixed(0),
        );
      } else {
        bottomText = l10n.trophyNoStreakThisMonth;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.scrim.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                days.toString(),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                l10n.trophyDays,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: scheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: color, size: 12),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: scheme.onSurface,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: scheme.surfaceContainerHighest,
              color: color,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (isAllTime && progress == 1.0)
                Icon(Icons.check_circle, color: color, size: 12),
              const SizedBox(width: 4),
              Text(
                bottomText,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: scheme.onSurfaceVariant,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneProgress(
    int currentStreak,
    Map<String, int> milestoneData,
  ) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final int milestone = milestoneData['milestone']!;
    final int remaining = milestoneData['remaining']!;
    final double progress = (milestone > 0) ? (currentStreak / milestone) : 1.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.trophyNextMilestoneDays(milestone.toString()),
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.onSurface,
                fontSize: 12,
              ),
            ),
            Text(
              remaining > 0
                  ? l10n.trophyDaysRemaining(remaining.toString())
                  : l10n.trophyMilestoneReached,
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.tertiary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: scheme.surfaceContainerHighest,
            color: scheme.tertiary,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedChallengeCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final featuredChallenge = ChallengeService.getFeaturedChallenge();
    final allEncounters = Hive.box<Encounter>('encounters').values.toList();

    return GestureDetector(
      onTap: () {
        // La acción de navegar es la misma en ambos casos
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChallengesScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: scheme.secondary.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CABECERA ---
            Row(
              children: [
                Icon(Icons.track_changes, color: scheme.secondary),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context).trophyActiveChallenges,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: scheme.secondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: scheme.onSurfaceVariant,
                  size: 14,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // --- LÓGICA CONDICIONAL ---
            if (featuredChallenge != null)
              // ESTADO 1: Hay un reto para mostrar
              _buildActiveChallengeContent(featuredChallenge, allEncounters)
            else
              // ESTADO 2: No hay retos o todos están completos
              _buildEmptyChallengeContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveChallengeContent(
    Challenge challenge,
    List<Encounter> allEncounters,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final progress = challenge.getProgress(allEncounters);
    final progressPercent = challenge.getProgressPercent(allEncounters);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _challengeTitle(AppLocalizations.of(context), challenge.id),
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressPercent,
                  minHeight: 8,
                  backgroundColor: scheme.scrim.withValues(alpha: 0.26),
                  color: scheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "${progress.toInt()} / ${challenge.goal}",
              style: TextStyle(
                color: scheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyChallengeContent() {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).trophyExploreGoals,
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppLocalizations.of(context).trophyExploreGoalsSubtitle,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
        ),
      ],
    );
  }

  String _challengeTitle(AppLocalizations l10n, String id) {
    switch (id) {
      case 'morning_master':
        return l10n.challengeMorningMasterTitle;
      case 'weekly_explorer':
        return l10n.challengeWeeklyExplorerTitle;
      case 'abstinence_21':
        return l10n.challengeAbstinence21Title;
      case 'abstinence_30':
        return l10n.challengeAbstinence30Title;
      case 'quality_week':
        return l10n.challengeQualityWeekTitle;
      case 'safety_champion':
        return l10n.challengeSafetyChampionTitle;
      case 'prelude_master':
        return l10n.challengePreludeMasterTitle;
      case 'steel_consistency':
        return l10n.challengeSteelConsistencyTitle;
      case 'quality_club':
        return l10n.challengeQualityClubTitle;
      case 'guardian_of_safety':
        return l10n.challengeGuardianOfSafetyTitle;
      case 'perfect_weekend':
        return l10n.challengePerfectWeekendTitle;
      case 'epic_morning':
        return l10n.challengeEpicMorningTitle;
      case 'frequent_flyer':
        return l10n.challengeFrequentFlyerTitle;
      case 'star_collector':
        return l10n.challengeStarCollectorTitle;
      case 'centurion':
        return l10n.challengeCenturionTitle;
      case 'legendary_guardian':
        return l10n.challengeLegendaryGuardianTitle;
      case 'polymath':
        return l10n.challengePolymathTitle;
      default:
        return id;
    }
  }
}
