import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notch_app/core/utils/locale_controller.dart';
import 'package:notch_app/features/feature/home/presentation/pages/home_page.dart';
import 'package:notch_app/features/feature/settings/services/settings_app_info_service.dart';
import 'package:notch_app/features/feature/settings/services/settings_factory_reset_service.dart';
import 'package:notch_app/features/feature/settings/services/settings_maintenance_service.dart';
import 'package:notch_app/features/feature/settings/services/settings_sheet_service.dart';
import 'package:notch_app/features/feature/settings/widgets/settings_content.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _storage = const FlutterSecureStorage();
  String _appVersion = 'Cargando...';
  String _buildNumber = '';
  bool _isRecalculating = false;
  bool _isRecalculatingXp = false;

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.settingsTitle),
      ),
      body: SettingsContent(
        appVersion: _appVersion,
        buildNumber: _buildNumber,
        isRecalculating: _isRecalculating,
        isRecalculatingXp: _isRecalculatingXp,
        onLanguageTap: _pickLanguage,
        onAboutAppTap: _showAboutAppSheet,
        onDeveloperTap: _showDeveloperSheet,
        onSupportTap: () =>
            _launchContact('mailto:me@christhoval.com?subject=Soporte NOTCH'),
        onFactoryResetTap: _factoryReset,
        onRecalculateAchievementsTap: () => _runMaintenance(
          isXp: false,
          action: SettingsMaintenanceService.recalculateAchievements,
          successMessage: l10n.settingsAchievementsUpdated,
        ),
        onRecalculateXpTap: () => _runMaintenance(
          isXp: true,
          action: SettingsMaintenanceService.recalculateXp,
          successMessage: l10n.settingsXpUpdated,
        ),
      ),
    );
  }

  Future<void> _loadAppInfo() async {
    final info = await SettingsAppInfoService.load();
    if (!mounted) return;
    setState(() {
      _appVersion = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  Future<void> _pickLanguage() async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final selectedCode = await SettingsSheetService.pickLanguage(context);
    if (selectedCode == null ||
        selectedCode == AppLocaleController.instance.languageCode) {
      return;
    }
    await AppLocaleController.instance.setLanguageCode(selectedCode);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.settingsLanguageUpdated),
        backgroundColor: scheme.primary,
      ),
    );
  }

  Future<void> _launchContact(String urlStr) async {
    await SettingsSheetService.launchContact(context, urlStr);
  }

  Future<void> _factoryReset() async {
    final confirm = await SettingsSheetService.confirmFactoryReset(context);
    if (!confirm) return;
    HapticFeedback.heavyImpact();
    await SettingsFactoryResetService.run(_storage);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  Future<void> _runMaintenance({
    required bool isXp,
    required Future<void> Function() action,
    required String successMessage,
  }) async {
    final scheme = Theme.of(context).colorScheme;
    setState(() {
      if (isXp) {
        _isRecalculatingXp = true;
      } else {
        _isRecalculating = true;
      }
    });
    await action();
    if (!mounted) return;
    setState(() {
      if (isXp) {
        _isRecalculatingXp = false;
      } else {
        _isRecalculating = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(successMessage), backgroundColor: scheme.primary),
    );
  }

  void _showAboutAppSheet() {
    SettingsSheetService.showAboutApp(context);
  }

  void _showDeveloperSheet() {
    SettingsSheetService.showDeveloper(context);
  }
}
