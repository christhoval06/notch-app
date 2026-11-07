import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/app_routes.dart';
import 'package:notch_app/features/settings/widgets/settings_tile.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class WatchSettingsTile extends StatelessWidget {
  const WatchSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    return SettingsTile(
      icon: Icons.watch_outlined,
      color: Theme.of(context).colorScheme.primary,
      title: l10n.watchSettingsTitle,
      subtitle: l10n.watchSettingsSubtitle,
      onTap: () => Navigator.pushNamed(context, AppRoutes.watchSettings),
    );
  }
}
