import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to NOTCH'**
  String get welcome;

  /// No description provided for @authReason.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to access your logs'**
  String get authReason;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save Notch'**
  String get save;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @partner.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get partner;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @orgasms.
  ///
  /// In en, this message translates to:
  /// **'Orgasms'**
  String get orgasms;

  /// No description provided for @usedProtection.
  ///
  /// In en, this message translates to:
  /// **'Used Protection'**
  String get usedProtection;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @safe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get safe;

  /// No description provided for @unsafe.
  ///
  /// In en, this message translates to:
  /// **'Unsafe'**
  String get unsafe;

  /// No description provided for @tagMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning Wood'**
  String get tagMorning;

  /// No description provided for @tagQuickie.
  ///
  /// In en, this message translates to:
  /// **'Quickie'**
  String get tagQuickie;

  /// No description provided for @tagOral.
  ///
  /// In en, this message translates to:
  /// **'Oral'**
  String get tagOral;

  /// No description provided for @tagAnal.
  ///
  /// In en, this message translates to:
  /// **'Anal'**
  String get tagAnal;

  /// No description provided for @tagToys.
  ///
  /// In en, this message translates to:
  /// **'Toys'**
  String get tagToys;

  /// No description provided for @tagDate.
  ///
  /// In en, this message translates to:
  /// **'Date Night'**
  String get tagDate;

  /// No description provided for @tagTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get tagTravel;

  /// No description provided for @tagKinky.
  ///
  /// In en, this message translates to:
  /// **'Kinky'**
  String get tagKinky;

  /// No description provided for @tagOutdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get tagOutdoor;

  /// No description provided for @tagAnniversary.
  ///
  /// In en, this message translates to:
  /// **'Anniversary'**
  String get tagAnniversary;

  /// No description provided for @tagOns.
  ///
  /// In en, this message translates to:
  /// **'One-Night Stand'**
  String get tagOns;

  /// No description provided for @tagFwb.
  ///
  /// In en, this message translates to:
  /// **'Friends w/ Benefits'**
  String get tagFwb;

  /// No description provided for @tagReconciliation.
  ///
  /// In en, this message translates to:
  /// **'Make-up Sex'**
  String get tagReconciliation;

  /// No description provided for @tagCelebration.
  ///
  /// In en, this message translates to:
  /// **'Celebration'**
  String get tagCelebration;

  /// No description provided for @tagVanilla.
  ///
  /// In en, this message translates to:
  /// **'Vanilla'**
  String get tagVanilla;

  /// No description provided for @tagDomsub.
  ///
  /// In en, this message translates to:
  /// **'Dom/Sub'**
  String get tagDomsub;

  /// No description provided for @tagMassage.
  ///
  /// In en, this message translates to:
  /// **'Erotic Massage'**
  String get tagMassage;

  /// No description provided for @tagCar.
  ///
  /// In en, this message translates to:
  /// **'Car Sex'**
  String get tagCar;

  /// No description provided for @tagHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get tagHotel;

  /// No description provided for @tagShower.
  ///
  /// In en, this message translates to:
  /// **'Shower / Bath'**
  String get tagShower;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Intelligence'**
  String get insightsTitle;

  /// No description provided for @insightsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Not enough data to generate insights yet.\\nKeep logging!'**
  String get insightsEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTagline.
  ///
  /// In en, this message translates to:
  /// **'Private Intimacy Tracker'**
  String get settingsTagline;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get settingsGeneral;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get settingsAbout;

  /// No description provided for @settingsDangerZone.
  ///
  /// In en, this message translates to:
  /// **'DANGER ZONE'**
  String get settingsDangerZone;

  /// No description provided for @settingsMaintenance.
  ///
  /// In en, this message translates to:
  /// **'MAINTENANCE'**
  String get settingsMaintenance;

  /// No description provided for @settingsSecurityAccess.
  ///
  /// In en, this message translates to:
  /// **'Security & Access'**
  String get settingsSecurityAccess;

  /// No description provided for @settingsSecurityAccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure PIN, Panic and Kill Switch'**
  String get settingsSecurityAccessSubtitle;

  /// No description provided for @settingsDataBackup.
  ///
  /// In en, this message translates to:
  /// **'Data & Backup'**
  String get settingsDataBackup;

  /// No description provided for @settingsDataBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backups and PDF export'**
  String get settingsDataBackupSubtitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsDeveloper;

  /// No description provided for @settingsDeveloperSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Built with privacy in mind'**
  String get settingsDeveloperSubtitle;

  /// No description provided for @settingsAboutDevTitle.
  ///
  /// In en, this message translates to:
  /// **'About the Dev'**
  String get settingsAboutDevTitle;

  /// No description provided for @settingsAboutDevDescription.
  ///
  /// In en, this message translates to:
  /// **'Hi, I\'m @christhoval. I built NOTCH for private and secure sexual activity tracking. I believe intimate data should stay private, so this app has no servers, no trackers, and you are the only owner of your information.'**
  String get settingsAboutDevDescription;

  /// No description provided for @settingsContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact / Support'**
  String get settingsContactSupport;

  /// No description provided for @settingsContactSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report bugs or suggest ideas'**
  String get settingsContactSupportSubtitle;

  /// No description provided for @settingsResetApp.
  ///
  /// In en, this message translates to:
  /// **'Reset App'**
  String get settingsResetApp;

  /// No description provided for @settingsResetAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data and restart'**
  String get settingsResetAppSubtitle;

  /// No description provided for @settingsRecalculateAchievements.
  ///
  /// In en, this message translates to:
  /// **'Recalculate Achievements'**
  String get settingsRecalculateAchievements;

  /// No description provided for @settingsRecalculateAchievementsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Refresh your medals if you think one is missing.'**
  String get settingsRecalculateAchievementsSubtitle;

  /// No description provided for @settingsAchievementsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Achievements updated successfully.'**
  String get settingsAchievementsUpdated;

  /// No description provided for @settingsRecalculateXp.
  ///
  /// In en, this message translates to:
  /// **'Recalculate Experience (XP)'**
  String get settingsRecalculateXp;

  /// No description provided for @settingsRecalculateXpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sync your level with your encounter history.'**
  String get settingsRecalculateXpSubtitle;

  /// No description provided for @settingsXpUpdated.
  ///
  /// In en, this message translates to:
  /// **'Experience (XP) updated successfully.'**
  String get settingsXpUpdated;

  /// No description provided for @settingsMadeWithFlutter.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ & Flutter'**
  String get settingsMadeWithFlutter;

  /// No description provided for @settingsLanguageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Language updated'**
  String get settingsLanguageUpdated;

  /// No description provided for @settingsCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open {url}'**
  String settingsCouldNotOpen(Object url);

  /// No description provided for @settingsFactoryResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset?'**
  String get settingsFactoryResetTitle;

  /// No description provided for @settingsFactoryResetMessage.
  ///
  /// In en, this message translates to:
  /// **'This action will delete ALL your logs, partners, progress and security settings. It cannot be undone.'**
  String get settingsFactoryResetMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'DELETE ALL'**
  String get deleteAll;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Absolute Privacy. Zero Compromises.'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Description.
  ///
  /// In en, this message translates to:
  /// **'What happens in NOTCH stays in NOTCH. All your records are encrypted and stored only on your device. We don\'t use servers. Your intimate life is yours alone.'**
  String get onboardingSlide1Description;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'Understand Your Patterns. Improve Your Well-being.'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Description.
  ///
  /// In en, this message translates to:
  /// **'Track your encounters to discover insights about your frequency, satisfaction and habits. NOTCH is your personal tool to better understand your sexual health.'**
  String get onboardingSlide2Description;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In en, this message translates to:
  /// **'Measure Your Progress. Celebrate Milestones.'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Description.
  ///
  /// In en, this message translates to:
  /// **'Set goals, monitor streaks and follow your \'Path of Mastery\'. Gamification is designed to motivate you to be more aware and consistent with your well-being.'**
  String get onboardingSlide3Description;

  /// No description provided for @onboardingGoToApp.
  ///
  /// In en, this message translates to:
  /// **'Got it, go to app'**
  String get onboardingGoToApp;

  /// No description provided for @onboardingPinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Access Keys'**
  String get onboardingPinsTitle;

  /// No description provided for @onboardingPinsDescription.
  ///
  /// In en, this message translates to:
  /// **'These are your default PINs. Memorize them and change them in Settings as soon as possible!'**
  String get onboardingPinsDescription;

  /// No description provided for @onboardingRealPin.
  ///
  /// In en, this message translates to:
  /// **'REAL PIN'**
  String get onboardingRealPin;

  /// No description provided for @onboardingRealPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To access NOTCH.'**
  String get onboardingRealPinSubtitle;

  /// No description provided for @onboardingPanicPin.
  ///
  /// In en, this message translates to:
  /// **'PANIC PIN'**
  String get onboardingPanicPin;

  /// No description provided for @onboardingPanicPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To open the fake app (tasks).'**
  String get onboardingPanicPinSubtitle;

  /// No description provided for @statsNoData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get statsNoData;

  /// No description provided for @statsPeriod30Days.
  ///
  /// In en, this message translates to:
  /// **'30 Days'**
  String get statsPeriod30Days;

  /// No description provided for @statsPeriod6Months.
  ///
  /// In en, this message translates to:
  /// **'6 Months'**
  String get statsPeriod6Months;

  /// No description provided for @statsPeriodTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statsPeriodTotal;

  /// No description provided for @statsHighestRankReached.
  ///
  /// In en, this message translates to:
  /// **'HIGHEST RANK REACHED'**
  String get statsHighestRankReached;

  /// No description provided for @statsXpTotal.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP total'**
  String statsXpTotal(Object xp);

  /// No description provided for @statsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statsTotal;

  /// No description provided for @statsAvgRating.
  ///
  /// In en, this message translates to:
  /// **'Avg Rating'**
  String get statsAvgRating;

  /// No description provided for @statsActivityDistribution.
  ///
  /// In en, this message translates to:
  /// **'Activity Distribution'**
  String get statsActivityDistribution;

  /// No description provided for @statsActivityLast6Months.
  ///
  /// In en, this message translates to:
  /// **'Activity (Last 6 Months)'**
  String get statsActivityLast6Months;

  /// No description provided for @statsAnnualActivityMap.
  ///
  /// In en, this message translates to:
  /// **'Annual Activity Map'**
  String get statsAnnualActivityMap;

  /// No description provided for @statsHeatmapSnackBar.
  ///
  /// In en, this message translates to:
  /// **'{date}: {count} encounters'**
  String statsHeatmapSnackBar(Object date, Object count);

  /// No description provided for @statsQualityBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Quality Breakdown'**
  String get statsQualityBreakdown;

  /// No description provided for @statsLegendary.
  ///
  /// In en, this message translates to:
  /// **'Legendary (9-10)'**
  String get statsLegendary;

  /// No description provided for @statsGood.
  ///
  /// In en, this message translates to:
  /// **'Good (7-8)'**
  String get statsGood;

  /// No description provided for @statsAverage.
  ///
  /// In en, this message translates to:
  /// **'Average (5-6)'**
  String get statsAverage;

  /// No description provided for @statsBad.
  ///
  /// In en, this message translates to:
  /// **'Bad (1-4)'**
  String get statsBad;

  /// No description provided for @statsNoTagData.
  ///
  /// In en, this message translates to:
  /// **'No tag data'**
  String get statsNoTagData;

  /// No description provided for @statsNoDescription.
  ///
  /// In en, this message translates to:
  /// **'No description.'**
  String get statsNoDescription;

  /// No description provided for @calendarNoActivity.
  ///
  /// In en, this message translates to:
  /// **'No activity this day.'**
  String get calendarNoActivity;

  /// No description provided for @calendarConfirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get calendarConfirmDeleteTitle;

  /// No description provided for @calendarConfirmDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action will also adjust your XP and progress. Are you sure?'**
  String get calendarConfirmDeleteMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @authBiometricError.
  ///
  /// In en, this message translates to:
  /// **'Biometric error: {error}'**
  String authBiometricError(Object error);

  /// No description provided for @authIncorrectCode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code'**
  String get authIncorrectCode;

  /// No description provided for @authKillSwitchExecuted.
  ///
  /// In en, this message translates to:
  /// **'⚠️ PROTOCOL EXECUTED. DATA DELETED.'**
  String get authKillSwitchExecuted;

  /// No description provided for @authBiometricButton.
  ///
  /// In en, this message translates to:
  /// **'Biometrics / FaceID'**
  String get authBiometricButton;

  /// No description provided for @insightAverageSatisfactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Average Satisfaction'**
  String get insightAverageSatisfactionTitle;

  /// No description provided for @insightAverageSatisfactionDescription.
  ///
  /// In en, this message translates to:
  /// **'Your average rating across all encounters is {avg} out of 10.'**
  String insightAverageSatisfactionDescription(Object avg);

  /// No description provided for @insightWeeklyFrequencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Frequency'**
  String get insightWeeklyFrequencyTitle;

  /// No description provided for @insightWeeklyFrequencyDescription.
  ///
  /// In en, this message translates to:
  /// **'On average, you log {freq} encounters per week.'**
  String insightWeeklyFrequencyDescription(Object freq);

  /// No description provided for @insightBestChemistryTitle.
  ///
  /// In en, this message translates to:
  /// **'Best Chemistry'**
  String get insightBestChemistryTitle;

  /// No description provided for @insightBestChemistryDescription.
  ///
  /// In en, this message translates to:
  /// **'Your encounters with \'{partner}\' have the highest average rating ({avg}/10).'**
  String insightBestChemistryDescription(Object partner, Object avg);

  /// No description provided for @insightDatesMatterTitle.
  ///
  /// In en, this message translates to:
  /// **'Dates Matter'**
  String get insightDatesMatterTitle;

  /// No description provided for @insightDatesMatterDescription.
  ///
  /// In en, this message translates to:
  /// **'Your average rating is {diff}% {trend} in encounters tagged \'{tagA}\' compared with \'{tagB}\'.'**
  String insightDatesMatterDescription(
    Object diff,
    Object trend,
    Object tagA,
    Object tagB,
  );

  /// No description provided for @insightHigher.
  ///
  /// In en, this message translates to:
  /// **'higher'**
  String get insightHigher;

  /// No description provided for @insightLower.
  ///
  /// In en, this message translates to:
  /// **'lower'**
  String get insightLower;

  /// No description provided for @insightRhythmChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Rhythm Change'**
  String get insightRhythmChangeTitle;

  /// No description provided for @insightRhythmChangeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your activity frequency has {direction} by {percent}% this month compared with last month.'**
  String insightRhythmChangeDescription(Object direction, Object percent);

  /// No description provided for @insightIncreased.
  ///
  /// In en, this message translates to:
  /// **'increased'**
  String get insightIncreased;

  /// No description provided for @insightDecreased.
  ///
  /// In en, this message translates to:
  /// **'decreased'**
  String get insightDecreased;

  /// No description provided for @insightHealthCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Check Suggested'**
  String get insightHealthCheckTitle;

  /// No description provided for @insightHealthCheckDescription.
  ///
  /// In en, this message translates to:
  /// **'It has been over 6 months since your last Health Passport log. Consider scheduling one.'**
  String get insightHealthCheckDescription;

  /// No description provided for @insightInTheZoneTitle.
  ///
  /// In en, this message translates to:
  /// **'In the Zone!'**
  String get insightInTheZoneTitle;

  /// No description provided for @insightInTheZoneDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'re on a streak of {streak} encounters rated as \'Good\' or \'Legendary\' (8+). Keep it going!'**
  String insightInTheZoneDescription(Object streak);

  /// No description provided for @insightDayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get insightDayMonday;

  /// No description provided for @insightDayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get insightDayTuesday;

  /// No description provided for @insightDayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get insightDayWednesday;

  /// No description provided for @insightDayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get insightDayThursday;

  /// No description provided for @insightDayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get insightDayFriday;

  /// No description provided for @insightDaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get insightDaySaturday;

  /// No description provided for @insightDaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get insightDaySunday;

  /// No description provided for @insightGoldenDayTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Golden Day'**
  String get insightGoldenDayTitle;

  /// No description provided for @insightGoldenDayDescription.
  ///
  /// In en, this message translates to:
  /// **'Your encounters on {day} usually have the highest average rating ({avg}/10).'**
  String insightGoldenDayDescription(Object day, Object avg);

  /// No description provided for @insightProtectionStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection Stats'**
  String get insightProtectionStatsTitle;

  /// No description provided for @insightProtectionStatsDescription.
  ///
  /// In en, this message translates to:
  /// **'You used protection in {percentage}% of your logged encounters.'**
  String insightProtectionStatsDescription(Object percentage);

  /// No description provided for @insightDominantStyleTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Dominant Style'**
  String get insightDominantStyleTitle;

  /// No description provided for @insightDominantStyleDescription.
  ///
  /// In en, this message translates to:
  /// **'Your most frequent tag is \'{tag}\'. It seems to be an important part of your routine.'**
  String insightDominantStyleDescription(Object tag);

  /// No description provided for @homeBlackBookTitle.
  ///
  /// In en, this message translates to:
  /// **'Black Book'**
  String get homeBlackBookTitle;

  /// No description provided for @homeTrophyRoomTitle.
  ///
  /// In en, this message translates to:
  /// **'Trophy Room'**
  String get homeTrophyRoomTitle;

  /// No description provided for @homeHealthPassportTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Passport'**
  String get homeHealthPassportTitle;

  /// No description provided for @homeStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get homeStatsTitle;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @homeTrophiesTab.
  ///
  /// In en, this message translates to:
  /// **'Trophies'**
  String get homeTrophiesTab;

  /// No description provided for @homeHealthTab.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get homeHealthTab;

  /// No description provided for @homeStatsTab.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get homeStatsTab;

  /// No description provided for @blackBookNoRecords.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get blackBookNoRecords;

  /// No description provided for @blackBookSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} Encounters • Last: {date}'**
  String blackBookSummary(Object count, Object date);

  /// No description provided for @fakeNewTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get fakeNewTask;

  /// No description provided for @fakeTaskHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Buy milk'**
  String get fakeTaskHint;

  /// No description provided for @fakeAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get fakeAdd;

  /// No description provided for @fakeMyTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get fakeMyTasks;

  /// No description provided for @fakeAllDone.
  ///
  /// In en, this message translates to:
  /// **'All done for today.\nAdd a new task!'**
  String get fakeAllDone;

  /// No description provided for @fakeTaskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task \"{title}\" deleted'**
  String fakeTaskDeleted(Object title);

  /// No description provided for @pinEnter4Digits.
  ///
  /// In en, this message translates to:
  /// **'Enter 4 digits'**
  String get pinEnter4Digits;

  /// No description provided for @securityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Security updated ✅'**
  String get securityUpdated;

  /// No description provided for @securityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securityTitle;

  /// No description provided for @securityConfigureKeys.
  ///
  /// In en, this message translates to:
  /// **'Configure your access keys.'**
  String get securityConfigureKeys;

  /// No description provided for @securityRealPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Real PIN'**
  String get securityRealPinTitle;

  /// No description provided for @securityRealPinDesc.
  ///
  /// In en, this message translates to:
  /// **'Your main access'**
  String get securityRealPinDesc;

  /// No description provided for @securityPanicPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Panic PIN'**
  String get securityPanicPinTitle;

  /// No description provided for @securityPanicPinDesc.
  ///
  /// In en, this message translates to:
  /// **'Opens the fake task list'**
  String get securityPanicPinDesc;

  /// No description provided for @securityKillSwitchTitle.
  ///
  /// In en, this message translates to:
  /// **'KILL SWITCH'**
  String get securityKillSwitchTitle;

  /// No description provided for @securityKillSwitchDesc.
  ///
  /// In en, this message translates to:
  /// **'⚠️ DELETES ALL DATA'**
  String get securityKillSwitchDesc;

  /// No description provided for @securitySaveConfig.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get securitySaveConfig;

  /// No description provided for @securityConfigurePin.
  ///
  /// In en, this message translates to:
  /// **'Configure {title}'**
  String securityConfigurePin(Object title);

  /// No description provided for @securityNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get securityNotSet;

  /// No description provided for @dataTitle.
  ///
  /// In en, this message translates to:
  /// **'Data & Backups'**
  String get dataTitle;

  /// No description provided for @dataBackupSection.
  ///
  /// In en, this message translates to:
  /// **'BACKUP'**
  String get dataBackupSection;

  /// No description provided for @dataCreateBackup.
  ///
  /// In en, this message translates to:
  /// **'Create Encrypted Backup'**
  String get dataCreateBackup;

  /// No description provided for @dataCreateBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate an encrypted .notch file to save in Drive/iCloud.'**
  String get dataCreateBackupSubtitle;

  /// No description provided for @dataBackupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup generated successfully'**
  String get dataBackupSuccess;

  /// No description provided for @dataRestoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get dataRestoreBackup;

  /// No description provided for @dataRestoreBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import a .notch file. ⚠️ It will overwrite current data.'**
  String get dataRestoreBackupSubtitle;

  /// No description provided for @dataRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully'**
  String get dataRestoreSuccess;

  /// No description provided for @dataExportSection.
  ///
  /// In en, this message translates to:
  /// **'EXPORT'**
  String get dataExportSection;

  /// No description provided for @dataGeneratePdf.
  ///
  /// In en, this message translates to:
  /// **'Generate PDF Report'**
  String get dataGeneratePdf;

  /// No description provided for @dataGeneratePdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a visual document with your stats and records.'**
  String get dataGeneratePdfSubtitle;

  /// No description provided for @dataPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'PDF generated'**
  String get dataPdfSuccess;

  /// No description provided for @dataAchievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievement unlocked: {name}!'**
  String dataAchievementUnlocked(Object name);

  /// No description provided for @dataError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String dataError(Object error);

  /// No description provided for @healthResultNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get healthResultNegative;

  /// No description provided for @healthResultPositive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get healthResultPositive;

  /// No description provided for @healthResultPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get healthResultPending;

  /// No description provided for @healthNewRecord.
  ///
  /// In en, this message translates to:
  /// **'New Health Record'**
  String get healthNewRecord;

  /// No description provided for @healthTestTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Test Type (e.g. Full Panel)'**
  String get healthTestTypeLabel;

  /// No description provided for @healthResultLabel.
  ///
  /// In en, this message translates to:
  /// **'Result:'**
  String get healthResultLabel;

  /// No description provided for @healthSaveAndSchedule.
  ///
  /// In en, this message translates to:
  /// **'Save & Schedule'**
  String get healthSaveAndSchedule;

  /// No description provided for @healthSavedReminder.
  ///
  /// In en, this message translates to:
  /// **'Saved. We\'ll remind you in 6 months.'**
  String get healthSavedReminder;

  /// No description provided for @healthRegisterTest.
  ///
  /// In en, this message translates to:
  /// **'Log Test'**
  String get healthRegisterTest;

  /// No description provided for @healthNoRecords.
  ///
  /// In en, this message translates to:
  /// **'No health records'**
  String get healthNoRecords;

  /// No description provided for @healthNoRecordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Health is sexy. Get checked!'**
  String get healthNoRecordsSubtitle;

  /// No description provided for @addEntryPartnerHint.
  ///
  /// In en, this message translates to:
  /// **'Type \'@\' to search or a new name...'**
  String get addEntryPartnerHint;

  /// No description provided for @sharePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get sharePreviewTitle;

  /// No description provided for @shareCardText.
  ///
  /// In en, this message translates to:
  /// **'New rank unlocked in NOTCH! 🏆 #NOTCHapp'**
  String get shareCardText;

  /// No description provided for @shareCurrentSeason.
  ///
  /// In en, this message translates to:
  /// **'CURRENT SEASON'**
  String get shareCurrentSeason;

  /// No description provided for @shareSeasonXp.
  ///
  /// In en, this message translates to:
  /// **'Season XP'**
  String get shareSeasonXp;

  /// No description provided for @shareMonthEncounters.
  ///
  /// In en, this message translates to:
  /// **'Month Encounters'**
  String get shareMonthEncounters;

  /// No description provided for @shareErrorGeneratingImage.
  ///
  /// In en, this message translates to:
  /// **'Error generating image to share'**
  String get shareErrorGeneratingImage;

  /// No description provided for @partnerChangeAvatar.
  ///
  /// In en, this message translates to:
  /// **'Change Avatar'**
  String get partnerChangeAvatar;

  /// No description provided for @partnerChooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get partnerChooseFromGallery;

  /// No description provided for @partnerChooseEmoji.
  ///
  /// In en, this message translates to:
  /// **'Choose an Emoji'**
  String get partnerChooseEmoji;

  /// No description provided for @partnerChooseEmojiTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an Emoji'**
  String get partnerChooseEmojiTitle;

  /// No description provided for @partnerNotesSaved.
  ///
  /// In en, this message translates to:
  /// **'Notes saved'**
  String get partnerNotesSaved;

  /// No description provided for @partnerEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get partnerEdit;

  /// No description provided for @partnerPrivateNotes.
  ///
  /// In en, this message translates to:
  /// **'PRIVATE NOTES'**
  String get partnerPrivateNotes;

  /// No description provided for @partnerNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Likes, dislikes, birthdays...'**
  String get partnerNotesHint;

  /// No description provided for @partnerNotesTapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap the pencil to add notes.'**
  String get partnerNotesTapToAdd;

  /// No description provided for @partnerHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'ENCOUNTER HISTORY'**
  String get partnerHistoryTitle;

  /// No description provided for @partnerNoEncounters.
  ///
  /// In en, this message translates to:
  /// **'No encounters recorded.'**
  String get partnerNoEncounters;

  /// No description provided for @trophyMonthRecord.
  ///
  /// In en, this message translates to:
  /// **'MONTH RECORD'**
  String get trophyMonthRecord;

  /// No description provided for @trophyHistorical.
  ///
  /// In en, this message translates to:
  /// **'HISTORICAL'**
  String get trophyHistorical;

  /// No description provided for @challengesTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challengesTitle;

  /// No description provided for @challengesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete these goals to prove your mastery and commitment.'**
  String get challengesSubtitle;

  /// No description provided for @challengeMorningMasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning Master'**
  String get challengeMorningMasterTitle;

  /// No description provided for @challengeMorningMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Log 5 encounters with the \'Morning Wood\' tag.'**
  String get challengeMorningMasterDesc;

  /// No description provided for @challengeWeeklyExplorerTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Explorer'**
  String get challengeWeeklyExplorerTitle;

  /// No description provided for @challengeWeeklyExplorerDesc.
  ///
  /// In en, this message translates to:
  /// **'Use 3 different tags in the last 7 days.'**
  String get challengeWeeklyExplorerDesc;

  /// No description provided for @challengeQualityWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'Quality Week'**
  String get challengeQualityWeekTitle;

  /// No description provided for @challengeQualityWeekDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach an average of 8.0+ in the last 7 days.'**
  String get challengeQualityWeekDesc;

  /// No description provided for @challengeSafetyChampionTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety Champion'**
  String get challengeSafetyChampionTitle;

  /// No description provided for @challengeSafetyChampionDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 100% protection in your last 5 encounters.'**
  String get challengeSafetyChampionDesc;

  /// No description provided for @challengePreludeMasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Prelude Master'**
  String get challengePreludeMasterTitle;

  /// No description provided for @challengePreludeMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Average 9.0+ in 5 straight encounters tagged \'Oral\'.'**
  String get challengePreludeMasterDesc;

  /// No description provided for @challengeSteelConsistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Steel Consistency'**
  String get challengeSteelConsistencyTitle;

  /// No description provided for @challengeSteelConsistencyDesc.
  ///
  /// In en, this message translates to:
  /// **'Log at least 8 encounters in the current season.'**
  String get challengeSteelConsistencyDesc;

  /// No description provided for @challengeQualityClubTitle.
  ///
  /// In en, this message translates to:
  /// **'9+ Club'**
  String get challengeQualityClubTitle;

  /// No description provided for @challengeQualityClubDesc.
  ///
  /// In en, this message translates to:
  /// **'Log 5 encounters this month with rating 9 or 10.'**
  String get challengeQualityClubDesc;

  /// No description provided for @challengeGuardianOfSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Guardian of Safety'**
  String get challengeGuardianOfSafetyTitle;

  /// No description provided for @challengeGuardianOfSafetyDesc.
  ///
  /// In en, this message translates to:
  /// **'Achieve a streak of 15 consecutive encounters using protection.'**
  String get challengeGuardianOfSafetyDesc;

  /// No description provided for @challengePerfectWeekendTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfect Weekend'**
  String get challengePerfectWeekendTitle;

  /// No description provided for @challengePerfectWeekendDesc.
  ///
  /// In en, this message translates to:
  /// **'Log encounters on Friday, Saturday and Sunday in one weekend, all rated 8+.'**
  String get challengePerfectWeekendDesc;

  /// No description provided for @challengeEpicMorningTitle.
  ///
  /// In en, this message translates to:
  /// **'Very Good Mornings'**
  String get challengeEpicMorningTitle;

  /// No description provided for @challengeEpicMorningDesc.
  ///
  /// In en, this message translates to:
  /// **'Accumulate 50 encounters with the \'Morning Wood\' tag.'**
  String get challengeEpicMorningDesc;

  /// No description provided for @challengeFrequentFlyerTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequent Flyer'**
  String get challengeFrequentFlyerTitle;

  /// No description provided for @challengeFrequentFlyerDesc.
  ///
  /// In en, this message translates to:
  /// **'Accumulate 15 encounters with the \'Travel\' tag.'**
  String get challengeFrequentFlyerDesc;

  /// No description provided for @challengeStarCollectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Star Collector'**
  String get challengeStarCollectorTitle;

  /// No description provided for @challengeStarCollectorDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 100 encounters rated 8 or higher.'**
  String get challengeStarCollectorDesc;

  /// No description provided for @challengeCenturionTitle.
  ///
  /// In en, this message translates to:
  /// **'Centurion'**
  String get challengeCenturionTitle;

  /// No description provided for @challengeCenturionDesc.
  ///
  /// In en, this message translates to:
  /// **'Log your first 100 total encounters.'**
  String get challengeCenturionDesc;

  /// No description provided for @challengeLegendaryGuardianTitle.
  ///
  /// In en, this message translates to:
  /// **'Legendary Guardian'**
  String get challengeLegendaryGuardianTitle;

  /// No description provided for @challengeLegendaryGuardianDesc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 95%+ protection rate across at least 50 encounters.'**
  String get challengeLegendaryGuardianDesc;

  /// No description provided for @challengePolymathTitle.
  ///
  /// In en, this message translates to:
  /// **'Polymath'**
  String get challengePolymathTitle;

  /// No description provided for @challengePolymathDesc.
  ///
  /// In en, this message translates to:
  /// **'Use each available tag at least once.'**
  String get challengePolymathDesc;

  /// No description provided for @levelInitiated1Name.
  ///
  /// In en, this message translates to:
  /// **'Initiate I'**
  String get levelInitiated1Name;

  /// No description provided for @levelInitiated1Desc.
  ///
  /// In en, this message translates to:
  /// **'The first step on the path of intimate self-discovery.'**
  String get levelInitiated1Desc;

  /// No description provided for @levelInitiated2Name.
  ///
  /// In en, this message translates to:
  /// **'Initiate II'**
  String get levelInitiated2Name;

  /// No description provided for @levelInitiated2Desc.
  ///
  /// In en, this message translates to:
  /// **'You begin to recognize patterns and understand your rhythms.'**
  String get levelInitiated2Desc;

  /// No description provided for @levelInitiated3Name.
  ///
  /// In en, this message translates to:
  /// **'Initiate III'**
  String get levelInitiated3Name;

  /// No description provided for @levelInitiated3Desc.
  ///
  /// In en, this message translates to:
  /// **'Curiosity becomes a conscious logging habit.'**
  String get levelInitiated3Desc;

  /// No description provided for @levelPractitioner1Name.
  ///
  /// In en, this message translates to:
  /// **'Practitioner I'**
  String get levelPractitioner1Name;

  /// No description provided for @levelPractitioner1Desc.
  ///
  /// In en, this message translates to:
  /// **'The discipline of logging reveals its first rewards.'**
  String get levelPractitioner1Desc;

  /// No description provided for @levelPractitioner2Name.
  ///
  /// In en, this message translates to:
  /// **'Practitioner II'**
  String get levelPractitioner2Name;

  /// No description provided for @levelPractitioner2Desc.
  ///
  /// In en, this message translates to:
  /// **'You develop deeper awareness of your desires and limits.'**
  String get levelPractitioner2Desc;

  /// No description provided for @levelPractitioner3Name.
  ///
  /// In en, this message translates to:
  /// **'Practitioner III'**
  String get levelPractitioner3Name;

  /// No description provided for @levelPractitioner3Desc.
  ///
  /// In en, this message translates to:
  /// **'Consistency shows commitment to your sexual well-being.'**
  String get levelPractitioner3Desc;

  /// No description provided for @levelAdept1Name.
  ///
  /// In en, this message translates to:
  /// **'Adept I'**
  String get levelAdept1Name;

  /// No description provided for @levelAdept1Desc.
  ///
  /// In en, this message translates to:
  /// **'You master the tools and begin experimenting with confidence.'**
  String get levelAdept1Desc;

  /// No description provided for @levelAdept2Name.
  ///
  /// In en, this message translates to:
  /// **'Adept II'**
  String get levelAdept2Name;

  /// No description provided for @levelAdept2Desc.
  ///
  /// In en, this message translates to:
  /// **'Your understanding of intimate dynamics deepens.'**
  String get levelAdept2Desc;

  /// No description provided for @levelAdept3Name.
  ///
  /// In en, this message translates to:
  /// **'Adept III'**
  String get levelAdept3Name;

  /// No description provided for @levelAdept3Desc.
  ///
  /// In en, this message translates to:
  /// **'The quality of your experiences becomes as important as quantity.'**
  String get levelAdept3Desc;

  /// No description provided for @levelVirtuoso1Name.
  ///
  /// In en, this message translates to:
  /// **'Virtuoso I'**
  String get levelVirtuoso1Name;

  /// No description provided for @levelVirtuoso1Desc.
  ///
  /// In en, this message translates to:
  /// **'Your actions are intentional and your logs are detailed.'**
  String get levelVirtuoso1Desc;

  /// No description provided for @levelVirtuoso2Name.
  ///
  /// In en, this message translates to:
  /// **'Virtuoso II'**
  String get levelVirtuoso2Name;

  /// No description provided for @levelVirtuoso2Desc.
  ///
  /// In en, this message translates to:
  /// **'You inspire confidence and show strong communication skills.'**
  String get levelVirtuoso2Desc;

  /// No description provided for @levelVirtuoso3Name.
  ///
  /// In en, this message translates to:
  /// **'Virtuoso III'**
  String get levelVirtuoso3Name;

  /// No description provided for @levelVirtuoso3Desc.
  ///
  /// In en, this message translates to:
  /// **'Intimacy becomes an art form you master.'**
  String get levelVirtuoso3Desc;

  /// No description provided for @levelKnower1Name.
  ///
  /// In en, this message translates to:
  /// **'Knower I'**
  String get levelKnower1Name;

  /// No description provided for @levelKnower1Desc.
  ///
  /// In en, this message translates to:
  /// **'You hold deep knowledge of yourself and your partners.'**
  String get levelKnower1Desc;

  /// No description provided for @levelKnower2Name.
  ///
  /// In en, this message translates to:
  /// **'Knower II'**
  String get levelKnower2Name;

  /// No description provided for @levelKnower2Desc.
  ///
  /// In en, this message translates to:
  /// **'Your experience lets you anticipate and create unforgettable moments.'**
  String get levelKnower2Desc;

  /// No description provided for @levelKnower3Name.
  ///
  /// In en, this message translates to:
  /// **'Knower III'**
  String get levelKnower3Name;

  /// No description provided for @levelKnower3Desc.
  ///
  /// In en, this message translates to:
  /// **'You are a reference point for maturity and sexual health.'**
  String get levelKnower3Desc;

  /// No description provided for @levelMasterName.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get levelMasterName;

  /// No description provided for @levelMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'You reached the summit of self-knowledge and intimate mastery.'**
  String get levelMasterDesc;

  /// No description provided for @levelGrandMasterName.
  ///
  /// In en, this message translates to:
  /// **'Grand Master'**
  String get levelGrandMasterName;

  /// No description provided for @levelGrandMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Your journey inspires others. You transcended the purely physical.'**
  String get levelGrandMasterDesc;

  /// No description provided for @levelLegendName.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get levelLegendName;

  /// No description provided for @levelLegendDesc.
  ///
  /// In en, this message translates to:
  /// **'Your legacy is written in the stars of intimacy.'**
  String get levelLegendDesc;

  /// No description provided for @trophyActiveChallenges.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE CHALLENGES'**
  String get trophyActiveChallenges;

  /// No description provided for @trophyExploreGoals.
  ///
  /// In en, this message translates to:
  /// **'Explore new goals'**
  String get trophyExploreGoals;

  /// No description provided for @trophyExploreGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to view all available challenges and keep improving.'**
  String get trophyExploreGoalsSubtitle;

  /// No description provided for @trophyUnlockedBadges.
  ///
  /// In en, this message translates to:
  /// **'UNLOCKED BADGES'**
  String get trophyUnlockedBadges;

  /// No description provided for @trophyCurrentLevel.
  ///
  /// In en, this message translates to:
  /// **'CURRENT LEVEL'**
  String get trophyCurrentLevel;

  /// No description provided for @trophyFinalRank.
  ///
  /// In en, this message translates to:
  /// **'FINAL RANK'**
  String get trophyFinalRank;

  /// No description provided for @trophyNextLevelInXp.
  ///
  /// In en, this message translates to:
  /// **'Next level in {xp} XP'**
  String trophyNextLevelInXp(Object xp);

  /// No description provided for @trophyCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'CURRENT STREAK'**
  String get trophyCurrentStreak;

  /// No description provided for @badgeLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get badgeLocked;

  /// No description provided for @achievementUnlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievement Unlocked!'**
  String get achievementUnlockedTitle;

  /// No description provided for @achievementRookieName.
  ///
  /// In en, this message translates to:
  /// **'Debut'**
  String get achievementRookieName;

  /// No description provided for @achievementRookieDesc.
  ///
  /// In en, this message translates to:
  /// **'Log your first encounter.'**
  String get achievementRookieDesc;

  /// No description provided for @achievementLegendName.
  ///
  /// In en, this message translates to:
  /// **'Legendary'**
  String get achievementLegendName;

  /// No description provided for @achievementLegendDesc.
  ///
  /// In en, this message translates to:
  /// **'Get a perfect 10/10 rating.'**
  String get achievementLegendDesc;

  /// No description provided for @achievementSprinterName.
  ///
  /// In en, this message translates to:
  /// **'Sprinter'**
  String get achievementSprinterName;

  /// No description provided for @achievementSprinterDesc.
  ///
  /// In en, this message translates to:
  /// **'3 encounters in less than 24 hours.'**
  String get achievementSprinterDesc;

  /// No description provided for @achievementSafePlayerName.
  ///
  /// In en, this message translates to:
  /// **'Safe Player'**
  String get achievementSafePlayerName;

  /// No description provided for @achievementSafePlayerDesc.
  ///
  /// In en, this message translates to:
  /// **'Streak of 10 protected encounters.'**
  String get achievementSafePlayerDesc;

  /// No description provided for @achievementHatTrickName.
  ///
  /// In en, this message translates to:
  /// **'Hat-Trick'**
  String get achievementHatTrickName;

  /// No description provided for @achievementHatTrickDesc.
  ///
  /// In en, this message translates to:
  /// **'3 or more orgasms in one encounter.'**
  String get achievementHatTrickDesc;

  /// No description provided for @achievementMarathonerName.
  ///
  /// In en, this message translates to:
  /// **'Marathoner'**
  String get achievementMarathonerName;

  /// No description provided for @achievementMarathonerDesc.
  ///
  /// In en, this message translates to:
  /// **'5 encounters in one weekend (Fri-Sun) in a month.'**
  String get achievementMarathonerDesc;

  /// No description provided for @achievementRenaissanceName.
  ///
  /// In en, this message translates to:
  /// **'Renaissance Man'**
  String get achievementRenaissanceName;

  /// No description provided for @achievementRenaissanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Activity on every weekday within a month.'**
  String get achievementRenaissanceDesc;

  /// No description provided for @achievementFireStreakName.
  ///
  /// In en, this message translates to:
  /// **'Fire Streak'**
  String get achievementFireStreakName;

  /// No description provided for @achievementFireStreakDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 7-day streak.'**
  String get achievementFireStreakDesc;

  /// No description provided for @achievementTopCriticName.
  ///
  /// In en, this message translates to:
  /// **'Top Critic'**
  String get achievementTopCriticName;

  /// No description provided for @achievementTopCriticDesc.
  ///
  /// In en, this message translates to:
  /// **'5 straight encounters rated 9+.'**
  String get achievementTopCriticDesc;

  /// No description provided for @achievementGrandMasterName.
  ///
  /// In en, this message translates to:
  /// **'Grand Master'**
  String get achievementGrandMasterName;

  /// No description provided for @achievementGrandMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach the \"Grand Master\" rank in a season.'**
  String get achievementGrandMasterDesc;

  /// No description provided for @achievementExplorerName.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get achievementExplorerName;

  /// No description provided for @achievementExplorerDesc.
  ///
  /// In en, this message translates to:
  /// **'Use 5 different tags in a month.'**
  String get achievementExplorerDesc;

  /// No description provided for @achievementGlobetrotterName.
  ///
  /// In en, this message translates to:
  /// **'Globetrotter'**
  String get achievementGlobetrotterName;

  /// No description provided for @achievementGlobetrotterDesc.
  ///
  /// In en, this message translates to:
  /// **'Log an encounter with the \"Travel\" tag.'**
  String get achievementGlobetrotterDesc;

  /// No description provided for @achievementNightOwlName.
  ///
  /// In en, this message translates to:
  /// **'Night Owl'**
  String get achievementNightOwlName;

  /// No description provided for @achievementNightOwlDesc.
  ///
  /// In en, this message translates to:
  /// **'10 encounters logged after midnight.'**
  String get achievementNightOwlDesc;

  /// No description provided for @achievementHealthChampionName.
  ///
  /// In en, this message translates to:
  /// **'Health Champion'**
  String get achievementHealthChampionName;

  /// No description provided for @achievementHealthChampionDesc.
  ///
  /// In en, this message translates to:
  /// **'Log your first Health Passport checkup.'**
  String get achievementHealthChampionDesc;

  /// No description provided for @achievementArchivistName.
  ///
  /// In en, this message translates to:
  /// **'Archivist'**
  String get achievementArchivistName;

  /// No description provided for @achievementArchivistDesc.
  ///
  /// In en, this message translates to:
  /// **'Create your first data backup.'**
  String get achievementArchivistDesc;

  /// No description provided for @trophyDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get trophyDays;

  /// No description provided for @trophyRecordReached.
  ///
  /// In en, this message translates to:
  /// **'Record reached'**
  String get trophyRecordReached;

  /// No description provided for @trophyBeatingRecord.
  ///
  /// In en, this message translates to:
  /// **'Beating record'**
  String get trophyBeatingRecord;

  /// No description provided for @trophyNoRecord.
  ///
  /// In en, this message translates to:
  /// **'No record'**
  String get trophyNoRecord;

  /// No description provided for @trophyPercentOfHistorical.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of historical'**
  String trophyPercentOfHistorical(Object percent);

  /// No description provided for @trophyNoStreakThisMonth.
  ///
  /// In en, this message translates to:
  /// **'No streak this month'**
  String get trophyNoStreakThisMonth;

  /// No description provided for @trophyNextMilestoneDays.
  ///
  /// In en, this message translates to:
  /// **'Next milestone: {days} days'**
  String trophyNextMilestoneDays(Object days);

  /// No description provided for @trophyDaysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{days} days remaining'**
  String trophyDaysRemaining(Object days);

  /// No description provided for @trophyMilestoneReached.
  ///
  /// In en, this message translates to:
  /// **'Milestone reached!'**
  String get trophyMilestoneReached;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
