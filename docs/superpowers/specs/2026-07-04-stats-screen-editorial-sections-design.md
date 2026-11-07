# Stats Screen Editorial Sections Design

## Goal

Refocus `StatsScreen` from segmented filtering into a premium editorial dashboard with fixed sections that explain the user's patterns without requiring extra decisions.

Primary priorities:

1. Reduce interaction complexity.
2. Increase perceived premium quality.
3. Extract more meaning from the same encounter data.

## Product Direction

The screen should feel closer to a personal intelligence report than a filterable analytics tool.

It should answer:

- How am I doing overall?
- Who matters most in my recent activity?
- Which contexts perform best?
- How safe has my recent behavior been?
- When do my strongest patterns happen?

## Experience Structure

### Overview

Keep a top overview area with:

- period toggle
- hero metrics
- comparison summary
- premium story cards

This remains the fast-scan layer.

### Partner Section

Replace partner filtering with a dedicated `Top 3 Partners` block.

Each partner card should show:

- partner name
- encounter count
- average rating
- total orgasms
- last encounter date

The section should also surface a simple editorial distinction when meaningful:

- `Most active`
- `Best chemistry`
- `Most recent`

### Tag Intelligence Section

Replace the pie-only reading with an insight-driven tag block.

For each top tag, show:

- usage count
- average rating
- most frequent partner for that tag
- dominant mood if available

Keep the number of surfaced tags intentionally small so the section reads as curated rather than exhaustive.

### Protection Section

Use a premium safety module instead of a plain stat row.

Required content:

- a gauge or radial indicator for protection percentage
- protected vs unprotected counts
- last unprotected partner
- last unprotected encounter date

Optional editorial line:

- stable
- improving
- caution

based on recent behavior versus the previous comparable period.

### Day/Time Section

Present this as a rhythm section instead of a filter.

Recommended content:

- strongest time bucket: morning, afternoon, or night
- strongest weekday
- simple split across the three day-time buckets
- one short narrative takeaway

Examples:

- `Friday night is your strongest window.`
- `Afternoons are frequent, but nights score higher.`

## Interaction Model

The redesign removes:

- segment chip navigation
- secondary sub-filter chips

The only global control that remains is the period toggle.

Micro-interactions should stay lightweight:

- story card tap opens deeper explanation
- partner card tap may later open details, but this is not required in v1
- charts remain informational, not exploratory

## Data Model Direction

The screen should move from one generic filtered model to section-oriented summaries.

Recommended computed summaries:

- `StatsOverviewSummary`
- `StatsPartnerSummary`
- `StatsTagSummary`
- `StatsProtectionSummary`
- `StatsRhythmSummary`

The UI should render from those summaries rather than deriving logic inline.

## Architecture

Implement inside `features/insights` using small services and widgets.

### Service Layer

Split calculations by responsibility:

- overview metrics and stories
- partner ranking summary
- tag intelligence summary
- protection summary
- rhythm summary

### Presentation Layer

Create one widget per major section:

- overview section
- top partners section
- tag intelligence section
- protection section
- rhythm section

This keeps `StatsContent` as a composition file and preserves the file-size rule.

## Scope

Included in this redesign:

- remove segment and sub-segment controls from `StatsScreen`
- add fixed editorial sections for partner, tags, protection, and day/time
- reuse existing overview modules where still useful
- localize all new UI copy

Not included in this pass:

- partner drill-down pages
- advanced comparison controls
- editable ranking preferences
- full per-tag history views

## Success Criteria

The redesign is successful when:

1. The screen can be understood without using any secondary filters.
2. The stats experience feels more curated and premium.
3. Each new section reveals a useful insight, not just a raw metric.
4. The implementation stays modular and within project file-size constraints.
