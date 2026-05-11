# AGENTS Rules (Project)

## File Size Rule

- Avoid very large files.
- Maximum: `150` lines per Dart file.
- If a file grows over `150` lines, split responsibilities before adding more logic.

## Widget Separation Rule

- Do not keep many widgets in one file.
- Each reusable widget should live in its own file.
- Private helper widgets are allowed in the same file only when they are tiny and tightly coupled.
- If a widget has:
  - internal state, or
  - custom layout complexity, or
  - business/UI logic,
  move it to a dedicated file under the same feature folder.

## Suggested Structure

- `features/<feature>/presentation/pages/*_page.dart`
- `features/<feature>/widgets/<widget_name>.dart`
- `core/widgets/<shared_widget>.dart`

## Layer Rules (`data`, `core`, `features`)

- Keep strict separation by responsibility:
  - `data`: persistence, models, repositories, adapters.
  - `core`: shared app-wide infrastructure, design system, constants, utilities.
  - `features`: user flows and UI for each module.

### `data` Layer

- Models are in `lib/data/models` and must stay persistence-focused.
- Use Hive models/adapters in `data`; avoid UI imports.
- Repositories in `lib/data/repositories` are the only access point to boxes/services.
- Hive setup must stay centralized in `lib/data/hive`:
  - `boxes.dart` for box names.
  - `hive_init.dart` for adapter registration/opening boxes.
- Do not access Hive boxes directly from widgets/pages.

### `core` Layer

- Put reusable widgets in `lib/core/widgets`.
- Put app-wide services/sessions/controllers in `lib/core/services` or `lib/core/session`.
- Put shared utilities/formatters in `lib/core/utils`.
- Put shared constants in `lib/core/constants` (`app_routes`, `app_prefs`, currencies, emojis, etc.).
- Generic patterns (layout registry/controller/sheet, pagination, formatter helpers) belong to `core`.

### `features` Layer

- Organize by feature: `presentation`, `widgets`, `state`, `services`.
- Feature pages compose sections/widgets; avoid heavy business logic in pages/widgets.
- Use feature services for mapping/aggregation and consume repositories from `data`.
- Keep feature widgets in separate files; avoid “all widgets in one page file”.
- For customizable screens, prefer:
  - `state/*_widget_registry.dart`
  - `state/*_layout_controller.dart`
  - `widgets/*_widgets_sheet.dart`

## Localization (l10n) Rule

- UI strings must not be hardcoded in widgets/pages.
- Add new user-facing strings to:
  - `lib/l10n/app_en.arb`
  - `lib/l10n/app_es.arb`
- Use generated `AppLocalizations` getters in code.
- Keep code language in English; translations live in l10n files.

## Theme Color Rule

- Do not hardcode UI colors in feature/core widgets.
- Always use `Theme.of(context).colorScheme` (or theme extensions/design tokens).
- `Color(...)` hex values are allowed only in centralized theme/token definitions, not in screen/widget implementations.

## Core Usage Rule

- Reusable UI components must go in `lib/core/widgets`.
- Shared non-UI logic/utilities must go in `lib/core/services` or `lib/core/utils`.
- Feature files should consume core components instead of duplicating logic/styles.

## Constants Rule

- Centralize constants in `lib/core/constants`.
- No repeated route names, prefs keys, box names, or fixed option lists inline.
- For domain options (e.g., currencies, emoji sets), prefer constants files.

## Routes Rule

- Define route paths only in `lib/core/constants/app_routes.dart`.
- Define route map/builders in `lib/core/router/app_router.dart`.
- Consume the router from app-level setup (`lib/core/app/amigo_app.dart`).
- Feature widgets/pages should navigate through `AppRoutes` constants.

## Services Rule

- Business/data mapping logic belongs in services/repositories, not widgets.
- Widgets should be presentation-first and consume view models from services.
- For list loading patterns, prefer reusable services (`InfinitePaginationService`).
- Keep service files split by responsibility to respect file size limits.

## Data Query Performance Rule

- Avoid repeated `getAll()`/full-box scans across multiple widgets in the same screen.
- For dashboard-style screens, build a shared snapshot in the feature service dependencies and reuse it per data revision.
- Cache derived maps/aggregations (for example: `id -> model`, `id -> name`, totals by foreign key) inside that snapshot.
- Invalidate snapshot cache only when source listenables change.
- Keep Hive access in repositories; widgets must consume already-aggregated view models.

## Refactor Trigger

When editing an existing file, split it if one of these is true:

- File is above `150` lines.
- More than `2` widget classes in the same file.
- Unrelated concerns mixed (UI + heavy mapping/logic).

## Review Gate

Before finalizing changes:

- Confirm file length is within limits.
- Confirm new widgets were not added inline in large files.
- Prefer small, composable widgets over monolithic screens.
