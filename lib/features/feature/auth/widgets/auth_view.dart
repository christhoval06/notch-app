import 'package:notch_app/core/session/app_access_session.dart';
import 'package:notch_app/features/feature/auth/presentation/auth_kill_switch_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:notch_app/features/feature/auth/services/auth_biometric_service.dart';
import 'package:notch_app/features/feature/auth/services/auth_pin_service.dart';
import 'package:notch_app/features/feature/auth/widgets/auth_content.dart';
import 'package:notch_app/features/feature/home/presentation/pages/fake_home_page.dart';
import 'package:notch_app/features/feature/home/presentation/pages/home_page.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _auth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();
  var _enteredPin = '';
  var _canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    final available = await AuthBiometricService.canCheckBiometrics(_auth);
    if (mounted) setState(() => _canCheckBiometrics = available);
  }

  Future<void> _authenticateBiometric() async {
    final l10n = AppLocalizations.of(context);
    try {
      final authenticated = await AuthBiometricService.authenticate(
        _auth,
        localizedReason: l10n.authReason,
      );
      if (authenticated) _navigateToRealApp();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authBiometricError(error.toString()))),
      );
    }
  }

  Future<void> _checkPin() async {
    final l10n = AppLocalizations.of(context);
    final outcome = await AuthPinService.checkPin(_storage, _enteredPin);
    if (!mounted) return;
    switch (outcome) {
      case AuthPinOutcome.realApp:
        HapticFeedback.heavyImpact();
        _navigateToRealApp();
      case AuthPinOutcome.fakeApp:
        HapticFeedback.heavyImpact();
        _navigateToFakeApp();
      case AuthPinOutcome.killSwitch:
        await _executeKillSwitch();
      case AuthPinOutcome.invalid:
        HapticFeedback.vibrate();
        setState(() => _enteredPin = '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.authIncorrectCode)));
    }
  }

  void _navigateToRealApp() {
    AppAccessSession.instance.unlockReal();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  void _navigateToFakeApp() {
    AppAccessSession.instance.enterDecoy();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => FakeHomeScreen()),
    );
  }

  Future<void> _executeKillSwitch() async {
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    HapticFeedback.heavyImpact();
    if (!await performAuthKillSwitch(context, _storage)) return;
    if (!mounted) return;
    setState(() => _enteredPin = '');
    showAuthKillSwitchFeedback(context);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
  }

  void _onDigitPress(String digit) {
    if (_enteredPin.length >= 4) return;
    setState(() => _enteredPin += digit);
    if (_enteredPin.length == 4) {
      HapticFeedback.mediumImpact();
      Future.delayed(const Duration(milliseconds: 200), _checkPin);
    }
  }

  void _onDeletePress() {
    if (_enteredPin.isEmpty) return;
    setState(() {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthContent(
      enteredPinLength: _enteredPin.length,
      canCheckBiometrics: _canCheckBiometrics,
      biometricLabel: l10n.authBiometricButton,
      onDigitPress: _onDigitPress,
      onDeletePress: _onDeletePress,
      onBiometricPressed: () {
        HapticFeedback.mediumImpact();
        _authenticateBiometric();
      },
    );
  }
}
