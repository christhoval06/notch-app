import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/features/feature/settings/widgets/data_management_action_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class DataManagementContent extends StatelessWidget {
  const DataManagementContent({
    super.key,
    required this.isLoading,
    required this.onCreateBackup,
    required this.onRestoreBackup,
    required this.onGeneratePdf,
  });

  final bool isLoading;
  final Future<void> Function() onCreateBackup;
  final Future<void> Function() onRestoreBackup;
  final Future<void> Function() onGeneratePdf;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _SectionTitle(title: l10n.dataBackupSection),
        DataManagementActionCard(
          icon: Icons.cloud_upload,
          color: scheme.primary,
          title: l10n.dataCreateBackup,
          subtitle: l10n.dataCreateBackupSubtitle,
          onTap: onCreateBackup,
        ),
        DataManagementActionCard(
          icon: Icons.restore_page,
          color: scheme.warning,
          title: l10n.dataRestoreBackup,
          subtitle: l10n.dataRestoreBackupSubtitle,
          onTap: onRestoreBackup,
        ),
        const SizedBox(height: 30),
        _SectionTitle(title: l10n.dataExportSection),
        DataManagementActionCard(
          icon: Icons.picture_as_pdf,
          color: scheme.error,
          title: l10n.dataGeneratePdf,
          subtitle: l10n.dataGeneratePdfSubtitle,
          onTap: onGeneratePdf,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
}
