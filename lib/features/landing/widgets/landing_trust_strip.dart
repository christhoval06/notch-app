import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/icon_label.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingTrustStrip extends StatelessWidget {
  const LandingTrustStrip({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 12,
      children: [
        for (final item in [
          (Icons.wifi_off, l.landingOffline),
          (Icons.enhanced_encryption_outlined, l.landingEncrypted),
          (Icons.shield_outlined, l.landingNoTrackers),
        ])
          IconLabel(
            icon: item.$1,
            label: item.$2,
            color: scheme.tertiary,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
      ],
    );
  }
}
