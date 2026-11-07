import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/locale_controller.dart';
import 'package:notch_app/features/settings/widgets/settings_about_sheet.dart';
import 'package:notch_app/features/settings/widgets/settings_language_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsSheetService {
  const SettingsSheetService._();

  static Future<String?> pickLanguage(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: scheme.surface,
      builder: (_) => SettingsLanguageSheet(
        selectedCode: AppLocaleController.instance.languageCode,
      ),
    );
  }

  static Future<void> launchContact(BuildContext context, String urlStr) async {
    final l10n = AppLocalizations.of(context);
    final url = Uri.parse(urlStr);
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) return;
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.settingsCouldNotOpen(urlStr))));
  }

  static Future<bool> confirmFactoryReset(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: scheme.surface,
            title: Text(
              l10n.settingsFactoryResetTitle,
              style: TextStyle(color: scheme.onSurface),
            ),
            content: Text(
              l10n.settingsFactoryResetMessage,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  l10n.deleteAll,
                  style: TextStyle(
                    color: scheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<void> showAboutApp(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return showModalBottomSheet(
      context: context,
      backgroundColor: scheme.surface,
      isScrollControlled: true,
      builder: (_) => SettingsAboutSheet(
        title: l10n.settingsAboutAppTitle,
        description: l10n.settingsAboutAppDescription,
        pillars: [
          SettingsAboutPillarData(
            icon: Icons.verified_user_outlined,
            title: l10n.settingsAboutAppPillarPrivacyTitle,
            body: l10n.settingsAboutAppPillarPrivacyBody,
          ),
          SettingsAboutPillarData(
            icon: Icons.insights_outlined,
            title: l10n.settingsAboutAppPillarPurposeTitle,
            body: l10n.settingsAboutAppPillarPurposeBody,
          ),
          SettingsAboutPillarData(
            icon: Icons.tune_outlined,
            title: l10n.settingsAboutAppPillarControlTitle,
            body: l10n.settingsAboutAppPillarControlBody,
          ),
        ],
      ),
    );
  }

  static Future<void> showDeveloper(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return showModalBottomSheet(
      context: context,
      backgroundColor: scheme.surface,
      isScrollControlled: true,
      builder: (_) => SettingsAboutSheet(
        title: '${l10n.settingsAboutDevTitle} 👨‍💻',
        description: l10n.settingsAboutDevDescription,
        pillars: [
          SettingsAboutPillarData(
            icon: Icons.badge_outlined,
            title: l10n.settingsAboutDevRoleTitle,
            body: l10n.settingsAboutDevRoleBody,
          ),
          SettingsAboutPillarData(
            icon: Icons.terminal_outlined,
            title: l10n.settingsAboutDevStackTitle,
            body: l10n.settingsAboutDevStackBody,
          ),
          SettingsAboutPillarData(
            icon: Icons.design_services_outlined,
            title: l10n.settingsAboutDevFocusTitle,
            body: l10n.settingsAboutDevFocusBody,
          ),
        ],
      ),
    );
  }
}
