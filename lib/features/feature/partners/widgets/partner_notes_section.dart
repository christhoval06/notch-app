import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerNotesSection extends StatelessWidget {
  const PartnerNotesSection({
    super.key,
    required this.controller,
    required this.isEditing,
    required this.notes,
    required this.onToggle,
  });

  final TextEditingController controller;
  final bool isEditing;
  final String? notes;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.partnerPrivateNotes,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  isEditing ? Icons.check_circle : Icons.edit,
                  color: scheme.primary,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
          if (isEditing)
            TextField(
              controller: controller,
              style: TextStyle(color: scheme.onSurface),
              maxLines: 5,
              autofocus: true,
              decoration: InputDecoration(
                hintText: l10n.partnerNotesHint,
                hintStyle: TextStyle(color: scheme.onSurfaceVariant),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: scheme.surface,
              ),
            )
          else
            Text(
              (notes == null || notes!.isEmpty)
                  ? l10n.partnerNotesTapToAdd
                  : notes!,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 16,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}
