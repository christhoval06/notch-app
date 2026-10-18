import 'package:flutter/material.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_view_model_service.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_content.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  StatPeriod _selectedPeriod = StatPeriod.sixMonths;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: Listenable.merge([
        EncounterRepository.listenable(),
        MonthlyProgressRepository.listenable(),
      ]),
      builder: (context, _) {
        final viewModel = StatsViewModelService.build(_selectedPeriod);
        return Scaffold(
          appBar: AppBar(title: Text(l10n.homeStatsTitle)),
          backgroundColor: scheme.surface,
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  scheme.surface,
                  scheme.surfaceContainerHighest.withValues(alpha: 0.18),
                  scheme.surface,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        child: StatsContent(
                          key: ValueKey(_selectedPeriod),
                          viewModel: viewModel,
                          selectedPeriod: _selectedPeriod,
                          onPeriodChanged: (period) {
                            setState(() => _selectedPeriod = period);
                          },
                        ),
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
}
