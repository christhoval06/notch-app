# Protection And Rhythm Drilldown Design

## Goal

Upgrade the `Protection` and `Rhythm` sections in `StatsScreen` with the same premium editorial drill-down pattern already used by `Activity Map`, `Top Partners`, and `Tag Intelligence`.

## Scope

This change adds tap-to-open bottom sheets for both sections.

`Protection` drill-down will show:
- headline insight and safety tone
- protection rate plus protected/unprotected counts
- last unprotected encounter context
- top partner associated with unprotected encounters
- recent unprotected encounters list

`Rhythm` drill-down will show:
- strongest time bucket and strongest weekday
- bucket distribution details
- weekday distribution details
- recent representative encounters
- short editorial summary of the pattern

## Architecture

The new logic stays in feature services and the screen-level widgets remain presentational.

New services:
- `stats_protection_detail_service.dart`
- `stats_rhythm_detail_service.dart`

New models will be added to `stats_editorial_models.dart` for:
- `StatsProtectionDetailSummary`
- `StatsRhythmDetailSummary`

New widgets will be split into small files:
- `stats_protection_detail_sheet.dart`
- `stats_protection_detail_metrics.dart`
- `stats_protection_recent_encounters.dart`
- `stats_protection_partner_insight.dart`
- `stats_rhythm_detail_sheet.dart`
- `stats_rhythm_detail_metrics.dart`
- `stats_rhythm_recent_encounters.dart`
- `stats_rhythm_weekday_breakdown.dart`

Existing section widgets will become interactive wrappers:
- `stats_protection_section.dart`
- `stats_rhythm_section.dart`

`StatsContent` will pass `viewModel.encounters` into both sections so detail services can derive contextual summaries without additional repository access.

## Interaction Design

Tapping the main section card opens a `ProfessionalBottomSheet`.

The sheet pattern will match the editorial style already established:
- compact title and subtitle
- premium metrics row
- contextual insight card
- recent encounter list when data exists
- graceful empty states when data is insufficient

The section cards themselves will gain subtle affordance through `InkWell` behavior and preserved premium styling rather than adding noisy controls.

## Data Rules

`Protection` summary rules:
- protection rate is based on the filtered encounters already used by the visible stats period
- last unprotected encounter uses the most recent unprotected entry
- top risk partner is the partner name with the most unprotected encounters
- recent list is limited to the latest few unprotected entries

`Rhythm` summary rules:
- strongest bucket comes from the highest count in the existing rhythm buckets
- strongest weekday comes from the highest weekday count
- recent representative list uses latest encounters from the filtered set
- editorial copy is derived from bucket/day combination and encounter density

## Error Handling And Empty States

- If there are no encounters, the sections stay hidden as they do today.
- If there is not enough data for drill-down details, the sheet still opens with a calm empty editorial state instead of failing silently.
- Missing partner names display a localized fallback already used elsewhere in stats.

## Testing

Add service tests for:
- protection detail aggregation
- rhythm detail aggregation

Add widget tests for:
- tapping `Protection` opens its detail sheet
- tapping `Rhythm` opens its detail sheet

Run:
- `flutter analyze --no-pub lib/features/insights test/features/insights`
- targeted `flutter test` for the new services and widgets

## Implementation Notes

- Respect the 150-line limit by splitting sheet parts aggressively.
- Keep all user-facing copy localized in `app_en.arb` and `app_es.arb`.
- Reuse existing stats widgets and tone services when possible to preserve consistency.
