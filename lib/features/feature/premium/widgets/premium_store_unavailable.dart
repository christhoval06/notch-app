import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PremiumStoreUnavailable extends StatelessWidget {
  const PremiumStoreUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        AppLocalizations.of(context).monetizationStoreUnavailable,
        style: TextStyle(color: scheme.onSurfaceVariant),
      ),
    );
  }
}
