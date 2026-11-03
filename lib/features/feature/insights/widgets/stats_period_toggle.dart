import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsPeriodToggle extends StatelessWidget {
  const StatsPeriodToggle({
    super.key,
    required this.selectedPeriod,
    required this.onChanged,
  });

  final StatPeriod selectedPeriod;
  final ValueChanged<StatPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final labels = {
      StatPeriod.month: l10n.statsPeriod30Days,
      StatPeriod.sixMonths: l10n.statsPeriod6Months,
      StatPeriod.allTime: l10n.statsPeriodTotal,
    };
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: StatPeriod.values
            .map(
              (period) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: _PeriodChip(
                    label: labels[period]!,
                    isSelected: period == selectedPeriod,
                    onTap: () => onChanged(period),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      scheme.primary.withValues(alpha: 0.3),
                      scheme.tertiary.withValues(alpha: 0.18),
                    ],
                  )
                : null,
            color: isSelected ? null : scheme.surface.withValues(alpha: 0.2),
            border: Border.all(
              color: isSelected
                  ? scheme.primary.withValues(alpha: 0.26)
                  : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? scheme.onSurface : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
