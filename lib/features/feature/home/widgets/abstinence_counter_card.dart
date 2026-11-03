import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/home/services/home_abstinence_view_model_service.dart';
import 'package:notch_app/features/feature/home/widgets/abstinence_counter_card_shell.dart';
import 'package:notch_app/l10n/app_localizations.dart';

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
      if (mounted) setState(() {});
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
    final encounters = Hive.box<Encounter>('encounters');
    final monthlyProgress = Hive.box<MonthlyProgress>('monthly_progress');

    return AnimatedBuilder(
      animation: Listenable.merge([
        encounters.listenable(),
        monthlyProgress.listenable(),
      ]),
      builder: (context, _) {
        final model = HomeAbstinenceViewModelService.build(
          encounters: encounters.values.toList(),
          monthlyEntries: monthlyProgress.values.toList(),
          now: DateTime.now(),
        );

        return AbstinenceCounterCardShell(
          title: l10n.homeAbstinenceTitle,
          subtitle: model.showZeroState
              ? l10n.homeAbstinenceNoDataSubtitle
              : l10n.homeAbstinenceSubtitle,
          value: l10n.homeAbstinenceDuration(
            model.days.toString(),
            model.hours.toString(),
            model.minutes.toString(),
          ),
          icon: model.showZeroState
              ? Icons.hourglass_empty_rounded
              : Icons.self_improvement_rounded,
        );
      },
    );
  }
}
