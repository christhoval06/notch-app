import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddEntryOrgasmCountField extends StatelessWidget {
  const AddEntryOrgasmCountField({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FormBuilderField<int>(
      name: 'orgasmCount',
      initialValue: 1,
      builder: (field) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _RoundButton(
              icon: Icons.remove,
              onPressed: () {
                HapticFeedback.lightImpact();
                if ((field.value ?? 0) > 0) {
                  field.didChange((field.value ?? 0) - 1);
                }
              },
            ),
            Text(
              '${field.value}',
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            _RoundButton(
              icon: Icons.add,
              onPressed: () {
                HapticFeedback.lightImpact();
                field.didChange((field.value ?? 0) + 1);
              },
            ),
          ],
        );
      },
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.surfaceContainerHighest,
      ),
      child: IconButton(
        icon: Icon(icon, color: scheme.onSurface),
        onPressed: onPressed,
      ),
    );
  }
}
