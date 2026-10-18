# Stats Screen Premium Design

## Goal

Upgrade `StatsScreen` into a premium, more interactive, more data-rich experience with a `luxury lifestyle` visual tone and `performance dashboard` reading model.

Primary priorities:

1. Balanced upgrade across visual design, interaction, and data value.
2. Strong focus on smarter data interpretation.
3. Lightweight interactivity without turning stats into a heavy BI dashboard.

## Product Direction

The new stats experience should feel like a `premium performance cockpit`:

- Editorial, premium presentation.
- Fast understanding of how the user is doing.
- Clear comparison against previous periods.
- Lightweight exploration by context.
- Short path from summary to deeper insights.

The screen should answer:

- How am I doing now?
- What changed versus before?
- In which context do I perform best?
- What patterns are worth repeating or watching?

## Experience Structure

### Top Area

- Premium hero with 3 primary metrics:
  - total encounters
  - average rating
  - total orgasms
- Each metric includes:
  - current value
  - previous equivalent period value
  - delta
  - trend state
- A short editorial comparison summary:
  - example: `Your activity rose, but quality dipped slightly.`

### Controls

- Existing period toggle remains, but elevated visually.
- Lightweight segment bar directly below hero:
  - `All`
  - `Partner`
  - `Tags`
  - `Protection`
  - `Day/Time`
- If a segment requires a sub-selection, show a simple secondary selector inline or below the segment bar.

### Story Layer

Show premium story cards before deep charts.

Initial story card set:

1. Best context
2. Momentum
3. Consistency
4. Protection trend
5. Prime time
6. Peak month

Reserve for later phases:

- Exploration mode
- Recovery signal

### Deep Stats Layer

Retain current chart modules, but move them below the story layer:

- monthly activity chart
- annual heatmap
- tag distribution
- quality breakdown

### Bridge to Insights

- Keep entry to deeper insights.
- Stats remains fast and scannable.
- Insights remains the deeper narrative layer.

## Interaction Model

### Period Comparison

Every major KPI and story card should compare current period against the previous equivalent period:

- 30 days vs previous 30 days
- 6 months vs previous 6 months
- total vs no direct delta, or a neutral state where comparison is not meaningful

### Lightweight Segmentation

Segment filters should recalculate the whole screen without navigation:

- all data
- by partner
- by tag
- by protection state
- by day/time bucket

This must stay lightweight:

- no advanced filter sheet in v1
- no complex multi-select in v1

### Short Drill-Down

Allow taps on key modules for quick context:

- tapping a monthly bar reveals that month summary
- tapping a story card reveals why the insight was generated
- heatmap tap continues to show day-level summary

The interaction should be short and contextual, not a deep drill-down flow.

## Data Recommendations

### Hero Metrics

Use:

- total encounters
- average rating
- total orgasms
- optionally later: orgasms per encounter

Each hero metric needs:

- current
- previous
- delta absolute or relative
- trend enum

### Comparison Summary

Generate one short editorial sentence from the strongest deltas:

- activity up/down
- quality up/down
- protection up/down

### Story Cards

Story cards should be based on real data with sufficient sample thresholds.

#### Best context

Find strongest recent context by:

- best partner with enough sample
- best tag or tag combo with enough sample

#### Momentum

Measure:

- encounter count change
- rating change
- optional orgasms-per-encounter change

#### Consistency

Measure:

- lowest variability in rating among contexts with enough sample

#### Protection trend

Measure:

- recent protection ratio vs previous equivalent ratio

#### Prime time

Measure:

- best weekday and/or time bucket by average performance with enough sample

#### Peak month

Measure:

- strongest recent month by average rating and enough activity

## Architecture

Implement in three layers inside `features/feature/insights`.

### 1. Query / Filter Layer

Responsibilities:

- load encounters
- filter by period
- apply active segment
- apply optional sub-segment
- build previous comparable dataset

### 2. Computation Layer

Responsibilities:

- calculate hero metrics
- calculate deltas
- compute story card source metrics
- compute chart data
- compute comparison summary inputs

### 3. Presentation Layer

Responsibilities:

- convert computed metrics into a UI-ready `StatsViewModel`
- provide story cards already editorialized
- provide segment state and labels
- provide comparison summary text inputs

The UI should not contain business logic or scoring logic.

## View Model Evolution

Current `StatsViewModel` is too shallow for the premium screen. It should evolve to include:

- filtered encounters
- hero metrics
- comparison summary
- story cards
- active segment state
- available segment options
- existing chart data
- highest rank
- optional drilldown payloads

Suggested additions:

- `StatsHeroMetric`
- `StatsTrend`
- `StatsComparisonSummary`
- `StatsStoryCard`
- `StatsSegment`
- `StatsSegmentOption`

## UI Composition

Split the screen into smaller widgets:

- `stats_hero_panel.dart`
- `stats_comparison_summary.dart`
- `stats_segment_bar.dart`
- `stats_segment_selector.dart`
- `stats_story_cards.dart`
- `stats_story_card.dart`
- `stats_deep_dive_section.dart`

Retain current chart widgets where possible and wrap them in the new structure.

## Edge Cases

- If there is no data, keep a strong empty state.
- If there is not enough sample for a story card, omit it rather than fabricate noise.
- If a segment has no data, show an empty segmented state with a safe return path to `All`.
- If previous comparable data is missing, show neutral trend state instead of fake deltas.

## Testing Strategy

### Metrics Tests

- period filtering
- previous period comparisons
- hero deltas
- segment filtering
- story card selection thresholds

### Presentation Tests

- `StatsViewModel` builds hero metrics correctly
- summary sentence input generation behaves correctly
- story cards are omitted when sample is insufficient

### Regression Tests

- no data
- sparse data
- empty segment result
- total period with no meaningful previous comparison

## Phase Plan

### V1

- premium hero
- period comparison
- lightweight segmentation
- 6 story cards
- current charts reordered below premium layer
- insights CTA remains

### V2

- richer drill-down
- more segment-specific detail
- additional story cards
- advanced contextual comparisons

## Scope Boundaries

This work does not include:

- full dashboard-builder style filters
- multi-select analytical tooling
- new routes for deep drill-down
- backend changes

## Recommended First Build

Build this exact v1:

1. premium hero metrics with deltas
2. editorial comparison summary
3. premium period toggle
4. lightweight segment bar
5. 6 story cards
6. existing charts re-ordered under the story layer
7. CTA to full insights

