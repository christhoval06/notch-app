import 'package:flutter/foundation.dart';

enum AppAccess { locked, real, decoy }

class AppAccessSession extends ValueNotifier<AppAccess> {
  AppAccessSession() : super(AppAccess.locked);
  static final instance = AppAccessSession();
  bool get canImport => value == AppAccess.real;
  void unlockReal() => value = AppAccess.real;
  void enterDecoy() => value = AppAccess.decoy;
  void lock() => value = AppAccess.locked;
}
