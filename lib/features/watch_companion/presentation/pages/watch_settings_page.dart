import 'package:flutter/material.dart';
import 'package:notch_app/features/watch_companion/state/watch_layout_controller.dart';
import 'package:notch_app/features/watch_companion/widgets/watch_card_settings_content.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class WatchSettingsPage extends StatelessWidget {
  const WatchSettingsPage({super.key, this.controller});
  final WatchLayoutController? controller;

  @override
  Widget build(BuildContext context) {
    final layout = controller ?? WatchLayoutController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).watchSettingsTitle),
      ),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: layout,
        builder: (context, cards, _) => WatchCardSettingsContent(
          cards: cards,
          onToggle: (id, enabled) =>
              _save(context, layout.setEnabled(id, enabled)),
          onReorder: (ids) => _save(context, layout.reorder(ids)),
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context, Future<void> action) async {
    try {
      await action;
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).watchCardsSaveError),
        ),
      );
    }
  }
}
