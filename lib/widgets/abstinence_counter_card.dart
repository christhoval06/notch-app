import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

import '../models/encounter.dart';

class AbstinenceCounterCard extends StatefulWidget {
  const AbstinenceCounterCard({super.key});

  @override
  State<AbstinenceCounterCard> createState() => _AbstinenceCounterCardState();
}

class _AbstinenceCounterCardState extends State<AbstinenceCounterCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final box = Hive.box<Encounter>('encounters');

    return ValueListenableBuilder<Box<Encounter>>(
      valueListenable: box.listenable(),
      builder: (context, encounterBox, _) {
        final encounters = encounterBox.values.toList()
          ..sort((a, b) => b.date.compareTo(a.date));

        if (encounters.isEmpty) {
          return _CardShell(
            title: l10n.homeAbstinenceTitle,
            subtitle: l10n.homeAbstinenceNoDataSubtitle,
            value: l10n.homeAbstinenceNoDataValue,
            icon: Icons.hourglass_empty_rounded,
          );
        }

        final lastEncounterDate = encounters.first.date;
        final now = DateTime.now();
        final diff = now.difference(lastEncounterDate);

        final days = diff.inDays;
        final hours = diff.inHours.remainder(24);
        final minutes = diff.inMinutes.remainder(60);

        return _CardShell(
          title: l10n.homeAbstinenceTitle,
          subtitle: l10n.homeAbstinenceSubtitle,
          value: l10n.homeAbstinenceDuration(
            days.toString(),
            hours.toString(),
            minutes.toString(),
          ),
          icon: Icons.self_improvement_rounded,
        );
      },
    );
  }
}

class _CardShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final IconData icon;

  const _CardShell({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F2431), Color(0xFF141A24)],
        ),
        border: Border.all(color: const Color(0xFF2A3342)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.lightBlueAccent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
