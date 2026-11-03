import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/core/constants/app_secure_keys.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/features/feature/settings/widgets/security_pin_field.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SecuritySettingsForm extends StatelessWidget {
  const SecuritySettingsForm({
    super.key,
    required this.formKey,
    required this.initialValues,
    required this.onSave,
  });

  final GlobalKey<FormBuilderState> formKey;
  final Map<String, dynamic> initialValues;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: FormBuilder(
        key: formKey,
        initialValue: initialValues,
        child: Column(
          children: [
            Text(
              l10n.securityConfigureKeys,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 30),
            SecurityPinField(
              name: AppSecureKeys.realPin,
              title: l10n.securityRealPinTitle,
              description: l10n.securityRealPinDesc,
              color: scheme.primary,
              icon: Icons.vpn_key,
            ),
            const SizedBox(height: 20),
            SecurityPinField(
              name: AppSecureKeys.fakePin,
              title: l10n.securityPanicPinTitle,
              description: l10n.securityPanicPinDesc,
              color: scheme.warning,
              icon: Icons.masks,
            ),
            const SizedBox(height: 20),
            SecurityPinField(
              name: AppSecureKeys.killPin,
              title: l10n.securityKillSwitchTitle,
              description: l10n.securityKillSwitchDesc,
              color: scheme.error,
              icon: Icons.delete_forever,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  l10n.securitySaveConfig,
                  style: TextStyle(color: scheme.onPrimary, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
