import 'package:notch_app/core/constants/app_prefs.dart';
import 'package:notch_app/features/gamification/services/challenge_category_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChallengeUiPreferences {
  const ChallengeUiPreferences({
    required this.selectedCategory,
    required this.collapsedCategories,
  });

  final ChallengeCategory? selectedCategory;
  final Set<ChallengeCategory> collapsedCategories;
}

class ChallengeUiPreferencesService {
  const ChallengeUiPreferencesService._();

  static Future<ChallengeUiPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedName = prefs.getString(AppPrefs.challengeCategoryFilter);
    final collapsedNames =
        prefs.getStringList(AppPrefs.challengeCollapsedCategories) ?? const [];
    return ChallengeUiPreferences(
      selectedCategory: _fromName(selectedName),
      collapsedCategories: collapsedNames
          .map(_fromName)
          .whereType<ChallengeCategory>()
          .toSet(),
    );
  }

  static Future<void> save({
    required ChallengeCategory? selectedCategory,
    required Set<ChallengeCategory> collapsedCategories,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (selectedCategory == null) {
      await prefs.remove(AppPrefs.challengeCategoryFilter);
    } else {
      await prefs.setString(
        AppPrefs.challengeCategoryFilter,
        selectedCategory.name,
      );
    }
    await prefs.setStringList(
      AppPrefs.challengeCollapsedCategories,
      collapsedCategories.map((category) => category.name).toList(),
    );
  }

  static ChallengeCategory? _fromName(String? value) {
    for (final category in ChallengeCategory.values) {
      if (category.name == value) return category;
    }
    return null;
  }
}
