# Top Partners Drill-Down Design

## Goal

Upgrade the `Top Partners` section in `StatsScreen` from a static summary into an interactive editorial panel with a premium detail view per partner.

The experience should help the user answer:

- Which partner has been most relevant in this period?
- What is the quality and safety profile with that partner?
- Which tags and moments define that connection?
- What have the latest encounters with that partner looked like?

## Current State

- `StatsTopPartnersSection` renders a ranked list of partner cards.
- `StatsPartnerCard` shows:
  - rank
  - partner name
  - badge label
  - avg rating
  - total orgasms
  - encounter count
  - last seen date
- Partner summaries are produced by `StatsPartnerSummaryService`.

This is visually strong, but still shallow. There is no tap interaction, no drill-down, and no partner-specific narrative.

## Proposed Experience

Tapping a partner card opens a premium bottom sheet with a partner editorial summary.

### Top-Level Flow

1. User opens `StatsScreen`.
2. User sees `Top Partners`.
3. User taps one partner card.
4. App opens a `ProfessionalBottomSheet`.
5. Bottom sheet shows a partner-specific story for the currently selected period.

## Detail View Contents

The partner detail sheet should include:

### 1. Hero Summary

- Partner name
- Badge label carried from the card
- Short editorial subtitle such as:
  - `Most active connection in this period`
  - `Highest chemistry among your top partners`
  - `Most recently seen`

### 2. Key Metrics Row

Show four compact facts:

- encounters with this partner
- average rating
- total orgasms
- protection rate

### 3. Signature Context

Show the strongest context for this partner:

- dominant mood
- top 3 tags used with this partner
- dominant day-time bucket if derivable from encounter times

### 4. Recent Encounters

Show a compact expandable list of recent encounters with:

- date
- time
- rating
- orgasm count
- protection state
- tags if present

Default collapsed view:

- latest 2 encounters

Expanded view:

- all partner encounters in the selected period

### 5. Editorial Insight

Show one short generated sentence using summary stats, for example:

- `This partner combines your highest average rating with strong consistency.`
- `Most of your encounters here happen at night and trend well above your baseline.`
- `Protection stayed consistent while the connection remained highly rated.`

## Data Model Changes

Add a partner drill-down summary model separate from `StatsPartnerSummary` to avoid overloading the list card data.

Suggested model:

- `StatsPartnerDetailSummary`
  - `partnerName`
  - `encounterCount`
  - `averageRating`
  - `totalOrgasms`
  - `protectionRate`
  - `dominantMood`
  - `topTags`
  - `recentEncounters`
  - `insightTone` or `insightText`

## Services

Add a dedicated service:

- `stats_partner_detail_service.dart`

Responsibilities:

- filter encounters by partner name from the current period
- compute protection rate
- compute dominant mood
- compute top tags
- sort recent encounters descending by date
- derive short editorial insight text

Keep list-card summary logic in `StatsPartnerSummaryService` and detail logic in the new detail service.

## Widget Structure

Suggested new widgets:

- `stats_partner_detail_sheet.dart`
- `stats_partner_detail_metrics.dart`
- `stats_partner_recent_encounters.dart`
- `stats_partner_context_chips.dart`

Keep `StatsTopPartnersSection` focused on list rendering and tap wiring only.

## Interaction Rules

- Tapping a card opens the sheet.
- If only one or two encounters exist, the recent encounter list stays collapsed without toggle noise.
- If there are more than two, show `Show more / Show less`.
- Empty optional fields degrade gracefully:
  - no mood -> use existing `statsNoMoodLabel`
  - no tags -> localized empty label

## Localization

Add only the strings required for:

- partner sheet subtitle variants
- partner detail labels
- empty-state labels
- editorial insight templates if needed

All user-facing text must go through l10n.

## Visual Direction

- Keep the same premium editorial language established in `Activity Map`
- Use gradient-backed card surfaces inside the sheet
- Use concise metric chips
- Avoid dense tables
- Favor a narrative summary plus compact facts

## Testing

Add or update tests for:

- partner detail service summary computation
- `Top Partners` tap opens a detail sheet
- sheet handles minimal and multi-encounter partner histories

## Recommendation

Implement `Top Partners` next, not `Tag Intelligence`.

Reason:

- it is more emotionally legible
- it naturally supports a premium drill-down
- it reuses already strong ranking cards
- it benefits more from encounter-level detail than tag cards do
