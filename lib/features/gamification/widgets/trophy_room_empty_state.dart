import 'package:flutter/material.dart';

class TrophyRoomEmptyState extends StatelessWidget {
  const TrophyRoomEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'Registra una actividad para empezar la temporada.',
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}
