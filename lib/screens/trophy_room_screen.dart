import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/models/encounter.dart';
import 'package:notch_app/screens/share_preview_screen.dart';
import 'package:notch_app/services/achievement_engine.dart';
import '../models/monthly_progress.dart';
import '../utils/gamification_engine.dart';

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
          rankName: levelData['name'],
          currentXp: progress.xp,
          progressToNextLevel: levelData['progress'],
          totalEncountersThisMonth: totalEncountersThisMonth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: const Color(0xFF121212),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Registra una actividad para empezar la temporada.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
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
              backgroundColor: const Color(0xFF121212),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. SELECTOR DE TEMPORADA
                    _buildSeasonSelector(monthIds),
                    const SizedBox(height: 25),

                    // 2. PANEL DE NIVEL
                    _buildLevelPanel(progress, isCurrentMonth),
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

                    // 3. SECCIÓN DE INSIGNIAS
                    const Text(
                      "INSIGNIAS DESBLOQUEADAS",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedMonthId,
          isExpanded: true,
          dropdownColor: Colors.grey[800],
          icon: Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: monthIds.map((id) {
            final date = DateFormat('yyyy-MM').parse(id);
            final formatted = DateFormat('MMMM yyyy').format(date);
            final isCurrent =
                id == DateFormat('yyyy-MM').format(DateTime.now());
            return DropdownMenuItem(
              value: id,
              child: Text(
                "Temporada: $formatted ${isCurrent ? '(Actual)' : ''}",
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

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent.shade700, Colors.purpleAccent.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Text(
                isCurrentMonth ? "NIVEL ACTUAL" : "RANGO FINAL",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                // Si es un mes pasado y tiene rango final, lo mostramos. Si no, calculamos el nivel.
                isCurrentMonth
                    ? levelData['name']
                    : (progress.finalRank ?? levelData['name']),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 5)],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${progress.xp} XP",
                style: const TextStyle(color: Colors.white, fontSize: 16),
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
                        backgroundColor: Colors.black38,
                        color: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Siguiente nivel en ${levelData['next_xp']} XP",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 10,
                      ),
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
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.blueAccent),
                  onPressed: () => _navigateToSharePreview(progress),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBadgesGrid(MonthlyProgress progress) {
    final allAchievements = AchievementEngine.getAllAchievements();

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
        final achievement = allAchievements[index];
        bool unlocked = progress.unlockedBadges.contains(achievement.id);

        return Tooltip(
          message: unlocked ? achievement.description : "Bloqueado",
          child: Container(
            decoration: BoxDecoration(
              color: unlocked
                  ? Colors.grey[900]
                  : Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: unlocked ? Colors.amberAccent : Colors.grey[800]!,
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
                    achievement.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: unlocked ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  if (!unlocked)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(Icons.lock, size: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStreaksSection({
    required bool isCurrentMonth,
    required int currentStreak,
    required int seasonBestStreak,
    required int allTimeBestStreak,
  }) {
    // Obtenemos el próximo hito desde el motor
    final nextMilestoneData = GamificationEngine.getNextStreakMilestone(
      currentStreak,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Negro suave
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
                  title: "RÉCORD MES",
                  icon: Icons.military_tech,
                  days: seasonBestStreak,
                  color: const Color(0xFF448AFF), // Azul
                  currentStreak: currentStreak,
                  recordToBeat: allTimeBestStreak,
                ),
              ),
              const SizedBox(width: 16),
              // Récord Histórico
              Expanded(
                child: _buildRecordCard(
                  title: "HISTÓRICO",
                  icon: Icons.star,
                  days: allTimeBestStreak,
                  color: const Color(0xFFFFC107), // Amarillo/Dorado
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFF9800).withOpacity(0.15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF9800).withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFFF9800),
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
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "días",
              style: GoogleFonts.lato(color: Colors.grey[400], fontSize: 20),
            ),
          ],
        ),
        Text(
          "RACHA ACTUAL",
          style: GoogleFonts.lato(
            color: const Color(0xFFFFC107),
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
    String bottomText;
    double progress = 0.0;

    if (isAllTime) {
      if (currentStreak >= recordToBeat && recordToBeat > 0) {
        bottomText = "Récord alcanzado";
        progress = 1.0;
      } else if (recordToBeat > 0) {
        bottomText = "Superando récord";
        progress = currentStreak / recordToBeat;
      } else {
        bottomText = "Sin récord";
      }
    } else {
      if (days > 0) {
        progress = days / recordToBeat;
        bottomText = "${(progress * 100).toStringAsFixed(0)}% del histórico";
      } else {
        bottomText = "Sin racha este mes";
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                days.toString(),
                style: GoogleFonts.montserrat(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "días",
                style: GoogleFonts.lato(color: Colors.grey[500], fontSize: 14),
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
                style: GoogleFonts.lato(
                  color: Colors.white,
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
              backgroundColor: Colors.grey[800],
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
                style: GoogleFonts.lato(color: Colors.grey[500], fontSize: 10),
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
    final int milestone = milestoneData['milestone']!;
    final int remaining = milestoneData['remaining']!;
    final double progress = (milestone > 0) ? (currentStreak / milestone) : 1.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Próximo hito: $milestone días",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 12),
            ),
            Text(
              remaining > 0 ? "$remaining días faltantes" : "¡Hito alcanzado!",
              style: GoogleFonts.lato(
                color: const Color(0xFFFF9800),
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
            backgroundColor: Colors.grey[800],
            color: const Color(0xFFFF9800),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
