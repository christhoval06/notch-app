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

  /// No description provided for @insightsHeroEyebrow.
  ///
  /// In en, this message translates to:
  /// **'EDITORIAL READOUT'**
  String get insightsHeroEyebrow;

  /// No description provided for @insightsHeroEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your intelligence layer is ready to learn.'**
  String get insightsHeroEmptyTitle;

  /// No description provided for @insightsHeroEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Start logging encounters or health checks and this screen will turn them into guided patterns, watchouts, and premium signals.'**
  String get insightsHeroEmptyBody;

  /// No description provided for @insightsHeroHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Health signals deserve closer attention.'**
  String get insightsHeroHealthTitle;

  /// No description provided for @insightsHeroHealthBody.
  ///
  /// In en, this message translates to:
  /// **'Your recent sexual-health data suggests this is a good moment to slow down, review protection habits, and keep your records updated.'**
  String get insightsHeroHealthBody;

  /// No description provided for @insightsHeroProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection is shaping a strong baseline.'**
  String get insightsHeroProtectionTitle;

  /// No description provided for @insightsHeroProtectionBody.
  ///
  /// In en, this message translates to:
  /// **'{rate}% of your encounters were protected, which is giving this period a safer and more stable profile.'**
  String insightsHeroProtectionBody(Object rate);

  /// No description provided for @insightsHeroRhythmTitle.
  ///
  /// In en, this message translates to:
  /// **'Your current rhythm is readable.'**
  String get insightsHeroRhythmTitle;

  /// No description provided for @insightsHeroRhythmBody.
  ///
  /// In en, this message translates to:
  /// **'Recent encounters are averaging {rating}, giving this period enough signal to extract patterns and watchouts.'**
  String insightsHeroRhythmBody(Object rating);

  /// No description provided for @insightsHeroChipStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting fresh'**
  String get insightsHeroChipStarting;

  /// No description provided for @insightsHeroChipNoSignals.
  ///
  /// In en, this message translates to:
  /// **'No signals yet'**
  String get insightsHeroChipNoSignals;

  /// No description provided for @insightsHeroProtectionChip.
  ///
  /// In en, this message translates to:
  /// **'{rate}% protected'**
  String insightsHeroProtectionChip(Object rate);

  /// No description provided for @insightsHeroQualityChip.
  ///
  /// In en, this message translates to:
  /// **'Avg rating {rating}'**
  String insightsHeroQualityChip(Object rating);

  /// No description provided for @insightsHeroEncountersChip.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters logged'**
  String insightsHeroEncountersChip(Object count);

  /// No description provided for @insightsHeroHealthLogsChip.
  ///
  /// In en, this message translates to:
  /// **'{count} health logs tracked'**
  String insightsHeroHealthLogsChip(Object count);

  /// No description provided for @insightsBestPatternLabel.
  ///
  /// In en, this message translates to:
  /// **'Best pattern'**
  String get insightsBestPatternLabel;

  /// No description provided for @insightsBestPatternPartnerHeadline.
  ///
  /// In en, this message translates to:
  /// **'{partner} is your strongest pattern so far.'**
  String insightsBestPatternPartnerHeadline(Object partner);

  /// No description provided for @insightsBestPatternPartnerBody.
  ///
  /// In en, this message translates to:
  /// **'This connection is averaging {rating}, making it your clearest quality signal in the current data.'**
  String insightsBestPatternPartnerBody(Object rating);

  /// No description provided for @insightsBestPatternRhythmHeadline.
  ///
  /// In en, this message translates to:
  /// **'{day} is giving you the best rhythm.'**
  String insightsBestPatternRhythmHeadline(Object day);

  /// No description provided for @insightsBestPatternRhythmBody.
  ///
  /// In en, this message translates to:
  /// **'The tag \"{tag}\" appears most often and helps define the strongest context in your logs.'**
  String insightsBestPatternRhythmBody(Object tag);

  /// No description provided for @insightsBestPatternPartnerDetail.
  ///
  /// In en, this message translates to:
  /// **'Across your current records, this partner stands out as the clearest positive pattern because the experience quality remains consistently stronger than the rest of the dataset. This is less about frequency alone and more about repeat quality.'**
  String insightsBestPatternPartnerDetail(Object partner);

  /// No description provided for @insightsBestPatternPartnerRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Use this pattern as a benchmark: notice the context, pace, timing, and emotional setup that tend to make these encounters work better.'**
  String get insightsBestPatternPartnerRecommendation;

  /// No description provided for @insightsBestPatternRhythmDetail.
  ///
  /// In en, this message translates to:
  /// **'Your current data suggests that this day creates a more favorable rhythm than the rest of the week. Even if the sample is still growing, it already behaves like a stronger window for better outcomes.'**
  String insightsBestPatternRhythmDetail(Object day);

  /// No description provided for @insightsBestPatternRhythmRecommendation.
  ///
  /// In en, this message translates to:
  /// **'If you want to improve consistency, try protecting and repeating the conditions that usually happen around this rhythm.'**
  String get insightsBestPatternRhythmRecommendation;

  /// No description provided for @insightsWatchoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Watchout'**
  String get insightsWatchoutLabel;

  /// No description provided for @insightsWatchoutHealthHeadline.
  ///
  /// In en, this message translates to:
  /// **'Recent health records need a closer read.'**
  String get insightsWatchoutHealthHeadline;

  /// No description provided for @insightsWatchoutHealthBody.
  ///
  /// In en, this message translates to:
  /// **'One of your latest health logs is positive or pending, so this period should be read with more caution than usual.'**
  String get insightsWatchoutHealthBody;

  /// No description provided for @insightsWatchoutHealthDetail.
  ///
  /// In en, this message translates to:
  /// **'This does not replace medical guidance, but it does mean your current sexual-health context has an unresolved signal. In product terms, this is one of the strongest reasons to temporarily shift from performance reading to caution reading.'**
  String get insightsWatchoutHealthDetail;

  /// No description provided for @insightsWatchoutHealthRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Pause risky patterns, prioritize follow-up, and keep your next health update logged so this screen can reflect a fresher status.'**
  String get insightsWatchoutHealthRecommendation;

  /// No description provided for @insightsWatchoutProtectionHeadline.
  ///
  /// In en, this message translates to:
  /// **'Protection is softer than your ideal baseline.'**
  String get insightsWatchoutProtectionHeadline;

  /// No description provided for @insightsWatchoutProtectionBody.
  ///
  /// In en, this message translates to:
  /// **'Only {rate}% of your encounters were protected, which raises the importance of caution and follow-up.'**
  String insightsWatchoutProtectionBody(Object rate);

  /// No description provided for @insightsWatchoutProtectionDetail.
  ///
  /// In en, this message translates to:
  /// **'Your recent protection behavior is not yet catastrophic, but it is soft enough to deserve attention. When protection slips, the rest of the screen should be read with more caution, even if quality or rhythm still look strong.'**
  String get insightsWatchoutProtectionDetail;

  /// No description provided for @insightsWatchoutProtectionRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Reinforce safer defaults in the moments where spontaneity usually overrides preparation.'**
  String get insightsWatchoutProtectionRecommendation;

  /// No description provided for @insightsWatchoutQualityHeadline.
  ///
  /// In en, this message translates to:
  /// **'Quality is showing more friction than flow.'**
  String get insightsWatchoutQualityHeadline;

  /// No description provided for @insightsWatchoutQualityBody.
  ///
  /// In en, this message translates to:
  /// **'Average ratings are low enough to suggest this period may need more intention, recovery, or context changes.'**
  String get insightsWatchoutQualityBody;

  /// No description provided for @insightsWatchoutQualityDetail.
  ///
  /// In en, this message translates to:
  /// **'Low averages usually mean the issue is not just one encounter but a repeated mismatch in context, energy, or connection. This is useful because it points to a pattern you can actually work on.'**
  String get insightsWatchoutQualityDetail;

  /// No description provided for @insightsWatchoutQualityRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Try changing one variable at a time: timing, pace, partner context, or recovery between encounters.'**
  String get insightsWatchoutQualityRecommendation;

  /// No description provided for @insightsWatchoutGapHeadline.
  ///
  /// In en, this message translates to:
  /// **'The signal is clean, but spaced out.'**
  String get insightsWatchoutGapHeadline;

  /// No description provided for @insightsWatchoutGapBody.
  ///
  /// In en, this message translates to:
  /// **'Your latest encounter was {days} days ago, so current patterns may still be early and less stable.'**
  String insightsWatchoutGapBody(Object days);

  /// No description provided for @insightsWatchoutGapDetail.
  ///
  /// In en, this message translates to:
  /// **'Long gaps are not bad by themselves, but they reduce confidence in short-term pattern reading. The screen can still interpret your data, just with less certainty about what is current versus historical.'**
  String get insightsWatchoutGapDetail;

  /// No description provided for @insightsWatchoutGapRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Let the next few logs rebuild momentum before treating this cycle as a firm pattern.'**
  String get insightsWatchoutGapRecommendation;

  /// No description provided for @insightsHealthSnapshotLabel.
  ///
  /// In en, this message translates to:
  /// **'Health snapshot'**
  String get insightsHealthSnapshotLabel;

  /// No description provided for @insightsHealthSnapshotEmptyHeadline.
  ///
  /// In en, this message translates to:
  /// **'No health logs yet.'**
  String get insightsHealthSnapshotEmptyHeadline;

  /// No description provided for @insightsHealthSnapshotEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Adding tests and symptoms will make this screen sharper, especially for risk radar and long-term health intelligence.'**
  String get insightsHealthSnapshotEmptyBody;

  /// No description provided for @insightsHealthSnapshotEmptyDetail.
  ///
  /// In en, this message translates to:
  /// **'Right now, the app can read rhythm, quality, and protection, but it is still missing the health layer that makes the intelligence more grounded over time.'**
  String get insightsHealthSnapshotEmptyDetail;

  /// No description provided for @insightsHealthSnapshotEmptyRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Log your next check, result, or relevant symptom so the health layer becomes part of your editorial readout.'**
  String get insightsHealthSnapshotEmptyRecommendation;

  /// No description provided for @insightsHealthSnapshotHeadline.
  ///
  /// In en, this message translates to:
  /// **'Last recorded health signal: {result} in {type}.'**
  String insightsHealthSnapshotHeadline(Object result, Object type);

  /// No description provided for @insightsHealthSnapshotBody.
  ///
  /// In en, this message translates to:
  /// **'That last update was {months} month(s) ago, which helps define how fresh your health context is.'**
  String insightsHealthSnapshotBody(Object months);

  /// No description provided for @insightsHealthSnapshotDetail.
  ///
  /// In en, this message translates to:
  /// **'This snapshot helps anchor the rest of the screen in something more durable than encounter-by-encounter variation. Even a single health record improves long-term interpretation.'**
  String insightsHealthSnapshotDetail(Object type);

  /// No description provided for @insightsHealthSnapshotRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Keep this layer fresh with periodic check-ins so the rest of your intelligence stays contextual, not isolated.'**
  String get insightsHealthSnapshotRecommendation;

  /// No description provided for @insightsRiskRadarTitle.
  ///
  /// In en, this message translates to:
  /// **'Risk radar'**
  String get insightsRiskRadarTitle;

  /// No description provided for @insightsSheetRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get insightsSheetRecommendation;

  /// No description provided for @insightsRiskProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get insightsRiskProtection;

  /// No description provided for @insightsRiskRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get insightsRiskRecovery;

  /// No description provided for @insightsRiskVariability.
  ///
  /// In en, this message translates to:
  /// **'Variability'**
  String get insightsRiskVariability;

  /// No description provided for @insightsRiskLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get insightsRiskLow;

  /// No description provided for @insightsRiskGuarded.
  ///
  /// In en, this message translates to:
  /// **'Guarded'**
  String get insightsRiskGuarded;

  /// No description provided for @insightsRiskHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get insightsRiskHigh;

  /// No description provided for @insightsDynamicFeedTitle.
  ///
  /// In en, this message translates to:
  /// **'More signals'**
  String get insightsDynamicFeedTitle;

  /// No description provided for @insightsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your premium insights will appear here.'**
  String get insightsEmptyTitle;

  /// No description provided for @insightsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'This screen becomes more useful once you log a few encounters or health checks. The more consistent the data, the sharper the editorial reading.'**
  String get insightsEmptyBody;

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

  /// No description provided for @settingsAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get settingsAboutApp;

  /// No description provided for @settingsAboutAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Why NOTCH exists and why it was created'**
  String get settingsAboutAppSubtitle;

  /// No description provided for @settingsAboutAppTitle.
  ///
  /// In en, this message translates to:
  /// **'About NOTCH'**
  String get settingsAboutAppTitle;

  /// No description provided for @settingsAboutAppDescription.
  ///
  /// In en, this message translates to:
  /// **'NOTCH exists to help you log your intimate activity in a private, secure, and intentional way. It was created because highly sensitive data should not live on external servers or be exposed to trackers. The app helps you understand patterns, improve your wellbeing, and keep full control of your information.'**
  String get settingsAboutAppDescription;

  /// No description provided for @settingsAboutAppPillarPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy first'**
  String get settingsAboutAppPillarPrivacyTitle;

  /// No description provided for @settingsAboutAppPillarPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Your data stays with you, with no servers and no trackers.'**
  String get settingsAboutAppPillarPrivacyBody;

  /// No description provided for @settingsAboutAppPillarPurposeTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear purpose'**
  String get settingsAboutAppPillarPurposeTitle;

  /// No description provided for @settingsAboutAppPillarPurposeBody.
  ///
  /// In en, this message translates to:
  /// **'Turn your logs into useful insights for your wellbeing.'**
  String get settingsAboutAppPillarPurposeBody;

  /// No description provided for @settingsAboutAppPillarControlTitle.
  ///
  /// In en, this message translates to:
  /// **'Full control'**
  String get settingsAboutAppPillarControlTitle;

  /// No description provided for @settingsAboutAppPillarControlBody.
  ///
  /// In en, this message translates to:
  /// **'You decide what to keep, export, or delete at any time.'**
  String get settingsAboutAppPillarControlBody;

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
  /// **'Hi, I\'m @christhoval, a fullstack engineer and Front-End Tech Lead based in Panama. I work with JavaScript and Python, and I build CLI tools, npm packages, and mobile apps. I focus on product, UX, and privacy by design. I created NOTCH because intimate data should stay in your hands: no servers, no trackers, and full control for you.'**
  String get settingsAboutDevDescription;

  /// No description provided for @settingsAboutDevRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Current role'**
  String get settingsAboutDevRoleTitle;

  /// No description provided for @settingsAboutDevRoleBody.
  ///
  /// In en, this message translates to:
  /// **'Fullstack Engineer and Front-End Tech Lead.'**
  String get settingsAboutDevRoleBody;

  /// No description provided for @settingsAboutDevStackTitle.
  ///
  /// In en, this message translates to:
  /// **'Core stack'**
  String get settingsAboutDevStackTitle;

  /// No description provided for @settingsAboutDevStackBody.
  ///
  /// In en, this message translates to:
  /// **'JavaScript, TypeScript, Python, Flutter, CLI, and npm.'**
  String get settingsAboutDevStackBody;

  /// No description provided for @settingsAboutDevFocusTitle.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get settingsAboutDevFocusTitle;

  /// No description provided for @settingsAboutDevFocusBody.
  ///
  /// In en, this message translates to:
  /// **'Product, UX, and privacy by design.'**
  String get settingsAboutDevFocusBody;

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

  /// No description provided for @pathTitle.
  ///
  /// In en, this message translates to:
  /// **'Path of Mastery'**
  String get pathTitle;

  /// No description provided for @pathUnlockedAtXp.
  ///
  /// In en, this message translates to:
  /// **'Unlocked at {xp} XP'**
  String pathUnlockedAtXp(Object xp);

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

  /// No description provided for @statsActivityTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity Trend'**
  String get statsActivityTrendTitle;

  /// No description provided for @statsActivityMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity Map'**
  String get statsActivityMapTitle;

  /// No description provided for @statsActivityMapSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} active days in this period.'**
  String statsActivityMapSummary(Object count);

  /// No description provided for @statsActivityLegendLess.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get statsActivityLegendLess;

  /// No description provided for @statsActivityLegendMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get statsActivityLegendMore;

  /// No description provided for @statsPremiumHeroEyebrow.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM INTELLIGENCE'**
  String get statsPremiumHeroEyebrow;

  /// No description provided for @statsPremiumHeroQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'Quality is trending premium'**
  String get statsPremiumHeroQualityTitle;

  /// No description provided for @statsPremiumHeroProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection discipline is leading'**
  String get statsPremiumHeroProtectionTitle;

  /// No description provided for @statsPremiumHeroPartnerTitle.
  ///
  /// In en, this message translates to:
  /// **'This period has a clear favorite'**
  String get statsPremiumHeroPartnerTitle;

  /// No description provided for @statsPremiumHeroConsistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Consistency is becoming a habit'**
  String get statsPremiumHeroConsistencyTitle;

  /// No description provided for @statsPremiumHeroRhythmTitle.
  ///
  /// In en, this message translates to:
  /// **'Your rhythm has a prime window'**
  String get statsPremiumHeroRhythmTitle;

  /// No description provided for @statsPremiumHeroQualityBody.
  ///
  /// In en, this message translates to:
  /// **'Your average rating is {rating}, making quality your strongest signal in this period.'**
  String statsPremiumHeroQualityBody(Object rating);

  /// No description provided for @statsPremiumHeroProtectionBody.
  ///
  /// In en, this message translates to:
  /// **'{rate}% of your encounters were protected, giving safety the strongest discipline signal right now.'**
  String statsPremiumHeroProtectionBody(Object rate);

  /// No description provided for @statsPremiumHeroPartnerBody.
  ///
  /// In en, this message translates to:
  /// **'{partner} accounts for {share}% of your encounters, shaping the tone of this period.'**
  String statsPremiumHeroPartnerBody(Object partner, Object share);

  /// No description provided for @statsPremiumHeroConsistencyBody.
  ///
  /// In en, this message translates to:
  /// **'You stayed active on {days} different days across a {span} day span, which is turning repetition into momentum.'**
  String statsPremiumHeroConsistencyBody(Object days, Object span);

  /// No description provided for @statsPremiumHeroRhythmBody.
  ///
  /// In en, this message translates to:
  /// **'{bucket} leads with {share}% of your encounters, giving this period a distinct time signature.'**
  String statsPremiumHeroRhythmBody(Object bucket, Object share);

  /// No description provided for @statsPremiumSignalScore.
  ///
  /// In en, this message translates to:
  /// **'{score} signal score'**
  String statsPremiumSignalScore(Object score);

  /// No description provided for @statsPremiumTrendUp.
  ///
  /// In en, this message translates to:
  /// **'Up vs previous period'**
  String get statsPremiumTrendUp;

  /// No description provided for @statsPremiumTrendDown.
  ///
  /// In en, this message translates to:
  /// **'Down vs previous period'**
  String get statsPremiumTrendDown;

  /// No description provided for @statsPremiumTrendStable.
  ///
  /// In en, this message translates to:
  /// **'Stable vs previous period'**
  String get statsPremiumTrendStable;

  /// No description provided for @statsPremiumConsistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get statsPremiumConsistencyTitle;

  /// No description provided for @statsPremiumQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'Quality momentum'**
  String get statsPremiumQualityTitle;

  /// No description provided for @statsPremiumPartnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Partner mode'**
  String get statsPremiumPartnerTitle;

  /// No description provided for @statsPremiumConsistencyHeadline.
  ///
  /// In en, this message translates to:
  /// **'{days} active days across {span} days'**
  String statsPremiumConsistencyHeadline(Object days, Object span);

  /// No description provided for @statsPremiumQualityHeadline.
  ///
  /// In en, this message translates to:
  /// **'Average rating {rating}'**
  String statsPremiumQualityHeadline(Object rating);

  /// No description provided for @statsPremiumPartnerHeadline.
  ///
  /// In en, this message translates to:
  /// **'{partners} partner(s), {share}% concentration'**
  String statsPremiumPartnerHeadline(Object partners, Object share);

  /// No description provided for @statsPremiumPartnerSupporting.
  ///
  /// In en, this message translates to:
  /// **'Top partner: {partner}. {trend}.'**
  String statsPremiumPartnerSupporting(Object partner, Object trend);

  /// No description provided for @statsPremiumSignalSupporting.
  ///
  /// In en, this message translates to:
  /// **'{trend}.'**
  String statsPremiumSignalSupporting(Object trend);

  /// No description provided for @statsPremiumDeckTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium readout'**
  String get statsPremiumDeckTitle;

  /// No description provided for @statsPremiumStoryQuality.
  ///
  /// In en, this message translates to:
  /// **'Quality pulse'**
  String get statsPremiumStoryQuality;

  /// No description provided for @statsPremiumStoryProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection drift'**
  String get statsPremiumStoryProtection;

  /// No description provided for @statsPremiumStoryPartner.
  ///
  /// In en, this message translates to:
  /// **'Partner focus'**
  String get statsPremiumStoryPartner;

  /// No description provided for @statsPremiumStoryConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency pulse'**
  String get statsPremiumStoryConsistency;

  /// No description provided for @statsPremiumStoryRhythm.
  ///
  /// In en, this message translates to:
  /// **'Rhythm dominance'**
  String get statsPremiumStoryRhythm;

  /// No description provided for @statsPremiumStoryQualityHeadline.
  ///
  /// In en, this message translates to:
  /// **'Quality is averaging {rating}'**
  String statsPremiumStoryQualityHeadline(Object rating);

  /// No description provided for @statsPremiumStoryProtectionHeadline.
  ///
  /// In en, this message translates to:
  /// **'Protection sits at {rate}%'**
  String statsPremiumStoryProtectionHeadline(Object rate);

  /// No description provided for @statsPremiumStoryPartnerHeadline.
  ///
  /// In en, this message translates to:
  /// **'{partner} is defining this period'**
  String statsPremiumStoryPartnerHeadline(Object partner);

  /// No description provided for @statsPremiumStoryConsistencyHeadline.
  ///
  /// In en, this message translates to:
  /// **'{days} active days are shaping your cadence'**
  String statsPremiumStoryConsistencyHeadline(Object days);

  /// No description provided for @statsPremiumStoryRhythmHeadline.
  ///
  /// In en, this message translates to:
  /// **'{bucket} is your dominant lane'**
  String statsPremiumStoryRhythmHeadline(Object bucket);

  /// No description provided for @statsPremiumStoryQualityBody.
  ///
  /// In en, this message translates to:
  /// **'High ratings are becoming one of the strongest patterns in your recent data.'**
  String get statsPremiumStoryQualityBody;

  /// No description provided for @statsPremiumStoryProtectionBody.
  ///
  /// In en, this message translates to:
  /// **'Your safety rate is now visible as a behavior trend, not just a one-off result.'**
  String get statsPremiumStoryProtectionBody;

  /// No description provided for @statsPremiumStoryPartnerBody.
  ///
  /// In en, this message translates to:
  /// **'{share}% of your encounters concentrate around the same partner.'**
  String statsPremiumStoryPartnerBody(Object share);

  /// No description provided for @statsPremiumStoryConsistencyBody.
  ///
  /// In en, this message translates to:
  /// **'This rhythm spans {span} days and starts to show repeat intent instead of isolated logging.'**
  String statsPremiumStoryConsistencyBody(Object span);

  /// No description provided for @statsPremiumStoryRhythmBody.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters happened inside that time window.'**
  String statsPremiumStoryRhythmBody(Object count);

  /// No description provided for @statsPremiumUnknownPartner.
  ///
  /// In en, this message translates to:
  /// **'your top partner'**
  String get statsPremiumUnknownPartner;

  /// No description provided for @statsActivitySelectedDay.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters selected'**
  String statsActivitySelectedDay(Object count);

  /// No description provided for @statsHeatmapSelection.
  ///
  /// In en, this message translates to:
  /// **'{date} • {count} encounters'**
  String statsHeatmapSelection(Object date, Object count);

  /// No description provided for @statsHeatmapSelectionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters'**
  String statsHeatmapSelectionCount(Object count);

  /// No description provided for @statsHeatmapDayInsight.
  ///
  /// In en, this message translates to:
  /// **'You logged {count} encounters on this day in the selected period.'**
  String statsHeatmapDayInsight(Object count);

  /// No description provided for @statsHeatmapTopPartnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Top partner'**
  String get statsHeatmapTopPartnerLabel;

  /// No description provided for @statsHeatmapTagsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags used'**
  String get statsHeatmapTagsLabel;

  /// No description provided for @statsHeatmapNoTags.
  ///
  /// In en, this message translates to:
  /// **'No tags logged'**
  String get statsHeatmapNoTags;

  /// No description provided for @statsHeatmapProtectionSafe.
  ///
  /// In en, this message translates to:
  /// **'All protected'**
  String get statsHeatmapProtectionSafe;

  /// No description provided for @statsHeatmapProtectionMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed protection'**
  String get statsHeatmapProtectionMixed;

  /// No description provided for @statsHeatmapProtectionNone.
  ///
  /// In en, this message translates to:
  /// **'No protection'**
  String get statsHeatmapProtectionNone;

  /// No description provided for @statsHeatmapSnackBar.
  ///
  /// In en, this message translates to:
  /// **'{date}: {count} encounters'**
  String statsHeatmapSnackBar(Object date, Object count);

  /// No description provided for @statsBusiestStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Busiest streak'**
  String get statsBusiestStreakTitle;

  /// No description provided for @statsWeeklySnapshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly snapshot'**
  String get statsWeeklySnapshotTitle;

  /// No description provided for @statsActiveDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Active days'**
  String get statsActiveDaysLabel;

  /// No description provided for @statsCurrentWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get statsCurrentWeekLabel;

  /// No description provided for @statsPreviousWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Previous 7 days'**
  String get statsPreviousWeekLabel;

  /// No description provided for @statsDaysUnit.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String statsDaysUnit(Object count);

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

  /// No description provided for @statsSegmentAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get statsSegmentAll;

  /// No description provided for @statsSegmentPartner.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get statsSegmentPartner;

  /// No description provided for @statsSegmentTags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get statsSegmentTags;

  /// No description provided for @statsSegmentProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get statsSegmentProtection;

  /// No description provided for @statsSegmentDayTime.
  ///
  /// In en, this message translates to:
  /// **'Day/Time'**
  String get statsSegmentDayTime;

  /// No description provided for @statsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get statsFilterAll;

  /// No description provided for @statsFilterProtected.
  ///
  /// In en, this message translates to:
  /// **'Protected'**
  String get statsFilterProtected;

  /// No description provided for @statsFilterUnprotected.
  ///
  /// In en, this message translates to:
  /// **'Unprotected'**
  String get statsFilterUnprotected;

  /// No description provided for @statsFilterMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get statsFilterMorning;

  /// No description provided for @statsFilterAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get statsFilterAfternoon;

  /// No description provided for @statsFilterNight.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get statsFilterNight;

  /// No description provided for @statsTopPartnersTitle.
  ///
  /// In en, this message translates to:
  /// **'Top Partners'**
  String get statsTopPartnersTitle;

  /// No description provided for @statsTagIntelligenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Tag Intelligence'**
  String get statsTagIntelligenceTitle;

  /// No description provided for @statsTagDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How this tag behaves in the current period'**
  String get statsTagDetailSubtitle;

  /// No description provided for @statsTagRelatedPartnersLabel.
  ///
  /// In en, this message translates to:
  /// **'Related partners'**
  String get statsTagRelatedPartnersLabel;

  /// No description provided for @statsTagRecentEncountersLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent tagged encounters'**
  String get statsTagRecentEncountersLabel;

  /// No description provided for @statsTagInsightHighQuality.
  ///
  /// In en, this message translates to:
  /// **'This tag tends to perform best with {partner}.'**
  String statsTagInsightHighQuality(Object partner);

  /// No description provided for @statsTagInsightSafe.
  ///
  /// In en, this message translates to:
  /// **'This tag stays highly protected and is most associated with {partner}.'**
  String statsTagInsightSafe(Object partner);

  /// No description provided for @statsTagInsightFrequent.
  ///
  /// In en, this message translates to:
  /// **'This tag appears most often with {partner} and signals repeat use.'**
  String statsTagInsightFrequent(Object partner);

  /// No description provided for @statsProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get statsProtectionTitle;

  /// No description provided for @statsRhythmTitle.
  ///
  /// In en, this message translates to:
  /// **'Day & Time'**
  String get statsRhythmTitle;

  /// No description provided for @statsEncountersLabel.
  ///
  /// In en, this message translates to:
  /// **'Encounters'**
  String get statsEncountersLabel;

  /// No description provided for @statsLastSeenLabel.
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get statsLastSeenLabel;

  /// No description provided for @statsMostFrequentPartnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequent partner'**
  String get statsMostFrequentPartnerLabel;

  /// No description provided for @statsDominantMoodLabel.
  ///
  /// In en, this message translates to:
  /// **'Dominant mood'**
  String get statsDominantMoodLabel;

  /// No description provided for @statsNoMoodLabel.
  ///
  /// In en, this message translates to:
  /// **'No mood logged'**
  String get statsNoMoodLabel;

  /// No description provided for @statsPartnerMostActive.
  ///
  /// In en, this message translates to:
  /// **'Most active'**
  String get statsPartnerMostActive;

  /// No description provided for @statsPartnerBestChemistry.
  ///
  /// In en, this message translates to:
  /// **'Best chemistry'**
  String get statsPartnerBestChemistry;

  /// No description provided for @statsPartnerMostRecent.
  ///
  /// In en, this message translates to:
  /// **'Most recent'**
  String get statsPartnerMostRecent;

  /// No description provided for @statsPartnerDetailMostActive.
  ///
  /// In en, this message translates to:
  /// **'Most active connection in this period'**
  String get statsPartnerDetailMostActive;

  /// No description provided for @statsPartnerDetailBestChemistry.
  ///
  /// In en, this message translates to:
  /// **'Highest chemistry among your top partners'**
  String get statsPartnerDetailBestChemistry;

  /// No description provided for @statsPartnerDetailMostRecent.
  ///
  /// In en, this message translates to:
  /// **'Most recently seen in this period'**
  String get statsPartnerDetailMostRecent;

  /// No description provided for @statsPartnerRecentEncountersLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent encounters'**
  String get statsPartnerRecentEncountersLabel;

  /// No description provided for @statsPartnerInsightHighChemistry.
  ///
  /// In en, this message translates to:
  /// **'{partner} combines strong ratings with consistent chemistry.'**
  String statsPartnerInsightHighChemistry(Object partner);

  /// No description provided for @statsPartnerInsightSafety.
  ///
  /// In en, this message translates to:
  /// **'Protection stayed high while {partner} remained active.'**
  String statsPartnerInsightSafety(Object partner);

  /// No description provided for @statsPartnerInsightMomentum.
  ///
  /// In en, this message translates to:
  /// **'{partner} leads this period with steady momentum and repeat activity.'**
  String statsPartnerInsightMomentum(Object partner);

  /// No description provided for @statsProtectionRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Protection rate'**
  String get statsProtectionRateLabel;

  /// No description provided for @statsLastUnprotectedPartnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Last unprotected partner'**
  String get statsLastUnprotectedPartnerLabel;

  /// No description provided for @statsLastUnprotectedDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Last unprotected date'**
  String get statsLastUnprotectedDateLabel;

  /// No description provided for @statsProtectionStable.
  ///
  /// In en, this message translates to:
  /// **'Protection stayed steady in this period.'**
  String get statsProtectionStable;

  /// No description provided for @statsProtectionImproving.
  ///
  /// In en, this message translates to:
  /// **'Protection improved versus the previous period.'**
  String get statsProtectionImproving;

  /// No description provided for @statsProtectionCaution.
  ///
  /// In en, this message translates to:
  /// **'Protection dipped versus the previous period.'**
  String get statsProtectionCaution;

  /// No description provided for @statsProtectionDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How protection behaved in the current period'**
  String get statsProtectionDetailSubtitle;

  /// No description provided for @statsProtectionInsightBody.
  ///
  /// In en, this message translates to:
  /// **'This view highlights your safety consistency, the most repeated unprotected context, and the latest moments worth noticing.'**
  String get statsProtectionInsightBody;

  /// No description provided for @statsProtectionTopRiskPartnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Top unprotected partner'**
  String get statsProtectionTopRiskPartnerLabel;

  /// No description provided for @statsProtectionRecentEncountersLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent unprotected encounters'**
  String get statsProtectionRecentEncountersLabel;

  /// No description provided for @statsStrongestWindowLabel.
  ///
  /// In en, this message translates to:
  /// **'Strongest window'**
  String get statsStrongestWindowLabel;

  /// No description provided for @statsStrongestDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Strongest day'**
  String get statsStrongestDayLabel;

  /// No description provided for @statsRhythmHeadline.
  ///
  /// In en, this message translates to:
  /// **'{day} {bucket} is your strongest window.'**
  String statsRhythmHeadline(Object day, Object bucket);

  /// No description provided for @statsRhythmDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How your timing behaved in the current period'**
  String get statsRhythmDetailSubtitle;

  /// No description provided for @statsRhythmWeeklyPulseLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly pulse'**
  String get statsRhythmWeeklyPulseLabel;

  /// No description provided for @statsRhythmRecentEncountersLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent encounters in this rhythm'**
  String get statsRhythmRecentEncountersLabel;

  /// No description provided for @statsComparisonBaseline.
  ///
  /// In en, this message translates to:
  /// **'You are building your baseline.'**
  String get statsComparisonBaseline;

  /// No description provided for @statsComparisonUp.
  ///
  /// In en, this message translates to:
  /// **'Your activity rose versus the previous period.'**
  String get statsComparisonUp;

  /// No description provided for @statsComparisonDown.
  ///
  /// In en, this message translates to:
  /// **'Your activity cooled versus the previous period.'**
  String get statsComparisonDown;

  /// No description provided for @statsComparisonStable.
  ///
  /// In en, this message translates to:
  /// **'Your rhythm stayed stable versus the previous period.'**
  String get statsComparisonStable;

  /// No description provided for @statsStoryBestContextTitle.
  ///
  /// In en, this message translates to:
  /// **'Best context'**
  String get statsStoryBestContextTitle;

  /// No description provided for @statsStoryBestContextSupporting.
  ///
  /// In en, this message translates to:
  /// **'Average rating {rating}'**
  String statsStoryBestContextSupporting(Object rating);

  /// No description provided for @statsStoryBestContextDetails.
  ///
  /// In en, this message translates to:
  /// **'Your strongest ratings this period clustered around {context}. It is a great setup to repeat when you want a higher-confidence experience.'**
  String statsStoryBestContextDetails(Object context);

  /// No description provided for @statsStoryMomentumTitle.
  ///
  /// In en, this message translates to:
  /// **'Momentum'**
  String get statsStoryMomentumTitle;

  /// No description provided for @statsStoryMomentumUpHeadline.
  ///
  /// In en, this message translates to:
  /// **'Activity is up'**
  String get statsStoryMomentumUpHeadline;

  /// No description provided for @statsStoryMomentumDownHeadline.
  ///
  /// In en, this message translates to:
  /// **'Activity is down'**
  String get statsStoryMomentumDownHeadline;

  /// No description provided for @statsStoryMomentumSupporting.
  ///
  /// In en, this message translates to:
  /// **'{count} encounter change vs previous period'**
  String statsStoryMomentumSupporting(Object count);

  /// No description provided for @statsStoryMomentumUpDetails.
  ///
  /// In en, this message translates to:
  /// **'You logged {count} more encounters than the previous period. That usually points to stronger consistency in your rhythm.'**
  String statsStoryMomentumUpDetails(Object count);

  /// No description provided for @statsStoryMomentumDownDetails.
  ///
  /// In en, this message translates to:
  /// **'You logged {count} fewer encounters than the previous period. It may be worth checking whether this was just timing or a real slowdown.'**
  String statsStoryMomentumDownDetails(Object count);

  /// No description provided for @statsStoryProtectionTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection trend'**
  String get statsStoryProtectionTrendTitle;

  /// No description provided for @statsStoryProtectionTrendUpHeadline.
  ///
  /// In en, this message translates to:
  /// **'Protection is up'**
  String get statsStoryProtectionTrendUpHeadline;

  /// No description provided for @statsStoryProtectionTrendDownHeadline.
  ///
  /// In en, this message translates to:
  /// **'Protection is down'**
  String get statsStoryProtectionTrendDownHeadline;

  /// No description provided for @statsStoryProtectionTrendSupporting.
  ///
  /// In en, this message translates to:
  /// **'{current}% vs {previous}%'**
  String statsStoryProtectionTrendSupporting(Object current, Object previous);

  /// No description provided for @statsStoryProtectionTrendUpDetails.
  ///
  /// In en, this message translates to:
  /// **'Protection use climbed from {previous}% to {current}% in this period. That is a meaningful shift toward safer consistency.'**
  String statsStoryProtectionTrendUpDetails(Object current, Object previous);

  /// No description provided for @statsStoryProtectionTrendDownDetails.
  ///
  /// In en, this message translates to:
  /// **'Protection use dropped from {previous}% to {current}% in this period. This is a good signal to keep an eye on.'**
  String statsStoryProtectionTrendDownDetails(Object current, Object previous);

  /// No description provided for @statsStoryPrimeTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Prime time'**
  String get statsStoryPrimeTimeTitle;

  /// No description provided for @statsStoryPrimeTimeSupporting.
  ///
  /// In en, this message translates to:
  /// **'Average rating {rating}'**
  String statsStoryPrimeTimeSupporting(Object rating);

  /// No description provided for @statsStoryPrimeTimeDetails.
  ///
  /// In en, this message translates to:
  /// **'Your best recent ratings cluster around {slot}. That looks like one of your highest-upside windows.'**
  String statsStoryPrimeTimeDetails(Object slot);

  /// No description provided for @statsStoryPeakMonthTitle.
  ///
  /// In en, this message translates to:
  /// **'Peak month'**
  String get statsStoryPeakMonthTitle;

  /// No description provided for @statsStoryPeakMonthSupporting.
  ///
  /// In en, this message translates to:
  /// **'Average rating {rating}'**
  String statsStoryPeakMonthSupporting(Object rating);

  /// No description provided for @statsStoryPeakMonthDetails.
  ///
  /// In en, this message translates to:
  /// **'{month} stands out as your strongest month in this view. It is a useful benchmark for the kind of rhythm you may want to recreate.'**
  String statsStoryPeakMonthDetails(Object month);

  /// No description provided for @statsStoryWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get statsStoryWeekdayMon;

  /// No description provided for @statsStoryWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get statsStoryWeekdayTue;

  /// No description provided for @statsStoryWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get statsStoryWeekdayWed;

  /// No description provided for @statsStoryWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get statsStoryWeekdayThu;

  /// No description provided for @statsStoryWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get statsStoryWeekdayFri;

  /// No description provided for @statsStoryWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get statsStoryWeekdaySat;

  /// No description provided for @statsStoryWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get statsStoryWeekdaySun;

  /// No description provided for @statsStoryDayTimeMorning.
  ///
  /// In en, this message translates to:
  /// **'morning'**
  String get statsStoryDayTimeMorning;

  /// No description provided for @statsStoryDayTimeAfternoon.
  ///
  /// In en, this message translates to:
  /// **'afternoon'**
  String get statsStoryDayTimeAfternoon;

  /// No description provided for @statsStoryDayTimeNight.
  ///
  /// In en, this message translates to:
  /// **'night'**
  String get statsStoryDayTimeNight;

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

  /// No description provided for @liteMonthlyEncounterLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Lite mode allows up to 5 records per month.'**
  String get liteMonthlyEncounterLimitReached;

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

  /// No description provided for @insightBestTagComboTitle.
  ///
  /// In en, this message translates to:
  /// **'Best Tag Combo'**
  String get insightBestTagComboTitle;

  /// No description provided for @insightBestTagComboDescription.
  ///
  /// In en, this message translates to:
  /// **'When {tags} show up together, your average rating climbs to {avg}/10.'**
  String insightBestTagComboDescription(Object tags, Object avg);

  /// No description provided for @insightMostConsistentPartnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Most Consistent Partner'**
  String get insightMostConsistentPartnerTitle;

  /// No description provided for @insightMostConsistentPartnerDescription.
  ///
  /// In en, this message translates to:
  /// **'{partner} is your most consistent connection, averaging {avg}/10.'**
  String insightMostConsistentPartnerDescription(Object partner, Object avg);

  /// No description provided for @insightMostUnpredictablePartnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Most Unpredictable Partner'**
  String get insightMostUnpredictablePartnerTitle;

  /// No description provided for @insightMostUnpredictablePartnerDescription.
  ///
  /// In en, this message translates to:
  /// **'{partner} shows the widest swings lately, with a variability score of {spread}.'**
  String insightMostUnpredictablePartnerDescription(
    Object partner,
    Object spread,
  );

  /// No description provided for @insightBestRecentPartnerTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Best Recent Partner Trend'**
  String get insightBestRecentPartnerTrendTitle;

  /// No description provided for @insightBestRecentPartnerTrendDescription.
  ///
  /// In en, this message translates to:
  /// **'{partner} is trending up, improving by about {diff} points in your latest encounters.'**
  String insightBestRecentPartnerTrendDescription(Object partner, Object diff);

  /// No description provided for @insightRecentChemistryTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Chemistry'**
  String get insightRecentChemistryTitle;

  /// No description provided for @insightRecentChemistryDescription.
  ///
  /// In en, this message translates to:
  /// **'{partner} has your strongest recent chemistry with an average of {avg}/10.'**
  String insightRecentChemistryDescription(Object partner, Object avg);

  /// No description provided for @insightProtectionRecentlyDroppedTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection Recently Dropped'**
  String get insightProtectionRecentlyDroppedTitle;

  /// No description provided for @insightProtectionRecentlyDroppedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your recent protection use is down to {recent}% compared with {previous}% in your earlier records.'**
  String insightProtectionRecentlyDroppedDescription(
    Object recent,
    Object previous,
  );

  /// No description provided for @insightLongActivityPauseTitle.
  ///
  /// In en, this message translates to:
  /// **'Long Activity Pause'**
  String get insightLongActivityPauseTitle;

  /// No description provided for @insightLongActivityPauseDescription.
  ///
  /// In en, this message translates to:
  /// **'It\'s been about {days} days since your last logged encounter. That pause might be worth checking in on.'**
  String insightLongActivityPauseDescription(Object days);

  /// No description provided for @insightHealthCheckOverdueTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Check Overdue'**
  String get insightHealthCheckOverdueTitle;

  /// No description provided for @insightHealthCheckOverdueDescription.
  ///
  /// In en, this message translates to:
  /// **'Your last Health Passport log was about {months} months ago. It may be a good time to schedule another check.'**
  String insightHealthCheckOverdueDescription(Object months);

  /// No description provided for @insightStrongestRecentMonthTitle.
  ///
  /// In en, this message translates to:
  /// **'Strongest Recent Month'**
  String get insightStrongestRecentMonthTitle;

  /// No description provided for @insightStrongestRecentMonthDescription.
  ///
  /// In en, this message translates to:
  /// **'{month} stands out with {count} encounters and an average rating of {avg}/10.'**
  String insightStrongestRecentMonthDescription(
    Object month,
    Object count,
    Object avg,
  );

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

  /// No description provided for @homePeopleTab.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get homePeopleTab;

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

  /// No description provided for @fakeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get fakeToday;

  /// No description provided for @fakeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get fakeYesterday;

  /// No description provided for @fakeFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get fakeFilterAll;

  /// No description provided for @fakeFilterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get fakeFilterPending;

  /// No description provided for @fakeFilterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get fakeFilterCompleted;

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

  /// No description provided for @healthAddRecordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your personal health record current with clear, private checkup entries.'**
  String get healthAddRecordSubtitle;

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

  /// No description provided for @addEntryPartnerRequired.
  ///
  /// In en, this message translates to:
  /// **'Partner name is required'**
  String get addEntryPartnerRequired;

  /// No description provided for @addEntryPartnerSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select partner'**
  String get addEntryPartnerSheetTitle;

  /// No description provided for @addEntryPartnerCreateOption.
  ///
  /// In en, this message translates to:
  /// **'Create \"@{name}\"'**
  String addEntryPartnerCreateOption(Object name);

  /// No description provided for @sharePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get sharePreviewTitle;

  /// No description provided for @sharePreviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your premium season snapshot is ready to share.'**
  String get sharePreviewSubtitle;

  /// No description provided for @sharePreviewAction.
  ///
  /// In en, this message translates to:
  /// **'Share card'**
  String get sharePreviewAction;

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

  /// No description provided for @trophyAbstinenceRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Abstinence Records'**
  String get trophyAbstinenceRecordsTitle;

  /// No description provided for @trophyAbstinenceRecordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your best streaks achieved'**
  String get trophyAbstinenceRecordsSubtitle;

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

  /// No description provided for @challengeSeasonal.
  ///
  /// In en, this message translates to:
  /// **'Seasonal'**
  String get challengeSeasonal;

  /// No description provided for @challengeHistorical.
  ///
  /// In en, this message translates to:
  /// **'Historical'**
  String get challengeHistorical;

  /// No description provided for @challengeXpReward.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String challengeXpReward(Object xp);

  /// No description provided for @challengeCategoryFoundation.
  ///
  /// In en, this message translates to:
  /// **'Foundation'**
  String get challengeCategoryFoundation;

  /// No description provided for @challengeCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get challengeCategoryAll;

  /// No description provided for @challengeCategorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get challengeCategorySocial;

  /// No description provided for @challengeCategoryEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get challengeCategoryEvents;

  /// No description provided for @challengeCategoryRelationships.
  ///
  /// In en, this message translates to:
  /// **'Relationships'**
  String get challengeCategoryRelationships;

  /// No description provided for @challengeCategoryMood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get challengeCategoryMood;

  /// No description provided for @challengeCategorySkill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get challengeCategorySkill;

  /// No description provided for @challengeCategoryLegacy.
  ///
  /// In en, this message translates to:
  /// **'Legacy'**
  String get challengeCategoryLegacy;

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
  /// **'Log 8 encounters in the last 7 days with an average rating of 8.0+.'**
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

  /// No description provided for @challengeQualityStreak3Title.
  ///
  /// In en, this message translates to:
  /// **'Quality Streak'**
  String get challengeQualityStreak3Title;

  /// No description provided for @challengeQualityStreak3Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 3 consecutive encounters rated 8 or higher in the current season.'**
  String get challengeQualityStreak3Desc;

  /// No description provided for @challengeQualityStreak5Title.
  ///
  /// In en, this message translates to:
  /// **'Unstoppable Quality'**
  String get challengeQualityStreak5Title;

  /// No description provided for @challengeQualityStreak5Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 consecutive encounters rated 8 or higher across your full history.'**
  String get challengeQualityStreak5Desc;

  /// No description provided for @challengeBalancedWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'Balanced Week'**
  String get challengeBalancedWeekTitle;

  /// No description provided for @challengeBalancedWeekDesc.
  ///
  /// In en, this message translates to:
  /// **'Log encounters on 3 distinct days within the last 7 days.'**
  String get challengeBalancedWeekDesc;

  /// No description provided for @challengeTagCombo5Title.
  ///
  /// In en, this message translates to:
  /// **'Tag Combo'**
  String get challengeTagCombo5Title;

  /// No description provided for @challengeTagCombo5Desc.
  ///
  /// In en, this message translates to:
  /// **'Use 5 distinct tags during the current season.'**
  String get challengeTagCombo5Desc;

  /// No description provided for @challengeSocialCircle3Title.
  ///
  /// In en, this message translates to:
  /// **'Social Circle'**
  String get challengeSocialCircle3Title;

  /// No description provided for @challengeSocialCircle3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log encounters with 3 distinct partners this season.'**
  String get challengeSocialCircle3Desc;

  /// No description provided for @challengeQualityNetwork3Title.
  ///
  /// In en, this message translates to:
  /// **'Quality Network'**
  String get challengeQualityNetwork3Title;

  /// No description provided for @challengeQualityNetwork3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log encounters this season with 3 distinct partners, each rated 8 or higher.'**
  String get challengeQualityNetwork3Desc;

  /// No description provided for @challengeSafeNetwork3Title.
  ///
  /// In en, this message translates to:
  /// **'Safe Network'**
  String get challengeSafeNetwork3Title;

  /// No description provided for @challengeSafeNetwork3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log protected encounters this season with 3 distinct partners.'**
  String get challengeSafeNetwork3Desc;

  /// No description provided for @challengeWeekendRun2Title.
  ///
  /// In en, this message translates to:
  /// **'Weekend Run'**
  String get challengeWeekendRun2Title;

  /// No description provided for @challengeWeekendRun2Desc.
  ///
  /// In en, this message translates to:
  /// **'Log encounters on 2 consecutive weekends during this season.'**
  String get challengeWeekendRun2Desc;

  /// No description provided for @challengeSocialWeekend3Title.
  ///
  /// In en, this message translates to:
  /// **'Social Weekend'**
  String get challengeSocialWeekend3Title;

  /// No description provided for @challengeSocialWeekend3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log weekend encounters with 3 distinct partners this season.'**
  String get challengeSocialWeekend3Desc;

  /// No description provided for @challengeEventMix3Title.
  ///
  /// In en, this message translates to:
  /// **'Event Mix'**
  String get challengeEventMix3Title;

  /// No description provided for @challengeEventMix3Desc.
  ///
  /// In en, this message translates to:
  /// **'Use 3 distinct event tags this season.'**
  String get challengeEventMix3Desc;

  /// No description provided for @challengeGetawayDuo2Title.
  ///
  /// In en, this message translates to:
  /// **'Getaway Duo'**
  String get challengeGetawayDuo2Title;

  /// No description provided for @challengeGetawayDuo2Desc.
  ///
  /// In en, this message translates to:
  /// **'Log 2 encounters this season with getaway tags.'**
  String get challengeGetawayDuo2Desc;

  /// No description provided for @challengeMoodSpectrum3Title.
  ///
  /// In en, this message translates to:
  /// **'Mood Spectrum'**
  String get challengeMoodSpectrum3Title;

  /// No description provided for @challengeMoodSpectrum3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log 3 distinct moods during this season.'**
  String get challengeMoodSpectrum3Desc;

  /// No description provided for @challengeHighSpirits3Title.
  ///
  /// In en, this message translates to:
  /// **'High Spirits'**
  String get challengeHighSpirits3Title;

  /// No description provided for @challengeHighSpirits3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log 3 encounters this season with a mood selected and rating 8 or higher.'**
  String get challengeHighSpirits3Desc;

  /// No description provided for @challengeSkillMix3Title.
  ///
  /// In en, this message translates to:
  /// **'Skill Mix'**
  String get challengeSkillMix3Title;

  /// No description provided for @challengeSkillMix3Desc.
  ///
  /// In en, this message translates to:
  /// **'Use 3 distinct practice tags this season.'**
  String get challengeSkillMix3Desc;

  /// No description provided for @challengePleasureCrafter3Title.
  ///
  /// In en, this message translates to:
  /// **'Pleasure Crafter'**
  String get challengePleasureCrafter3Title;

  /// No description provided for @challengePleasureCrafter3Desc.
  ///
  /// In en, this message translates to:
  /// **'Log 3 encounters this season with practice tags and rating 8 or higher.'**
  String get challengePleasureCrafter3Desc;

  /// No description provided for @challengeConnectionArc3Title.
  ///
  /// In en, this message translates to:
  /// **'Connection Arc'**
  String get challengeConnectionArc3Title;

  /// No description provided for @challengeConnectionArc3Desc.
  ///
  /// In en, this message translates to:
  /// **'Use 3 relationship-dynamic tags this season.'**
  String get challengeConnectionArc3Desc;

  /// No description provided for @challengeDateNight2Title.
  ///
  /// In en, this message translates to:
  /// **'Date Night'**
  String get challengeDateNight2Title;

  /// No description provided for @challengeDateNight2Desc.
  ///
  /// In en, this message translates to:
  /// **'Log 2 encounters this season with romantic tags.'**
  String get challengeDateNight2Desc;

  /// No description provided for @challengeSinglePartnerSeasonTitle.
  ///
  /// In en, this message translates to:
  /// **'One Partner Only'**
  String get challengeSinglePartnerSeasonTitle;

  /// No description provided for @challengeSinglePartnerSeasonDesc.
  ///
  /// In en, this message translates to:
  /// **'Log 8 encounters this season with only one partner. A second partner breaks the challenge.'**
  String get challengeSinglePartnerSeasonDesc;

  /// No description provided for @challengeLoyalMonthTitle.
  ///
  /// In en, this message translates to:
  /// **'Loyal Month'**
  String get challengeLoyalMonthTitle;

  /// No description provided for @challengeLoyalMonthDesc.
  ///
  /// In en, this message translates to:
  /// **'Log 12 encounters this season with only one partner. A second partner breaks the challenge.'**
  String get challengeLoyalMonthDesc;

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

  /// No description provided for @challengeSinglePartner100Title.
  ///
  /// In en, this message translates to:
  /// **'Same Story'**
  String get challengeSinglePartner100Title;

  /// No description provided for @challengeSinglePartner100Desc.
  ///
  /// In en, this message translates to:
  /// **'Accumulate 100 encounters with a single partner.'**
  String get challengeSinglePartner100Desc;

  /// No description provided for @challengeSinglePartner500Title.
  ///
  /// In en, this message translates to:
  /// **'Legendary Bond'**
  String get challengeSinglePartner500Title;

  /// No description provided for @challengeSinglePartner500Desc.
  ///
  /// In en, this message translates to:
  /// **'Accumulate 500 encounters with a single partner.'**
  String get challengeSinglePartner500Desc;

  /// No description provided for @challengeSteadyBond50Title.
  ///
  /// In en, this message translates to:
  /// **'Safe Bond'**
  String get challengeSteadyBond50Title;

  /// No description provided for @challengeSteadyBond50Desc.
  ///
  /// In en, this message translates to:
  /// **'Accumulate 50 protected encounters with a single partner across your full history.'**
  String get challengeSteadyBond50Desc;

  /// No description provided for @challengeConstellation10Title.
  ///
  /// In en, this message translates to:
  /// **'Constellation'**
  String get challengeConstellation10Title;

  /// No description provided for @challengeConstellation10Desc.
  ///
  /// In en, this message translates to:
  /// **'Log encounters with 10 distinct partners across your full history.'**
  String get challengeConstellation10Desc;

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

  /// No description provided for @challengeAbstinence21Title.
  ///
  /// In en, this message translates to:
  /// **'21-Day Abstinence'**
  String get challengeAbstinence21Title;

  /// No description provided for @challengeAbstinence21Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 21-day streak without logging encounters.'**
  String get challengeAbstinence21Desc;

  /// No description provided for @challengeAbstinence30Title.
  ///
  /// In en, this message translates to:
  /// **'30-Day Abstinence'**
  String get challengeAbstinence30Title;

  /// No description provided for @challengeAbstinence30Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 30-day streak without logging encounters.'**
  String get challengeAbstinence30Desc;

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

  /// No description provided for @trophyRoomSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your rank, streaks, and seasonal achievements in one premium space.'**
  String get trophyRoomSubtitle;

  /// No description provided for @trophySeasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get trophySeasonLabel;

  /// No description provided for @trophyCurrentShort.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get trophyCurrentShort;

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

  /// No description provided for @trophyActivityRhythm.
  ///
  /// In en, this message translates to:
  /// **'Activity Rhythm'**
  String get trophyActivityRhythm;

  /// No description provided for @trophyNightOwl.
  ///
  /// In en, this message translates to:
  /// **'You are a night owl'**
  String get trophyNightOwl;

  /// No description provided for @trophyDayExplorer.
  ///
  /// In en, this message translates to:
  /// **'You are more active during the day'**
  String get trophyDayExplorer;

  /// No description provided for @trophyRhythmDetail.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of your encounters happen between 10 PM and 2 AM.'**
  String trophyRhythmDetail(Object percent);

  /// No description provided for @trophyRhythmPeakWindowDetail.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of your encounters happen between {range}.'**
  String trophyRhythmPeakWindowDetail(Object percent, Object range);

  /// No description provided for @trophyRhythmVibeNight1.
  ///
  /// In en, this message translates to:
  /// **'You are a night beast'**
  String get trophyRhythmVibeNight1;

  /// No description provided for @trophyRhythmVibeNight2.
  ///
  /// In en, this message translates to:
  /// **'Moon mode: activated'**
  String get trophyRhythmVibeNight2;

  /// No description provided for @trophyRhythmVibeNight3.
  ///
  /// In en, this message translates to:
  /// **'Your prime time starts after dark'**
  String get trophyRhythmVibeNight3;

  /// No description provided for @trophyRhythmVibeDay1.
  ///
  /// In en, this message translates to:
  /// **'You run on pure daylight energy'**
  String get trophyRhythmVibeDay1;

  /// No description provided for @trophyRhythmVibeDay2.
  ///
  /// In en, this message translates to:
  /// **'Sunlight champion, no doubt'**
  String get trophyRhythmVibeDay2;

  /// No description provided for @trophyRhythmVibeDay3.
  ///
  /// In en, this message translates to:
  /// **'Day shift MVP'**
  String get trophyRhythmVibeDay3;

  /// No description provided for @trophyRhythmDominantLabel.
  ///
  /// In en, this message translates to:
  /// **'Dominant pattern'**
  String get trophyRhythmDominantLabel;

  /// No description provided for @trophyRhythmDominantDay.
  ///
  /// In en, this message translates to:
  /// **'More daytime'**
  String get trophyRhythmDominantDay;

  /// No description provided for @trophyRhythmDominantNight.
  ///
  /// In en, this message translates to:
  /// **'More nighttime'**
  String get trophyRhythmDominantNight;

  /// No description provided for @trophyPeakHour.
  ///
  /// In en, this message translates to:
  /// **'Peak hour'**
  String get trophyPeakHour;

  /// No description provided for @trophyWeeklyActivity.
  ///
  /// In en, this message translates to:
  /// **'Weekly activity'**
  String get trophyWeeklyActivity;

  /// No description provided for @trophyWeeklyActivityNoData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data'**
  String get trophyWeeklyActivityNoData;

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

  /// No description provided for @achievementAbstinenceBronzeName.
  ///
  /// In en, this message translates to:
  /// **'Abstinence Bronze'**
  String get achievementAbstinenceBronzeName;

  /// No description provided for @achievementAbstinenceBronzeDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 7 abstinence days during the current month.'**
  String get achievementAbstinenceBronzeDesc;

  /// No description provided for @achievementAbstinenceSilverName.
  ///
  /// In en, this message translates to:
  /// **'Abstinence Silver'**
  String get achievementAbstinenceSilverName;

  /// No description provided for @achievementAbstinenceSilverDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 14 abstinence days during the current month.'**
  String get achievementAbstinenceSilverDesc;

  /// No description provided for @achievementAbstinenceGoldName.
  ///
  /// In en, this message translates to:
  /// **'Abstinence Gold'**
  String get achievementAbstinenceGoldName;

  /// No description provided for @achievementAbstinenceGoldDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 30 abstinence days during the current month.'**
  String get achievementAbstinenceGoldDesc;

  /// No description provided for @achievementAbstinenceDiamondName.
  ///
  /// In en, this message translates to:
  /// **'Abstinence Diamond'**
  String get achievementAbstinenceDiamondName;

  /// No description provided for @achievementAbstinenceDiamondDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach 60 historical abstinence days.'**
  String get achievementAbstinenceDiamondDesc;

  /// No description provided for @achievementAbstinenceMaster45Name.
  ///
  /// In en, this message translates to:
  /// **'Abstinence 45'**
  String get achievementAbstinenceMaster45Name;

  /// No description provided for @achievementAbstinenceMaster45Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach 45 historical abstinence days.'**
  String get achievementAbstinenceMaster45Desc;

  /// No description provided for @achievementAbstinenceMaster90Name.
  ///
  /// In en, this message translates to:
  /// **'Abstinence 90'**
  String get achievementAbstinenceMaster90Name;

  /// No description provided for @achievementAbstinenceMaster90Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach 90 historical abstinence days.'**
  String get achievementAbstinenceMaster90Desc;

  /// No description provided for @achievementAbstinenceMaster120Name.
  ///
  /// In en, this message translates to:
  /// **'Abstinence 120'**
  String get achievementAbstinenceMaster120Name;

  /// No description provided for @achievementAbstinenceMaster120Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach 120 historical abstinence days.'**
  String get achievementAbstinenceMaster120Desc;

  /// No description provided for @achievementMonkModeName.
  ///
  /// In en, this message translates to:
  /// **'Monk Mode'**
  String get achievementMonkModeName;

  /// No description provided for @achievementMonkModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep 100% abstinence during the current month.'**
  String get achievementMonkModeDesc;

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

  /// No description provided for @trophyBadgeUnlockedInSeasons.
  ///
  /// In en, this message translates to:
  /// **'Unlocked in {count} season(s)'**
  String trophyBadgeUnlockedInSeasons(Object count);

  /// No description provided for @trophyBadgeNotUnlockedHistory.
  ///
  /// In en, this message translates to:
  /// **'You have not unlocked this badge yet.'**
  String get trophyBadgeNotUnlockedHistory;

  /// No description provided for @trophyBadgeOneTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'One-time achievement'**
  String get trophyBadgeOneTimeTitle;

  /// No description provided for @trophyBadgeOneTimeUnlocked.
  ///
  /// In en, this message translates to:
  /// **'You have already unlocked this badge.'**
  String get trophyBadgeOneTimeUnlocked;

  /// No description provided for @trophyBadgeStatusUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get trophyBadgeStatusUnlocked;

  /// No description provided for @trophyBadgeStatusLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get trophyBadgeStatusLocked;

  /// No description provided for @trophyBadgeModalFootnote.
  ///
  /// In en, this message translates to:
  /// **'Every badge reflects your progress across seasons, milestones, and personal consistency.'**
  String get trophyBadgeModalFootnote;

  /// No description provided for @trophyBadgeRuleTitleExclusive.
  ///
  /// In en, this message translates to:
  /// **'Season rule: one partner'**
  String get trophyBadgeRuleTitleExclusive;

  /// No description provided for @trophyBadgeRuleBodyExclusive.
  ///
  /// In en, this message translates to:
  /// **'Unlock this badge by reaching 8 encounters in the current season and keeping every one of them with the same partner.'**
  String get trophyBadgeRuleBodyExclusive;

  /// No description provided for @trophyBadgeRuleTitleVariety.
  ///
  /// In en, this message translates to:
  /// **'Season rule: multiple partners'**
  String get trophyBadgeRuleTitleVariety;

  /// No description provided for @trophyBadgeRuleBodyVariety.
  ///
  /// In en, this message translates to:
  /// **'Unlock this badge when the current season includes encounters with 3 different partners.'**
  String get trophyBadgeRuleBodyVariety;

  /// No description provided for @trophyShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get trophyShowMore;

  /// No description provided for @trophyShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get trophyShowLess;

  /// No description provided for @monetizationPremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTCH Premium'**
  String get monetizationPremiumTitle;

  /// No description provided for @monetizationManagePlansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage plans and restore purchases'**
  String get monetizationManagePlansSubtitle;

  /// No description provided for @monetizationActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTCH Premium active'**
  String get monetizationActiveTitle;

  /// No description provided for @monetizationActiveDescription.
  ///
  /// In en, this message translates to:
  /// **'You already have full access to premium features.'**
  String get monetizationActiveDescription;

  /// No description provided for @monetizationContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get monetizationContinue;

  /// No description provided for @monetizationUnlockAll.
  ///
  /// In en, this message translates to:
  /// **'Unlock all advanced features.'**
  String get monetizationUnlockAll;

  /// No description provided for @monetizationUnlockFeature.
  ///
  /// In en, this message translates to:
  /// **'Unlock: {feature}'**
  String monetizationUnlockFeature(Object feature);

  /// No description provided for @monetizationFallbackDescription.
  ///
  /// In en, this message translates to:
  /// **'Advanced privacy, encrypted backups, complete insights, and more.'**
  String get monetizationFallbackDescription;

  /// No description provided for @monetizationRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get monetizationRestorePurchases;

  /// No description provided for @monetizationStoreUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Products could not be loaded. Verify the IDs in App Store Connect / Play Console.'**
  String get monetizationStoreUnavailable;

  /// No description provided for @monetizationRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get monetizationRecommended;

  /// No description provided for @monetizationContinueWithPrice.
  ///
  /// In en, this message translates to:
  /// **'Continue - {price}'**
  String monetizationContinueWithPrice(Object price);

  /// No description provided for @premiumFeatureInsightsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover full correlations and trends from your history.'**
  String get premiumFeatureInsightsDescription;

  /// No description provided for @premiumFeatureDataBackupDescription.
  ///
  /// In en, this message translates to:
  /// **'Export, restore, and protect your history when changing devices.'**
  String get premiumFeatureDataBackupDescription;

  /// No description provided for @premiumFeatureHealthPassportDescription.
  ///
  /// In en, this message translates to:
  /// **'Log health checks and schedule automatic reminders.'**
  String get premiumFeatureHealthPassportDescription;

  /// No description provided for @premiumFeatureBlackBookDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock detailed profiles, private notes, and customization.'**
  String get premiumFeatureBlackBookDescription;

  /// No description provided for @monetizationOpenNativePaywall.
  ///
  /// In en, this message translates to:
  /// **'Open RevenueCat Paywall'**
  String get monetizationOpenNativePaywall;

  /// No description provided for @settingsCustomerCenter.
  ///
  /// In en, this message translates to:
  /// **'Customer Center'**
  String get settingsCustomerCenter;

  /// No description provided for @settingsCustomerCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage subscriptions and billing'**
  String get settingsCustomerCenterSubtitle;

  /// No description provided for @homeAbstinenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Abstinence Time'**
  String get homeAbstinenceTitle;

  /// No description provided for @homeAbstinenceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Since your last encounter'**
  String get homeAbstinenceSubtitle;

  /// No description provided for @homeAbstinenceNoDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No encounters logged yet.'**
  String get homeAbstinenceNoDataSubtitle;

  /// No description provided for @homeAbstinenceNoDataValue.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get homeAbstinenceNoDataValue;

  /// No description provided for @homeAbstinenceDuration.
  ///
  /// In en, this message translates to:
  /// **'{days} days {hours} hours {minutes} minutes'**
  String homeAbstinenceDuration(Object days, Object hours, Object minutes);
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
