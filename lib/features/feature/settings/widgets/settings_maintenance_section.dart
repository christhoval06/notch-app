import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/features/feature/settings/widgets/settings_section_header.dart';
import 'package:notch_app/features/feature/settings/widgets/settings_tile.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SettingsMaintenanceSection extends StatelessWidget {
  const SettingsMaintenanceSection({
    super.key,
    required this.isRecalculating,
    required this.isRecalculatingXp,
    required this.onRecalculateAchievementsTap,
    required this.onRecalculateXpTap,
  });

  final bool isRecalculating;
  final bool isRecalculatingXp;
  final VoidCallback onRecalculateAchievementsTap;
  final VoidCallback onRecalculateXpTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SettingsSectionHeader(title: l10n.settingsMaintenance),
        isRecalculating
            ? const Center(child: CircularProgressIndicator())
            : SettingsTile(
                icon: Icons.refresh,
                color: scheme.success,
                title: l10n.settingsRecalculateAchievements,
                subtitle: l10n.settingsRecalculateAchievementsSubtitle,
                onTap: onRecalculateAchievementsTap,
              ),
        isRecalculatingXp
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              )
            : SettingsTile(
                icon: Icons.calculate,
                color: scheme.tertiary,
                title: l10n.settingsRecalculateXp,
                subtitle: l10n.settingsRecalculateXpSubtitle,
                onTap: onRecalculateXpTap,
              ),
      ],
    );
  }
}
