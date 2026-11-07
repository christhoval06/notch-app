import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/home/services/home_abstinence_view_model_service.dart';
import 'package:notch_app/features/home/widgets/abstinence_counter_card_shell.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AbstinenceCounterCard extends StatefulWidget {
  const AbstinenceCounterCard({super.key});

  @override
  State<AbstinenceCounterCard> createState() => _AbstinenceCounterCardState();
}

class _AbstinenceCounterCardState extends State<AbstinenceCounterCard> {
  Timer? _timer;
  late final Listenable _sources;
  List<Encounter> _encounters = [];
  List<MonthlyProgress> _monthlyProgress = [];

  void _load() {
    _encounters = EncounterRepository.getAll();
    _monthlyProgress = MonthlyProgressRepository.getAll();
  }

  void _dataChanged() {
    _load();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _sources = Listenable.merge([
      EncounterRepository.listenable(),
      MonthlyProgressRepository.listenable(),
    ])..addListener(_dataChanged);
    _load();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sources.removeListener(_dataChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final model = HomeAbstinenceViewModelService.build(
      encounters: _encounters,
      monthlyEntries: _monthlyProgress,
      now: DateTime.now(),
    );
    return AbstinenceCounterCardShell(
      title: l10n.homeAbstinenceTitle,
      subtitle: model.showZeroState ? l10n.homeAbstinenceNoDataSubtitle : null,
      value: l10n.homeAbstinenceDuration(
        model.days.toString(),
        model.hours.toString(),
        model.minutes.toString(),
      ),
      icon: Icons.hourglass_bottom_rounded,
    );
  }
}
