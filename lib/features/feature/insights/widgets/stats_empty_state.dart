import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsEmptyState extends StatelessWidget {
  const StatsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        AppLocalizations.of(context).statsNoData,
        style: TextStyle(color: scheme.onSurfaceVariant),
      ),
    );
  }
}
