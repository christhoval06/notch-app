import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/locale_controller.dart';
import 'package:notch_app/features/feature/health/presentation/pages/health_passport_page.dart';
import 'package:notch_app/features/feature/settings/presentation/pages/data_management_page.dart';
import 'package:notch_app/features/feature/settings/presentation/pages/security_settings_page.dart';
import 'package:notch_app/features/feature/settings/widgets/settings_section_header.dart';
import 'package:notch_app/features/feature/settings/widgets/settings_tile.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/features/watch_companion/widgets/watch_settings_tile.dart';

class SettingsGeneralSection extends StatelessWidget {
  const SettingsGeneralSection({super.key, required this.onLanguageTap});

  final VoidCallback onLanguageTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SettingsSectionHeader(title: l10n.settingsGeneral),
        const WatchSettingsTile(),
        SettingsTile(
          icon: Icons.shield_outlined,
          color: scheme.warning,
          title: l10n.settingsSecurityAccess,
          subtitle: l10n.settingsSecurityAccessSubtitle,
          onTap: () => _open(context, SecuritySettingsScreen()),
        ),
        SettingsTile(
          icon: Icons.cloud_sync_outlined,
          color: scheme.primary,
          title: l10n.settingsDataBackup,
          subtitle: l10n.settingsDataBackupSubtitle,
          onTap: () => _open(context, const DataManagementScreen()),
        ),
        SettingsTile(
          icon: Icons.local_hospital_outlined,
          color: scheme.error,
          title: l10n.homeHealthPassportTitle,
          subtitle: l10n.settingsHealthPassportSubtitle,
          onTap: () => _open(context, const HealthPassportScreen()),
        ),
        SettingsTile(
          icon: Icons.language,
          color: scheme.tertiary,
          title: l10n.settingsLanguage,
          subtitle: AppLocaleController.instance.languageCode == 'es'
              ? 'Español'
              : 'English',
          onTap: onLanguageTap,
        ),
      ],
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
