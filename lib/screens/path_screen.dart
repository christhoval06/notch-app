import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/monthly_progress.dart';
import '../utils/gamification_engine.dart';

class PathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<MonthlyProgress>(
        'monthly_progress',
      ).listenable(),
      builder: (context, Box<MonthlyProgress> box, _) {
        return FutureBuilder<MonthlyProgress>(
          future: GamificationEngine.getCurrentMonthlyProgress(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || box.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final progress = snapshot.data!;
            final currentXp = progress.xp;
            final levels = GamificationEngine.levels;

            // Encontrar el índice del nivel actual del usuario
            int currentLevelIndex = 0;
            for (int i = levels.length - 1; i >= 0; i--) {
              if (currentXp >= (levels[i]['xp'] as int)) {
                currentLevelIndex = i;
                break;
              }
            }

            final double totalProgress = currentXp / (levels.last['xp'] as int);

            return Scaffold(
              backgroundColor: const Color(0xFF121212),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Camino de Maestría ✨",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: Stack(
                children: [
                  // 1. El pintor que dibuja la línea de conexión vertical
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _PathPainter(
                        progress: totalProgress.clamp(0.0, 1.0),
                      ),
                    ),
                  ),

                  // 2. La lista de niveles (nodos) que se puede scrollear
                  ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      final level = levels[index];
                      final isUnlocked = currentXp >= (level['xp'] as int);
                      final isCurrent = index == currentLevelIndex;

                      return _buildNodeRow(
                        index: index,
                        levelName: level['name'],
                        xpRequired: level['xp'],
                        isUnlocked: isUnlocked,
                        isCurrent: isCurrent,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- WIDGETS AUXILIARES ---

  // Construye la fila para cada nodo, alternando la alineación
  Widget _buildNodeRow({
    required int index,
    required String levelName,
    required int xpRequired,
    required bool isUnlocked,
    required bool isCurrent,
  }) {
    final bool isLeftAligned =
        (GamificationEngine.levels.length - 1 - index) % 2 != 0;
    // final bool isLeftAligned = index % 2 == 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: isLeftAligned
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          // Espaciador para alinear a la derecha
          if (!isLeftAligned) const Spacer(),

          // El Nodo (la "burbuja" del nivel)
          _PathNode(
            levelName: levelName,
            xpRequired: xpRequired,
            isUnlocked: isUnlocked,
            isCurrent: isCurrent,
            icon: isUnlocked ? Icons.check : Icons.lock_outline,
          ),

          // Espaciador para alinear a la izquierda
          if (isLeftAligned) const Spacer(),
        ],
      ),
    );
  }
}

// --- WIDGET PARA EL NODO INDIVIDUAL ---
class _PathNode extends StatefulWidget {
  final String levelName;
  final int xpRequired;
  final bool isUnlocked;
  final bool isCurrent;
  final IconData icon;

  const _PathNode({
    Key? key,
    required this.levelName,
    required this.xpRequired,
    required this.isUnlocked,
    required this.isCurrent,
    required this.icon,
  }) : super(key: key);

  @override
  _PathNodeState createState() => _PathNodeState();
}

class _PathNodeState extends State<_PathNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Si este es el nodo actual (el siguiente objetivo), iniciamos la animación en bucle
    if (widget.isCurrent) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = widget.isCurrent
        ? Colors.amberAccent
        : Colors.blueAccent;
    final Color nodeColor = widget.isUnlocked ? activeColor : Colors.grey[800]!;
    return GestureDetector(
      onTap: () {
        if (widget.isUnlocked) {
          HapticFeedback.mediumImpact();
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.grey[900],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (ctx) {
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icono del nivel
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: nodeColor.withOpacity(0.1),
                        border: Border.all(color: nodeColor, width: 2),
                      ),
                      child: Icon(widget.icon, color: nodeColor, size: 30),
                    ),
                    const SizedBox(height: 15),
                    // Nombre del nivel
                    Text(
                      widget.levelName,
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // XP requerido
                    Text(
                      "Desbloqueado a los ${widget.xpRequired} XP",
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                    const SizedBox(height: 15),
                    // Descripción
                    Text(
                      GamificationEngine.levels.firstWhere(
                        (level) => level['name'] == widget.levelName,
                      )['desc'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[300], height: 1.5),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Column(
        children: [
          // Usamos AnimatedBuilder para aplicar la animación de pulso
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: nodeColor.withOpacity(0.2),
                  border: Border.all(color: nodeColor, width: 2),
                  // El 'boxShadow' ahora se anima para crear el efecto de pulso
                  boxShadow: widget.isCurrent
                      ? [
                          BoxShadow(
                            color: nodeColor.withOpacity(
                              0.5 + (_animation.value * 0.3),
                            ),
                            blurRadius: 15 + (_animation.value * 10),
                            spreadRadius: 2,
                          ),
                        ]
                      : (widget.isUnlocked
                            ? [
                                BoxShadow(
                                  color: nodeColor.withOpacity(0.5),
                                  blurRadius: 15,
                                ),
                              ]
                            : null),
                ),
                child: Icon(widget.icon, color: nodeColor, size: 30),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            widget.levelName,
            style: GoogleFonts.lato(
              color: widget.isUnlocked ? Colors.white : Colors.grey[600],
              fontWeight: widget.isCurrent
                  ? FontWeight.bold
                  : FontWeight.normal,
              shadows: widget.isCurrent
                  ? [Shadow(color: nodeColor.withOpacity(0.5), blurRadius: 10)]
                  : null,
            ),
          ),
          Text(
            "${widget.xpRequired} XP",
            style: GoogleFonts.lato(
              color: widget.isUnlocked
                  ? nodeColor.withOpacity(0.8)
                  : Colors.grey[700],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// --- PINTOR PARA LA LÍNEA DEL CAMINO ---
class _PathPainter extends CustomPainter {
  final double progress;

  _PathPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.grey[850]!
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final foregroundPaint = Paint()
      ..shader = LinearGradient(
        // <-- Usamos un gradiente para un efecto "energético"
        colors: [Colors.blueAccent, Colors.purpleAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, 0, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    // Dibuja una línea vertical simple en el centro
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);

    canvas.drawPath(path, backgroundPaint);

    final progressPath = Path();
    progressPath.moveTo(size.width / 2, size.height);
    progressPath.lineTo(size.width / 2, size.height * (1.0 - progress));

    canvas.drawPath(progressPath, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant _PathPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
