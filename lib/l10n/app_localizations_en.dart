// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome to NOTCH';

  @override
  String get authReason => 'Please authenticate to access your logs';

  @override
  String get save => 'Save Notch';

  @override
  String get mood => 'Mood';

  @override
  String get partner => 'Partner';

  @override
  String get tags => 'Tags';

  @override
  String get orgasms => 'Orgasms';

  @override
  String get usedProtection => 'Used Protection';

  @override
  String get rating => 'Rating';

  @override
  String get safe => 'Safe';

  @override
  String get unsafe => 'Unsafe';

  @override
  String get tagMorning => 'Morning Wood';

  @override
  String get tagQuickie => 'Quickie';

  @override
  String get tagOral => 'Oral';

  @override
  String get tagAnal => 'Anal';

  @override
  String get tagToys => 'Toys';

  @override
  String get tagDate => 'Date Night';

  @override
  String get tagTravel => 'Travel';

  @override
  String get tagKinky => 'Kinky';

  @override
  String get tagOutdoor => 'Outdoor';

  @override
  String get tagAnniversary => 'Anniversary';

  @override
  String get tagOns => 'One-Night Stand';

  @override
  String get tagFwb => 'Friends w/ Benefits';

  @override
  String get tagReconciliation => 'Make-up Sex';

  @override
  String get tagCelebration => 'Celebration';

  @override
  String get tagVanilla => 'Vanilla';

  @override
  String get tagDomsub => 'Dom/Sub';

  @override
  String get tagMassage => 'Erotic Massage';

  @override
  String get tagCar => 'Car Sex';

  @override
  String get tagHotel => 'Hotel';

  @override
  String get tagShower => 'Shower / Bath';

  @override
  String get insightsTitle => 'Data Intelligence';

  @override
  String get insightsEmpty =>
      'Not enough data to generate insights yet.\\nKeep logging!';

  @override
  String get insightsHeroEyebrow => 'EDITORIAL READOUT';

  @override
  String get insightsHeroEmptyTitle =>
      'Your intelligence layer is ready to learn.';

  @override
  String get insightsHeroEmptyBody =>
      'Start logging encounters or health checks and this screen will turn them into guided patterns, watchouts, and premium signals.';

  @override
  String get insightsHeroHealthTitle =>
      'Health signals deserve closer attention.';

  @override
  String get insightsHeroHealthBody =>
      'Your recent sexual-health data suggests this is a good moment to slow down, review protection habits, and keep your records updated.';

  @override
  String get insightsHeroProtectionTitle =>
      'Protection is shaping a strong baseline.';

  @override
  String insightsHeroProtectionBody(Object rate) {
    return '$rate% of your encounters were protected, which is giving this period a safer and more stable profile.';
  }

  @override
  String get insightsHeroRhythmTitle => 'Your current rhythm is readable.';

  @override
  String insightsHeroRhythmBody(Object rating) {
    return 'Recent encounters are averaging $rating, giving this period enough signal to extract patterns and watchouts.';
  }

  @override
  String get insightsHeroChipStarting => 'Starting fresh';

  @override
  String get insightsHeroChipNoSignals => 'No signals yet';

  @override
  String insightsHeroProtectionChip(Object rate) {
    return '$rate% protected';
  }

  @override
  String insightsHeroQualityChip(Object rating) {
    return 'Avg rating $rating';
  }

  @override
  String insightsHeroEncountersChip(Object count) {
    return '$count encounters logged';
  }

  @override
  String insightsHeroHealthLogsChip(Object count) {
    return '$count health logs tracked';
  }

  @override
  String get insightsBestPatternLabel => 'Best pattern';

  @override
  String insightsBestPatternPartnerHeadline(Object partner) {
    return '$partner is your strongest pattern so far.';
  }

  @override
  String insightsBestPatternPartnerBody(Object rating) {
    return 'This connection is averaging $rating, making it your clearest quality signal in the current data.';
  }

  @override
  String insightsBestPatternRhythmHeadline(Object day) {
    return '$day is giving you the best rhythm.';
  }

  @override
  String insightsBestPatternRhythmBody(Object tag) {
    return 'The tag \"$tag\" appears most often and helps define the strongest context in your logs.';
  }

  @override
  String insightsBestPatternPartnerDetail(Object partner) {
    return 'Across your current records, this partner stands out as the clearest positive pattern because the experience quality remains consistently stronger than the rest of the dataset. This is less about frequency alone and more about repeat quality.';
  }

  @override
  String get insightsBestPatternPartnerRecommendation =>
      'Use this pattern as a benchmark: notice the context, pace, timing, and emotional setup that tend to make these encounters work better.';

  @override
  String insightsBestPatternRhythmDetail(Object day) {
    return 'Your current data suggests that this day creates a more favorable rhythm than the rest of the week. Even if the sample is still growing, it already behaves like a stronger window for better outcomes.';
  }

  @override
  String get insightsBestPatternRhythmRecommendation =>
      'If you want to improve consistency, try protecting and repeating the conditions that usually happen around this rhythm.';

  @override
  String get insightsWatchoutLabel => 'Watchout';

  @override
  String get insightsWatchoutHealthHeadline =>
      'Recent health records need a closer read.';

  @override
  String get insightsWatchoutHealthBody =>
      'One of your latest health logs is positive or pending, so this period should be read with more caution than usual.';

  @override
  String get insightsWatchoutHealthDetail =>
      'This does not replace medical guidance, but it does mean your current sexual-health context has an unresolved signal. In product terms, this is one of the strongest reasons to temporarily shift from performance reading to caution reading.';

  @override
  String get insightsWatchoutHealthRecommendation =>
      'Pause risky patterns, prioritize follow-up, and keep your next health update logged so this screen can reflect a fresher status.';

  @override
  String get insightsWatchoutProtectionHeadline =>
      'Protection is softer than your ideal baseline.';

  @override
  String insightsWatchoutProtectionBody(Object rate) {
    return 'Only $rate% of your encounters were protected, which raises the importance of caution and follow-up.';
  }

  @override
  String get insightsWatchoutProtectionDetail =>
      'Your recent protection behavior is not yet catastrophic, but it is soft enough to deserve attention. When protection slips, the rest of the screen should be read with more caution, even if quality or rhythm still look strong.';

  @override
  String get insightsWatchoutProtectionRecommendation =>
      'Reinforce safer defaults in the moments where spontaneity usually overrides preparation.';

  @override
  String get insightsWatchoutQualityHeadline =>
      'Quality is showing more friction than flow.';

  @override
  String get insightsWatchoutQualityBody =>
      'Average ratings are low enough to suggest this period may need more intention, recovery, or context changes.';

  @override
  String get insightsWatchoutQualityDetail =>
      'Low averages usually mean the issue is not just one encounter but a repeated mismatch in context, energy, or connection. This is useful because it points to a pattern you can actually work on.';

  @override
  String get insightsWatchoutQualityRecommendation =>
      'Try changing one variable at a time: timing, pace, partner context, or recovery between encounters.';

  @override
  String get insightsWatchoutGapHeadline =>
      'The signal is clean, but spaced out.';

  @override
  String insightsWatchoutGapBody(Object days) {
    return 'Your latest encounter was $days days ago, so current patterns may still be early and less stable.';
  }

  @override
  String get insightsWatchoutGapDetail =>
      'Long gaps are not bad by themselves, but they reduce confidence in short-term pattern reading. The screen can still interpret your data, just with less certainty about what is current versus historical.';

  @override
  String get insightsWatchoutGapRecommendation =>
      'Let the next few logs rebuild momentum before treating this cycle as a firm pattern.';

  @override
  String get insightsHealthSnapshotLabel => 'Health snapshot';

  @override
  String get insightsHealthSnapshotEmptyHeadline => 'No health logs yet.';

  @override
  String get insightsHealthSnapshotEmptyBody =>
      'Adding tests and symptoms will make this screen sharper, especially for risk radar and long-term health intelligence.';

  @override
  String get insightsHealthSnapshotEmptyDetail =>
      'Right now, the app can read rhythm, quality, and protection, but it is still missing the health layer that makes the intelligence more grounded over time.';

  @override
  String get insightsHealthSnapshotEmptyRecommendation =>
      'Log your next check, result, or relevant symptom so the health layer becomes part of your editorial readout.';

  @override
  String insightsHealthSnapshotHeadline(Object result, Object type) {
    return 'Last recorded health signal: $result in $type.';
  }

  @override
  String insightsHealthSnapshotBody(Object months) {
    return 'That last update was $months month(s) ago, which helps define how fresh your health context is.';
  }

  @override
  String insightsHealthSnapshotDetail(Object type) {
    return 'This snapshot helps anchor the rest of the screen in something more durable than encounter-by-encounter variation. Even a single health record improves long-term interpretation.';
  }

  @override
  String get insightsHealthSnapshotRecommendation =>
      'Keep this layer fresh with periodic check-ins so the rest of your intelligence stays contextual, not isolated.';

  @override
  String get insightsRiskRadarTitle => 'Risk radar';

  @override
  String get insightsSheetRecommendation => 'Recommendation';

  @override
  String get insightsRiskProtection => 'Protection';

  @override
  String get insightsRiskRecovery => 'Recovery';

  @override
  String get insightsRiskVariability => 'Variability';

  @override
  String get insightsRiskLow => 'Low';

  @override
  String get insightsRiskGuarded => 'Guarded';

  @override
  String get insightsRiskHigh => 'High';

  @override
  String get insightsDynamicFeedTitle => 'More signals';

  @override
  String get insightsEmptyTitle => 'Your premium insights will appear here.';

  @override
  String get insightsEmptyBody =>
      'This screen becomes more useful once you log a few encounters or health checks. The more consistent the data, the sharper the editorial reading.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTagline => 'Private Intimacy Tracker';

  @override
  String get settingsHealthPassportSubtitle =>
      'Log health checks and schedule automatic reminders.';

  @override
  String get settingsGeneral => 'GENERAL';

  @override
  String get settingsAbout => 'ABOUT';

  @override
  String get settingsDangerZone => 'DANGER ZONE';

  @override
  String get settingsMaintenance => 'MAINTENANCE';

  @override
  String get settingsSecurityAccess => 'Security & Access';

  @override
  String get settingsSecurityAccessSubtitle =>
      'Configure PIN, Panic and Kill Switch';

  @override
  String get settingsDataBackup => 'Data & Backup';

  @override
  String get settingsDataBackupSubtitle => 'Backups and PDF export';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAboutApp => 'About the app';

  @override
  String get settingsAboutAppSubtitle =>
      'Why NOTCH exists and why it was created';

  @override
  String get settingsAboutAppTitle => 'About NOTCH';

  @override
  String get settingsAboutAppDescription =>
      'NOTCH exists to help you log your intimate activity in a private, secure, and intentional way. It was created because highly sensitive data should not live on external servers or be exposed to trackers. The app helps you understand patterns, improve your wellbeing, and keep full control of your information.';

  @override
  String get settingsAboutAppPillarPrivacyTitle => 'Privacy first';

  @override
  String get settingsAboutAppPillarPrivacyBody =>
      'Your data stays with you, with no servers and no trackers.';

  @override
  String get settingsAboutAppPillarPurposeTitle => 'Clear purpose';

  @override
  String get settingsAboutAppPillarPurposeBody =>
      'Turn your logs into useful insights for your wellbeing.';

  @override
  String get settingsAboutAppPillarControlTitle => 'Full control';

  @override
  String get settingsAboutAppPillarControlBody =>
      'You decide what to keep, export, or delete at any time.';

  @override
  String get settingsDeveloper => 'Developer';

  @override
  String get settingsDeveloperSubtitle => 'Built with privacy in mind';

  @override
  String get settingsAboutDevTitle => 'About the Dev';

  @override
  String get settingsAboutDevDescription =>
      'Hi, I\'m @christhoval, a fullstack engineer and Front-End Tech Lead based in Panama. I work with JavaScript and Python, and I build CLI tools, npm packages, and mobile apps. I focus on product, UX, and privacy by design. I created NOTCH because intimate data should stay in your hands: no servers, no trackers, and full control for you.';

  @override
  String get settingsAboutDevRoleTitle => 'Current role';

  @override
  String get settingsAboutDevRoleBody =>
      'Fullstack Engineer and Front-End Tech Lead.';

  @override
  String get settingsAboutDevStackTitle => 'Core stack';

  @override
  String get settingsAboutDevStackBody =>
      'JavaScript, TypeScript, Python, Flutter, CLI, and npm.';

  @override
  String get settingsAboutDevFocusTitle => 'Focus';

  @override
  String get settingsAboutDevFocusBody => 'Product, UX, and privacy by design.';

  @override
  String get settingsContactSupport => 'Contact / Support';

  @override
  String get settingsContactSupportSubtitle => 'Report bugs or suggest ideas';

  @override
  String get settingsResetApp => 'Reset App';

  @override
  String get settingsResetAppSubtitle => 'Delete all data and restart';

  @override
  String get settingsRecalculateAchievements => 'Recalculate Achievements';

  @override
  String get settingsRecalculateAchievementsSubtitle =>
      'Refresh your medals if you think one is missing.';

  @override
  String get settingsAchievementsUpdated =>
      'Achievements updated successfully.';

  @override
  String get settingsRecalculateXp => 'Recalculate Experience (XP)';

  @override
  String get settingsRecalculateXpSubtitle =>
      'Sync your level with your encounter history.';

  @override
  String get settingsXpUpdated => 'Experience (XP) updated successfully.';

  @override
  String get settingsMadeWithFlutter => 'Made with ❤️ & Flutter';

  @override
  String get settingsLanguageUpdated => 'Language updated';

  @override
  String settingsCouldNotOpen(Object url) {
    return 'Could not open $url';
  }

  @override
  String get settingsFactoryResetTitle => 'Factory Reset?';

  @override
  String get settingsFactoryResetMessage =>
      'This action will delete ALL your logs, partners, progress and security settings. It cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteAll => 'DELETE ALL';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingSlide1Title => 'Absolute Privacy. Zero Compromises.';

  @override
  String get onboardingSlide1Description =>
      'What happens in NOTCH stays in NOTCH. All your records are encrypted and stored only on your device. We don\'t use servers. Your intimate life is yours alone.';

  @override
  String get onboardingSlide2Title =>
      'Understand Your Patterns. Improve Your Well-being.';

  @override
  String get onboardingSlide2Description =>
      'Track your encounters to discover insights about your frequency, satisfaction and habits. NOTCH is your personal tool to better understand your sexual health.';

  @override
  String get onboardingSlide3Title =>
      'Measure Your Progress. Celebrate Milestones.';

  @override
  String get onboardingSlide3Description =>
      'Set goals, monitor streaks and follow your \'Path of Mastery\'. Gamification is designed to motivate you to be more aware and consistent with your well-being.';

  @override
  String get onboardingGoToApp => 'Got it, go to app';

  @override
  String get onboardingPinsTitle => 'Your Access Keys';

  @override
  String get onboardingPinsDescription =>
      'These are your default PINs. Memorize them and change them in Settings as soon as possible!';

  @override
  String get onboardingRealPin => 'REAL PIN';

  @override
  String get onboardingRealPinSubtitle => 'To access NOTCH.';

  @override
  String get onboardingPanicPin => 'PANIC PIN';

  @override
  String get onboardingPanicPinSubtitle => 'To open the fake app (tasks).';

  @override
  String get statsNoData => 'No data yet';

  @override
  String get statsPeriod30Days => '30 Days';

  @override
  String get statsPeriod6Months => '6 Months';

  @override
  String get statsPeriodTotal => 'Total';

  @override
  String get statsHighestRankReached => 'HIGHEST RANK REACHED';

  @override
  String statsXpTotal(Object xp) {
    return '$xp XP total';
  }

  @override
  String get pathTitle => 'Path of Mastery';

  @override
  String pathUnlockedAtXp(Object xp) {
    return 'Unlocked at $xp XP';
  }

  @override
  String get statsTotal => 'Total';

  @override
  String get statsAvgRating => 'Avg Rating';

  @override
  String get statsActivityDistribution => 'Activity Distribution';

  @override
  String get statsActivityLast6Months => 'Activity (Last 6 Months)';

  @override
  String get statsAnnualActivityMap => 'Annual Activity Map';

  @override
  String get statsActivityTrendTitle => 'Activity Trend';

  @override
  String get statsActivityMapTitle => 'Activity Map';

  @override
  String statsActivityMapSummary(Object count) {
    return '$count active days in this period.';
  }

  @override
  String get statsActivityLegendLess => 'Less';

  @override
  String get statsActivityLegendMore => 'More';

  @override
  String get statsPremiumHeroEyebrow => 'PREMIUM INTELLIGENCE';

  @override
  String get statsPremiumHeroQualityTitle => 'Quality is trending premium';

  @override
  String get statsPremiumHeroProtectionTitle =>
      'Protection discipline is leading';

  @override
  String get statsPremiumHeroPartnerTitle => 'This period has a clear favorite';

  @override
  String get statsPremiumHeroConsistencyTitle =>
      'Consistency is becoming a habit';

  @override
  String get statsPremiumHeroRhythmTitle => 'Your rhythm has a prime window';

  @override
  String statsPremiumHeroQualityBody(Object rating) {
    return 'Your average rating is $rating, making quality your strongest signal in this period.';
  }

  @override
  String statsPremiumHeroProtectionBody(Object rate) {
    return '$rate% of your encounters were protected, giving safety the strongest discipline signal right now.';
  }

  @override
  String statsPremiumHeroPartnerBody(Object partner, Object share) {
    return '$partner accounts for $share% of your encounters, shaping the tone of this period.';
  }

  @override
  String statsPremiumHeroConsistencyBody(Object days, Object span) {
    return 'You stayed active on $days different days across a $span day span, which is turning repetition into momentum.';
  }

  @override
  String statsPremiumHeroRhythmBody(Object bucket, Object share) {
    return '$bucket leads with $share% of your encounters, giving this period a distinct time signature.';
  }

  @override
  String statsPremiumSignalScore(Object score) {
    return '$score signal score';
  }

  @override
  String get statsPremiumTrendUp => 'Up vs previous period';

  @override
  String get statsPremiumTrendDown => 'Down vs previous period';

  @override
  String get statsPremiumTrendStable => 'Stable vs previous period';

  @override
  String get statsPremiumConsistencyTitle => 'Consistency';

  @override
  String get statsPremiumQualityTitle => 'Quality momentum';

  @override
  String get statsPremiumPartnerTitle => 'Partner mode';

  @override
  String statsPremiumConsistencyHeadline(Object days, Object span) {
    return '$days active days across $span days';
  }

  @override
  String statsPremiumQualityHeadline(Object rating) {
    return 'Average rating $rating';
  }

  @override
  String statsPremiumPartnerHeadline(Object partners, Object share) {
    return '$partners partner(s), $share% concentration';
  }

  @override
  String statsPremiumPartnerSupporting(Object partner, Object trend) {
    return 'Top partner: $partner. $trend.';
  }

  @override
  String statsPremiumSignalSupporting(Object trend) {
    return '$trend.';
  }

  @override
  String get statsPremiumDeckTitle => 'Premium readout';

  @override
  String get statsPremiumStoryQuality => 'Quality pulse';

  @override
  String get statsPremiumStoryProtection => 'Protection drift';

  @override
  String get statsPremiumStoryPartner => 'Partner focus';

  @override
  String get statsPremiumStoryConsistency => 'Consistency pulse';

  @override
  String get statsPremiumStoryRhythm => 'Rhythm dominance';

  @override
  String statsPremiumStoryQualityHeadline(Object rating) {
    return 'Quality is averaging $rating';
  }

  @override
  String statsPremiumStoryProtectionHeadline(Object rate) {
    return 'Protection sits at $rate%';
  }

  @override
  String statsPremiumStoryPartnerHeadline(Object partner) {
    return '$partner is defining this period';
  }

  @override
  String statsPremiumStoryConsistencyHeadline(Object days) {
    return '$days active days are shaping your cadence';
  }

  @override
  String statsPremiumStoryRhythmHeadline(Object bucket) {
    return '$bucket is your dominant lane';
  }

  @override
  String get statsPremiumStoryQualityBody =>
      'High ratings are becoming one of the strongest patterns in your recent data.';

  @override
  String get statsPremiumStoryProtectionBody =>
      'Your safety rate is now visible as a behavior trend, not just a one-off result.';

  @override
  String statsPremiumStoryPartnerBody(Object share) {
    return '$share% of your encounters concentrate around the same partner.';
  }

  @override
  String statsPremiumStoryConsistencyBody(Object span) {
    return 'This rhythm spans $span days and starts to show repeat intent instead of isolated logging.';
  }

  @override
  String statsPremiumStoryRhythmBody(Object count) {
    return '$count encounters happened inside that time window.';
  }

  @override
  String get statsPremiumUnknownPartner => 'your top partner';

  @override
  String statsActivitySelectedDay(Object count) {
    return '$count encounters selected';
  }

  @override
  String statsHeatmapSelection(Object date, Object count) {
    return '$date • $count encounters';
  }

  @override
  String statsHeatmapSelectionCount(Object count) {
    return '$count encounters';
  }

  @override
  String statsHeatmapDayInsight(Object count) {
    return 'You logged $count encounters on this day in the selected period.';
  }

  @override
  String get statsHeatmapTopPartnerLabel => 'Top partner';

  @override
  String get statsHeatmapTagsLabel => 'Tags used';

  @override
  String get statsHeatmapNoTags => 'No tags logged';

  @override
  String get statsHeatmapProtectionSafe => 'All protected';

  @override
  String get statsHeatmapProtectionMixed => 'Mixed protection';

  @override
  String get statsHeatmapProtectionNone => 'No protection';

  @override
  String statsHeatmapSnackBar(Object date, Object count) {
    return '$date: $count encounters';
  }

  @override
  String get statsBusiestStreakTitle => 'Busiest streak';

  @override
  String get statsWeeklySnapshotTitle => 'Weekly snapshot';

  @override
  String get statsActiveDaysLabel => 'Active days';

  @override
  String get statsCurrentWeekLabel => 'Last 7 days';

  @override
  String get statsPreviousWeekLabel => 'Previous 7 days';

  @override
  String statsDaysUnit(Object count) {
    return '$count days';
  }

  @override
  String get statsQualityBreakdown => 'Quality Breakdown';

  @override
  String get statsLegendary => 'Legendary (9-10)';

  @override
  String get statsGood => 'Good (7-8)';

  @override
  String get statsAverage => 'Average (5-6)';

  @override
  String get statsBad => 'Bad (1-4)';

  @override
  String get statsNoTagData => 'No tag data';

  @override
  String get statsNoDescription => 'No description.';

  @override
  String get statsSegmentAll => 'All';

  @override
  String get statsSegmentPartner => 'Partner';

  @override
  String get statsSegmentTags => 'Tags';

  @override
  String get statsSegmentProtection => 'Protection';

  @override
  String get statsSegmentDayTime => 'Day/Time';

  @override
  String get statsFilterAll => 'All';

  @override
  String get statsFilterProtected => 'Protected';

  @override
  String get statsFilterUnprotected => 'Unprotected';

  @override
  String get statsFilterMorning => 'Morning';

  @override
  String get statsFilterAfternoon => 'Afternoon';

  @override
  String get statsFilterNight => 'Night';

  @override
  String get statsTopPartnersTitle => 'Top Partners';

  @override
  String get statsTagIntelligenceTitle => 'Tag Intelligence';

  @override
  String get statsTagDetailSubtitle =>
      'How this tag behaves in the current period';

  @override
  String get statsTagRelatedPartnersLabel => 'Related partners';

  @override
  String get statsTagRecentEncountersLabel => 'Recent tagged encounters';

  @override
  String statsTagInsightHighQuality(Object partner) {
    return 'This tag tends to perform best with $partner.';
  }

  @override
  String statsTagInsightSafe(Object partner) {
    return 'This tag stays highly protected and is most associated with $partner.';
  }

  @override
  String statsTagInsightFrequent(Object partner) {
    return 'This tag appears most often with $partner and signals repeat use.';
  }

  @override
  String get statsProtectionTitle => 'Protection';

  @override
  String get statsRhythmTitle => 'Day & Time';

  @override
  String get statsEncountersLabel => 'Encounters';

  @override
  String get statsLastSeenLabel => 'Last seen';

  @override
  String get statsMostFrequentPartnerLabel => 'Frequent partner';

  @override
  String get statsDominantMoodLabel => 'Dominant mood';

  @override
  String get statsNoMoodLabel => 'No mood logged';

  @override
  String get statsPartnerMostActive => 'Most active';

  @override
  String get statsPartnerBestChemistry => 'Best chemistry';

  @override
  String get statsPartnerMostRecent => 'Most recent';

  @override
  String get statsPartnerDetailMostActive =>
      'Most active connection in this period';

  @override
  String get statsPartnerDetailBestChemistry =>
      'Highest chemistry among your top partners';

  @override
  String get statsPartnerDetailMostRecent =>
      'Most recently seen in this period';

  @override
  String get statsPartnerRecentEncountersLabel => 'Recent encounters';

  @override
  String statsPartnerInsightHighChemistry(Object partner) {
    return '$partner combines strong ratings with consistent chemistry.';
  }

  @override
  String statsPartnerInsightSafety(Object partner) {
    return 'Protection stayed high while $partner remained active.';
  }

  @override
  String statsPartnerInsightMomentum(Object partner) {
    return '$partner leads this period with steady momentum and repeat activity.';
  }

  @override
  String get statsProtectionRateLabel => 'Protection rate';

  @override
  String get statsLastUnprotectedPartnerLabel => 'Last unprotected partner';

  @override
  String get statsLastUnprotectedDateLabel => 'Last unprotected date';

  @override
  String get statsProtectionStable =>
      'Protection stayed steady in this period.';

  @override
  String get statsProtectionImproving =>
      'Protection improved versus the previous period.';

  @override
  String get statsProtectionCaution =>
      'Protection dipped versus the previous period.';

  @override
  String get statsProtectionDetailSubtitle =>
      'How protection behaved in the current period';

  @override
  String get statsProtectionInsightBody =>
      'This view highlights your safety consistency, the most repeated unprotected context, and the latest moments worth noticing.';

  @override
  String get statsProtectionTopRiskPartnerLabel => 'Top unprotected partner';

  @override
  String get statsProtectionRecentEncountersLabel =>
      'Recent unprotected encounters';

  @override
  String get statsStrongestWindowLabel => 'Strongest window';

  @override
  String get statsStrongestDayLabel => 'Strongest day';

  @override
  String statsRhythmHeadline(Object day, Object bucket) {
    return '$day $bucket is your strongest window.';
  }

  @override
  String get statsRhythmDetailSubtitle =>
      'How your timing behaved in the current period';

  @override
  String get statsRhythmWeeklyPulseLabel => 'Weekly pulse';

  @override
  String get statsRhythmRecentEncountersLabel =>
      'Recent encounters in this rhythm';

  @override
  String get statsComparisonBaseline => 'You are building your baseline.';

  @override
  String get statsComparisonUp =>
      'Your activity rose versus the previous period.';

  @override
  String get statsComparisonDown =>
      'Your activity cooled versus the previous period.';

  @override
  String get statsComparisonStable =>
      'Your rhythm stayed stable versus the previous period.';

  @override
  String get statsStoryBestContextTitle => 'Best context';

  @override
  String statsStoryBestContextSupporting(Object rating) {
    return 'Average rating $rating';
  }

  @override
  String statsStoryBestContextDetails(Object context) {
    return 'Your strongest ratings this period clustered around $context. It is a great setup to repeat when you want a higher-confidence experience.';
  }

  @override
  String get statsStoryMomentumTitle => 'Momentum';

  @override
  String get statsStoryMomentumUpHeadline => 'Activity is up';

  @override
  String get statsStoryMomentumDownHeadline => 'Activity is down';

  @override
  String statsStoryMomentumSupporting(Object count) {
    return '$count encounter change vs previous period';
  }

  @override
  String statsStoryMomentumUpDetails(Object count) {
    return 'You logged $count more encounters than the previous period. That usually points to stronger consistency in your rhythm.';
  }

  @override
  String statsStoryMomentumDownDetails(Object count) {
    return 'You logged $count fewer encounters than the previous period. It may be worth checking whether this was just timing or a real slowdown.';
  }

  @override
  String get statsStoryProtectionTrendTitle => 'Protection trend';

  @override
  String get statsStoryProtectionTrendUpHeadline => 'Protection is up';

  @override
  String get statsStoryProtectionTrendDownHeadline => 'Protection is down';

  @override
  String statsStoryProtectionTrendSupporting(Object current, Object previous) {
    return '$current% vs $previous%';
  }

  @override
  String statsStoryProtectionTrendUpDetails(Object current, Object previous) {
    return 'Protection use climbed from $previous% to $current% in this period. That is a meaningful shift toward safer consistency.';
  }

  @override
  String statsStoryProtectionTrendDownDetails(Object current, Object previous) {
    return 'Protection use dropped from $previous% to $current% in this period. This is a good signal to keep an eye on.';
  }

  @override
  String get statsStoryPrimeTimeTitle => 'Prime time';

  @override
  String statsStoryPrimeTimeSupporting(Object rating) {
    return 'Average rating $rating';
  }

  @override
  String statsStoryPrimeTimeDetails(Object slot) {
    return 'Your best recent ratings cluster around $slot. That looks like one of your highest-upside windows.';
  }

  @override
  String get statsStoryPeakMonthTitle => 'Peak month';

  @override
  String statsStoryPeakMonthSupporting(Object rating) {
    return 'Average rating $rating';
  }

  @override
  String statsStoryPeakMonthDetails(Object month) {
    return '$month stands out as your strongest month in this view. It is a useful benchmark for the kind of rhythm you may want to recreate.';
  }

  @override
  String get statsStoryWeekdayMon => 'Monday';

  @override
  String get statsStoryWeekdayTue => 'Tuesday';

  @override
  String get statsStoryWeekdayWed => 'Wednesday';

  @override
  String get statsStoryWeekdayThu => 'Thursday';

  @override
  String get statsStoryWeekdayFri => 'Friday';

  @override
  String get statsStoryWeekdaySat => 'Saturday';

  @override
  String get statsStoryWeekdaySun => 'Sunday';

  @override
  String get statsStoryDayTimeMorning => 'morning';

  @override
  String get statsStoryDayTimeAfternoon => 'afternoon';

  @override
  String get statsStoryDayTimeNight => 'night';

  @override
  String get calendarNoActivity => 'No activity this day.';

  @override
  String get calendarConfirmDeleteTitle => 'Confirm Delete';

  @override
  String get calendarConfirmDeleteMessage =>
      'This action will also adjust your XP and progress. Are you sure?';

  @override
  String get delete => 'Delete';

  @override
  String authBiometricError(Object error) {
    return 'Biometric error: $error';
  }

  @override
  String get authIncorrectCode => 'Incorrect code';

  @override
  String get liteMonthlyEncounterLimitReached =>
      'Lite mode allows up to 5 records per month.';

  @override
  String get authKillSwitchExecuted => '⚠️ PROTOCOL EXECUTED. DATA DELETED.';

  @override
  String get authBiometricButton => 'Biometrics / FaceID';

  @override
  String get insightAverageSatisfactionTitle => 'Average Satisfaction';

  @override
  String insightAverageSatisfactionDescription(Object avg) {
    return 'Your average rating across all encounters is $avg out of 10.';
  }

  @override
  String get insightWeeklyFrequencyTitle => 'Weekly Frequency';

  @override
  String insightWeeklyFrequencyDescription(Object freq) {
    return 'On average, you log $freq encounters per week.';
  }

  @override
  String get insightBestChemistryTitle => 'Best Chemistry';

  @override
  String insightBestChemistryDescription(Object partner, Object avg) {
    return 'Your encounters with \'$partner\' have the highest average rating ($avg/10).';
  }

  @override
  String get insightDatesMatterTitle => 'Dates Matter';

  @override
  String insightDatesMatterDescription(
    Object diff,
    Object trend,
    Object tagA,
    Object tagB,
  ) {
    return 'Your average rating is $diff% $trend in encounters tagged \'$tagA\' compared with \'$tagB\'.';
  }

  @override
  String get insightHigher => 'higher';

  @override
  String get insightLower => 'lower';

  @override
  String get insightRhythmChangeTitle => 'Rhythm Change';

  @override
  String insightRhythmChangeDescription(Object direction, Object percent) {
    return 'Your activity frequency has $direction by $percent% this month compared with last month.';
  }

  @override
  String get insightIncreased => 'increased';

  @override
  String get insightDecreased => 'decreased';

  @override
  String get insightHealthCheckTitle => 'Health Check Suggested';

  @override
  String get insightHealthCheckDescription =>
      'It has been over 6 months since your last Health Passport log. Consider scheduling one.';

  @override
  String get insightInTheZoneTitle => 'In the Zone!';

  @override
  String insightInTheZoneDescription(Object streak) {
    return 'You\'re on a streak of $streak encounters rated as \'Good\' or \'Legendary\' (8+). Keep it going!';
  }

  @override
  String get insightDayMonday => 'Monday';

  @override
  String get insightDayTuesday => 'Tuesday';

  @override
  String get insightDayWednesday => 'Wednesday';

  @override
  String get insightDayThursday => 'Thursday';

  @override
  String get insightDayFriday => 'Friday';

  @override
  String get insightDaySaturday => 'Saturday';

  @override
  String get insightDaySunday => 'Sunday';

  @override
  String get insightGoldenDayTitle => 'Your Golden Day';

  @override
  String insightGoldenDayDescription(Object day, Object avg) {
    return 'Your encounters on $day usually have the highest average rating ($avg/10).';
  }

  @override
  String get insightProtectionStatsTitle => 'Protection Stats';

  @override
  String insightProtectionStatsDescription(Object percentage) {
    return 'You used protection in $percentage% of your logged encounters.';
  }

  @override
  String get insightDominantStyleTitle => 'Your Dominant Style';

  @override
  String insightDominantStyleDescription(Object tag) {
    return 'Your most frequent tag is \'$tag\'. It seems to be an important part of your routine.';
  }

  @override
  String get insightBestTagComboTitle => 'Best Tag Combo';

  @override
  String insightBestTagComboDescription(Object tags, Object avg) {
    return 'When $tags show up together, your average rating climbs to $avg/10.';
  }

  @override
  String get insightMostConsistentPartnerTitle => 'Most Consistent Partner';

  @override
  String insightMostConsistentPartnerDescription(Object partner, Object avg) {
    return '$partner is your most consistent connection, averaging $avg/10.';
  }

  @override
  String get insightMostUnpredictablePartnerTitle =>
      'Most Unpredictable Partner';

  @override
  String insightMostUnpredictablePartnerDescription(
    Object partner,
    Object spread,
  ) {
    return '$partner shows the widest swings lately, with a variability score of $spread.';
  }

  @override
  String get insightBestRecentPartnerTrendTitle => 'Best Recent Partner Trend';

  @override
  String insightBestRecentPartnerTrendDescription(Object partner, Object diff) {
    return '$partner is trending up, improving by about $diff points in your latest encounters.';
  }

  @override
  String get insightRecentChemistryTitle => 'Recent Chemistry';

  @override
  String insightRecentChemistryDescription(Object partner, Object avg) {
    return '$partner has your strongest recent chemistry with an average of $avg/10.';
  }

  @override
  String get insightProtectionRecentlyDroppedTitle =>
      'Protection Recently Dropped';

  @override
  String insightProtectionRecentlyDroppedDescription(
    Object recent,
    Object previous,
  ) {
    return 'Your recent protection use is down to $recent% compared with $previous% in your earlier records.';
  }

  @override
  String get insightLongActivityPauseTitle => 'Long Activity Pause';

  @override
  String insightLongActivityPauseDescription(Object days) {
    return 'It\'s been about $days days since your last logged encounter. That pause might be worth checking in on.';
  }

  @override
  String get insightHealthCheckOverdueTitle => 'Health Check Overdue';

  @override
  String insightHealthCheckOverdueDescription(Object months) {
    return 'Your last Health Passport log was about $months months ago. It may be a good time to schedule another check.';
  }

  @override
  String get insightStrongestRecentMonthTitle => 'Strongest Recent Month';

  @override
  String insightStrongestRecentMonthDescription(
    Object month,
    Object count,
    Object avg,
  ) {
    return '$month stands out with $count encounters and an average rating of $avg/10.';
  }

  @override
  String get homeBlackBookTitle => 'Black Book';

  @override
  String get homeTrophyRoomTitle => 'Trophy Room';

  @override
  String get homeHealthPassportTitle => 'Health Passport';

  @override
  String get homeStatsTitle => 'Stats';

  @override
  String get homeTab => 'Home';

  @override
  String get homePeopleTab => 'People';

  @override
  String get homeTrophiesTab => 'Trophies';

  @override
  String get homeHealthTab => 'Health';

  @override
  String get homeStatsTab => 'Stats';

  @override
  String get blackBookNoRecords => 'No records yet';

  @override
  String blackBookSummary(Object count, Object date) {
    return '$count Encounters • Last: $date';
  }

  @override
  String get fakeNewTask => 'New Task';

  @override
  String get fakeTaskHint => 'e.g. Buy milk';

  @override
  String get fakeAdd => 'Add';

  @override
  String get fakeMyTasks => 'My Tasks';

  @override
  String get fakeAllDone => 'All done for today.\nAdd a new task!';

  @override
  String get fakeToday => 'Today';

  @override
  String get fakeYesterday => 'Yesterday';

  @override
  String get fakeFilterAll => 'All';

  @override
  String get fakeFilterPending => 'Pending';

  @override
  String get fakeFilterCompleted => 'Completed';

  @override
  String fakeTaskDeleted(Object title) {
    return 'Task \"$title\" deleted';
  }

  @override
  String get pinEnter4Digits => 'Enter 4 digits';

  @override
  String get securityUpdated => 'Security updated ✅';

  @override
  String get securityTitle => 'Security';

  @override
  String get securityConfigureKeys => 'Configure your access keys.';

  @override
  String get securityRealPinTitle => 'Real PIN';

  @override
  String get securityRealPinDesc => 'Your main access';

  @override
  String get securityPanicPinTitle => 'Panic PIN';

  @override
  String get securityPanicPinDesc => 'Opens the fake task list';

  @override
  String get securityKillSwitchTitle => 'KILL SWITCH';

  @override
  String get securityKillSwitchDesc => '⚠️ DELETES ALL DATA';

  @override
  String get securitySaveConfig => 'Save Settings';

  @override
  String securityConfigurePin(Object title) {
    return 'Configure $title';
  }

  @override
  String get securityNotSet => 'Not set';

  @override
  String get dataTitle => 'Data & Backups';

  @override
  String get dataBackupSection => 'BACKUP';

  @override
  String get dataCreateBackup => 'Create Encrypted Backup';

  @override
  String get dataCreateBackupSubtitle =>
      'Generate an encrypted .notch file to save in Drive/iCloud.';

  @override
  String get dataBackupSuccess => 'Backup generated successfully';

  @override
  String get dataRestoreBackup => 'Restore Backup';

  @override
  String get dataRestoreBackupSubtitle =>
      'Import a .notch file. ⚠️ It will overwrite current data.';

  @override
  String get dataRestoreSuccess => 'Data restored successfully';

  @override
  String get dataExportSection => 'EXPORT';

  @override
  String get dataGeneratePdf => 'Generate PDF Report';

  @override
  String get dataGeneratePdfSubtitle =>
      'Create a visual document with your stats and records.';

  @override
  String get dataPdfSuccess => 'PDF generated';

  @override
  String dataAchievementUnlocked(Object name) {
    return 'Achievement unlocked: $name!';
  }

  @override
  String dataError(Object error) {
    return 'Error: $error';
  }

  @override
  String get healthResultNegative => 'Negative';

  @override
  String get healthResultPositive => 'Positive';

  @override
  String get healthResultPending => 'Pending';

  @override
  String get healthNewRecord => 'New Health Record';

  @override
  String get healthAddRecordSubtitle =>
      'Keep your personal health record current with clear, private checkup entries.';

  @override
  String get healthTestTypeLabel => 'Test Type (e.g. Full Panel)';

  @override
  String get healthResultLabel => 'Result:';

  @override
  String get healthSaveAndSchedule => 'Save & Schedule';

  @override
  String get healthSavedReminder => 'Saved. We\'ll remind you in 6 months.';

  @override
  String get healthRegisterTest => 'Log Test';

  @override
  String get healthTestHistoryTitle => 'Test history';

  @override
  String get healthNoRecords => 'No health records';

  @override
  String get healthNoRecordsSubtitle => 'Health is sexy. Get checked!';

  @override
  String get addEntryPartnerHint => 'Type \'@\' to search or a new name...';

  @override
  String get addEntryPartnerRequired => 'Partner name is required';

  @override
  String get addEntryPartnerSheetTitle => 'Select partner';

  @override
  String addEntryPartnerCreateOption(Object name) {
    return 'Create \"@$name\"';
  }

  @override
  String get sharePreviewTitle => 'Preview';

  @override
  String get sharePreviewSubtitle =>
      'Your premium season snapshot is ready to share.';

  @override
  String get sharePreviewAction => 'Share card';

  @override
  String get shareCardText => 'New rank unlocked in NOTCH! 🏆 #NOTCHapp';

  @override
  String get shareCurrentSeason => 'CURRENT SEASON';

  @override
  String get shareSeasonXp => 'Season XP';

  @override
  String get shareMonthEncounters => 'Month Encounters';

  @override
  String get shareErrorGeneratingImage => 'Error generating image to share';

  @override
  String get partnerChangeAvatar => 'Change Avatar';

  @override
  String get partnerChooseFromGallery => 'Choose from Gallery';

  @override
  String get partnerChooseEmoji => 'Choose an Emoji';

  @override
  String get partnerChooseEmojiTitle => 'Choose an Emoji';

  @override
  String get partnerNotesSaved => 'Notes saved';

  @override
  String get partnerEdit => 'Edit';

  @override
  String get partnerPrivateNotes => 'PRIVATE NOTES';

  @override
  String get partnerNotesHint => 'Likes, dislikes, birthdays...';

  @override
  String get partnerNotesTapToAdd => 'Tap the pencil to add notes.';

  @override
  String get partnerHistoryTitle => 'ENCOUNTER HISTORY';

  @override
  String get partnerNoEncounters => 'No encounters recorded.';

  @override
  String get trophyMonthRecord => 'MONTH RECORD';

  @override
  String get trophyHistorical => 'HISTORICAL';

  @override
  String get trophyAbstinenceRecordsTitle => 'Abstinence Records';

  @override
  String get trophyAbstinenceRecordsSubtitle => 'Your best streaks achieved';

  @override
  String get challengesTitle => 'Challenges';

  @override
  String get challengesSubtitle =>
      'Complete these goals to prove your mastery and commitment.';

  @override
  String get challengeSeasonal => 'Seasonal';

  @override
  String get challengeHistorical => 'Historical';

  @override
  String challengeXpReward(Object xp) {
    return '$xp XP';
  }

  @override
  String get challengeCategoryFoundation => 'Foundation';

  @override
  String get challengeCategoryAll => 'All';

  @override
  String get challengeCategorySocial => 'Social';

  @override
  String get challengeCategoryEvents => 'Events';

  @override
  String get challengeCategoryRelationships => 'Relationships';

  @override
  String get challengeCategoryMood => 'Mood';

  @override
  String get challengeCategorySkill => 'Skill';

  @override
  String get challengeCategoryLegacy => 'Legacy';

  @override
  String get challengeMorningMasterTitle => 'Morning Master';

  @override
  String get challengeMorningMasterDesc =>
      'Log 5 encounters with the \'Morning Wood\' tag.';

  @override
  String get challengeWeeklyExplorerTitle => 'Weekly Explorer';

  @override
  String get challengeWeeklyExplorerDesc =>
      'Use 3 different tags in the last 7 days.';

  @override
  String get challengeQualityWeekTitle => 'Quality Week';

  @override
  String get challengeQualityWeekDesc =>
      'Log 8 encounters in the last 7 days with an average rating of 8.0+.';

  @override
  String get challengeSafetyChampionTitle => 'Safety Champion';

  @override
  String get challengeSafetyChampionDesc =>
      'Reach 100% protection in your last 5 encounters.';

  @override
  String get challengePreludeMasterTitle => 'Prelude Master';

  @override
  String get challengePreludeMasterDesc =>
      'Average 9.0+ in 5 straight encounters tagged \'Oral\'.';

  @override
  String get challengeSteelConsistencyTitle => 'Steel Consistency';

  @override
  String get challengeSteelConsistencyDesc =>
      'Log at least 8 encounters in the current season.';

  @override
  String get challengeQualityClubTitle => '9+ Club';

  @override
  String get challengeQualityClubDesc =>
      'Log 5 encounters this month with rating 9 or 10.';

  @override
  String get challengeQualityStreak3Title => 'Quality Streak';

  @override
  String get challengeQualityStreak3Desc =>
      'Complete 3 consecutive encounters rated 8 or higher in the current season.';

  @override
  String get challengeQualityStreak5Title => 'Unstoppable Quality';

  @override
  String get challengeQualityStreak5Desc =>
      'Complete 5 consecutive encounters rated 8 or higher across your full history.';

  @override
  String get challengeBalancedWeekTitle => 'Balanced Week';

  @override
  String get challengeBalancedWeekDesc =>
      'Log encounters on 3 distinct days within the last 7 days.';

  @override
  String get challengeTagCombo5Title => 'Tag Combo';

  @override
  String get challengeTagCombo5Desc =>
      'Use 5 distinct tags during the current season.';

  @override
  String get challengeSocialCircle3Title => 'Social Circle';

  @override
  String get challengeSocialCircle3Desc =>
      'Log encounters with 3 distinct partners this season.';

  @override
  String get challengeQualityNetwork3Title => 'Quality Network';

  @override
  String get challengeQualityNetwork3Desc =>
      'Log encounters this season with 3 distinct partners, each rated 8 or higher.';

  @override
  String get challengeSafeNetwork3Title => 'Safe Network';

  @override
  String get challengeSafeNetwork3Desc =>
      'Log protected encounters this season with 3 distinct partners.';

  @override
  String get challengeWeekendRun2Title => 'Weekend Run';

  @override
  String get challengeWeekendRun2Desc =>
      'Log encounters on 2 consecutive weekends during this season.';

  @override
  String get challengeSocialWeekend3Title => 'Social Weekend';

  @override
  String get challengeSocialWeekend3Desc =>
      'Log weekend encounters with 3 distinct partners this season.';

  @override
  String get challengeEventMix3Title => 'Event Mix';

  @override
  String get challengeEventMix3Desc => 'Use 3 distinct event tags this season.';

  @override
  String get challengeGetawayDuo2Title => 'Getaway Duo';

  @override
  String get challengeGetawayDuo2Desc =>
      'Log 2 encounters this season with getaway tags.';

  @override
  String get challengeMoodSpectrum3Title => 'Mood Spectrum';

  @override
  String get challengeMoodSpectrum3Desc =>
      'Log 3 distinct moods during this season.';

  @override
  String get challengeHighSpirits3Title => 'High Spirits';

  @override
  String get challengeHighSpirits3Desc =>
      'Log 3 encounters this season with a mood selected and rating 8 or higher.';

  @override
  String get challengeSkillMix3Title => 'Skill Mix';

  @override
  String get challengeSkillMix3Desc =>
      'Use 3 distinct practice tags this season.';

  @override
  String get challengePleasureCrafter3Title => 'Pleasure Crafter';

  @override
  String get challengePleasureCrafter3Desc =>
      'Log 3 encounters this season with practice tags and rating 8 or higher.';

  @override
  String get challengeConnectionArc3Title => 'Connection Arc';

  @override
  String get challengeConnectionArc3Desc =>
      'Use 3 relationship-dynamic tags this season.';

  @override
  String get challengeDateNight2Title => 'Date Night';

  @override
  String get challengeDateNight2Desc =>
      'Log 2 encounters this season with romantic tags.';

  @override
  String get challengeSinglePartnerSeasonTitle => 'One Partner Only';

  @override
  String get challengeSinglePartnerSeasonDesc =>
      'Log 8 encounters this season with only one partner. A second partner breaks the challenge.';

  @override
  String get challengeLoyalMonthTitle => 'Loyal Month';

  @override
  String get challengeLoyalMonthDesc =>
      'Log 12 encounters this season with only one partner. A second partner breaks the challenge.';

  @override
  String get challengeGuardianOfSafetyTitle => 'Guardian of Safety';

  @override
  String get challengeGuardianOfSafetyDesc =>
      'Achieve a streak of 15 consecutive encounters using protection.';

  @override
  String get challengePerfectWeekendTitle => 'Perfect Weekend';

  @override
  String get challengePerfectWeekendDesc =>
      'Log encounters on Friday, Saturday and Sunday in one weekend, all rated 8+.';

  @override
  String get challengeEpicMorningTitle => 'Very Good Mornings';

  @override
  String get challengeEpicMorningDesc =>
      'Accumulate 50 encounters with the \'Morning Wood\' tag.';

  @override
  String get challengeFrequentFlyerTitle => 'Frequent Flyer';

  @override
  String get challengeFrequentFlyerDesc =>
      'Accumulate 15 encounters with the \'Travel\' tag.';

  @override
  String get challengeStarCollectorTitle => 'Star Collector';

  @override
  String get challengeStarCollectorDesc =>
      'Reach 100 encounters rated 8 or higher.';

  @override
  String get challengeCenturionTitle => 'Centurion';

  @override
  String get challengeCenturionDesc => 'Log your first 100 total encounters.';

  @override
  String get challengeLegendaryGuardianTitle => 'Legendary Guardian';

  @override
  String get challengeLegendaryGuardianDesc =>
      'Maintain a 95%+ protection rate across at least 50 encounters.';

  @override
  String get challengeSinglePartner100Title => 'Same Story';

  @override
  String get challengeSinglePartner100Desc =>
      'Accumulate 100 encounters with a single partner.';

  @override
  String get challengeSinglePartner500Title => 'Legendary Bond';

  @override
  String get challengeSinglePartner500Desc =>
      'Accumulate 500 encounters with a single partner.';

  @override
  String get challengeSteadyBond50Title => 'Safe Bond';

  @override
  String get challengeSteadyBond50Desc =>
      'Accumulate 50 protected encounters with a single partner across your full history.';

  @override
  String get challengeConstellation10Title => 'Constellation';

  @override
  String get challengeConstellation10Desc =>
      'Log encounters with 10 distinct partners across your full history.';

  @override
  String get challengePolymathTitle => 'Polymath';

  @override
  String get challengePolymathDesc => 'Use each available tag at least once.';

  @override
  String get challengeAbstinence21Title => '21-Day Abstinence';

  @override
  String get challengeAbstinence21Desc =>
      'Keep a 21-day streak without logging encounters.';

  @override
  String get challengeAbstinence30Title => '30-Day Abstinence';

  @override
  String get challengeAbstinence30Desc =>
      'Keep a 30-day streak without logging encounters.';

  @override
  String get levelInitiated1Name => 'Initiate I';

  @override
  String get levelInitiated1Desc =>
      'The first step on the path of intimate self-discovery.';

  @override
  String get levelInitiated2Name => 'Initiate II';

  @override
  String get levelInitiated2Desc =>
      'You begin to recognize patterns and understand your rhythms.';

  @override
  String get levelInitiated3Name => 'Initiate III';

  @override
  String get levelInitiated3Desc =>
      'Curiosity becomes a conscious logging habit.';

  @override
  String get levelPractitioner1Name => 'Practitioner I';

  @override
  String get levelPractitioner1Desc =>
      'The discipline of logging reveals its first rewards.';

  @override
  String get levelPractitioner2Name => 'Practitioner II';

  @override
  String get levelPractitioner2Desc =>
      'You develop deeper awareness of your desires and limits.';

  @override
  String get levelPractitioner3Name => 'Practitioner III';

  @override
  String get levelPractitioner3Desc =>
      'Consistency shows commitment to your sexual well-being.';

  @override
  String get levelAdept1Name => 'Adept I';

  @override
  String get levelAdept1Desc =>
      'You master the tools and begin experimenting with confidence.';

  @override
  String get levelAdept2Name => 'Adept II';

  @override
  String get levelAdept2Desc =>
      'Your understanding of intimate dynamics deepens.';

  @override
  String get levelAdept3Name => 'Adept III';

  @override
  String get levelAdept3Desc =>
      'The quality of your experiences becomes as important as quantity.';

  @override
  String get levelVirtuoso1Name => 'Virtuoso I';

  @override
  String get levelVirtuoso1Desc =>
      'Your actions are intentional and your logs are detailed.';

  @override
  String get levelVirtuoso2Name => 'Virtuoso II';

  @override
  String get levelVirtuoso2Desc =>
      'You inspire confidence and show strong communication skills.';

  @override
  String get levelVirtuoso3Name => 'Virtuoso III';

  @override
  String get levelVirtuoso3Desc => 'Intimacy becomes an art form you master.';

  @override
  String get levelKnower1Name => 'Knower I';

  @override
  String get levelKnower1Desc =>
      'You hold deep knowledge of yourself and your partners.';

  @override
  String get levelKnower2Name => 'Knower II';

  @override
  String get levelKnower2Desc =>
      'Your experience lets you anticipate and create unforgettable moments.';

  @override
  String get levelKnower3Name => 'Knower III';

  @override
  String get levelKnower3Desc =>
      'You are a reference point for maturity and sexual health.';

  @override
  String get levelMasterName => 'Master';

  @override
  String get levelMasterDesc =>
      'You reached the summit of self-knowledge and intimate mastery.';

  @override
  String get levelGrandMasterName => 'Grand Master';

  @override
  String get levelGrandMasterDesc =>
      'Your journey inspires others. You transcended the purely physical.';

  @override
  String get levelLegendName => 'Legend';

  @override
  String get levelLegendDesc =>
      'Your legacy is written in the stars of intimacy.';

  @override
  String get trophyActiveChallenges => 'ACTIVE CHALLENGES';

  @override
  String get trophyExploreGoals => 'Explore new goals';

  @override
  String get trophyExploreGoalsSubtitle =>
      'Tap to view all available challenges and keep improving.';

  @override
  String get trophyUnlockedBadges => 'UNLOCKED BADGES';

  @override
  String get trophyRoomSubtitle =>
      'Track your rank, streaks, and seasonal achievements in one premium space.';

  @override
  String get trophySeasonLabel => 'Season';

  @override
  String get trophyCurrentShort => 'Current';

  @override
  String get trophyCurrentLevel => 'CURRENT LEVEL';

  @override
  String get trophyFinalRank => 'FINAL RANK';

  @override
  String trophyNextLevelInXp(Object xp) {
    return 'Next level in $xp XP';
  }

  @override
  String get trophyCurrentStreak => 'CURRENT STREAK';

  @override
  String get trophyActivityRhythm => 'Activity Rhythm';

  @override
  String get trophyNightOwl => 'You are a night owl';

  @override
  String get trophyDayExplorer => 'You are more active during the day';

  @override
  String trophyRhythmDetail(Object percent) {
    return '$percent% of your encounters happen between 10 PM and 2 AM.';
  }

  @override
  String trophyRhythmPeakWindowDetail(Object percent, Object range) {
    return '$percent% of your encounters happen between $range.';
  }

  @override
  String get trophyRhythmVibeNight1 => 'You are a night beast';

  @override
  String get trophyRhythmVibeNight2 => 'Moon mode: activated';

  @override
  String get trophyRhythmVibeNight3 => 'Your prime time starts after dark';

  @override
  String get trophyRhythmVibeDay1 => 'You run on pure daylight energy';

  @override
  String get trophyRhythmVibeDay2 => 'Sunlight champion, no doubt';

  @override
  String get trophyRhythmVibeDay3 => 'Day shift MVP';

  @override
  String get trophyRhythmDominantLabel => 'Dominant pattern';

  @override
  String get trophyRhythmDominantDay => 'More daytime';

  @override
  String get trophyRhythmDominantNight => 'More nighttime';

  @override
  String get trophyPeakHour => 'Peak hour';

  @override
  String get trophyWeeklyActivity => 'Weekly activity';

  @override
  String get trophyWeeklyActivityNoData => 'Not enough data';

  @override
  String get badgeLocked => 'Locked';

  @override
  String get achievementUnlockedTitle => 'Achievement Unlocked!';

  @override
  String get achievementRookieName => 'Debut';

  @override
  String get achievementRookieDesc => 'Log your first encounter.';

  @override
  String get achievementLegendName => 'Legendary';

  @override
  String get achievementLegendDesc => 'Get a perfect 10/10 rating.';

  @override
  String get achievementSprinterName => 'Sprinter';

  @override
  String get achievementSprinterDesc => '3 encounters in less than 24 hours.';

  @override
  String get achievementSafePlayerName => 'Safe Player';

  @override
  String get achievementSafePlayerDesc => 'Streak of 10 protected encounters.';

  @override
  String get achievementHatTrickName => 'Hat-Trick';

  @override
  String get achievementHatTrickDesc => '3 or more orgasms in one encounter.';

  @override
  String get achievementMarathonerName => 'Marathoner';

  @override
  String get achievementMarathonerDesc =>
      '5 encounters in one weekend (Fri-Sun) in a month.';

  @override
  String get achievementRenaissanceName => 'Renaissance Man';

  @override
  String get achievementRenaissanceDesc =>
      'Activity on every weekday within a month.';

  @override
  String get achievementFireStreakName => 'Fire Streak';

  @override
  String get achievementFireStreakDesc => 'Keep a 7-day streak.';

  @override
  String get achievementAbstinenceBronzeName => 'Abstinence Bronze';

  @override
  String get achievementAbstinenceBronzeDesc =>
      'Reach 7 abstinence days during the current month.';

  @override
  String get achievementAbstinenceSilverName => 'Abstinence Silver';

  @override
  String get achievementAbstinenceSilverDesc =>
      'Reach 14 abstinence days during the current month.';

  @override
  String get achievementAbstinenceGoldName => 'Abstinence Gold';

  @override
  String get achievementAbstinenceGoldDesc =>
      'Reach 30 abstinence days during the current month.';

  @override
  String get achievementAbstinenceDiamondName => 'Abstinence Diamond';

  @override
  String get achievementAbstinenceDiamondDesc =>
      'Reach 60 historical abstinence days.';

  @override
  String get achievementAbstinenceMaster45Name => 'Abstinence 45';

  @override
  String get achievementAbstinenceMaster45Desc =>
      'Reach 45 historical abstinence days.';

  @override
  String get achievementAbstinenceMaster90Name => 'Abstinence 90';

  @override
  String get achievementAbstinenceMaster90Desc =>
      'Reach 90 historical abstinence days.';

  @override
  String get achievementAbstinenceMaster120Name => 'Abstinence 120';

  @override
  String get achievementAbstinenceMaster120Desc =>
      'Reach 120 historical abstinence days.';

  @override
  String get achievementMonkModeName => 'Monk Mode';

  @override
  String get achievementMonkModeDesc =>
      'Keep 100% abstinence during the current month.';

  @override
  String get achievementTopCriticName => 'Top Critic';

  @override
  String get achievementTopCriticDesc => '5 straight encounters rated 9+.';

  @override
  String get achievementGrandMasterName => 'Grand Master';

  @override
  String get achievementGrandMasterDesc =>
      'Reach the \"Grand Master\" rank in a season.';

  @override
  String get achievementExplorerName => 'Explorer';

  @override
  String get achievementExplorerDesc => 'Use 5 different tags in a month.';

  @override
  String get achievementGlobetrotterName => 'Globetrotter';

  @override
  String get achievementGlobetrotterDesc =>
      'Log an encounter with the \"Travel\" tag.';

  @override
  String get achievementNightOwlName => 'Night Owl';

  @override
  String get achievementNightOwlDesc => '10 encounters logged after midnight.';

  @override
  String get achievementHealthChampionName => 'Health Champion';

  @override
  String get achievementHealthChampionDesc =>
      'Log your first Health Passport checkup.';

  @override
  String get achievementArchivistName => 'Archivist';

  @override
  String get achievementArchivistDesc => 'Create your first data backup.';

  @override
  String get trophyDays => 'days';

  @override
  String get trophyRecordReached => 'Record reached';

  @override
  String get trophyBeatingRecord => 'Beating record';

  @override
  String get trophyNoRecord => 'No record';

  @override
  String trophyPercentOfHistorical(Object percent) {
    return '$percent% of historical';
  }

  @override
  String get trophyNoStreakThisMonth => 'No streak this month';

  @override
  String trophyNextMilestoneDays(Object days) {
    return 'Next milestone: $days days';
  }

  @override
  String trophyDaysRemaining(Object days) {
    return '$days days remaining';
  }

  @override
  String get trophyMilestoneReached => 'Milestone reached!';

  @override
  String trophyBadgeUnlockedInSeasons(Object count) {
    return 'Unlocked in $count season(s)';
  }

  @override
  String get trophyBadgeNotUnlockedHistory =>
      'You have not unlocked this badge yet.';

  @override
  String get trophyBadgeOneTimeTitle => 'One-time achievement';

  @override
  String get trophyBadgeOneTimeUnlocked =>
      'You have already unlocked this badge.';

  @override
  String get trophyBadgeStatusUnlocked => 'Unlocked';

  @override
  String get trophyBadgeStatusLocked => 'Locked';

  @override
  String get trophyBadgeModalFootnote =>
      'Every badge reflects your progress across seasons, milestones, and personal consistency.';

  @override
  String get trophyBadgeRuleTitleExclusive => 'Season rule: one partner';

  @override
  String get trophyBadgeRuleBodyExclusive =>
      'Unlock this badge by reaching 8 encounters in the current season and keeping every one of them with the same partner.';

  @override
  String get trophyBadgeRuleTitleVariety => 'Season rule: multiple partners';

  @override
  String get trophyBadgeRuleBodyVariety =>
      'Unlock this badge when the current season includes encounters with 3 different partners.';

  @override
  String get trophyShowMore => 'Show more';

  @override
  String get trophyShowLess => 'Show less';

  @override
  String get homeAbstinenceTitle => 'Abstinence';

  @override
  String get homeAbstinenceSubtitle => 'Since your last encounter';

  @override
  String get homeAbstinenceNoDataSubtitle => 'No encounters logged yet.';

  @override
  String get homeAbstinenceNoDataValue => 'No data';

  @override
  String homeAbstinenceDuration(Object days, Object hours, Object minutes) {
    return '${days}d ${hours}h ${minutes}m';
  }

  @override
  String get landingBrand => 'NOTCH';

  @override
  String get landingFeatures => 'Features';

  @override
  String get landingPrivacy => 'Privacy Architecture';

  @override
  String get landingHealth => 'Health Passport';

  @override
  String get landingPricing => 'Pricing';

  @override
  String get landingFaq => 'FAQ';

  @override
  String get landingGet => 'Get NOTCH · \$1.99';

  @override
  String get landingBadge => 'ZERO SERVERS · 100% ON-DEVICE · NO SUBSCRIPTIONS';

  @override
  String get landingHeroTitle => 'Absolute Privacy.\nZero Compromises.';

  @override
  String get landingHeroBody =>
      'The discreet intimacy and personal wellness tracker. Understand your patterns, celebrate your progress, and keep your intimate life entirely yours.';

  @override
  String get landingDownload => 'Download for iOS';

  @override
  String get landingExplore => 'Explore features';

  @override
  String get landingAndroid => 'Android · Coming soon';

  @override
  String get landingOffline => 'Works offline';

  @override
  String get landingEncrypted => 'Encrypted backups';

  @override
  String get landingNoTrackers => 'Zero third-party trackers';

  @override
  String get landingNoAccounts => 'No accounts';

  @override
  String get landingNoSubscriptions => 'No subscriptions';

  @override
  String get landingFoundationsLabel => 'UNCOMPROMISING FOUNDATIONS';

  @override
  String get landingFoundationsTitle => 'Engineered for absolute discretion.';

  @override
  String get landingFoundationsBody =>
      'Your most personal information deserves a space that puts you in control. Private by design, from the first tap.';

  @override
  String get landingSecurityTitle => 'Privacy & Decoy PIN';

  @override
  String get landingSecurityBody =>
      'Protect your journal with biometrics and a personal PIN. A separate Decoy PIN opens a discreet everyday interface when you need it.';

  @override
  String get landingSecurityLink => 'Discreet by design';

  @override
  String get landingInsightsTitle => 'Intimacy & Insights';

  @override
  String get landingInsightsBody =>
      'Track satisfaction, moods, partners, and habits. Discover meaningful patterns with visual insights calculated on your device.';

  @override
  String get landingInsightsLink => 'Your patterns, made clear';

  @override
  String get landingHealthTitle => 'Sexual Health & Safety';

  @override
  String get landingHealthBody =>
      'Keep health checks, protection records, and reminders together. Build a more intentional relationship with your wellbeing.';

  @override
  String get landingHealthLink => 'Care starts with awareness';

  @override
  String get landingModuleOne => 'MODULE 01';

  @override
  String get landingLoggerTitle => 'The Intuitive Encounter Logger';

  @override
  String get landingLoggerBody =>
      'Capture the moments that matter, without the friction. Add a mood, tag your experience, and record what feels relevant to you.';

  @override
  String get landingLoggerPointOne => 'Dynamic tags, moods & personal notes';

  @override
  String get landingLoggerPointTwo => 'A clear timeline & calendar view';

  @override
  String get landingModuleTwo => 'MODULE 02';

  @override
  String get landingStatsTitle => 'Data Intelligence & Activity Heatmaps';

  @override
  String get landingStatsBody =>
      'Turn your private logs into meaningful insight. Visualize your rhythm, explore trends, and understand your habits over time. All calculated locally.';

  @override
  String get landingStatsPointOne => 'Activity heatmaps & personal trends';

  @override
  String get landingStatsPointTwo => '100% on-device insights';

  @override
  String get landingModuleThree => 'MODULE 03';

  @override
  String get landingBookTitle => 'Your Private Black Book & Health Passport';

  @override
  String get landingBookBody =>
      'Keep partner details, preferences, and your personal health history in one discreet place. Organize your records and set reminders on your own terms.';

  @override
  String get landingBookPointOne => 'Personal partner records & preferences';

  @override
  String get landingBookPointTwo => 'Health check logs & local reminders';

  @override
  String get landingModuleFour => 'MODULE 04';

  @override
  String get landingTrophyTitle => 'The Trophy Room & Mastery XP';

  @override
  String get landingTrophyBody =>
      'Celebrate self-discovery, consistency, and personal milestones. Explore seasonal challenges, collect badges, and follow your own path of progress.';

  @override
  String get landingTrophyPointOne =>
      'Seasonal challenges & collectible badges';

  @override
  String get landingTrophyPointTwo =>
      'Personal progress, without a leaderboard';

  @override
  String get landingArchitectureLabel => 'ZERO TELEMETRY ARCHITECTURE';

  @override
  String get landingArchitectureTitle => 'Your life. Your device. Your data.';

  @override
  String get landingArchitectureBody =>
      'Privacy is a foundation, not an upgrade. Here is how NOTCH approaches your most sensitive information.';

  @override
  String get landingArchitectureVector => 'Built around your privacy';

  @override
  String get landingArchitectureNotch => 'NOTCH';

  @override
  String get landingArchitectureOther => 'A typical connected app';

  @override
  String get landingStorage => 'Data storage';

  @override
  String get landingStorageLocal => 'Local on your device';

  @override
  String get landingStorageRemote => 'Remote servers & cloud accounts';

  @override
  String get landingAccount => 'Account & identification';

  @override
  String get landingAccountLocal => 'No account or email required';

  @override
  String get landingAccountRemote => 'Sign-up & identity profiles';

  @override
  String get landingTracking => 'Third-party tracking';

  @override
  String get landingTrackingLocal => 'No advertising or analytics SDKs';

  @override
  String get landingTrackingRemote => 'May include analytics & advertising';

  @override
  String get landingBusiness => 'Business model';

  @override
  String get landingBusinessLocal => '\$1.99 · One-time purchase';

  @override
  String get landingBusinessRemote => 'Often a recurring subscription';

  @override
  String get landingPricingLabel => 'CLEAN, HONEST PRICING';

  @override
  String get landingPricingTitle => 'Pay Once. Keep It for Life.';

  @override
  String get landingPricingBody =>
      'One purchase. All features. No recurring payments, and no selling your personal information.';

  @override
  String get landingLicense => 'FULL VERSION · NO SUBSCRIPTIONS';

  @override
  String get landingPrice => '\$1.99';

  @override
  String get landingPriceUnit => 'USD · One-time payment';

  @override
  String get landingPriceNote =>
      'Full version for iOS. Android coming soon. Store pricing may vary by region.';

  @override
  String get landingIncludedLogs => 'Unlimited encounters & notes';

  @override
  String get landingIncludedSecurity => 'Biometrics & Decoy PIN';

  @override
  String get landingIncludedHealth => 'Health Passport & reminders';

  @override
  String get landingIncludedStats => 'Heatmaps & personal insights';

  @override
  String get landingIncludedBook => 'Private partner records';

  @override
  String get landingIncludedBackup => 'Encrypted backup & restore';

  @override
  String get landingFaqLabel => 'FREQUENTLY ASKED QUESTIONS';

  @override
  String get landingFaqTitle => 'Everything you need to know.';

  @override
  String get landingFaqOne => 'How does the Decoy PIN work?';

  @override
  String get landingAnswerOne =>
      'Configure a separate Decoy PIN in Security & Access. Entering it opens a discreet task interface instead of your private journal. Your primary PIN gives you access to your records.';

  @override
  String get landingFaqTwo => 'What happens if I delete the app?';

  @override
  String get landingAnswerTwo =>
      'Your records are stored locally, so deleting the app can remove them. Export an encrypted backup before deleting the app or changing phones, and keep the backup and password somewhere safe.';

  @override
  String get landingFaqThree => 'Can anyone see my data or analytics?';

  @override
  String get landingAnswerThree =>
      'NOTCH calculates your insights on your device and does not send your journal to a NOTCH server. You control any files you choose to export or share. Protect your device and your backup password.';

  @override
  String get landingFaqFour => 'How does the Kill Switch work?';

  @override
  String get landingAnswerFour =>
      'Configure an optional Kill Switch PIN in Security & Access. Entering that dedicated PIN at the lock screen erases your local records. Review the settings carefully and keep an encrypted backup if you want to retain your history.';

  @override
  String get landingFaqFive => 'Can I move my logs to a new phone?';

  @override
  String get landingAnswerFive =>
      'Yes. Export a password-protected backup from Data & Backup, transfer it securely, then restore it in NOTCH on your new device using the same password.';

  @override
  String get landingCtaTitle => 'Reclaim Your Intimate Privacy Today.';

  @override
  String get landingCtaBody =>
      'A little more self-awareness. A lot more peace of mind. Your personal wellness journey, safely in your hands.';

  @override
  String get landingFooterBody =>
      'Private Intimacy & Wellness Tracker. Designed for discretion, personal insight, and control over your intimate records.';

  @override
  String get landingFooterLinks => 'Explore NOTCH';

  @override
  String get landingSupport => 'Support';

  @override
  String get landingContact => 'Contact support';

  @override
  String get landingCopyright => '© 2026 NOTCH. Private by design.';

  @override
  String get landingStoreUnavailable => 'App Store availability';

  @override
  String get landingStoreMessage =>
      'The NOTCH store link is not available yet. Please check back soon or contact support for launch details.';

  @override
  String get landingLinkError =>
      'This link could not be opened. Please try again.';

  @override
  String get landingClose => 'Close';

  @override
  String get landingMenu => 'Open navigation';

  @override
  String get landingScreenshot => 'NOTCH app screenshot';

  @override
  String get landingLanguageSwitch => 'Español';

  @override
  String get appClipSampleBadge => 'SAMPLE DATA';

  @override
  String get appClipTitle => 'A little insight. Just for you.';

  @override
  String get appClipDescription =>
      'Explore Notch with fictional entries. Tap a date to see how your private journal could look.';

  @override
  String get appClipCalendar => 'Your calendar';

  @override
  String get appClipSampleEntry => 'Fictional entry';

  @override
  String get appClipRating => 'Rating';

  @override
  String get appClipProtection => 'Protection used';

  @override
  String get appClipProtectionUsed => 'Yes';

  @override
  String get appClipProtectionNotUsed => 'No';

  @override
  String get appClipEmptyDay => 'No sample entry on this day';

  @override
  String get appClipInsights => 'Sample insights';

  @override
  String get appClipEntries => 'Entries this month';

  @override
  String get appClipAverageRating => 'Average rating';

  @override
  String get appClipPrivacy =>
      'This preview uses only fictional data. Nothing you do here is saved.';

  @override
  String get appClipGetApp => 'Get Notch';

  @override
  String get appClipInstallUnavailable =>
      'Couldn\'t open the App Store. Please try again.';

  @override
  String get watchAbstinence => 'Abstinence';

  @override
  String watchDuration(int days, int hours, int minutes) {
    return '${days}d ${hours}h ${minutes}m';
  }

  @override
  String get watchNoHistory => 'No activity recorded yet';

  @override
  String get watchCurrentLevel => 'Current level';

  @override
  String get watchXP => 'XP';

  @override
  String get watchStats => 'Monthly stats';

  @override
  String get watchEntries => 'Entries';

  @override
  String get watchAverage => 'Avg. rating';

  @override
  String get watchProtection => 'Protection';

  @override
  String get watchLastSync => 'Last sync';

  @override
  String get watchOpenPhone => 'Open and unlock Notch on your iPhone to sync.';

  @override
  String get watchAddEntry => 'Add entry';

  @override
  String get watchQueueTitle => 'Entry queue';

  @override
  String get watchRefresh => 'Sync now';

  @override
  String get watchNotice => 'Notch';

  @override
  String get watchOK => 'OK';

  @override
  String get watchSyncUnavailable =>
      'Sync is unavailable. Your pending entries are kept. Try again after opening Notch on iPhone.';

  @override
  String get watchStorageUnavailable =>
      'Could not save locally. Your entry has not been queued. Please try again.';

  @override
  String get watchQueueFull =>
      'The queue is full. Sync your pending entries before adding more.';

  @override
  String get watchInvalidEntry =>
      'Check the partner name, rating, protection and orgasm count.';

  @override
  String get watchPartner => 'Partner';

  @override
  String get watchRating => 'Rating';

  @override
  String get watchOrgasms => 'Orgasms';

  @override
  String get watchChooseProtection => 'Choose…';

  @override
  String get watchYes => 'Yes';

  @override
  String get watchNo => 'No';

  @override
  String get watchPendingExplanation =>
      'This entry stays pending until Notch on your unlocked iPhone confirms saving it.';

  @override
  String get watchSave => 'Queue entry';

  @override
  String get watchPending => 'Pending sync';

  @override
  String get watchDiscard => 'Discard';

  @override
  String get watchResetRejected =>
      'Notch was reset. Discard this entry and sync again.';

  @override
  String get watchLimitRejected => 'The monthly entry limit has been reached.';

  @override
  String get watchTimeRejected =>
      'The entry time is ahead of your iPhone. Check the watch clock.';

  @override
  String get watchResetUnavailable =>
      'The reset could not finish. Please try again.';

  @override
  String get watchMood => 'Mood';

  @override
  String get watchTags => 'Tags';

  @override
  String get watchNone => 'None';

  @override
  String get watchChoosePartner => 'Choose…';

  @override
  String get watchExistingPartners => 'Existing partners';

  @override
  String get watchNoPartners =>
      'Sync Notch on iPhone for partner suggestions, or enter a name above.';

  @override
  String get watchOptionsNeedSync =>
      'Open Notch on iPhone to sync your entry options.';

  @override
  String get watchSettingsTitle => 'Apple Watch';

  @override
  String get watchSettingsSubtitle => 'Choose and arrange your Watch cards';

  @override
  String get watchCardsDescription =>
      'Swipe or turn the Digital Crown to move between cards.';

  @override
  String get watchCardsSyncHint =>
      'Changes appear after syncing with your unlocked iPhone.';

  @override
  String get watchCardsReorder => 'Drag enabled cards to change their order.';

  @override
  String get watchCardLevel => 'XP & level';

  @override
  String get watchCardOrgasms => 'Monthly orgasms';

  @override
  String get watchCardsEmpty =>
      'No cards enabled. Entry and sync actions remain available.';

  @override
  String get watchCardsSaveError => 'Could not save Watch settings. Try again.';

  @override
  String get watchActions => 'Actions';

  @override
  String get watchChooseCards =>
      'Choose cards in Notch Settings → Apple Watch on your iPhone.';
}
