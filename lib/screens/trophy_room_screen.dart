import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/models/encounter.dart';
import 'package:notch_app/screens/share_preview_screen.dart';
import '../models/monthly_progress.dart';
import '../utils/gamification_engine.dart';

class TrophyRoomScreen extends StatefulWidget {
  @override
  _TrophyRoomScreenState createState() => _TrophyRoomScreenState();
}

class _TrophyRoomScreenState extends State<TrophyRoomScreen> {
  String? _selectedMonthId;
  bool _isSharing = false;

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
    return ValueListenableBuilder(
      valueListenable: Hive.box<MonthlyProgress>(
        'monthly_progress',
      ).listenable(),
      builder: (context, Box<MonthlyProgress> box, _) {
        // Antes de construir la UI, llamamos a la lógica para asegurarnos de que el mes actual exista
        return FutureBuilder<MonthlyProgress>(
          future: GamificationEngine.getCurrentMonthlyProgress(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || box.isEmpty) {
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
            final monthIds = box.values.map((p) => p.monthId).toList();
            monthIds.sort((a, b) => b.compareTo(a)); // Más reciente primero
            _selectedMonthId ??=
                monthIds.first; // Seleccionar el actual por defecto

            final progress = box.values.firstWhere(
              (p) => p.monthId == _selectedMonthId,
            );
            final isCurrentMonth =
                _selectedMonthId ==
                DateFormat('yyyy-MM').format(DateTime.now());

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
    // Si no hay trofeos, muestra un mensaje
    if (GamificationEngine.badges.isEmpty) {
      return const Center(
        child: Text(
          "No hay insignias disponibles.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 por fila para que quepan más
        childAspectRatio: 0.9,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: GamificationEngine.badges.length,
      itemBuilder: (context, index) {
        String key = GamificationEngine.badges.keys.elementAt(index);
        Map<String, String> badgeData = GamificationEngine.badges[key]!;
        bool unlocked = progress.unlockedBadges.contains(key);

        return Tooltip(
          // Añadimos un tooltip para ver la descripción
          message: unlocked ? badgeData['desc']! : "Bloqueado",
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
                  Text(
                    badgeData['icon']!,
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    badgeData['name']!,
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
}
