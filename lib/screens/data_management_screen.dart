import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/services/achievement_engine.dart';
import 'package:notch_app/theme/color_scheme_semantics.dart';
import 'package:notch_app/utils/achievement_localization.dart';
import 'package:notch_app/utils/gamification_engine.dart';
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
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    setState(() => _isLoading = true);
    try {
      await action();

      if (action == _backupService.createEncryptedBackup) {
        final unlocked = await AchievementEngine.processEvent(
          event: AchievementEvent.backupCreated,
        );
        if (unlocked.isNotEmpty) {
          successMsg +=
              " 🏆 ${l10n.dataAchievementUnlocked(localizeAchievementName(l10n, unlocked.first.id, unlocked.first.name))}";
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMsg),
            backgroundColor: scheme.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.dataError(e.toString())),
            backgroundColor: scheme.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.dataTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSectionTitle(l10n.dataBackupSection),
                _buildCard(
                  icon: Icons.cloud_upload,
                  color: scheme.primary,
                  title: l10n.dataCreateBackup,
                  subtitle: l10n.dataCreateBackupSubtitle,
                  onTap: () => _handleAction(
                    _backupService.createEncryptedBackup,
                    l10n.dataBackupSuccess,
                  ),
                ),
                _buildCard(
                  icon: Icons.restore_page,
                  color: scheme.warning,
                  title: l10n.dataRestoreBackup,
                  subtitle: l10n.dataRestoreBackupSubtitle,
                  onTap: () async {
                    bool success = await _backupService.restoreBackup();
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.dataRestoreSuccess),
                          backgroundColor: scheme.success,
                        ),
                      );
                      // Opcional: Reiniciar app o navegar al Home
                    }
                  },
                ),

                const SizedBox(height: 30),

                _buildSectionTitle(l10n.dataExportSection),
                _buildCard(
                  icon: Icons.picture_as_pdf,
                  color: scheme.error,
                  title: l10n.dataGeneratePdf,
                  subtitle: l10n.dataGeneratePdfSubtitle,
                  onTap: () => _handleAction(
                    _pdfService.generateReport,
                    l10n.dataPdfSuccess,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        title,
        style: TextStyle(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
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
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.surface,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: scheme.onSurfaceVariant,
          size: 14,
        ),
        onTap: onTap,
      ),
    );
  }
}
