# Health Passport Premium Editorial Design

## Goal

Redesign `Health Passport` so it feels premium, trustworthy, and visually distinct while preserving the current data model and behaviors.

This change should:
- introduce a stronger top-level visual identity
- make current health status easier to scan
- elevate the log history from simple rows to premium health record cards
- keep the experience calm, clear, and medically credible

## Current State

The current feature is functional but visually basic:

- `health_passport_view.dart` is a scaffold with app bar, FAB, and a raw list
- `health_logs_tile.dart` renders each log as a simple `ListTile`
- `health_logs_empty_state.dart` is lightweight and not aspirational
- `health_add_log_sheet.dart` is structurally sound but feels like a generic form

The feature already has the necessary primitives:

- stored health logs
- result-specific icon/color styling
- add-log bottom sheet flow
- localized copy

## Design Direction

Use a `premium editorial` direction with a `clinic luxe` tone.

The experience should feel like a personal medical record, not a plain utility list and not a novelty passport theme.

Visual goals:

- warm light surfaces instead of flat white
- generous spacing and stronger hierarchy
- refined chips, cards, and status labels
- restrained premium accents
- result colors that remain informative without looking alarming

## Information Hierarchy

### 1. Hero Summary

Add a prominent summary card at the top of the screen.

The hero should include:

- `Health Passport` title/subtitle
- latest check date
- latest result
- follow-up status or reminder state
- primary CTA to add a new record

This card should be the visual anchor of the screen.

### 2. Summary Metrics

Below the hero, show compact summary chips or stat capsules.

Recommended fields:

- last test type
- result status
- time since last check
- recommended follow-up indicator

These should be visually secondary to the hero but faster to scan than reading the timeline.

### 3. Editorial History

Replace simple tiles with richer history cards.

Each history card should present:

- test type
- result chip
- date
- icon or badge linked to result
- optional secondary caption such as “most recent” when relevant

The list should feel like a curated personal record.

### 4. Empty State

If no logs exist, the screen should still feel premium.

The empty state should:

- preserve the hero treatment
- explain the purpose of the feature
- give a strong CTA to create the first record
- feel reassuring rather than empty

## Result Styling

Result presentation should stay semantic but more polished.

Recommended palette direction:

- negative: clinical green
- pending / inconclusive: soft amber
- positive: controlled red, muted rather than loud

Each result should map consistently across:

- hero summary
- summary chips
- history cards
- add-log result selector

## Component Plan

### Existing Files to Refactor

- `lib/features/feature/health/widgets/health_passport_view.dart`
- `lib/features/feature/health/widgets/health_logs_list.dart`
- `lib/features/feature/health/widgets/health_logs_tile.dart`
- `lib/features/feature/health/widgets/health_logs_empty_state.dart`
- `lib/features/feature/health/widgets/health_add_log_sheet.dart`

### New Widgets Recommended

- `health_passport_hero_card.dart`
- `health_passport_summary_row.dart`
- `health_log_record_card.dart`
- `health_passport_section_header.dart`

Optional if needed:

- `health_passport_result_chip.dart`
- `health_passport_empty_hero.dart`

These separations keep files below the project size limit and make iterative polish easier.

## Behavior Rules

### With Existing Logs

- show hero summary using the most recent log
- show summary metrics under the hero
- show history ordered newest-first
- highlight the latest record subtly

### Without Logs

- show premium hero with reassuring introduction copy
- keep add-record CTA visually dominant
- suppress empty timeline chrome that adds noise

### Add Log Flow

The bottom sheet should match the premium visual system:

- improved top spacing and handle
- better title hierarchy
- upgraded text field styling
- result choices that feel like premium segmented selection
- more deliberate save CTA treatment

No logic changes are required for submission flow in this redesign.

## Data and Logic Scope

This design is intentionally presentation-first.

Do not change:

- health log persistence model
- save behavior
- repository interfaces
- scheduling logic already attached to submission

Allowed derived presentation logic:

- compute latest log
- compute time since latest log
- compute follow-up messaging from latest log date

This logic should live in feature services, not in widgets.

## Accessibility and Small Screens

The redesign must remain safe on smaller devices.

Required constraints:

- avoid dense horizontal layouts in hero sections
- allow hero content to stack vertically on narrow widths
- avoid chips or pills that depend on one-line text
- keep CTA reachable without needing oversized hero height

## Testing and Verification

Minimum verification:

- `flutter analyze` on touched health feature files
- widget-level sanity pass for empty and populated states
- manual check on narrow device size for hero stacking and bottom sheet spacing

Recommended follow-up:

- add at least one widget test for empty vs populated `HealthPassportView`

## Scope Boundary

This design does not include:

- new health fields
- attachments or lab documents
- reminders redesign beyond visual messaging
- advanced filtering or grouping in history

## Recommended Implementation Order

1. add summary/hero widgets
2. refactor screen composition in `health_passport_view.dart`
3. redesign history cards
4. redesign empty state
5. redesign add-log sheet
6. verify narrow-width behavior

## Recommendation

Implement the feature as a premium editorial health record with a strong summary hero and an upgraded card-based history.

This gives `Health Passport` a more premium identity while staying calm, credible, and easy to maintain.
