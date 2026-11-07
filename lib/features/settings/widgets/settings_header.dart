import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    super.key,
    required this.appVersion,
    required this.buildNumber,
  });

  final String appVersion;
  final String buildNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.2),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(Icons.lock_outline, size: 40, color: scheme.primary),
          ),
        ),
        const SizedBox(height: 15),
        Center(
          child: Text(
            'NOTCH',
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        Center(
          child: Text(
            'v$appVersion ($buildNumber)',
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            l10n.settingsTagline,
            style: TextStyle(
              color: scheme.primary.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
