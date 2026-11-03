import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/utils/achievement_copy_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('returns localized copy when id is known and fallback when it is not', () async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(
      AchievementCopyService.localizeName(l10n, 'rookie', 'fallback'),
      isNot('fallback'),
    );
    expect(
      AchievementCopyService.localizeDescription(l10n, 'unknown', 'fallback'),
      'fallback',
    );
  });
}
