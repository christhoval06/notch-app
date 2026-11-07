import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntrySubmitButton extends StatelessWidget {
  const AddEntrySubmitButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          l10n.save,
          style: TextStyle(fontSize: 18, color: scheme.onPrimary),
        ),
      ),
    );
  }
}
