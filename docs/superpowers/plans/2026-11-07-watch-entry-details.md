# Watch entry details implementation plan

> Execute inline using superpowers:executing-plans; this extends the companion the user already approved.

**Goal:** Add the requested mood/tags/existing-partner controls to Watch entry creation and match the phone abstinence card to the Watch card.

**Architecture:** Extend schema 1 with optional fields so existing persisted commands remain readable and retain their original fingerprints. Export bounded partner names and the phone's existing mood/tag choices in authenticated snapshots. Reuse existing save/recovery and access gates. The phone card keeps its existing calculations with repository access and a Watch-style layout.

**Tech stack:** Existing Flutter/Hive, SwiftUI and Watch Connectivity, no dependency additions.

**Spec:** User request in this chat: mood, tags, select existing partner, rating; app abstinence card like Watch. Existing inline execution authorization applies.

## Constraints and decisions

- Mood and tags remain optional, matching the phone form. Rating remains 1–10.
- Share the phone option keys; transmit localized tag labels and emoji choices in the snapshot.
- Export names only, including names from saved partners and encounters. Cap suggestions at 50 and 8 KB of UTF-8 JSON; prioritize most recently used, preserve manual entry. Never export notes, contact details, avatars or history.
- Normal locking keeps cached choices; decoy/reset applies the existing live access gate.
- Keep 150-line handwritten Dart limit, repository-only storage, localization and theme rules. Preserve existing dirty App Clip/shared files.

## Review focus

Old queue decoding/fingerprints; lost mood/tags during recovery; invalid option IDs; partner edits without encounter changes; responsive localized phone card.

## Task 1: Extend command and snapshot contracts

- [x] Add failing Dart/native tests for option round-trip, malformed values, old command compatibility, bounded partner suggestions and enriched import recovery.
- [x] Add optional moodEmoji/tags to Dart/Swift commands and importer with old-map compatibility. Add snapshot option aggregation/cache and partner listenable invalidation.
- [x] Run companion and native harness tests green.

## Task 2: Watch form

- [x] Add draft option fields and fail/pass native round-trip tests.
- [x] Separate partner picker and multi-select tags view; retain manual partner entry and rating, add optional mood picker. Use live access gates and English/Spanish labels.
- [x] Build and inspect the form on the 40 mm Watch with fictional data, then remove that data.

## Task 3: Phone abstinence card

- [x] Replace direct Hive reads with repositories and cached source snapshots.
- [x] Match Watch's hourglass/accent heading, large monospaced duration and rounded surface. Show explanatory copy only for no history.
- [x] Verify compact and larger text layouts in English/Spanish; retain timer and empty-state behavior.

## Task 4: Verification

- [x] Run targeted/full Flutter tests, analysis, native harnesses, Watch build and parent embedding build. Report existing baseline failures.
- [x] Fresh whole-change review; fix important findings once and rerun affected checks. Update docs and preserve existing unrelated edits.

## Verification result

22 companion tests and two abstinence service tests pass. Full suite: 136 pass,
five known baseline failures; full analysis: 23 baseline findings, none in the
changed code. All five native harnesses pass. Watch simulator and parent
simulator embedding builds pass. Fresh independent review found no issues.
The phone card was rendered with real app fonts in English/Spanish at normal
and 1.6× scale. The Watch form and mood choices render on the isolated 40 mm
simulator; partner/tag interaction and real paired submission remain manual
checks. The fictional preview cache and simulator were removed. Existing
simulator storage and earlier App Clip edits were preserved.
