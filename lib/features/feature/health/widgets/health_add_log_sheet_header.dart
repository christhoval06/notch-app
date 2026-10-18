import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HealthAddLogSheetHeader extends StatelessWidget {
  const HealthAddLogSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: scheme.outlineVariant,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          l10n.healthNewRecord,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.healthAddRecordSubtitle,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
