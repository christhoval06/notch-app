# Challenge Expansion Design

## Goal

Extend the current challenge system without removing existing challenges.

This change will:
- keep all current challenge IDs
- preserve the existing seasonal vs historical catalog structure
- add XP rewards based on challenge difficulty
- add new partner-focused challenges

## Current Constraints

- Challenges are currently split across two catalogs:
  - `seasonal_challenge_catalog.dart`
  - `lifetime_challenge_catalog.dart`
- Progress is recalculated from encounters.
- Current challenges do not grant explicit gamification XP rewards.
- `Encounter` stores `partnerName`, which is sufficient to support partner-based progress rules.

## Decisions

### 1. Existing Challenges Stay

No current challenge is removed.

The system keeps existing challenge IDs and behavior, except where already corrected for bugs.

### 2. Seasonal vs Historical Families

The current catalog split remains the source of truth:

- seasonal challenges live in `seasonal_challenge_catalog.dart`
- historical challenges live in `lifetime_challenge_catalog.dart`

This avoids introducing a second classification layer prematurely.

### 3. XP Rewards by Difficulty

Challenges will grant XP when completed.

Rewards are based on difficulty tier:

- `easy`: `40 XP`
- `medium`: `75 XP`
- `hard`: `120 XP`
- `historical`: `180 XP`
- `legendaryHistorical`: `250 XP`

XP should be granted immediately when a challenge becomes completed, but only once per reward claim.

### 4. Reward Claim Safety

Challenge rewards must not be granted more than once for the same completion.

The system will persist claimed challenge rewards separately from raw challenge progress.

This is required because progress can be recalculated when:
- the app starts
- data changes
- seasons change
- old encounters are edited or restored

### 5. New Partner Challenges

#### Seasonal

`single_partner_season`

- family: seasonal
- difficulty: hard
- reward: `120 XP`
- goal: `8`
- rule:
  - count encounters in the current season
  - all counted encounters must belong to exactly one partner
  - if a second partner appears in the same season, progress becomes `0`

Interpretation:
- one partner across the season is required
- the challenge is broken by introducing another partner

#### Historical

`single_partner_100`

- family: historical
- difficulty: historical
- reward: `180 XP`
- goal: `100`
- rule:
  - find the partner with the highest encounter count in full history
  - progress equals that highest count

#### Historical

`single_partner_500`

- family: historical
- difficulty: legendaryHistorical
- reward: `250 XP`
- goal: `500`
- rule:
  - same calculation as `single_partner_100`
  - progress equals the highest historical encounter count for any single partner

## Data Model Changes

The `Challenge` model should gain enough metadata to support rewards and future grouping cleanly.

Recommended additions:

- `family`
- `difficulty`
- `xpReward`

Suggested enums:

- `ChallengeFamily.seasonal`
- `ChallengeFamily.historical`

- `ChallengeDifficulty.easy`
- `ChallengeDifficulty.medium`
- `ChallengeDifficulty.hard`
- `ChallengeDifficulty.historical`
- `ChallengeDifficulty.legendaryHistorical`

## Persistence Changes

Introduce persisted reward tracking for completed challenges.

Suggested shape:

- a list or set of claimed challenge IDs
- optionally season-scoped keys for seasonal rewards if rewards must repeat across seasons

Open implementation choice:
- if seasonal challenges should reward once per season, claimed keys should include season identity
- if seasonal challenges should reward only once globally, a plain challenge ID is enough

Recommended behavior:
- seasonal rewards should be claimable once per season
- historical rewards should be claimable once globally

## Progress Rules

### Seasonal Single Partner

For the current season:

- gather all encounters in season
- if none exist, progress is `0`
- collect distinct normalized `partnerName` values
- if distinct partners > 1, progress is `0`
- otherwise progress = encounter count, clamped to goal

### Historical Single Partner

For all encounters:

- group by normalized `partnerName`
- progress = highest count among all groups

## Normalization

Partner matching should normalize `partnerName` values before grouping:

- trim whitespace
- compare case-insensitively

This reduces accidental splits like `Ana`, `ana`, or ` Ana `.

## UI Changes

Challenges UI can continue using the current card system.

Minimum additions:
- new titles and descriptions for the three partner challenges
- reward-ready metadata available to the challenge presentation layer

Future enhancement, not required now:
- show family badge (`Seasonal`, `Historical`)
- show XP reward pill on each challenge card

## Verification Plan

Add service tests for:

- seasonal single-partner progress counts correctly
- seasonal single-partner progress resets to `0` after a second partner appears
- historical single-partner progress uses the top partner count
- XP tier mapping returns expected values
- seasonal claims are once per season
- historical claims are once globally

## Scope Boundary

This design does not include:

- redesigning the challenges screen
- replacing `partnerName` with `partnerId`
- retroactive migration of past challenge rewards beyond what is needed for safe claiming

## Recommendation

Implement in this order:

1. challenge metadata for family, difficulty, reward
2. reward claim persistence
3. partner-based progress helpers
4. the three new challenges
5. tests and localized strings

## Recommended Backlog

After the initial partner challenge implementation, the next recommended batch is:

### 1. `quality_streak_3`

- family: seasonal
- difficulty: medium
- reward: `75 XP`
- goal: `3`
- rule:
  - complete `3` consecutive encounters with rating `8+`

Why:
- easy to explain
- gives a quality-based short-term target

### 2. `balanced_week`

- family: seasonal
- difficulty: medium
- reward: `75 XP`
- goal: `3`
- rule:
  - log encounters on `3` distinct days inside the last `7` days

Why:
- encourages rhythm instead of raw volume
- complements existing streak and abstinence challenges

### 3. `tag_combo_5`

- family: seasonal
- difficulty: hard
- reward: `120 XP`
- goal: `5`
- rule:
  - use `5` distinct tags during the current season

Why:
- promotes exploration
- fits the existing tag-driven system cleanly

### 4. `quality_streak_5`

- family: historical
- difficulty: historical
- reward: `180 XP`
- goal: `5`
- rule:
  - complete `5` consecutive encounters with rating `8+`

Why:
- extends the same idea as `quality_streak_3`
- creates a more prestigious long-term version

### 5. `loyal_month`

- family: seasonal
- difficulty: hard
- reward: `120 XP`
- goal: `12`
- rule:
  - log `12` encounters in the season with exactly one partner
  - progress becomes `0` if a second partner appears in the same season

Why:
- pairs naturally with `single_partner_season`
- creates a tougher version without inventing a separate mechanic

### 6. `steady_bond_50`

- family: historical
- difficulty: legendaryHistorical
- reward: `250 XP`
- goal: `50`
- rule:
  - log `50` protected encounters with a single partner across full history

Why:
- combines loyalty and safety
- feels premium and meaningfully different from the raw `500` count challenge

### Priority Order

Recommended implementation priority after the first partner batch:

1. `quality_streak_3`
2. `balanced_week`
3. `tag_combo_5`
4. `quality_streak_5`
5. `loyal_month`
6. `steady_bond_50`
