import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntryRatingField extends StatelessWidget {
  const AddEntryRatingField({
    super.key,
    required this.lastHapticValue,
    required this.onRatingChanged,
  });

  final double lastHapticValue;
  final ValueChanged<double> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return FormBuilderSlider(
      name: 'rating',
      initialValue: 8,
      min: 1,
      max: 10,
      divisions: 9,
      activeColor: scheme.primary,
      inactiveColor: scheme.surfaceContainerHighest,
      decoration: InputDecoration(
        labelText: l10n.rating,
        labelStyle: TextStyle(color: scheme.onSurfaceVariant, fontSize: 18),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        if (value != null && value != lastHapticValue) {
          HapticFeedback.selectionClick();
          onRatingChanged(value);
        }
      },
      valueTransformer: (value) => value?.round(),
    );
  }
}
