import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleController {
  AppLocaleController._();

  static const String _prefKey = 'app_language';
  static final AppLocaleController instance = AppLocaleController._();

  final ValueNotifier<Locale> localeNotifier = ValueNotifier(
    const Locale('es'),
  );

  Locale get locale => localeNotifier.value;
  String get languageCode => locale.languageCode;

  Future<void> init(SharedPreferences prefs) async {
    final String? saved = prefs.getString(_prefKey);
    final String normalized = _normalizeLanguageCode(
      saved ?? PlatformDispatcher.instance.locale.languageCode,
    );
    localeNotifier.value = Locale(normalized);
  }

  Future<void> setLanguageCode(String languageCode) async {
    final String normalized = _normalizeLanguageCode(languageCode);
    if (normalized == this.languageCode) {
      return;
    }

    localeNotifier.value = Locale(normalized);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, normalized);
  }

  String _normalizeLanguageCode(String code) {
    switch (code.toLowerCase()) {
      case 'en':
      case 'es':
        return code.toLowerCase();
      default:
        return 'es';
    }
  }
}
