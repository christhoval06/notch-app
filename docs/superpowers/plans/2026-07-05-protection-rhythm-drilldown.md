# Protection And Rhythm Drilldown Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add premium tap-to-open drill-down sheets for the `Protection` and `Rhythm` stats sections.

**Architecture:** Keep all aggregation logic in feature services and keep section widgets presentation-only. Reuse the existing editorial bottom-sheet pattern and split new UI into small widgets so no touched Dart file exceeds the project limit.

**Tech Stack:** Flutter, Dart, project l10n ARB files, widget tests, service tests

---

### Task 1: Protection detail data model and service

**Files:**
- Create: `lib/features/feature/insights/services/stats_protection_detail_models.dart`
- Create: `lib/features/feature/insights/services/stats_protection_detail_service.dart`
- Test: `test/features/feature/insights/services/stats_protection_detail_service_test.dart`

- [ ] Add a failing service test for protection aggregation.
- [ ] Implement `StatsProtectionDetailSummary` in a dedicated model file to avoid growing `stats_editorial_models.dart`.
- [ ] Implement protection detail aggregation with last unprotected context, top risk partner, and recent unprotected encounters.
- [ ] Run the protection detail service test and confirm it passes.

### Task 2: Protection interactive sheet

**Files:**
- Modify: `lib/features/feature/insights/widgets/stats_content.dart`
- Modify: `lib/features/feature/insights/widgets/stats_protection_section.dart`
- Create: `lib/features/feature/insights/widgets/stats_protection_detail_sheet.dart`
- Create: `lib/features/feature/insights/widgets/stats_protection_detail_metrics.dart`
- Create: `lib/features/feature/insights/widgets/stats_protection_recent_encounters.dart`
- Create: `lib/features/feature/insights/widgets/stats_protection_partner_insight.dart`
- Test: `test/features/feature/insights/widgets/stats_protection_section_test.dart`

- [ ] Add a failing widget test that taps the protection card and expects the detail sheet content.
- [ ] Pass `viewModel.encounters` into `StatsProtectionSection`.
- [ ] Make the section tappable and open the new editorial protection sheet.
- [ ] Keep each new widget file focused and under the line limit.
- [ ] Run the protection widget test and confirm it passes.

### Task 3: Rhythm detail data model and service

**Files:**
- Create: `lib/features/feature/insights/services/stats_rhythm_detail_models.dart`
- Create: `lib/features/feature/insights/services/stats_rhythm_detail_service.dart`
- Test: `test/features/feature/insights/services/stats_rhythm_detail_service_test.dart`

- [ ] Add a failing service test for rhythm aggregation.
- [ ] Implement `StatsRhythmDetailSummary` with bucket counts, weekday counts, and recent encounters.
- [ ] Implement rhythm detail aggregation with strongest bucket, strongest weekday, and editorial context.
- [ ] Run the rhythm detail service test and confirm it passes.

### Task 4: Rhythm interactive sheet

**Files:**
- Modify: `lib/features/feature/insights/widgets/stats_content.dart`
- Modify: `lib/features/feature/insights/widgets/stats_rhythm_section.dart`
- Create: `lib/features/feature/insights/widgets/stats_rhythm_detail_sheet.dart`
- Create: `lib/features/feature/insights/widgets/stats_rhythm_detail_metrics.dart`
- Create: `lib/features/feature/insights/widgets/stats_rhythm_recent_encounters.dart`
- Create: `lib/features/feature/insights/widgets/stats_rhythm_weekday_breakdown.dart`
- Test: `test/features/feature/insights/widgets/stats_rhythm_section_test.dart`

- [ ] Add a failing widget test that taps the rhythm card and expects the detail sheet content.
- [ ] Pass `viewModel.encounters` into `StatsRhythmSection`.
- [ ] Make the section tappable and open the new editorial rhythm sheet.
- [ ] Reuse the protection sheet structure where it improves consistency, without coupling the files.
- [ ] Run the rhythm widget test and confirm it passes.

### Task 5: Localization and verification

**Files:**
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`
- Modify: generated l10n output via `flutter gen-l10n`

- [ ] Add all new strings required by both sheets in English and Spanish.
- [ ] Regenerate localizations.
- [ ] Run targeted insight tests for protection and rhythm.
- [ ] Run `flutter analyze --no-pub lib/features/feature/insights test/features/feature/insights`.
