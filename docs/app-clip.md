# Notch App Clip

`NotchClip` renders the main app's Flutter UI using a separate entry point,
`lib/main_app_clip.dart`. It reuses `AppTheme.dark()`, `CalendarTableCard`,
`CalendarEncounterCard`, and `StatsSummaryCard`, including the main app's fonts,
colors, calendar behavior, and English/Spanish localization.

The preview shows four fictional entries in the current month. The encounter
cards use read-only mode, which hides their delete action; normal app cards
remain editable. The stats card was moved to `lib/core/widgets` so both flows
consume the same implementation.

The clip never initializes Hive, notification services, authentication, shared
preferences, or Flutter plugins. Its sample models exist only in memory. The
**Get Notch** button calls a native MethodChannel to open
[Notch's App Store page](https://apps.apple.com/us/app/notch/id6759076734).
The URL is shared with the landing page through `AppStoreConfig` and supports
the `NOTCH_APP_STORE_URL` build-time override for Apple App Store HTTPS links.
If iOS cannot open the link, the clip shows a localized retry message.
Each invocation opens the same preview; URL parameters
are ignored.

## Size and deployment

The unsigned arm64 device release measured about **32 MB** before App Store
thinning. This exceeds the iOS 16 limit of 15 MB, so the clip now targets
**iOS 17+**. The full app's deployment target is unchanged.

Use digital invocation links in environments with reliable internet to qualify
for Apple's 100 MB allowance. Ordinary physical QR/NFC/App Clip Code experiences
are not covered by that allowance. Apple's App Clip **demo link** is a separate
option that can support physical invocations for demos of this size; configure
and test that option in App Store Connect if needed.

The final uncompressed, thinned distribution size must still be checked in the
App Store distribution report. This local unsigned build is not a substitute
for App Store validation. See [Apple's size rules](https://developer.apple.com/documentation/appclip/choosing-the-right-functionality-for-your-app-clip).

## Run locally

1. Run `flutter pub get` to generate `ios/Flutter/Generated.xcconfig`.
2. Open `ios/Runner.xcworkspace` in Xcode.
3. Select the shared **NotchClip** scheme and an iPhone simulator, then Run.

The clip target overrides `FLUTTER_TARGET` with `lib/main_app_clip.dart`.
Its build/embed scripts use `TARGET_TEMP_DIR/FlutterProducts` as the Flutter
artifact output, and its framework search path points there. Runner keeps its
own entry point and build artifacts. This prevents one target's `App.framework`
from replacing the other's during a parent build or archive.

The native host owns a window scene and the App Store redirect channel. It links
Flutter only; it does not register the full app's plugins.

After changing UI copy, update `lib/l10n/app_en.arb` and `app_es.arb`, then run
`flutter gen-l10n`. The clip now uses generated `AppLocalizations` directly;
there is no separate native translation catalog.

Run the preview tests:

```sh
flutter test test/features/app_clip
```

Build the clip independently:

```sh
xcodebuild -project ios/Runner.xcodeproj -scheme NotchClip \
  -configuration Debug -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/notch-clip-build CODE_SIGNING_ALLOWED=NO build
```

Build an unsigned device release for local size checks:

```sh
xcodebuild -project ios/Runner.xcodeproj -scheme NotchClip \
  -configuration Release -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  -derivedDataPath /tmp/notch-clip-release CODE_SIGNING_ALLOWED=NO build
```

## Signing and publishing

1. In Apple Developer team `HA64587VPE`, register App Clip ID
   `dev.christhoval.apps.notch.Clip`, associated with parent app ID
   `dev.christhoval.apps.notch`. Both targets use the same team.
2. Refresh provisioning for Runner and NotchClip. Runner declares the clip
   ID; the clip declares the parent ID and on-demand installation capability.
3. Archive the **Runner** scheme for a device. The clip is embedded under
   `Runner.app/AppClips/NotchClip.app` before Runner's Thin Binary phase.
   Distribute the parent archive, not a standalone clip archive.
4. Select the uploaded build in App Store Connect and configure the default
   App Clip experience, including its card image, subtitle, and action.
5. Test via TestFlight on an iPhone without the full app installed. Check
   both languages, date selection, month navigation, scrolling with larger
   text, and the Get Notch App Store redirect.
6. Verify the distribution size report and the invocation rules above, then
   submit the app and experience for review. Share the generated digital link.

The expected default link format is
`https://appclip.apple.com/id?p=dev.christhoval.apps.notch.Clip`;
use the actual link shown by App Store Connect. Default links require no
custom domain association. See [Apple's default experience guide](https://developer.apple.com/help/app-store-connect/offer-app-clip-experiences/offer-a-default-app-clip-experience/).

A custom website banner or domain requires Associated Domains on both targets
and an `apple-app-site-association` file on the domain. No unverified domain
is included in this setup. See [Apple's association guide](https://developer.apple.com/documentation/appclip/associating-your-app-clip-with-your-website).

Verify the App Store redirect on a physical iPhone; the simulator does not
provide the complete App Store installation flow.

## Validation on November 7, 2026

The preview's six Flutter tests pass without opening Hive, including Spanish
localization, the App Store redirect request, and redirect failure handling.
Targeted Dart analysis reports no issues. Earlier simulator and unsigned device
release builds passed; the final redirect change passes native Swift type-checking.
The full Flutter suite retains the five existing baseline failures below:

- `analyzer_context_insights_test.dart`: strongest recent month insight.
- `analyzer_partner_insights_test.dart`: strongest recent chemistry insight.
- `lite_mode_service_test.dart`: block saving after five current-month records.
- `stats_heatmap_card_test.dart`: build across supported periods.
- `widget_test.dart`: counter increments smoke test.
