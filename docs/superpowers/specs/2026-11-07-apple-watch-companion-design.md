# Notch Apple Watch companion

Date: November 7, 2026
Status: Approved by the user; implemented with verification limits in `docs/apple-watch.md`.

## Intent and agreed scope

The user wants an Apple Watch version that shows abstinence time, adds an entry,
shows the current level card, and offers some stats. They selected an iPhone
companion with a cached dashboard and queued entries that sync into Notch.

The iPhone remains the authoritative store and source of calculations. The
watch provides useful cached information and accepts entries while disconnected.
An entry is only called saved after the phone confirms a durable import.

## Approaches considered

1. **iPhone companion with cached snapshots and an entry queue — selected.**
   Native SwiftUI on watchOS, Watch Connectivity for transport, and the existing
   Flutter app for persistence, rules, and aggregation. Works offline from the
   last snapshot and queues entries. Final validation waits for a real iPhone
   app unlock.
2. **Independent watch app with separate storage and calculations.** Can work
   independently of the phone, but needs duplicated domain logic, ownership and
   conflict rules, and broader synchronization. The user chose the companion.

A Flutter watch UI is not proposed: watchOS is not an officially supported
Flutter deployment platform. Native watch views will use Notch's dark surfaces
and blue, green, and purple accents, sized for the watch.

## Proposed first-version behavior

These details are implementation proposals, rather than additional user requests.

### Dashboard

- Abstinence: days, hours, and minutes using the same zero/history rules as
  `HomeAbstinenceViewModelService`. Sync the authoritative reference timestamp
  and zero state; update the duration locally while offline. A pending watch
  entry does not reset this confirmed timer. Its pending status stays visible.
- Current level: the current **monthly season's** localized level name, XP,
  progress fraction, and next-level XP using `GamificationLevelService` and the
  same monthly progress source as the phone. This is not a new lifetime level.
- Stats: current-month entry count, average rating, and protection-use percentage.
  Use an empty state for averages/percentages with no records, avoiding invented
  values. The snapshot carries its month identifier and last-updated timestamp;
  stale cached stats stay labeled with that month across a month rollover.
- Show last sync and pending-entry count. Disconnection keeps the cached
  dashboard available. Before the first sync, explain that Notch must be opened
  and unlocked on the paired iPhone.
- Separate small views for the timer, level, stats, pending state, and entry form.
  No complications, widgets, notification content, or detailed encounter history
  in this version.

### Add entry

- Partner label: required text input, supporting watchOS text entry/dictation;
  do not sync the phone's partner/address-book list in this first version.
- Rating: 1–10; orgasm count: 0–99; protection: explicit yes/no selection.
- The recorded date/time is captured when Save is tapped on the watch. Do not
  silently replace it with the later phone-import time.
- Normalize/validate partner text as on the phone: trim, strip the leading @,
  reject empty text; cap the watch field at 80 characters.
- Leave notes, tags, mood, photos, editing, and deleting to the phone initially.
- Save first persists an immutable queued command on the watch with a UUID.
  Show **Pending sync**, not **Saved**, until an iPhone receipt arrives.
- Block duplicate taps while persisting. A retry retains the same UUID and
  payload. Pending records survive app/process restarts.
- A permanently rejected entry remains visible with its reason and a discard
  action. Correcting and resubmitting creates a new UUID. A temporarily locked
  or unavailable phone is pending, not a rejection.

## Transport, ownership, and recovery

Use Watch Connectivity directly, with a small platform channel between the
Runner native host and Dart. Do not add a third-party sync dependency.

### Dashboard snapshots

- Send the latest snapshot with `updateApplicationContext`; the watch persists
  the last accepted snapshot for offline display.
- A schema version, pairing/reset generation, monotonically increasing revision,
  generated-at time, phone locale, season/month ID, and numeric metrics accompany
  each snapshot. Reject unsupported schemas and older revisions in the same
  generation. A generation change replaces the previous snapshot.
- The phone exports aggregate values and localized level text, not raw encounter
  records, photos, notes, health data, or the partner directory.
- The phone aggregates from one cached feature snapshot of repository data per
  data revision. Widgets do not scan boxes. Rebuild when encounter/monthly
  progress sources change and when entering a new calendar month after unlock.
- Phone locale changes refresh level text on the next sync. Native watch labels
  use English/Spanish strings selected by the watch system locale.

### Entry queue and receipts

- Use `transferUserInfo` for queued entries and receipts so delivery does not
  require both apps to be reachable simultaneously. An optional foreground
  message can request a refresh; reachability is not the durable transport.
- Activate WCSession on each device; handle activation errors, phone session
  deactivation/reactivation, reinstallation, and unavailable/unpaired watches.
- Watch commands contain schema version, reset generation, UUID, capture time,
  partner label, rating, orgasm count, and protection choice.
- Native iOS accepts incoming commands into a durable local inbox, even if Dart
  is not running. It does not call Flutter plugins from a background callback or
  bypass app authentication. Bound and validate envelope sizes before storing.
- Drain the inbox sequentially only while the main app has a real authenticated
  foreground session. Opening a panic/decoy screen does not authorize imports.
- Dart validates the schema, generation, fields, and timestamp. Check the shared
  monthly entry limit against the event's own month. Allow delayed past events;
  reject timestamps more than five minutes ahead of the phone clock with an
  actionable reason. Store the actual instant; use the phone's domain timezone
  when assigning the entry's month.
- Derive a stable encounter ID from the command UUID. Add a repository lookup
  and a durable import receipt/journal through the data layer. A repeated UUID
  with the same content resumes or returns the recorded outcome. The same UUID
  with different content is rejected; never overwrite an existing entry.
- A receipt becomes accepted only after the encounter and its resulting
  progression state are durable. Then send the receipt, remove the inbox item,
  and publish a refreshed dashboard. Lost receipts can be sent again safely.
- A watch removes an accepted command's sensitive payload after persisting its
  accepted receipt. Keep only bounded status metadata. Cap pending commands at
  100 and explain a full queue; never silently discard an unsynced entry.
- The import journal must recover from termination after encounter persistence
  but before progression/receipt persistence. Recovery reconciles progression
  from authoritative records instead of blindly incrementing XP again.

## Shared entry and gamification rules

The existing phone submission service depends on form widgets, and
`GamificationEngine.processEncounter` currently loads current-month progress.
An offline watch event may arrive in a later month. Extract a small non-UI save
path that both phone forms and watch imports can call, preserving phone behavior.

- Keep persistence and import journals in data repositories, with Hive setup
  centralized under `lib/data/hive` and box names under constants.
- Use event-month progression for delayed events. Preserve the existing default
  current-month behavior of unrelated callers.
- Make the import/recovery operation idempotent for base XP, challenge reward XP,
  and achievement unlock state. Recompute the affected month's base XP from its
  encounters and include already claimed challenge rewards once. Existing reward
  and achievement identifiers remain the deduplication keys; do not invent a
  second points formula for the watch.
- Replays must not duplicate entries, reward claims, or achievement notifications.
  Persist operation completion before acknowledging. Serialize watch imports
  with phone saves that touch the same data to avoid races on monthly limits.
- Do not reuse the existing full `recalculateAllXp` indiscriminately: it scans all
  history and may delete other monthly progress. Implement bounded affected-month
  reconciliation with the required existing reward/achievement services.
- Extract only the responsibilities needed for this integration; keep Dart files
  within 150 lines and split existing touched files that exceed the limit.

## App access and reset semantics

- Add a small shared access-session controller that distinguishes real unlocked,
  locked, and decoy access. Set it from successful real authentication; reset it
  before backgrounding/locking. It gates inbox draining and fresh snapshot export.
- Ordinary iPhone locking pauses imports/export. The watch can still show its
  previously authorized cached aggregates and queue new commands, as agreed by
  the cached companion approach. Watch OS device-lock protections remain active;
  mark sensitive SwiftUI content appropriately for inactive/always-on rendering.
- Entering decoy mode must not export real data or import queued entries. Send
  a cache-clear/disabled snapshot when connectivity permits; do not display real
  watch metrics while the watch knows the companion is in decoy mode.
- Kill switch clears the phone inbox/import receipts and rotates a persistent
  reset generation, invalidating all earlier watch commands. Send a reset context
  and cancel available outstanding transfers. The watch clears cached data and
  pending commands when it receives a new/reset generation.
- A disconnected watch cannot be erased immediately by the phone. Document that
  limitation; never claim instant remote deletion. Old-generation commands must
  still be rejected after reconnecting so erased records cannot reappear.
- Initial association requires a real phone unlock. After reset/reinstallation,
  establish a fresh generation before accepting new watch entries. A generation
  mismatch never silently relabels an old queued command as current.

## Platform integration and structure

- Add a single-target native SwiftUI companion under `ios/NotchWatch`, proposed
  minimum watchOS 10. The existing iPhone deployment minimum remains unchanged.
- Bundle ID: `dev.christhoval.apps.notch.watchkitapp`, same development team as
  Runner, with the companion identifier pointing to `dev.christhoval.apps.notch`.
- Embed the watch app in Runner with a shared NotchWatch scheme. Keep App Clip
  membership, source files, Flutter artifacts, and privacy behavior separate.
- Use small Swift files for connectivity, protocol models, storage, theme,
  localization, and each view. Native Watch code does not attempt to open Hive.
- Dart integration belongs under `features/watch_companion/{services,state}`;
  shared platform/access primitives belong under core; repositories and import
  persistence belong under data. Add no box access to widgets.
- Extend Runner through focused native helpers instead of growing AppDelegate.
  Preserve the existing privacy cover, plugin registration, and App Clip target.
- Add English/Spanish entries to the app ARBs and the native watch localization
  resources. Keep native protocol keys/constants and matching Dart constants
  documented and validated with shared protocol fixtures.
- Centralize native theme tokens and use the existing app palette. Add no UI hex
  colors to feature view implementations. No hardcoded user-facing view strings.

## Validation and definition of done

1. Unit tests for timestamp/zero-state abstinence, current-season level mapping,
   empty stats, and month rollover, using an explicit clock and repositories.
2. Protocol tests for unknown schema, invalid fields, stale generation/revision,
   duplicate command UUID, duplicate receipt, offline restart, and queue bounds.
3. Import integration tests covering app locked/decoy, entry limit, a delayed
   prior-month entry, kill-switch reset, and interrupted-save recovery without
   duplicated XP, rewards, or records. Confirm normal phone saving still works.
4. Compile the watch simulator and unsigned watch device release; build Runner
   with both the watch app and existing App Clip embedded. Verify identifiers,
   version/build matching, target membership, and distinct Flutter artifacts.
5. Inspect English/Spanish views in a watch simulator at small and large sizes,
   exercising entry validation, queue status, and cached/empty states.
6. Exercise paired phone/watch delivery, restart, reconnect, and acknowledgement
   in an available paired simulator. Physical paired-device/TestFlight checks are
   required for background delivery guarantees, protected storage, signing, and
   actual installation. Report any unavailable checks explicitly.
7. Run targeted analysis and the Flutter suite. The last baseline was 114 passed
   and five pre-existing failing tests (listed in `docs/app-clip.md`); identify
   regressions separately and do not hide those baseline failures.
8. Provide `docs/apple-watch.md` with setup, signing, pairing, queued-entry
   behavior, limits, and manual device checks. Preserve unrelated working edits.

## Builder discretion

Choose native view navigation, card arrangement, bounded receipt retention, queue
file format, exact test fixtures, and focused extraction boundaries. Prefer the
smallest design that satisfies the behavioral guarantees above. No independent
watch database, cloud service, HealthKit integration, subscriptions, complications,
or extra forms are included. If the shared import/progression changes reveal a
larger unrelated correctness issue, report it before expanding the project.
