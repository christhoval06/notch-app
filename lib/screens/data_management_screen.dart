import 'package:flutter/material.dart';
import '../services/backup_service.dart';
import '../services/pdf_service.dart';

class DataManagementScreen extends StatefulWidget {
  @override
  _DataManagementScreenState createState() => _DataManagementScreenState();
}

class _DataManagementScreenState extends State<DataManagementScreen> {
  final _backupService = BackupService();
  final _pdfService = PdfService();
  bool _isLoading = false;

  Future<void> _handleAction(
    Future<void> Function() action,
    String successMsg,
  ) async {
    setState(() => _isLoading = true);
    try {
      await action();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(successMsg), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Datos y Respaldos"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSectionTitle("COPIA DE SEGURIDAD (BACKUP)"),
                _buildCard(
                  icon: Icons.cloud_upload,
                  color: Colors.blueAccent,
                  title: "Crear Respaldo Encriptado",
                  subtitle:
                      "Genera un archivo .notch cifrado para guardar en Drive/iCloud.",
                  onTap: () => _handleAction(
                    _backupService.createEncryptedBackup,
                    "Backup generado exitosamente",
                  ),
                ),
                _buildCard(
                  icon: Icons.restore_page,
                  color: Colors.orangeAccent,
                  title: "Restaurar Respaldo",
                  subtitle:
                      "Importa un archivo .notch. ⚠️ Sobrescribirá los datos actuales.",
                  onTap: () async {
                    bool success = await _backupService.restoreBackup();
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Datos restaurados correctamente"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Opcional: Reiniciar app o navegar al Home
                    }
                  },
                ),

                const SizedBox(height: 30),

                _buildSectionTitle("EXPORTACIÓN"),
                _buildCard(
                  icon: Icons.picture_as_pdf,
                  color: Colors.redAccent,
                  title: "Generar Reporte PDF",
                  subtitle:
                      "Crea un documento visual con tus estadísticas y registros.",
                  onTap: () =>
                      _handleAction(_pdfService.generateReport, "PDF generado"),
                ),
              ],
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 14,
        ),
        onTap: onTap,
      ),
    );
  }
}
