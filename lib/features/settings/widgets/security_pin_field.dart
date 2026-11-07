import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/features/auth/widgets/pin_selection_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SecurityPinField extends StatelessWidget {
  const SecurityPinField({
    super.key,
    required this.name,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  final String name;
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FormBuilderField<String>(
      name: name,
      builder: (field) {
        final isEmpty = field.value == null || field.value!.isEmpty;
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {
            final newPin = await showModalBottomSheet<String>(
              context: context,
              isScrollControlled: true,
              builder: (sheetContext) => PinSelectionSheet(
                title: AppLocalizations.of(
                  sheetContext,
                ).securityConfigurePin(title),
                color: color,
              ),
            );
            if (newPin != null) field.didChange(newPin);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: field.hasError ? scheme.error : scheme.outlineVariant,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isEmpty)
                  Text(
                    AppLocalizations.of(context).securityNotSet,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  )
                else
                  Row(
                    children: List.generate(
                      4,
                      (_) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color: scheme.onSurfaceVariant,
                  size: 14,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
