import 'package:flutter/material.dart';
import 'package:notch_app/core/configs/feature_flags.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/features/feature/premium/models/premium_access.dart';
import 'package:notch_app/features/feature/premium/models/premium_feature.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart'; // Para Haptics
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/locale_controller.dart';
import 'package:notch_app/core/widgets/feature_guard.dart';
import 'package:notch_app/features/feature/health/presentation/pages/health_passport_page.dart';

// IMPORTS DE TUS PANTALLAS
import 'security_settings_page.dart'; // La pantalla de PINs antigua
import 'data_management_page.dart'; // La pantalla de Backup/PDF
import 'package:notch_app/features/feature/home/presentation/pages/home_page.dart';
import 'package:notch_app/features/feature/premium/presentation/pages/premium_upsell_page.dart';

// IMPORTS DE MODELOS (Para el reseteo)
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/health_log.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = "Cargando...";
  String _buildNumber = "";
  final _storage = const FlutterSecureStorage();
  bool _isRecalculating = false;
  bool _isRecalculatingXp = false;

  Future<void> _pickLanguage() async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final selectedCode = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: scheme.surface,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                "Español",
                style: TextStyle(color: scheme.onSurface),
              ),
              trailing: AppLocaleController.instance.languageCode == 'es'
                  ? Icon(Icons.check, color: scheme.primary)
                  : null,
              onTap: () => Navigator.pop(ctx, 'es'),
            ),
            ListTile(
              title: Text(
                "English",
                style: TextStyle(color: scheme.onSurface),
              ),
              trailing: AppLocaleController.instance.languageCode == 'en'
                  ? Icon(Icons.check, color: scheme.primary)
                  : null,
              onTap: () => Navigator.pop(ctx, 'en'),
            ),
          ],
        ),
      ),
    );

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

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  // Obtener versión real del pubspec.yaml
  Future<void> _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  // Abrir Correo o Web
  Future<void> _launchContact(String urlStr) async {
    final l10n = AppLocalizations.of(context);
    final Uri url = Uri.parse(urlStr);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsCouldNotOpen(urlStr))),
      );
    }
  }

  // Lógica de Reseteo de Fábrica (Manual)
  Future<void> _factoryReset() async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    // Diálogo de confirmación
    bool confirm =
        await showDialog(
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

    if (confirm) {
      HapticFeedback.heavyImpact();
      await Hive.close();
      // Borrar Hive
      final boxes = [
        'encounters',
        'partners',
        'monthly_progress',
        'health_logs',
      ];
      for (var boxName in boxes) {
        try {
          // Ahora sí podemos borrar sin miedo porque Hive ya cerró la conexión
          await Hive.deleteBoxFromDisk(boxName);
        } catch (e) {
          print("No se pudo borrar $boxName (quizás no existía): $e");
        }
      }

      // Reabrir cajas vacías para evitar crash
      await Hive.openBox<Encounter>('encounters');
      await Hive.openBox<Partner>('partners');
      await Hive.openBox<MonthlyProgress>('monthly_progress');
      await Hive.openBox<HealthLog>('health_logs');

      // Borrar Secure Storage
      await _storage.deleteAll();

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        children: [
          // 1. CABECERA APP
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
                    color: scheme.primary.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_outline,
                size: 40,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "NOTCH",
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
              "v$_appVersion ($_buildNumber)",
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              l10n.settingsTagline,
              style: TextStyle(
                color: scheme.primary.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // 2. SECCIÓN GENERAL
          _buildSectionHeader(l10n.settingsGeneral),
          _buildTile(
            icon: Icons.shield_outlined,
            color: scheme.warning,
            title: l10n.settingsSecurityAccess,
            subtitle: l10n.settingsSecurityAccessSubtitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SecuritySettingsScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.cloud_sync_outlined,
            color: scheme.primary,
            title: l10n.settingsDataBackup,
            subtitle: l10n.settingsDataBackupSubtitle,
            onTap: () => PremiumAccess.guard(
              context: context,
              feature: PremiumFeature.dataBackup,
              onAllowed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DataManagementScreen()),
                );
              },
            ),
          ),
          _buildTile(
            icon: Icons.local_hospital_outlined,
            color: scheme.error,
            title: l10n.homeHealthPassportTitle,
            subtitle: l10n.premiumFeatureHealthPassportDescription,
            onTap: () => PremiumAccess.guard(
              context: context,
              feature: PremiumFeature.healthPassport,
              onAllowed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HealthPassportScreen()),
                );
              },
            ),
          ),
          FeatureGuard(
            featureName: FeatureNames.showPremiumSettingsItem,
            child: _buildTile(
              icon: Icons.workspace_premium,
              color: scheme.warning,
              title: l10n.monetizationPremiumTitle,
              subtitle: l10n.monetizationManagePlansSubtitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumUpsellScreen()),
              ),
            ),
          ),
          _buildTile(
            icon: Icons.language,
            color: Colors.tealAccent,
            title: l10n.settingsLanguage,
            subtitle: AppLocaleController.instance.languageCode == 'es'
                ? "Español"
                : "English",
            onTap: _pickLanguage,
          ),

          // 3. SOBRE EL DESARROLLADOR
          _buildSectionHeader(l10n.settingsAbout),
          _buildTile(
            icon: Icons.info_outline,
            color: scheme.primary,
            title: l10n.settingsAboutApp,
            subtitle: l10n.settingsAboutAppSubtitle,
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: scheme.surface,
                isScrollControlled: true,
                builder: (ctx) => SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    constraints: const BoxConstraints(maxHeight: 560),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: scheme.outlineVariant,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.settingsAboutAppTitle,
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l10n.settingsAboutAppDescription,
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _buildAboutPillar(
                            icon: Icons.verified_user_outlined,
                            title: l10n.settingsAboutAppPillarPrivacyTitle,
                            body: l10n.settingsAboutAppPillarPrivacyBody,
                          ),
                          const SizedBox(height: 10),
                          _buildAboutPillar(
                            icon: Icons.insights_outlined,
                            title: l10n.settingsAboutAppPillarPurposeTitle,
                            body: l10n.settingsAboutAppPillarPurposeBody,
                          ),
                          const SizedBox(height: 10),
                          _buildAboutPillar(
                            icon: Icons.tune_outlined,
                            title: l10n.settingsAboutAppPillarControlTitle,
                            body: l10n.settingsAboutAppPillarControlBody,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          _buildTile(
            icon: Icons.code,
            color: Colors.purpleAccent,
            title: l10n.settingsDeveloper,
            subtitle: l10n.settingsDeveloperSubtitle,
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: scheme.surface,
                isScrollControlled: true,
                builder: (ctx) => SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    constraints: const BoxConstraints(maxHeight: 560),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: scheme.outlineVariant,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "${l10n.settingsAboutDevTitle} 👨‍💻",
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l10n.settingsAboutDevDescription,
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _buildAboutPillar(
                            icon: Icons.badge_outlined,
                            title: l10n.settingsAboutDevRoleTitle,
                            body: l10n.settingsAboutDevRoleBody,
                          ),
                          const SizedBox(height: 10),
                          _buildAboutPillar(
                            icon: Icons.terminal_outlined,
                            title: l10n.settingsAboutDevStackTitle,
                            body: l10n.settingsAboutDevStackBody,
                          ),
                          const SizedBox(height: 10),
                          _buildAboutPillar(
                            icon: Icons.design_services_outlined,
                            title: l10n.settingsAboutDevFocusTitle,
                            body: l10n.settingsAboutDevFocusBody,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          _buildTile(
            icon: Icons.mail_outline,
            color: scheme.onSurface,
            title: l10n.settingsContactSupport,
            subtitle: l10n.settingsContactSupportSubtitle,
            onTap: () => _launchContact(
              'mailto:me@christhoval.com?subject=Soporte NOTCH',
            ),
          ),
          // _buildTile(
          //   icon: Icons.policy_outlined,
          //   color: Colors.grey,
          //   title: "Política de Privacidad",
          //   subtitle: "Términos de uso y manejo de datos",
          //   onTap: () => _launchContact(
          //     'https://tudominio.com/privacy',
          //   ), // Crea una web simple gratis
          // ),

          // 4. ZONA DE PELIGRO
          _buildSectionHeader(l10n.settingsDangerZone),
          _buildTile(
            icon: Icons.delete_forever,
            color: scheme.error,
            title: l10n.settingsResetApp,
            subtitle: l10n.settingsResetAppSubtitle,
            onTap: _factoryReset,
          ),

          _buildSectionHeader(l10n.settingsMaintenance),
          _isRecalculating
              ? const Center(child: CircularProgressIndicator())
              : _buildTile(
                  icon: Icons.refresh,
                  color: scheme.success,
                  title: l10n.settingsRecalculateAchievements,
                  subtitle: l10n.settingsRecalculateAchievementsSubtitle,
                  onTap: () async {
                    setState(() => _isRecalculating = true);

                    await AchievementEngine.recalculateAllAchievements();

                    if (mounted) {
                      setState(() => _isRecalculating = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.settingsAchievementsUpdated),
                          backgroundColor: scheme.primary,
                        ),
                      );
                    }
                  },
                ),
          _isRecalculatingXp
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : _buildTile(
                  icon: Icons.calculate,
                  color: Colors.cyanAccent,
                  title: l10n.settingsRecalculateXp,
                  subtitle: l10n.settingsRecalculateXpSubtitle,
                  onTap: () async {
                    setState(() => _isRecalculatingXp = true);

                    await GamificationEngine.recalculateAllXp();

                    if (mounted) {
                      setState(() => _isRecalculatingXp = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.settingsXpUpdated),
                          backgroundColor: scheme.primary,
                        ),
                      );
                    }
                  },
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
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          color: scheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: scheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: scheme.onSurfaceVariant,
        size: 18,
      ),
      onTap: onTap,
    );
  }

  Widget _buildAboutPillar({
    required IconData icon,
    required String title,
    required String body,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(color: scheme.onSurfaceVariant, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
