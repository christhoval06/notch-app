# Watch dashboard pages implementation plan

> Execute inline using superpowers:executing-plans, continuing the user's chosen Watch companion workflow.

**Goal:** Provide swipeable cards inside the Watch app and enable/reorder them from iPhone settings. The user explicitly chose in-app cards over Smart Stack widgets.

**Architecture:** Persist an ordered list of enabled card IDs in one phone preference. Include it in authenticated snapshots and cache it on Watch. Render a vertical-page TabView, keeping entry/queue/sync actions available independently of card selection. Reuse existing aggregates; add current-month orgasm total.

**Tech stack:** Existing Flutter/SharedPreferences, SwiftUI watchOS10 TabView, existing WatchConnectivity snapshot channel. No new targets, entitlements or dependencies.

## Constraints and decisions

- Defaults remain abstinence, level and stats. Monthly orgasm total is an optional fourth card.
- Empty selection is valid; retain the actions page and show settings instructions.
- Missing configuration in older snapshots uses defaults; unknown/duplicate card IDs are ignored.
- Preserve enabled-card order. Re-enabling appends a card. Serialize phone preference updates.
- Localized English/Spanish settings and Watch labels; centralized IDs/keys and theme colors; handwritten Dart <=150 lines.
- Watch settings remain phone-owned and sync after real unlock. Preserve privacy gates, generation/revision ordering, and existing command delivery.
- Keep current feature branch and preserve pre-existing dirty App Clip/shared files.

## Review focus

All cards off; removing the selected page; old snapshots; rapid preference changes; disabled/decoy snapshots; optional aggregate zero/month boundaries.

## Task 1: Phone configuration and snapshot

- [x] Add failing preference/controller and snapshot tests for defaults, empty/invalid lists, order, concurrent toggles, persistence and current-month orgasm totals.
- [x] Add core card IDs/pref key, data preference repository, feature layout controller. Initialize in main before Watch start; listen for configuration changes and include values in snapshots.
- [x] Run tests green.

## Task 2: Phone settings

- [x] Add named route and iOS settings tile. Build separate settings page/content/row widgets for enabled-card ordering, toggles, sync explanation and save errors.
- [x] Add en/es localization and exercise real settings/controller persistence through widget tests.

## Task 3: Watch pages

- [x] Add native layout reducer tests for defaults, empty/unknown IDs, access gates and selection fallback.
- [x] Add vertical paging, separate card/action pages, optional monthly total card, and persistent quick-add access. Keep disabled/first-sync behavior and existing entry/queue navigation.
- [x] Add optional snapshot fields and localized strings; include new sources in Watch target only.

## Task 4: Verify

- [x] Run targeted/full Flutter tests, analysis and native harnesses; build parent simulator with embedded Watch and App Clip.
- [x] Inspect small Watch paging and settings UI using fictional data without changing real preferences.
- [x] Request independent whole-change review, fix important findings, and record exact verification/limitations in docs/apple-watch.md.

## Verification and limitations

Parent simulator build with Watch/Clip succeeds. All28 companion tests pass;
full suite142 pass with5 existing baseline failures. Full analysis retains23
baseline findings, none in changed code. Seven native harnesses pass including
selection transitions and live connectivity. Fresh review found one Important
initial-page issue, reproduced RED and fixed GREEN. Settings rendered with
isolated preferences in en/es at390pt; first card and pagination indicators fit
40mm Watch. Full Crown/swipe behavior, large text and other Watch sizes remain
manual. A disposable preview simulator was removed after disk exhaustion before
any fictional data was loaded; existing cached content was inspected read-only.
The updated apps were installed while retaining existing records/preferences.
