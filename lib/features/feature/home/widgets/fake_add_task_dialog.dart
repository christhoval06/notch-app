import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

Future<void> showFakeAddTaskDialog(
  BuildContext context, {
  required ValueChanged<String> onAdd,
}) async {
  final l10n = AppLocalizations.of(context);
  final scheme = Theme.of(context).colorScheme;
  final titleController = TextEditingController();

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: scheme.surface,
        title: Text(l10n.fakeNewTask, style: TextStyle(color: scheme.onSurface)),
        content: TextField(
          controller: titleController,
          autofocus: true,
          style: TextStyle(color: scheme.onSurface),
          decoration: InputDecoration(hintText: l10n.fakeTaskHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
          TextButton(
            onPressed: () {
              final value = titleController.text.trim();
              if (value.isEmpty) return;
              onAdd(value);
              Navigator.of(dialogContext).pop();
            },
            child: Text(l10n.fakeAdd, style: TextStyle(color: scheme.primary)),
          ),
        ],
      );
    },
  );
}
