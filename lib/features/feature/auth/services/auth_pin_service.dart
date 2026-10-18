import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notch_app/core/constants/app_constants.dart';
import 'package:notch_app/core/constants/app_secure_keys.dart';

enum AuthPinOutcome { realApp, fakeApp, killSwitch, invalid }

class AuthPinService {
  const AuthPinService._();

  static Future<AuthPinOutcome> checkPin(
    FlutterSecureStorage storage,
    String enteredPin,
  ) async {
    var realPin = await storage.read(key: AppSecureKeys.realPin);
    var fakePin = await storage.read(key: AppSecureKeys.fakePin);
    final killPin = await storage.read(key: AppSecureKeys.killPin);

    if (realPin == null || realPin.isEmpty) realPin = DEFAULT_REAL_PIN;
    if (fakePin == null || fakePin.isEmpty) fakePin = DEFAULT_PANIC_PIN;

    if (enteredPin == realPin) return AuthPinOutcome.realApp;
    if (enteredPin == fakePin) return AuthPinOutcome.fakeApp;
    if (killPin != null && killPin.isNotEmpty && enteredPin == killPin) {
      return AuthPinOutcome.killSwitch;
    }
    return AuthPinOutcome.invalid;
  }
}
