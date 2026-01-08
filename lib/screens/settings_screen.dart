import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart'; // Para Haptics

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
    final Uri url = Uri.parse(urlStr);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No se pudo abrir $urlStr")));
    }
  }

  // Lógica de Reseteo de Fábrica (Manual)
  Future<void> _factoryReset() async {
    // Diálogo de confirmación
    bool confirm =
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              "¿Restablecer de Fábrica?",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Esta acción borrará TODOS tus registros, parejas, progreso y configuraciones de seguridad. No se puede deshacer.",
              style: TextStyle(color: Colors.grey[300]),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  "BORRAR TODO",
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
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Ajustes"),
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
              "Private Intimacy Tracker",
              style: TextStyle(
                color: Colors.blueAccent.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // 2. SECCIÓN GENERAL
          _buildSectionHeader("GENERAL"),
          _buildTile(
            icon: Icons.shield_outlined,
            color: Colors.orangeAccent,
            title: "Seguridad y Accesos",
            subtitle: "Configurar PIN, Pánico y Kill Switch",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SecuritySettingsScreen()),
            ),
          ),
          _buildTile(
            icon: Icons.cloud_sync_outlined,
            color: Colors.blueAccent,
            title: "Datos y Respaldo",
            subtitle: "Copias de seguridad y Exportar PDF",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DataManagementScreen()),
            ),
          ),

          // 3. SOBRE EL DESARROLLADOR
          _buildSectionHeader("ACERCA DE"),
          _buildTile(
            icon: Icons.code,
            color: Colors.purpleAccent,
            title: "Desarrollador",
            subtitle: "Creado con privacidad en mente",
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[900],
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(20),
                  height: 300,
                  child: Column(
                    children: [
                      const Text(
                        "Sobre el Dev 👨‍💻",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Hola, soy @christhoval. Creé NOTCH para el registro privado y seguro de la actividad sexual. Porque creo que los datos íntimos deben permanecer privados, esta app no tiene servidores, no tiene trackers y tú eres el único dueño de tu información.",
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
            title: "Contacto / Soporte",
            subtitle: "Reportar bugs o sugerir ideas",
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
          _buildSectionHeader("ZONA DE PELIGRO"),
          _buildTile(
            icon: Icons.delete_forever,
            color: Colors.redAccent,
            title: "Restablecer App",
            subtitle: "Borrar todos los datos y reiniciar",
            onTap: _factoryReset,
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              "Made with ❤️ & Flutter",
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
