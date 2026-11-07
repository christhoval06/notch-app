import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_mood_field.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_orgasm_count_field.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_partner_field.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_protection_switch.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_rating_field.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_section_label.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_submit_button.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_tags_field.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntryForm extends StatelessWidget {
  const AddEntryForm({
    super.key,
    required this.formKey,
    required this.partnerDraftValue,
    required this.lastHapticValue,
    required this.onPartnerDraftChanged,
    required this.onRatingChanged,
    required this.onSubmit,
  });

  final GlobalKey<FormBuilderState> formKey;
  final String partnerDraftValue;
  final double lastHapticValue;
  final ValueChanged<String> onPartnerDraftChanged;
  final ValueChanged<double> onRatingChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddEntrySectionLabel(text: l10n.mood),
          const AddEntryMoodField(),
          const SizedBox(height: 25),
          AddEntrySectionLabel(text: l10n.partner),
          AddEntryPartnerField(
            draftValue: partnerDraftValue,
            onDraftChanged: onPartnerDraftChanged,
          ),
          const SizedBox(height: 25),
          AddEntrySectionLabel(text: l10n.tags),
          const AddEntryTagsField(),
          const SizedBox(height: 25),
          AddEntrySectionLabel(text: l10n.orgasms),
          const AddEntryOrgasmCountField(),
          const SizedBox(height: 25),
          const AddEntryProtectionSwitch(),
          const SizedBox(height: 25),
          AddEntryRatingField(
            lastHapticValue: lastHapticValue,
            onRatingChanged: onRatingChanged,
          ),
          const SizedBox(height: 40),
          AddEntrySubmitButton(onPressed: onSubmit),
        ],
      ),
    );
  }
}
