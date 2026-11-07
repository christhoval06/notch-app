import 'package:flutter/material.dart';
import 'package:notch_app/features/settings/widgets/settings_section_header.dart';
import 'package:notch_app/features/settings/widgets/settings_tile.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SettingsAboutSection extends StatelessWidget {
  const SettingsAboutSection({
    super.key,
    required this.onAboutAppTap,
    required this.onDeveloperTap,
    required this.onSupportTap,
  });

  final VoidCallback onAboutAppTap;
  final VoidCallback onDeveloperTap;
  final VoidCallback onSupportTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SettingsSectionHeader(title: l10n.settingsAbout),
        SettingsTile(
          icon: Icons.info_outline,
          color: scheme.primary,
          title: l10n.settingsAboutApp,
          subtitle: l10n.settingsAboutAppSubtitle,
          onTap: onAboutAppTap,
        ),
        SettingsTile(
          icon: Icons.code,
          color: scheme.secondary,
          title: l10n.settingsDeveloper,
          subtitle: l10n.settingsDeveloperSubtitle,
          onTap: onDeveloperTap,
        ),
        SettingsTile(
          icon: Icons.mail_outline,
          color: scheme.onSurface,
          title: l10n.settingsContactSupport,
          subtitle: l10n.settingsContactSupportSubtitle,
          onTap: onSupportTap,
        ),
      ],
    );
  }
}
