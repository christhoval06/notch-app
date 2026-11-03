import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerEmojiPickerDialog extends StatelessWidget {
  const PartnerEmojiPickerDialog({super.key, required this.emojis});

  final List<String> emojis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: scheme.surfaceContainerHighest,
      title: Text(
        l10n.partnerChooseEmojiTitle,
        style: TextStyle(color: scheme.onSurface),
      ),
      content: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: emojis
            .map(
              (emoji) => GestureDetector(
                onTap: () => Navigator.pop(context, emoji),
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            )
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }
}
