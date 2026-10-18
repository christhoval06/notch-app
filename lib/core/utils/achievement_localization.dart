import 'package:notch_app/core/utils/achievement_copy_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

String localizeAchievementName(
  AppLocalizations l10n,
  String id,
  String fallback,
) {
  return AchievementCopyService.localizeName(l10n, id, fallback);
}

String localizeAchievementDescription(
  AppLocalizations l10n,
  String id,
  String fallback,
) {
  return AchievementCopyService.localizeDescription(l10n, id, fallback);
}
