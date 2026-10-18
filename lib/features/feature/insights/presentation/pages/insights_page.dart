import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/health_log_repository.dart';
import 'package:notch_app/features/feature/insights/services/insights_view_model_service.dart';
import 'package:notch_app/features/feature/insights/widgets/insights_content.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: Listenable.merge([
        EncounterRepository.listenable(),
        HealthLogRepository.listenable(),
      ]),
      builder: (context, _) {
        final viewModel = InsightsViewModelService.build(
          encounters: EncounterRepository.getAll(),
          healthLogs: HealthLogRepository.getAll(),
          l10n: l10n,
        );
        return Scaffold(
          backgroundColor: scheme.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(l10n.insightsTitle),
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  scheme.surface,
                  scheme.surfaceContainerHighest.withValues(alpha: 0.16),
                  scheme.surface,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(child: InsightsContent(viewModel: viewModel)),
          ),
        );
      },
    );
  }
}
