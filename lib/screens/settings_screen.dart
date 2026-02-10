import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/services/achievement_engine.dart';
import 'package:notch_app/utils/gamification_engine.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart'; // Para Haptics
import 'package:notch_app/utils/locale_controller.dart';

// IMPORTS DE TUS PANTALLAS
import 'security_settings_screen.dart'; // La pantalla de PINs antigua
import 'data_management_screen.dart'; // La pantalla de Backup/PDF
import 'home_screen.dart';

// IMPORTS DE MODELOS (Para el reseteo)
import '../models/encounter.dart';
import '../models/partner.dart';
import '../models/monthly_progress.dart';
import '../models/health_log.dart';

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
    final selectedCode = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                "Español",
                style: TextStyle(color: Colors.white),
              ),
              trailing: AppLocaleController.instance.languageCode == 'es'
                  ? const Icon(Icons.check, color: Colors.blueAccent)
                  : null,
              onTap: () => Navigator.pop(ctx, 'es'),
            ),
            ListTile(
              title: const Text(
                "English",
                style: TextStyle(color: Colors.white),
              ),
              trailing: AppLocaleController.instance.languageCode == 'en'
                  ? const Icon(Icons.check, color: Colors.blueAccent)
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
        backgroundColor: Colors.green,
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
    // Diálogo de confirmación
    bool confirm =
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              l10n.settingsFactoryResetTitle,
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              l10n.settingsFactoryResetMessage,
              style: TextStyle(color: Colors.grey[300]),
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
                    color: Colors.redAccent,
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
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
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
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 40,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              "NOTCH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          Center(
            child: Text(
              "v$_appVersion ($_buildNumber)",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              l10n.settingsTagline,
              style: TextStyle(
                color: Colors.blueAccent.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // 2. SECCIÓN GENERAL
          _buildSectionHeader(l10n.settingsGeneral),
          _buildTile(
            icon: Icons.shield_outlined,
            color: Colors.orangeAccent,
            title: l10n.settingsSecurityAccess,
            subtitle: l10n.settingsSecurityAccessSubtitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SecuritySettingsScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.cloud_sync_outlined,
            color: Colors.blueAccent,
            title: l10n.settingsDataBackup,
            subtitle: l10n.settingsDataBackupSubtitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DataManagementScreen()),
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
            icon: Icons.code,
            color: Colors.purpleAccent,
            title: l10n.settingsDeveloper,
            subtitle: l10n.settingsDeveloperSubtitle,
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[900],
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(20),
                  height: 300,
                  child: Column(
                    children: [
                      Text(
                        "${l10n.settingsAboutDevTitle} 👨‍💻",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.settingsAboutDevDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      // const SizedBox(height: 30),
                      // ElevatedButton.icon(
                      //   icon: const Icon(Icons.coffee),
                      //   label: const Text("Apoya el proyecto"),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.amber[800],
                      //   ),
                      //   onPressed: () => _launchContact(
                      //     'https://www.buymeacoffee.com/tuusuario',
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
          _buildTile(
            icon: Icons.mail_outline,
            color: Colors.white,
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
            color: Colors.redAccent,
            title: l10n.settingsResetApp,
            subtitle: l10n.settingsResetAppSubtitle,
            onTap: _factoryReset,
          ),

          _buildSectionHeader(l10n.settingsMaintenance),
          _isRecalculating
              ? const Center(child: CircularProgressIndicator())
              : _buildTile(
                  icon: Icons.refresh,
                  color: Colors.greenAccent,
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
                          backgroundColor: Colors.green,
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
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              l10n.settingsMadeWithFlutter,
              style: TextStyle(color: Colors.grey[800], fontSize: 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
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
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[500], fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }
}
