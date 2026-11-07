import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notch_app/core/constants/app_secure_keys.dart';
import 'package:notch_app/features/settings/widgets/security_settings_form.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _storage = const FlutterSecureStorage();
  bool _isLoading = true;
  Map<String, dynamic> _initialValues = {};

  @override
  void initState() {
    super.initState();
    _loadPins();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.securityTitle),
      ),
      body: SecuritySettingsForm(
        formKey: _formKey,
        initialValues: _initialValues,
        onSave: _saveForm,
      ),
    );
  }

  Future<void> _loadPins() async {
    final real = await _storage.read(key: AppSecureKeys.realPin);
    final fake = await _storage.read(key: AppSecureKeys.fakePin);
    final kill = await _storage.read(key: AppSecureKeys.killPin);
    if (!mounted) return;

    setState(() {
      _initialValues = {
        AppSecureKeys.realPin: real ?? '',
        AppSecureKeys.fakePin: fake ?? '',
        AppSecureKeys.killPin: kill ?? '',
      };
      _isLoading = false;
    });
  }

  Future<void> _saveForm() async {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

    final values = _formKey.currentState!.value;
    await _storage.write(
      key: AppSecureKeys.realPin,
      value: values[AppSecureKeys.realPin],
    );
    await _storage.write(
      key: AppSecureKeys.fakePin,
      value: values[AppSecureKeys.fakePin],
    );
    await _storage.write(
      key: AppSecureKeys.killPin,
      value: values[AppSecureKeys.killPin],
    );
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.securityUpdated),
        backgroundColor: scheme.primary,
      ),
    );
  }
}
