import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/feature/settings/services/backup_service.dart';
import 'package:notch_app/features/feature/settings/services/pdf_service.dart';
import 'package:notch_app/features/feature/settings/widgets/data_management_content.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class DataManagementView extends StatefulWidget {
  const DataManagementView({super.key});

  @override
  State<DataManagementView> createState() => _DataManagementViewState();
}

class _DataManagementViewState extends State<DataManagementView> {
  final _backupService = BackupService();
  final _pdfService = PdfService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.dataTitle),
      ),
      body: DataManagementContent(
        isLoading: _isLoading,
        onCreateBackup: _createBackup,
        onRestoreBackup: _restoreBackup,
        onGeneratePdf: _generatePdf,
      ),
    );
  }

  Future<void> _createBackup() async {
    final l10n = AppLocalizations.of(context);
    await _runAction(
      action: _backupService.createEncryptedBackup,
      successMessage: l10n.dataBackupSuccess,
      achievementEvent: AchievementEvent.backupCreated,
    );
  }

  Future<void> _restoreBackup() async {
    await _runAction(
      action: () async {
        final restored = await _backupService.restoreBackup();
        if (restored) {
          await AchievementEngine.recalculateAllAchievements();
        }
        return restored;
      },
      successMessage: AppLocalizations.of(context).dataRestoreSuccess,
    );
  }

  Future<void> _generatePdf() async {
    await _runAction(
      action: _pdfService.generateReport,
      successMessage: AppLocalizations.of(context).dataPdfSuccess,
    );
  }

  Future<void> _runAction({
    required Future<dynamic> Function() action,
    required String successMessage,
    AchievementEvent? achievementEvent,
  }) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final scheme = Theme.of(context).colorScheme;
    setState(() => _isLoading = true);
    try {
      final result = await action();
      if (!mounted || result == false) return;
      var message = successMessage;
      if (achievementEvent != null) {
        message = await _appendAchievementMessage(message, achievementEvent);
      }
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(message), backgroundColor: scheme.success),
      );
    } catch (error) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.dataError(error.toString())),
          backgroundColor: scheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<String> _appendAchievementMessage(
    String message,
    AchievementEvent event,
  ) async {
    final l10n = AppLocalizations.of(context);
    final unlocked = await AchievementEngine.processEvent(event: event);
    if (!mounted || unlocked.isEmpty) return message;
    final achievementName = localizeAchievementName(
      l10n,
      unlocked.first.id,
      unlocked.first.name,
    );
    return '$message 🏆 ${l10n.dataAchievementUnlocked(achievementName)}';
  }
}
