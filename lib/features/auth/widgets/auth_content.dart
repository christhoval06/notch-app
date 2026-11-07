import 'package:flutter/material.dart';
import 'package:notch_app/features/auth/widgets/pin_pad.dart';

class AuthContent extends StatelessWidget {
  const AuthContent({
    super.key,
    required this.enteredPinLength,
    required this.canCheckBiometrics,
    required this.biometricLabel,
    required this.onDigitPress,
    required this.onDeletePress,
    required this.onBiometricPressed,
  });

  final int enteredPinLength;
  final bool canCheckBiometrics;
  final String biometricLabel;
  final ValueChanged<String> onDigitPress;
  final VoidCallback onDeletePress;
  final VoidCallback onBiometricPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(Icons.lock_outline, size: 60, color: scheme.onSurfaceVariant),
            const SizedBox(height: 20),
            PinDots(length: enteredPinLength, activeColor: scheme.primary),
            const Spacer(),
            Numpad(onDigitPress: onDigitPress, onDeletePress: onDeletePress),
            const SizedBox(height: 20),
            if (canCheckBiometrics)
              TextButton.icon(
                onPressed: onBiometricPressed,
                icon: Icon(Icons.fingerprint, color: scheme.primary),
                label: Text(
                  biometricLabel,
                  style: TextStyle(color: scheme.primary),
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
