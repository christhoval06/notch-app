import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/core/constants/app_prefs.dart';

class OnboardingCompletionService {
  const OnboardingCompletionService._();

  static Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppPrefs.onboardingCompleted, true);
  }
}
