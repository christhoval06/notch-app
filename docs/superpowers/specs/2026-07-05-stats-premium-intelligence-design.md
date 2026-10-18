# Stats Premium Intelligence Design

## Goal

Upgrade the current `Stats/Insights` experience with a premium intelligence layer that makes existing data easier to understand and more valuable to act on.

This design keeps the current stats screen structure and sections, but adds a new top layer that interprets the data instead of only displaying raw summaries.

Primary priorities:

1. Preserve the current screen and enrich it instead of replacing it.
2. Increase perceived premium quality through stronger editorial hierarchy.
3. Add genuinely new intelligence signals, not just additional cards.
4. Keep the first release modular, testable, and safe to evolve.

## Product Direction

The stats experience should feel like a personal intelligence brief:

- fast to scan
- premium in presentation
- editorial in tone
- grounded in real encounter data

The top of the screen should answer:

- What is the strongest signal in this period?
- Is the user's consistency improving or slipping?
- Is quality rising, stable, or cooling?
- Is the user in a focused or exploratory relational mode?

The deeper sections that already exist should remain available below this new layer.

## Experience Structure

The screen keeps the current layout model, but introduces a new premium intelligence layer above the existing overview.

### Top Layer

#### 1. Mixed Hero Insight

A single large hero card chooses the strongest insight for the selected period.

Possible categories:

- quality momentum
- consistency shift
- partner mode
- protection drift
- rhythm dominance

The hero should contain:

- a short eyebrow such as `This period`
- a strong editorial headline
- a short supporting explanation
- a highlighted metric label and value
- a tone state: positive, caution, or neutral

Examples:

- `Quality is trending up`
- `Your rhythm is getting sharper`
- `You are in a more focused phase`
- `Protection slipped this period`

#### 2. Signal Strip

Three compact signal cards live below the hero:

- consistency
- quality momentum
- partner mode

Each signal card should show:

- short label
- compact value
- delta or state
- trend/tone color

#### 3. Premium Story Deck

Two or three editorial cards should translate the data into short human readings.

Initial story types:

- best pattern
- biggest shift
- opportunity

This layer should feel curated rather than exhaustive.

### Existing Sections Below

Below the new premium intelligence layer, the screen should continue to render the existing sections:

- overview
- activity
- top partners
- tag intelligence
- protection
- rhythm

This preserves the current information architecture while making the entry point much stronger.

## Intelligence Signals

### Consistency Index

Purpose:
Measure behavioral regularity, not just total volume.

Inputs:

- encounter frequency
- weekly continuity
- average gap between encounters
- distribution consistency inside the period

Editorial states:

- `Steady`
- `Improving`
- `Irregular`

### Quality Momentum

Purpose:
Measure whether recent experience quality is improving or cooling.

Inputs:

- average rating in current period
- average rating in previous comparable period
- percentage of encounters rated `8+`
- confidence threshold from sample size

Editorial states:

- `Rising`
- `Stable`
- `Cooling`

### Partner Mode

Purpose:
Describe the relational style of the selected period.

Inputs:

- distinct partner count
- concentration in top partner
- distribution across partners

Editorial states:

- `Focused`
- `Balanced`
- `Exploratory`

### Protection Drift

Purpose:
Measure whether safety behavior changed meaningfully versus the previous comparable period.

Inputs:

- protection ratio current vs previous
- recent unprotected encounters
- sample threshold

Editorial states:

- `Stable`
- `Improving`
- `Watch`

### Rhythm Dominance

Purpose:
Detect whether there is a strong time-based behavioral window.

Inputs:

- dominant time bucket
- dominant weekday
- strength of concentration

Editorial states:

- `Night-led`
- `Day-led`
- `Mixed`

## Mixed Hero Selection

The hero uses a hybrid selection strategy:

1. Build candidate insights from every supported category.
2. Discard candidates that do not meet minimum sample thresholds.
3. Score remaining candidates by:
   - magnitude of change
   - clarity of pattern
   - confidence of the dataset
   - editorial priority
4. Select the highest scoring candidate.
5. If no candidate is strong enough, show a neutral fallback hero.

This keeps the behavior intelligent without making it unpredictable.

## Scope

### Included In V1

- mixed hero insight
- signal strip with:
  - consistency
  - quality momentum
  - partner mode
- premium story deck
- new premium intelligence models
- premium intelligence services
- integration into `StatsViewModel`
- top-layer rendering in `StatsContent`
- localized editorial copy
- neutral fallback states for low-data periods

### Calculated In V1, But Not Always Surfaced In The Signal Strip

- protection drift
- rhythm dominance

These are allowed to act as hero candidates even if they are not fixed cards in the strip.

### Deferred To V2

- dynamic section reordering
- deep drilldown flows
- advanced recommendation engine
- composite intelligence score
- contextual recommendations per tag or partner

## Architecture

All implementation remains inside `lib/features/feature/insights`.

### New Service Files

- `stats_premium_models.dart`
- `stats_consistency_service.dart`
- `stats_quality_momentum_service.dart`
- `stats_partner_mode_service.dart`
- `stats_protection_drift_service.dart`
- `stats_rhythm_dominance_service.dart`
- `stats_hero_insight_service.dart`
- `stats_premium_intelligence_service.dart`

### New Widget Files

- `stats_premium_hero.dart`
- `stats_signal_strip.dart`
- `stats_signal_card.dart`
- `stats_premium_story_deck.dart`

### Existing Files To Evolve

- `stats_models.dart`
  Add `premiumIntelligence` to `StatsViewModel`.

- `stats_view_model_service.dart`
  Build and inject premium intelligence after current and previous datasets are calculated.

- `stats_content.dart`
  Insert the premium intelligence layer above the existing overview and below the period toggle.

## Data Flow

1. Load encounters from repositories.
2. Filter current and previous comparable periods.
3. Build existing summaries as today.
4. Build premium intelligence package from current and previous datasets.
5. Inject premium package into `StatsViewModel`.
6. Render:
   - period toggle
   - premium hero
   - signal strip
   - premium story deck
   - existing overview and deeper sections

## UI Direction

The premium intelligence layer should feel more editorial than dashboard-like.

Visual principles:

- one strong hero card
- compact but luxurious signals
- restrained color as meaning, not decoration
- readable hierarchy before density
- premium motion only where it improves understanding

The new layer should visually match the premium direction already used in recent health and gamification work.

## Guardrails

- No hardcoded user-facing strings in widgets.
- New copy must go to both `app_en.arb` and `app_es.arb`.
- Keep files under 150 lines by splitting widgets and services early.
- Keep logic in services, not in widgets.
- Avoid introducing weak or noisy insights with tiny sample sizes.

## Success Criteria

The design is successful when:

1. The user immediately sees a useful top-level reading of the selected period.
2. The top layer feels meaningfully more premium than the current stats screen.
3. The three fixed signals are understandable in seconds.
4. The mixed hero changes categories with clear logic and not random behavior.
5. The implementation preserves current sections and keeps architecture modular.
