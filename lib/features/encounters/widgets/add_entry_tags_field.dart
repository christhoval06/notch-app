import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntryTagsField extends StatelessWidget {
  const AddEntryTagsField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return FormBuilderField<List<String>>(
      name: 'tags',
      initialValue: const [],
      builder: (field) {
        return InputDecorator(
          decoration: InputDecoration(
            border: InputBorder.none,
            errorText: field.errorText,
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: tagKeys.map((key) {
              final currentList = field.value ?? [];
              final isSelected = currentList.contains(key);
              return FilterChip(
                label: Text(tagLabelFromL10n(l10n, key)),
                selected: isSelected,
                backgroundColor: scheme.surface,
                selectedColor: scheme.primary,
                checkmarkColor: scheme.onPrimary,
                labelStyle: TextStyle(
                  color: isSelected
                      ? scheme.onPrimary
                      : scheme.onSurfaceVariant,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : scheme.outlineVariant,
                  ),
                ),
                onSelected: (selected) {
                  final newList = List<String>.from(currentList);
                  HapticFeedback.mediumImpact();
                  if (selected) {
                    newList.add(key);
                  } else {
                    newList.remove(key);
                  }
                  field.didChange(newList);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
