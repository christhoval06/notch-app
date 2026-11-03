import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/features/landing/models/landing_feature.dart';
import 'package:notch_app/l10n/app_localizations.dart';

abstract final class LandingContentService {
  static List<LandingFeature> features(AppLocalizations l) => [
    LandingFeature(
      label: l.landingModuleOne,
      title: l.landingLoggerTitle,
      body: l.landingLoggerBody,
      points: [l.landingLoggerPointOne, l.landingLoggerPointTwo],
      screens: [LandingConfig.loggerScreen, LandingConfig.loggerDetailsScreen],
    ),
    LandingFeature(
      label: l.landingModuleTwo,
      title: l.landingStatsTitle,
      body: l.landingStatsBody,
      points: [l.landingStatsPointOne, l.landingStatsPointTwo],
      screens: [LandingConfig.heatmapScreen, LandingConfig.insightScreen],
    ),
    LandingFeature(
      label: l.landingModuleThree,
      title: l.landingBookTitle,
      body: l.landingBookBody,
      points: [l.landingBookPointOne, l.landingBookPointTwo],
      screens: [LandingConfig.bookScreen, LandingConfig.protectionScreen],
    ),
    LandingFeature(
      label: l.landingModuleFour,
      title: l.landingTrophyTitle,
      body: l.landingTrophyBody,
      points: [l.landingTrophyPointOne, l.landingTrophyPointTwo],
      screens: [LandingConfig.trophyScreen, LandingConfig.badgeScreen],
    ),
  ];

  static List<(String, String)> questions(AppLocalizations l) => [
    (l.landingFaqOne, l.landingAnswerOne),
    (l.landingFaqTwo, l.landingAnswerTwo),
    (l.landingFaqThree, l.landingAnswerThree),
    (l.landingFaqFour, l.landingAnswerFour),
    (l.landingFaqFive, l.landingAnswerFive),
  ];

  static List<(String, String, String)> comparisons(AppLocalizations l) => [
    (l.landingStorage, l.landingStorageLocal, l.landingStorageRemote),
    (l.landingAccount, l.landingAccountLocal, l.landingAccountRemote),
    (l.landingTracking, l.landingTrackingLocal, l.landingTrackingRemote),
    (l.landingBusiness, l.landingBusinessLocal, l.landingBusinessRemote),
  ];
}
