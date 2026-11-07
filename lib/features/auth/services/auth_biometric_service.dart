import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class AuthBiometricService {
  const AuthBiometricService._();

  static Future<bool> canCheckBiometrics(LocalAuthentication auth) async {
    try {
      return await auth.canCheckBiometrics;
    } catch (error) {
      debugPrint('AuthBiometricService.canCheckBiometrics failed: $error');
      return false;
    }
  }

  static Future<bool> authenticate(
    LocalAuthentication auth, {
    required String localizedReason,
  }) async {
    return auth.authenticate(
      localizedReason: localizedReason,
      biometricOnly: true,
    );
  }
}
