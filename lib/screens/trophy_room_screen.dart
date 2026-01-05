import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_progress.dart';
import '../utils/gamification_engine.dart';

class TrophyRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final progressBox = Hive.box<UserProgress>('user_progress');

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: ValueListenableBuilder(
        valueListenable: progressBox.listenable(),
        builder: (context, Box<UserProgress> box, _) {
          final progress = box.isNotEmpty ? box.getAt(0)! : UserProgress();
          final levelData = GamificationEngine.getCurrentLevel(
            progress.currentXp,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 1. SECCIÓN DE NIVEL
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.shade700,
                        Colors.purpleAccent.shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "NIVEL ACTUAL",
                        style: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 2,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        levelData['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${levelData['current_total_xp']} XP",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      // Barra de progreso
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: levelData['progress'],
                          minHeight: 10,
                          backgroundColor: Colors.black26,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "INSIGNIAS / BADGES",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 2. GRID DE TROFEOS
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: GamificationEngine.badges.length,
                  itemBuilder: (context, index) {
                    String key = GamificationEngine.badges.keys.elementAt(
                      index,
                    );
                    Map<String, String> badgeData =
                        GamificationEngine.badges[key]!;
                    bool unlocked = progress.unlockedBadges.contains(key);

                    return Container(
                      decoration: BoxDecoration(
                        color: unlocked
                            ? Colors.grey[900]
                            : Colors.grey[900]!.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: unlocked
                              ? Colors.amberAccent
                              : Colors.grey[800]!,
                          width: unlocked ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            badgeData['icon']!,
                            style: TextStyle(
                              fontSize: 40,
                              color: unlocked
                                  ? null
                                  : Colors.grey.withOpacity(0.2),
                            ),
                            // El filtro de color gris es un truco visual para lo "bloqueado"
                          ),
                          const SizedBox(height: 10),
                          Text(
                            badgeData['name']!,
                            style: TextStyle(
                              color: unlocked ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!unlocked)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(
                                Icons.lock,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
