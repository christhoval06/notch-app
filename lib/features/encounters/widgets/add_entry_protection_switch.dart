import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntryProtectionSwitch extends StatelessWidget {
  const AddEntryProtectionSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FormBuilderSwitch(
        name: 'protected',
        initialValue: true,
        decoration: const InputDecoration(border: InputBorder.none),
        title: Row(
          children: [
            Icon(Icons.security, color: scheme.success, size: 20),
            const SizedBox(width: 10),
            Text(
              l10n.usedProtection,
              style: TextStyle(color: scheme.onSurface, fontSize: 16),
            ),
          ],
        ),
        activeColor: scheme.success,
        inactiveThumbColor: scheme.onSurfaceVariant,
        inactiveTrackColor: scheme.surfaceContainerHighest,
        onChanged: (_) => HapticFeedback.mediumImpact(),
      ),
    );
  }
}
