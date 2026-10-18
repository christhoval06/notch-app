# Stats Activity Heatmap Motion Design

## Goal

Bring back the GitHub-like `calendar heatmap` as a core comparison surface in `StatsScreen` and add lightweight motion so period changes feel intentional.

## Direction

Keep the heatmap as the main activity comparison module.

The redesign should:

- make the heatmap respond to the active period
- keep monthly activity as a secondary support chart
- add subtle section reveal and period-change transitions
- improve activity feedback when the user taps a day

## Scope

Included:

- reintroduce an activity section in `StatsScreen`
- update `StatsHeatmapCard` to use active period ranges
- keep or refine the activity chart as supporting comparison
- add micro-interactions for section reveal and period switching

Not included:

- deep drill-down analytics
- per-week comparison modules
- custom gesture-driven zooming

## Success Criteria

1. The heatmap clearly changes when the user switches `month`, `sixMonths`, and `allTime`.
2. The activity section feels premium and responsive, not static.
3. The GitHub-style comparison feel is preserved.
