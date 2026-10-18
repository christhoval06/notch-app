import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PremiumUnlockedContent extends StatelessWidget {
  const PremiumUnlockedContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: scheme.success, size: 52),
              const SizedBox(height: 16),
              Text(
                l10n.monetizationActiveTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.monetizationActiveDescription,
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.monetizationContinue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
