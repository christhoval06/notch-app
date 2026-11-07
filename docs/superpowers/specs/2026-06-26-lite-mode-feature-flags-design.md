# Lite Mode And RevenueCat Flags Design

## Goal

Add centralized feature flags under `lib/core/constants` so the app can:

- Disable RevenueCat integration entirely.
- Enable a lite mode with a monthly cap of 5 encounter records.
- Hide selected Trophy Room sections in lite mode.

## Scope

This change covers:

- A shared constants file for feature flags and lite-mode limits.
- RevenueCat initialization and paywall entry-point gating.
- Encounter creation gating for the current month.
- Trophy Room section visibility gating.
- Localization for the lite-mode limit message.
- Focused tests for the lite-mode rules.

This change does not cover:

- Remote config.
- Per-user subscription entitlements.
- Server-side enforcement.

## Recommended Approach

Use static compile-time style flags in `lib/core/constants/feature_flags.dart`.

Why this approach:

- Matches the project rule to keep constants centralized in `core/constants`.
- Keeps product decisions explicit and easy to toggle during development.
- Avoids coupling lite-mode behavior to RevenueCat state.
- Minimizes the number of files that need business logic changes.

## Constants Design

Create `lib/core/constants/feature_flags.dart` with:

- `FeatureFlags.revenueCatEnabled = false`
- `FeatureFlags.liteModeEnabled = true`
- `FeatureFlags.liteMonthlyEncounterLimit = 5`

Optionally expose a helper getter:

- `FeatureFlags.shouldEnforceLiteEncounterLimit`

The flags stay static for now and are consumed directly by features.

## RevenueCat Behavior

`lib/features/premium/services/subscription_service.dart` should short-circuit when `FeatureFlags.revenueCatEnabled` is `false`.

Expected behavior:

- Skip Purchases configuration/init.
- Avoid loading offerings.
- Prevent paywall presentation methods from trying to call RevenueCat SDK.
- Leave the service in a safe, non-crashing state.

This should be implemented as an early guard, not by partially configuring the SDK.

## Lite Encounter Limit Behavior

When `FeatureFlags.liteModeEnabled` is `true`, the app should prevent saving a new encounter once the current month already contains 5 records.

Enforcement details:

- Count only encounters whose date falls in the current calendar month and year.
- If the count is already `>= 5`, stop before persistence and before achievement side effects.
- Show a localized `SnackBar` explaining that the lite monthly limit has been reached.
- Do not navigate away or open a paywall.

Recommended implementation shape:

- Add a small helper in a feature or service layer to answer whether another encounter can be added for a given date and list/count.
- Keep Hive access in the repository or existing page/service boundary; avoid pushing box reads into reusable widgets.

## Trophy Room Lite Behavior

When `FeatureFlags.liteModeEnabled` is `true`, hide these sections from the Trophy Room:

- Current streak widget.
- Activity pace widget.
- Challenges widget/section.

All other Trophy Room content remains unchanged.

Implementation guidance:

- Add simple conditional rendering around the existing section builders.
- If `trophy_room_page.dart` risks growing further beyond project limits, extract the gated sections into dedicated widgets under `lib/features/gamification/widgets/`.

## Localization

Add one new localized string to:

- `lib/l10n/app_en.arb`
- `lib/l10n/app_es.arb`

Message intent:

- Inform the user that the lite version allows only 5 records per month.

No other user-facing copy changes are required.

## Testing

Use test-first changes for the new lite-mode rule.

Planned tests:

- A unit test for the lite encounter limit helper:
  - Allows saving when the month has fewer than 5 records.
  - Blocks saving when the month has 5 records.
  - Ignores records from other months.
- If practical without bloating the page file, a focused test for Trophy Room visibility gating.

RevenueCat gating can be covered with a lightweight unit test or verified through guard-focused logic extraction if the current service structure makes direct testing expensive.

## Risks And Mitigations

- `trophy_room_page.dart` is already a likely refactor hotspot.
  - Mitigation: extract gated sections instead of adding more inline branching if needed.
- Encounter save flow may trigger achievements or other side effects after persistence.
  - Mitigation: place the lite limit guard before any write or downstream processing.
- RevenueCat methods may be called from multiple entry points.
  - Mitigation: guard both initialization and interactive SDK entry points.

## Acceptance Criteria

- RevenueCat remains disabled when the flag is `false`.
- Lite mode blocks the 6th encounter in the same month with a localized `SnackBar`.
- Lite mode hides current streak, activity pace, and challenges in Trophy Room.
- New constants live in `lib/core/constants`.
- Touched Dart files respect the project size and separation rules.
