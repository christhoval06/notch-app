import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/watch_dashboard_cards.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class WatchCardToggle extends StatelessWidget {
  const WatchCardToggle({
    super.key,
    required this.id,
    required this.enabled,
    required this.onChanged,
    this.index,
  });
  final String id;
  final bool enabled;
  final int? index;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, icon) = switch (id) {
      WatchDashboardCards.abstinence => (
        l10n.homeAbstinenceTitle,
        Icons.hourglass_bottom_rounded,
      ),
      WatchDashboardCards.level => (l10n.watchCardLevel, Icons.star_rounded),
      WatchDashboardCards.stats => (l10n.watchStats, Icons.bar_chart_rounded),
      _ => (l10n.watchCardOrgasms, Icons.favorite_rounded),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile.adaptive(
        value: enabled,
        onChanged: onChanged,
        title: Text(label),
        tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        secondary: index == null
            ? Icon(icon)
            : ReorderableDragStartListener(
                index: index!,
                child: const Icon(Icons.drag_indicator),
              ),
      ),
    );
  }
}
