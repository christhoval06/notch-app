import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SharePreviewHeader extends StatelessWidget {
  const SharePreviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh.withValues(alpha: 0.84),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: Text(
            'NOTCH',
            style: TextStyle(
              fontFamily: 'Lato',
              color: scheme.onSurface.withValues(alpha: 0.7),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          l10n.sharePreviewTitle,
          style: TextStyle(
            fontFamily: 'BebasNeue',
            color: scheme.onSurface,
            fontSize: 34,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.sharePreviewSubtitle,
          style: TextStyle(
            fontFamily: 'Lato',
            color: scheme.onSurface.withValues(alpha: 0.72),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
