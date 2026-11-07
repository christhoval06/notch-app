# Apple Watch Companion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans for inline execution, or superpowers:subagent-driven-development if the user chooses delegated implementation. Implement task-by-task; track the checkboxes below.

**Goal:** Add an Apple Watch companion with cached abstinence, current monthly level, monthly stats, and reliably queued entry creation.

**Architecture:** A native SwiftUI watch app exchanges versioned messages with Runner through Watch Connectivity. A native phone inbox retains received commands until a real unlocked Flutter session imports them through repositories. The phone owns calculations and confirmed data; the watch owns its offline queue and last snapshot.

**Tech Stack:** Flutter/Dart, SwiftUI, Watch Connectivity, existing Hive repositories, native protected file storage, Flutter MethodChannel; no new third-party dependency.

**Spec:** `docs/superpowers/specs/2026-11-07-apple-watch-companion-design.md`.

**Status:** User approved implementation. Tasks 1–7 are implemented; Task 8 automated/build verification and review are complete. Authenticated paired-device flow, larger/Spanish visual checks, and signing remain manual release checks documented in `docs/apple-watch.md`.

## Global constraints

- Watch minimum: watchOS 10; preserve Runner's existing iOS minimum and App Clip's iOS 17 minimum.
- Watch bundle ID: `dev.christhoval.apps.notch.watchkitapp`; parent: `dev.christhoval.apps.notch`; team: `HA64587VPE`.
- Maximum 150 lines per handwritten Dart file; split responsibilities and reusable widgets.
- Keep all new Hive access in data repositories and setup in `lib/data/hive`; widgets consume services/view models.
- Partner text: required, trimmed, leading @ removed, maximum 80 characters. Rating: 1–10; orgasm count: 0–99; protection: required explicit selection.
- Queue cap: 100 pending commands; stable UUID per submission; same UUID with changed content is rejected.
- Reject event timestamps more than five minutes ahead of the phone clock. Preserve delayed past event instants and assign their month using phone local time.
- Entry imports and fresh exports require a real authenticated foreground session; locked/decoy sessions never authorize imports.
- Native labels and app ARBs support English/Spanish; no user-facing text or UI hex colors in view implementations.
- Current level and stats describe the phone's current monthly season. Empty averages/percentages are absent values, not fabricated numbers.
- Dashboard delivery uses `updateApplicationContext`; durable commands and receipts use `transferUserInfo`.
- Preserve all existing uncommitted App Clip and unrelated edits. Do not commit unrelated files.

## Review focus

1. Crash after encounter save but before acknowledgement: recovery must produce one record and one progression result (Task 3).
2. A queued entry crosses a month/timezone boundary: preserve its instant and update the affected month (Tasks 1 and 3).
3. A kill switch occurs while the watch is disconnected: stale commands must not resurrect erased records (Tasks 4 and 5).
4. Messages arrive duplicated or out of order: keep the latest snapshot and stable receipt without destructive overwrites (Tasks 1 and 5).
5. The watch is unreachable or the phone is locked: retain the queue and show pending/cached states without claiming a confirmed save (Tasks 4–7).

## File responsibility map

| Area | Planned files | Responsibility |
|---|---|---|
| Wire contract | `lib/core/constants/watch_protocol.dart`, `lib/features/watch_companion/services/watch_command.dart`, `watch_snapshot.dart`, `watch_receipt.dart` in the same folder; `ios/WatchShared/WatchProtocol.swift`, `WatchCommand.swift`, `WatchSnapshot.swift`, `WatchReceipt.swift` | Versioned DTOs and serialization; matched fixtures |
| Aggregation | `lib/features/watch_companion/services/watch_snapshot_service.dart` | Cached repository snapshot and existing abstinence/level calculations |
| Saving | `lib/core/services/encounter_write_coordinator.dart`, `lib/features/feature/encounters/services/encounter_save_service.dart` | Serialized, non-UI save path used by phone and watch |
| Recovery | `lib/data/repositories/watch_import_repository.dart`, `lib/features/watch_companion/services/watch_import_service.dart`, `lib/features/feature/gamification/services/encounter_progress_reconciliation_service.dart` | Durable import journal, deduplication, affected-month recovery |
| Access and reset | `lib/core/session/app_access_session.dart`, `lib/features/watch_companion/state/watch_companion_controller.dart` | Auth state, lifecycle gates, reset orchestration |
| Phone transport | `ios/Runner/WatchCompanion/WatchPhoneSession.swift`, `WatchPhoneInbox.swift`, `WatchPlatformBridge.swift`, `WatchPairingStore.swift` | Native inbox, session, generation/revision, channel |
| Watch runtime | `ios/NotchWatch/State/WatchCompanionStore.swift`, `WatchQueueStore.swift`, `Services/WatchSession.swift` | Persistent queue, cached context, receipts, reconnection |
| Watch UI | `ios/NotchWatch/NotchWatchApp.swift`, separate files under `Views`, `Theme/WatchTheme.swift`, `en.lproj/Localizable.strings`, `es.lproj/Localizable.strings` | Small watch-native views and centralized theme/localization |
| Verification | `test/features/watch_companion/*_test.dart`, `test/native/watch_protocol/main.swift`, `test/native/watch_queue/main.swift`, shared JSON under `test/fixtures/watch_companion` | Protocol, service, recovery, and queue behaviors |
| Targets/docs | `ios/Runner.xcodeproj/project.pbxproj`, shared `NotchWatch.xcscheme`, `ios/NotchWatch/Info.plist`, `NotchWatch.xcconfig`, assets, `docs/apple-watch.md` | Build, embedding, signing instructions |

Split any listed file further if its implementation would exceed the size limit. Generated Hive adapters/localizations remain generated artifacts.

## Task 1: Define and validate the phone/watch wire contract

**Files:** Create the wire-contract and fixture files from the responsibility map; create `test/features/watch_companion/watch_protocol_test.dart` and `test/native/watch_protocol/main.swift`.

**Interfaces:**
- `WatchCommand.fromMap(Map<String, Object?> map)` and `Map<String, Object?> toMap()`; fields: schemaVersion, generation, id, capturedAtMs, partnerLabel, rating, orgasmCount, protected.
- `WatchCommand.validate(DateTime now)` returns a typed validation result, preserving wire data and rejecting invalid fields.
- `WatchSnapshot` holds generation/revision, generatedAtMs, locale, monthId, nullable abstinence reference, zero-state flag, localized level, XP/progress/next XP, count, nullable average/protection rate.
- `WatchReceipt` contains generation, UUID, status (`accepted` or `rejected`) and a stable rejection reason code. Temporary locking is not a receipt rejection.
- Native Codable DTOs use the exact matching JSON key names and values. Protocol version starts at 1.

- [x] Write Dart tests for each boundary: rating 0/11, count -1/100, empty/81-character partner, normalization, unsupported version, now+5m+1ms, and a valid delayed November 30 event imported December 1. Assertions pin unchanged epoch time.
- [x] Run `flutter test test/features/watch_companion/watch_protocol_test.dart`; confirm failures for missing behavior.
- [x] Implement DTOs/constants; create shared valid and rejected JSON fixtures consumed by both languages. Keep generation mismatch validation in the importer, not in data parsing.
- [x] Run the Dart test and `swiftc ios/WatchShared/*.swift test/native/watch_protocol/main.swift -o /tmp/notch-watch-protocol-tests && /tmp/notch-watch-protocol-tests`; both must pass round trips and invalid-input assertions.
- [x] Commit only the contract, fixtures, and tests: `feat: define watch companion protocol`.

## Task 2: Build the authoritative dashboard snapshot

**Files:** Create snapshot service and `test/features/watch_companion/watch_snapshot_service_test.dart`; consume existing encounter/monthly repositories, `HomeAbstinenceViewModelService`, level/localization helpers.

**Interfaces:** `WatchSnapshotService.build({required DateTime now, required List<Encounter> encounters, required List<MonthlyProgress> monthlyProgress, required AppLocalizations l10n, required String generation, required int revision}) -> WatchSnapshot`. Controller supplies one cached input snapshot per source revision.

- [x] Write tests for no history, latest encounter, current-season XP, no current-month records, one protected of two records (0.5), ratings 8 and 10 (9.0), and December rollover. Assert old monthly stats stay labeled by month when cached on watch.
- [x] Run `flutter test test/features/watch_companion/watch_snapshot_service_test.dart` and confirm red behavior.
- [x] Implement aggregation using existing domain calculations, with nullable empty averages and reference timestamp. The service never reads Hive itself and never sends partner names/history.
- [x] Run snapshot tests; assert generated maps contain aggregate fields only and progress stays within 0–1. Confirm zero-state behavior matches the existing service.
- [x] Commit: `feat: build watch dashboard snapshots from app data`.

## Task 3: Add shared saving and crash-safe watch imports

**Files:** Create save/coordinator/import/reconciliation files from the map. Modify `add_entry_submission_service.dart`, `encounter_repository.dart`, `monthly_progress_repository.dart`, necessary gamification helpers, `lib/data/hive/{boxes,hive_init}.dart`. Add `test/features/watch_companion/watch_import_service_test.dart` and focused encounter save tests.

**Interfaces:**
- `EncounterWriteCoordinator.run<T>(Future<T> Function() operation) -> Future<T>` serializes phone saves and watch imports.
- `EncounterSaveService.save(Encounter encounter) -> Future<EncounterSaveResult>` performs the shared limit/save/progression path without a FormBuilder dependency.
- `WatchImportService.import(WatchCommand command) -> Future<WatchReceipt>` consumes a durable native inbox item, an access/generation check, and the same serialized save path.
- `WatchImportRepository` durably stores command identity/content, stage (`received`, `entryPersisted`, `progressReconciled`, `completed`), and final receipt; expose lookup, stage write, and clear operations.
- `EncounterProgressReconciliationService.reconcile({required DateTime eventDate}) -> Future<void>` recomputes affected-month base XP plus once-claimed rewards and reconciles achievements without duplicate notification delivery.

- [x] Write real temporary-Hive integration tests: import twice, changed-content UUID, failure after `entryPersisted` then restart/retry, delayed prior-month entry, limit enforcement, and concurrent phone/watch saves. Assert one record, exact XP, no repeated reward IDs, and a durable accepted receipt only after completion.
- [x] Run the focused tests and confirm red behavior before introducing the shared save path.
- [x] Add repository ID lookup/journal storage and central box registration. Implement serialized saving and bounded affected-month reconciliation; adapt the existing phone form service to delegate without changing its validation/UI behavior. Preserve actual timestamps.
- [x] Run import/save tests with injected failures at each journal boundary. Verify retry recovery, current-month phone behavior, and stable achievement/reward state. Do not call a global history rebuild to repair one import.
- [x] Commit: `feat: import queued watch entries without duplicate progression`.

## Task 4: Integrate real access state and reset generations

**Files:** Create access session/controller files; modify auth navigation, `app_lifecycle_observer.dart`, `auth_kill_switch_service.dart`, and `lib/main.dart` initialization. Split any touched oversized file before adding behavior. Add `watch_access_session_test.dart` and `watch_reset_test.dart`.

**Interfaces:**
- `AppAccessSession` exposes a listenable state (`locked`, `real`, `decoy`) and `unlockReal()`, `enterDecoy()`, `lock()`.
- `WatchCompanionController.start()` subscribes to access/source changes; `drainInbox()` imports only in real foreground state; `reset()` stops draining, clears inbox/journal and rotates generation.
- Pairing generation and context revision are native phone-owned persisted values exposed through the channel. Dart cannot accidentally replace an old command's generation.

- [x] Write tests asserting no import/export while locked/decoy, one drain after real unlock, locking during a drain prevents further imports, and reset rejects an old queued generation after reactivation.
- [x] Run access/reset tests and confirm failures.
- [x] Wire authentication/lifecycle state changes; add explicit real-session entry after onboarding/auth paths as appropriate. Make kill-switch invalidation occur before old inbox commands can resume; include new journal storage in reset handling.
- [x] Run access/reset/import tests; verify normal locking preserves cached watch data while decoy/reset emits a clear state when transport permits.
- [x] Commit: `feat: gate watch sync on real app access and reset state`.

## Task 5: Implement native phone transport and the Dart bridge

**Files:** Create `ios/Runner/WatchCompanion/*.swift`, shared DTO usage, protected inbox storage, and focused Dart transport adapter under `features/watch_companion/services`. Modify Runner AppDelegate only to attach the helper/channel. Add `watch_transport_test.dart` and native inbox fixtures/tests.

**Interfaces:** Channel `dev.christhoval.apps.notch/watch_companion`; methods `activate`, `readInbox`, `completeInboxItem`, `publishSnapshot`, `readPairingState`, `rotateGeneration`. Events notify inbox availability/activation state; commands remain durable until completed.

- [ ] Write bridge-boundary tests for unknown methods, invalid envelopes, process restart, duplicate inbox UUID, and receipt delivery after a temporarily unreachable watch. Assert user-visible pending behavior, not mock-call counts.
- [x] Run tests red; provide a Foundation-only native storage test harness using shared fixtures.
- [x] Implement WCSession activation/reactivation and serial durable inbox operations; use protected local files, bounded envelope validation, and deferred Dart draining. Use application context for latest dashboard and userInfo for commands/receipts. Preserve existing AppDelegate privacy cover and plugin setup.
- [x] Run protocol/inbox/transport tests. Simulate first-unlock storage unavailability as a retryable transport condition; never acknowledge a command whose inbox persistence failed.
- [x] Commit: `feat: connect watch transport to the iPhone importer`.

## Task 6: Implement the watch's persistent queue and cache

**Files:** Create watch state/service files from the map and `test/native/watch_queue/main.swift`. Keep Foundation persistence/reducer logic separately testable from WatchConnectivity/SwiftUI.

**Interfaces:** `WatchQueueStore.enqueue(_ command: WatchCommand) throws`, `pendingCommands()`, `apply(_ receipt: WatchReceipt)`, `apply(_ snapshot: WatchSnapshot)`, `reset(to generation: String)`. `WatchCompanionStore` publishes dashboard, pending/rejected rows, last sync, and connection/activation state to views.

- [x] Write assertions for enqueue/restart, duplicate receipt, late lower revision, old-generation receipt, a 101st pending command, and changed/reset generation clearing old cache/commands. Assert acceptance removes the sensitive payload but retains bounded receipt metadata.
- [x] Run `swiftc ios/WatchShared/*.swift ios/NotchWatch/State/WatchQueueStore.swift test/native/watch_queue/main.swift -o /tmp/notch-watch-queue-tests && /tmp/notch-watch-queue-tests`; confirm red behavior first.
- [x] Implement atomic storage writes and queue state transitions. Send pending commands using userInfo transfers, preserving IDs across retries. Reject stale/unsupported context, reactivate sessions correctly, and retain the cached dashboard during ordinary disconnection.
- [x] Rerun native tests and simulate relaunch with an interrupted enqueue. Ensure persistence precedes every Pending UI update and no connection signal is mistaken for a Saved receipt.
- [x] Commit: `feat: persist watch dashboard and offline entry queue`.

## Task 7: Build the watch app, views, theme, and localization

**Files:** Create `ios/NotchWatch` app/target configuration, theme, separate dashboard/timer/level/stats/form/pending-row view files, icon assets, English/Spanish strings. Modify Xcode project/Runner embedding and app ARBs. Add shared NotchWatch scheme and a native test target for queue/form reducers if needed.

**Interfaces:** Views consume `WatchCompanionStore`; form submission calls the queue with explicit field values, capture time, stable generation, and fresh UUID. Timer derives duration from confirmed snapshot reference, without resetting for pending entries.

- [x] Write form-reducer tests for missing partner/protection, boundary ratings/counts, duplicate Save taps, and queue-full result. Verify no command is created before initial pairing generation exists.
- [x] Run reducer tests red. Implement compact watch-native cards and form navigation, explicit Pending/Rejected/Accepted states, discard rejected entries, last-sync/month labels, and first-sync instructions. Apply privacy-sensitive rendering to personal content.
- [x] Configure a single-target watchOS 10 app with companion bundle ID and shared version/build values. Embed in Runner while retaining the App Clip dependency, embed phase order, source membership, and isolated Flutter outputs.
- [ ] Run form/queue tests, `flutter gen-l10n`, and build the watch simulator and unsigned watch device release through the NotchWatch scheme. Inspect small/large simulators in English/Spanish; test offline cache, errors, scrolling, and input limits.
- [x] Commit: `feat: add Notch Apple Watch companion UI`.

## Task 8: Exercise the complete paired flow and document release

**Files:** Create `docs/apple-watch.md`; add paired-flow regression fixtures/tests to relevant prior tasks. Update target/configuration only for defects demonstrated by verification.

- [ ] Pair available phone/watch simulators and record their IDs. Launch the full app, authenticate, verify initial snapshot, create an entry on watch, and confirm receipt plus refreshed timer/level/stats. Confirm the phone's saved entry has the captured timestamp and expected values.
- [ ] Disconnect/restart/reconnect and repeat; exercise duplicate delivery, phone locked, decoy, a month boundary, and reset with stale queued data. Verify no false Saved status, duplicate records/XP, or old data resurrection. Record checks that require physical hardware rather than claiming simulator equivalence.
- [x] Run `flutter analyze lib test`, `flutter test`, and native protocol/queue tests. Compare against the known five baseline test failures; fix new regressions and list baseline failures by name.
- [x] Build `NotchWatch` for watch simulator and unsigned device, `Runner` for iOS simulator/device, and `NotchClip` for simulator. Inspect parent embedding, IDs, matching versions, and different Runner/App Clip Flutter artifact hashes. Signed archive/export remains a separate account/device check.
- [x] Write setup, signing, pairing, background-delivery limitations, reset/offline behavior, cache privacy, App Store/TestFlight checks, and actual verification results in `docs/apple-watch.md`. Check file lengths/localization/theme/layering and run `git diff --check`.
- [x] Request an independent whole-change review, resolve actionable findings, rerun checks affected by fixes, and commit only task files: `docs: document watch setup and verified companion behavior`.

## Execution notes

Unchecked verification items are partial or remain manual release checks. Native
Foundation harnesses cover protocol, durable inbox, queue, form validation and
bridge startup retry instead of a mock-only Dart transport test. Small-watch
English dashboard/form and Spanish first-sync were inspected; larger Watch and
full Spanish dashboard checks remain. See `docs/apple-watch.md` for exact scope.

## Execution recommendation and release boundary

Implement inline in the current chat, task-by-task, with the final independent
review. These tasks share transport and persistence interfaces closely, so one
implementer can keep those contracts consistent. The user approved execution;
the ledger records implementation evidence and release checks still pending.

A successfully compiled companion is not equivalent to a publicly installable
watch release. Developer-account registration, signed paired-device checks,
TestFlight background delivery, and App Store submission must be verified and
reported separately. Do not expand to standalone watch storage or complications.
