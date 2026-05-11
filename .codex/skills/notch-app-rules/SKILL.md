---
name: notch-app-rules
description: Enforce Notch app architecture and coding guardrails for Flutter changes. Use when modifying Dart code in this repository, especially when adding or refactoring features, widgets, routes, services, localization strings, constants, or data access patterns that must comply with project AGENTS rules.
---

# Notch App Rules

## Overview

Apply this skill before and during any code change in this repository. Keep edits aligned with project structure, layering, localization, theming, and file-size constraints.

## Execution Workflow

1. Read `/Users/alfamedic/Developer/apps/notch-app/AGENTS.md` before editing.
2. Locate impacted files and check current file lengths and widget count.
3. Implement changes while enforcing layer boundaries (`data`, `core`, `features`).
4. Move reusable or complex widgets into dedicated files.
5. Move business logic out of UI files into services/repositories.
6. Add localization entries for new user-facing strings.
7. Re-check touched files against the review gate before finalizing.

## Non-Negotiable Guardrails

- Keep every Dart file at or below 150 lines. Split responsibilities early.
- Keep reusable widgets in separate files; keep helper widgets inline only if tiny and tightly coupled.
- Avoid mixing unrelated concerns in one file (UI + heavy mapping/logic).
- Keep Hive model/adapter/repository work in `lib/data`; avoid direct Hive box access from widgets/pages.
- Keep shared app primitives in `lib/core` (widgets, services, constants, utils, routing).
- Keep feature-specific flows in `lib/features/<feature>` with `presentation`, `widgets`, `state`, `services` organization.
- Route paths: define in `lib/core/constants/app_routes.dart` and wire builders in `lib/core/router/app_router.dart`.
- Avoid hardcoded UI strings in widgets/pages; use `AppLocalizations` generated getters.
- Add new user-facing text to both `lib/l10n/app_en.arb` and `lib/l10n/app_es.arb`.
- Avoid hardcoded colors in feature/core widgets; use `Theme.of(context).colorScheme` or theme tokens.
- Centralize repeated constants (routes, prefs keys, box names, option lists) under `lib/core/constants`.

## Data and Performance Rules

- Keep Hive setup centralized in `lib/data/hive/boxes.dart` and `lib/data/hive/hive_init.dart`.
- Use repositories in `lib/data/repositories` as the only box/service access point.
- Avoid repeated full scans (`getAll()`) across multiple widgets on the same screen.
- Build shared feature snapshots for dashboard-style screens and reuse per data revision.
- Cache derived maps/aggregations in feature services and invalidate only on source listenable changes.

## Refactor Triggers

Refactor immediately when any touched file meets at least one condition:

- Dart file exceeds 150 lines.
- File contains more than 2 widget classes.
- File mixes unrelated responsibilities.

## Review Gate

Before finalizing a change:

1. Confirm every touched Dart file remains within 150 lines.
2. Confirm no new complex/stateful widget was added inline to a large page file.
3. Confirm UI strings are localized and ARB files are updated in both languages.
4. Confirm no hardcoded feature/core UI colors were introduced.
5. Confirm routes/constants/data access respect central definitions and layer boundaries.
6. Prefer small composable widgets and services over monolithic screen logic.
