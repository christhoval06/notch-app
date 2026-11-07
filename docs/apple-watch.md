# Notch Apple Watch companion

The watch app supports watchOS 10 and later. It shows a cached abstinence timer,
the current monthly level, monthly entry count, average rating, and protection
rate. Entries can be queued offline with a selected or typed partner, rating,
optional mood and tags, orgasm count, and an explicit protection choice.
Native labels support English and Spanish. The iPhone abstinence card now uses
the same green hourglass heading and large, compact duration as the Watch.

## Run locally

Open `ios/Runner.xcworkspace` in Xcode. Select the `NotchWatch` scheme and a
paired Watch simulator or registered Watch. Run the full `Runner` app on the
paired iPhone and unlock the real Notch session once to supply the first
snapshot. The App Clip does not provide Watch sync.

The Watch bundle identifier is `dev.christhoval.apps.notch.watchkitapp`; its
companion is `dev.christhoval.apps.notch`. Runner embeds the Watch app alongside
the existing App Clip. The version/build comes from Flutter's generated
configuration. Runner still supports iOS 15; the App Clip requires iOS 17.

Useful checks from the repository root:

```sh
flutter test --no-pub test/features/watch_companion
flutter analyze --no-pub lib/features/watch_companion lib/core/session test/features/watch_companion
xcodebuild -project ios/Runner.xcodeproj -scheme NotchWatch -configuration Debug -sdk watchsimulator -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO build
xcodebuild -project ios/Runner.xcodeproj -scheme NotchWatch -configuration Release -sdk watchos -destination 'generic/platform=watchOS' CODE_SIGNING_ALLOWED=NO build
flutter build ios --simulator --debug --no-codesign -d <iphone-simulator-id>
flutter build ios --release --no-codesign
```

## Sync, privacy, and recovery

The phone computes the dashboard using existing repositories and progression
services. Latest snapshots use Watch Connectivity application context. Commands
and receipts use durable user-info transfers. Delivery is asynchronous; being
reachable does not mean an entry has been saved.

The Watch persists a command before showing it as pending, retains its UUID
across retries, and permits at most 100 pending commands. Acceptance removes the
sensitive queued payload. Rejected entries remain visible for review/discard.
Commands retain their original capture timestamp; the phone assigns the month
in its local timezone and rejects timestamps over five minutes in the future.

Imports and fresh dashboard exports require a real unlocked foreground phone
session. Ordinary locking retains the cached Watch dashboard. Decoy access
disables private views, including destinations already open. Reset rotates the
pairing generation before erasure, preventing old queued commands from restoring
erased records. A disconnected Watch cannot be remotely cleared immediately;
it applies the disabled/reset state when that state arrives.

Phone writes are serialized. A durable import journal, stable encounter ID,
and deterministic month reconciliation recover interrupted saves without
duplicating encounters or XP. Closed seasons receive base XP and reconcile
already claimed rewards; time-dependent historical challenges are not fabricated.
Watch files use atomic writes; phone inbox files use protected local storage.
Snapshots include up to 50 partner-name suggestions within an 8 KB budget,
prioritizing recent encounters and then saved partners. Manual name entry is
available. Notes, contact details, avatars and encounter history are not
exported. Suggestions refresh after partner changes and real phone unlock.
Mood/tag choices match the phone form, including localized tag labels. These
optional command fields preserve compatibility with older pending entries.

## Verification on November 7, 2026

- All 22 Dart companion tests pass, including four persisted-write/reopen
  recovery boundaries, access/reset, timestamps, duplicate import, snapshots,
  progression regressions, mood/tag recovery, backward compatibility and
  bounded partner suggestions. The two existing abstinence service tests pass.
  Full analysis retains 23 baseline findings outside the changed code.
- Five Foundation harnesses pass: protocol, phone inbox, Watch queue, entry
  draft validation, and native bridge recovery after temporary file failure.
- Updated Watch and Runner simulator Debug builds pass, with both Watch and
  App Clip embedded. The initial companion also passed unsigned Watch and
  iPhone Release builds; this follow-up has not been signed or archived.
  All three report version 1.0.0, build 8.
  The initial release was rebuilt successfully using a fresh DerivedData directory
  after a stale SDK-module cache error; generated simulator intermediates were
  cleared to recover disk space. No source workaround was required.
- Bundle inspection confirms Watch minimum 10.0, Runner 15.0, App Clip 17.0,
  correct companion IDs/platforms, and different Runner/App Clip Flutter
  kernel hashes in the simulator build.
- On the 40 mm Watch simulator, fictional cached data verifies the timer,
  level, monthly stats, scrolling, and entry form. The first-sync view also
  renders in English and Spanish. The Watch stepper initially wrapped its
  label vertically; replacing it with a compact picker fixes the 40 mm form.
  The follow-up form and mood choices render on an isolated 40 mm Watch.
  Actual partner/tag selection and paired save still need interactive device
  verification. The phone card renders without overflow in English/Spanish at
  normal and 1.6× text scale. Fictional data and its isolated simulator were
  removed after inspection; existing simulator storage was preserved.
- Full Flutter suite: 136 pass, five existing baseline failures remain:
  `AnalyzerContextInsights adds an insight for the strongest recent month`,
  `AnalyzerPartnerInsights adds an insight for the strongest recent chemistry`,
  `LiteModeService.canAddEncounter blocks saving when current month already has five records`,
  `builds heatmap card across supported periods`, and
  `Counter increments smoke test`.
- Full analysis reports 23 existing findings outside the new companion code.

The test simulator pair is `4BCD93AB-F24E-4184-93E2-25CBE65B949E`:
iPhone `58BB5917-0D5E-4201-9D0E-34FAF8A5EB4D` and Watch
`85FA34F3-3DCB-48C9-8175-EF75A70C97B6`. Existing phone authentication/data
was preserved. A complete authenticated paired UI save was not performed.

## Before release

Register/confirm the Watch identifier and profiles under the app's Apple
Developer team, then archive Runner with signing enabled. Verify matching
versions and embedded targets in the archive and validate it in Xcode.

On a signed paired iPhone/Watch, verify initial sync after real unlock, entry
receipt and refreshed dashboard, delayed background delivery, airplane mode,
relaunch, locked/decoy phone, and reset while disconnected. Confirm exactly one
phone encounter and one progression result after repeated delivery. Check a
month boundary, English/Spanish, larger Watch sizes, and accessibility text
sizes. These device/TestFlight checks remain outstanding; unsigned compilation
does not verify provisioning, background scheduling, or App Store acceptance.

Deferred polish: accepted entries disappear from the pending list without a
separate success toast. Partner text is capped at 80 UTF-16 units, preserving
composed characters when shortening manual input.
