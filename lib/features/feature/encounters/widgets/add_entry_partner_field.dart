import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/features/feature/encounters/services/encounter_partner_suggestions_service.dart';
import 'package:notch_app/features/feature/encounters/widgets/partner_picker_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntryPartnerField extends StatelessWidget {
  const AddEntryPartnerField({
    super.key,
    required this.draftValue,
    required this.onDraftChanged,
  });

  final String draftValue;
  final ValueChanged<String> onDraftChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final suggestions = EncounterPartnerSuggestionsService.build();

    return FormBuilderField<String>(
      name: 'partnerName',
      validator: (value) {
        final current = (value ?? '').trim();
        final draft = draftValue.trim();
        if (current.isEmpty && draft.isEmpty) {
          return l10n.addEntryPartnerRequired;
        }
        return null;
      },
      builder: (field) {
        final scheme = Theme.of(context).colorScheme;
        final currentValue = (field.value ?? draftValue).trim();
        final displayValue = currentValue.isEmpty ? '' : '@$currentValue';

        Future<void> openPicker() async {
          final selected = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FractionallySizedBox(
              heightFactor: 0.88,
              child: PartnerPickerSheet(
                partnerNames: suggestions.partnerNames,
                usageCounts: suggestions.usageCounts,
                initialValue: currentValue,
              ),
            ),
          );
          if (selected == null || selected.trim().isEmpty) return;

          final clean = selected.trim().replaceFirst(RegExp(r'^[@＠]'), '');
          onDraftChanged(clean);
          field.didChange(clean);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: openPicker,
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: scheme.surface,
                  hintText: l10n.addEntryPartnerHint,
                  hintStyle: TextStyle(color: scheme.onSurfaceVariant),
                  errorText: field.errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.14),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '@',
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        displayValue.isEmpty
                            ? l10n.addEntryPartnerHint
                            : displayValue,
                        style: TextStyle(
                          color: displayValue.isEmpty
                              ? scheme.onSurfaceVariant
                              : scheme.onSurface,
                          fontWeight: displayValue.isEmpty
                              ? FontWeight.w400
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    if (displayValue.isNotEmpty)
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: scheme.onSurfaceVariant,
                          size: 18,
                        ),
                        onPressed: () {
                          onDraftChanged('');
                          field.didChange('');
                        },
                      ),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            if (suggestions.quickNames.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestions.quickNames.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final partner = suggestions.quickNames[index];
                    return ActionChip(
                      label: Text('@$partner'),
                      onPressed: () {
                        onDraftChanged(partner);
                        field.didChange(partner);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
