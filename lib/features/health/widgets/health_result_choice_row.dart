import 'package:flutter/material.dart';
import 'package:notch_app/features/health/services/health_log_result_style_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HealthResultChoiceRow extends StatelessWidget {
  const HealthResultChoiceRow({
    super.key,
    required this.selectedResult,
    required this.onChanged,
  });

  final String selectedResult;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final results = [
      l10n.healthResultNegative,
      l10n.healthResultPositive,
      l10n.healthResultPending,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.healthResultLabel,
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: results.map((value) {
            final style = HealthLogResultStyleService.resolve(context, value);
            final selected = selectedResult == value;
            return ChoiceChip(
              avatar: Icon(style.icon, size: 16, color: style.accent),
              label: Text(value),
              selected: selected,
              backgroundColor: scheme.surfaceContainerHighest,
              selectedColor: style.surface,
              side: BorderSide(
                color: selected ? style.outline : scheme.outlineVariant,
              ),
              onSelected: (_) => onChanged(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
