import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/watch_dashboard_cards.dart';
import 'package:notch_app/features/watch_companion/widgets/watch_card_toggle.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class WatchCardSettingsContent extends StatelessWidget {
  const WatchCardSettingsContent({
    super.key,
    required this.cards,
    required this.onToggle,
    required this.onReorder,
  });
  final List<String> cards;
  final void Function(String, bool) onToggle;
  final ValueChanged<List<String>> onReorder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(l10n.watchCardsDescription),
        const SizedBox(height: 8),
        Text(l10n.watchCardsSyncHint, style: TextStyle(color: secondary)),
        const SizedBox(height: 20),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          onReorderItem: (oldIndex, newIndex) {
            final next = [...cards];
            next.insert(newIndex, next.removeAt(oldIndex));
            onReorder(next);
          },
          children: [
            for (var i = 0; i < cards.length; i++)
              WatchCardToggle(
                key: ValueKey(cards[i]),
                id: cards[i],
                enabled: true,
                index: i,
                onChanged: (value) => onToggle(cards[i], value),
              ),
          ],
        ),
        if (cards.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              l10n.watchCardsEmpty,
              style: TextStyle(color: secondary),
            ),
          ),
        for (final id in WatchDashboardCards.all.where(
          (id) => !cards.contains(id),
        ))
          WatchCardToggle(
            key: ValueKey(id),
            id: id,
            enabled: false,
            onChanged: (value) => onToggle(id, value),
          ),
        const SizedBox(height: 12),
        Text(l10n.watchCardsReorder, style: TextStyle(color: secondary)),
      ],
    );
  }
}
