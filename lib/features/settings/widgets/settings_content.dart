import 'package:flutter/material.dart';
import 'package:notch_app/features/settings/widgets/settings_about_section.dart';
import 'package:notch_app/features/settings/widgets/settings_general_section.dart';
import 'package:notch_app/features/settings/widgets/settings_header.dart';
import 'package:notch_app/features/settings/widgets/settings_maintenance_section.dart';
import 'package:notch_app/features/settings/widgets/settings_section_header.dart';
import 'package:notch_app/features/settings/widgets/settings_tile.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
    required this.appVersion,
    required this.buildNumber,
    required this.isRecalculating,
    required this.isRecalculatingXp,
    required this.onLanguageTap,
    required this.onAboutAppTap,
    required this.onDeveloperTap,
    required this.onSupportTap,
    required this.onFactoryResetTap,
    required this.onRecalculateAchievementsTap,
    required this.onRecalculateXpTap,
  });

  final String appVersion;
  final String buildNumber;
  final bool isRecalculating;
  final bool isRecalculatingXp;
  final VoidCallback onLanguageTap;
  final VoidCallback onAboutAppTap;
  final VoidCallback onDeveloperTap;
  final VoidCallback onSupportTap;
  final VoidCallback onFactoryResetTap;
  final VoidCallback onRecalculateAchievementsTap;
  final VoidCallback onRecalculateXpTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      children: [
        SettingsHeader(appVersion: appVersion, buildNumber: buildNumber),
        SettingsGeneralSection(onLanguageTap: onLanguageTap),
        SettingsAboutSection(
          onAboutAppTap: onAboutAppTap,
          onDeveloperTap: onDeveloperTap,
          onSupportTap: onSupportTap,
        ),
        SettingsSectionHeader(title: l10n.settingsDangerZone),
        SettingsTile(
          icon: Icons.delete_forever,
          color: scheme.error,
          title: l10n.settingsResetApp,
          subtitle: l10n.settingsResetAppSubtitle,
          onTap: onFactoryResetTap,
        ),
        SettingsMaintenanceSection(
          isRecalculating: isRecalculating,
          isRecalculatingXp: isRecalculatingXp,
          onRecalculateAchievementsTap: onRecalculateAchievementsTap,
          onRecalculateXpTap: onRecalculateXpTap,
        ),
        const SizedBox(height: 40),
        Center(
          child: Text(
            l10n.settingsMadeWithFlutter,
            style: TextStyle(color: scheme.outline, fontSize: 10),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
