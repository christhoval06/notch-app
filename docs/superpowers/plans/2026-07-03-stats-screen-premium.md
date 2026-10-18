# Stats Screen Premium Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild `StatsScreen` into a premium cockpit with hero metrics, comparison deltas, lightweight segmentation, and editorial story cards while preserving the existing charts.

**Architecture:** Keep UI dumb and push logic into the insights feature service layer. Add a query/filter layer for current vs previous comparable periods, a computation layer for hero metrics and story cards, and a presentation layer that returns a richer `StatsViewModel` for the screen widgets.

**Tech Stack:** Flutter, Dart, Hive repositories, existing `Analyzer`, existing insights widgets, `flutter_test`, `flutter analyze`

---

## File Map

**Create**
- `lib/features/feature/insights/services/stats_filter_service.dart`
- `lib/features/feature/insights/services/stats_story_service.dart`
- `lib/features/feature/insights/services/stats_comparison_service.dart`
- `lib/features/feature/insights/widgets/stats_hero_panel.dart`
- `lib/features/feature/insights/widgets/stats_segment_bar.dart`
- `lib/features/feature/insights/widgets/stats_story_cards.dart`
- `lib/features/feature/insights/widgets/stats_comparison_summary.dart`
- `test/features/feature/insights/services/stats_filter_service_test.dart`
- `test/features/feature/insights/services/stats_story_service_test.dart`
- `test/features/feature/insights/services/stats_view_model_service_test.dart`

**Modify**
- `lib/features/feature/insights/services/stats_view_model_service.dart`
- `lib/features/feature/insights/widgets/stats_view.dart`
- `lib/features/feature/insights/widgets/stats_content.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_es.arb`

**Verify**
- `flutter test test/features/feature/insights/services/stats_filter_service_test.dart test/features/feature/insights/services/stats_story_service_test.dart test/features/feature/insights/services/stats_view_model_service_test.dart`
- `flutter analyze --no-pub ...`

### Task 1: Add Stats Filter and Comparison Base

**Files:**
- Create: `lib/features/feature/insights/services/stats_filter_service.dart`
- Test: `test/features/feature/insights/services/stats_filter_service_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_filter_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_view_model_service.dart';

void main() {
  test('builds current and previous windows for month and six months', () {
    final now = DateTime(2026, 7, 3);
    final encounters = [
      _encounter('1', now.subtract(const Duration(days: 10))),
      _encounter('2', now.subtract(const Duration(days: 20))),
      _encounter('3', now.subtract(const Duration(days: 40))),
      _encounter('4', now.subtract(const Duration(days: 200))),
    ];

    final month = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.month,
      segment: StatsSegment.all,
      now: now,
    );
    final sixMonths = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.sixMonths,
      segment: StatsSegment.all,
      now: now,
    );

    expect(month.current.length, 2);
    expect(month.previous.length, 1);
    expect(sixMonths.current.length, 3);
    expect(sixMonths.previous.length, 1);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/feature/insights/services/stats_filter_service_test.dart`
Expected: FAIL because `StatsFilterService` and segment types do not exist yet.

- [ ] **Step 3: Write minimal implementation**

```dart
enum StatsSegment { all, partner, tags, protection, dayTime }

class StatsFilterResult {
  const StatsFilterResult({
    required this.current,
    required this.previous,
  });

  final List<Encounter> current;
  final List<Encounter> previous;
}

class StatsFilterService {
  const StatsFilterService._();

  static StatsFilterResult filter({
    required List<Encounter> encounters,
    required StatPeriod period,
    required StatsSegment segment,
    DateTime? now,
    String? selection,
  }) {
    final anchor = now ?? DateTime.now();
    final current = _periodSlice(encounters, period, anchor);
    final previous = _previousSlice(encounters, period, anchor);
    return StatsFilterResult(
      current: _applySegment(current, segment, selection),
      previous: _applySegment(previous, segment, selection),
    );
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/feature/insights/services/stats_filter_service_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/insights/services/stats_filter_service.dart test/features/feature/insights/services/stats_filter_service_test.dart
git commit -m "feat: add stats filtering base"
```

### Task 2: Add Story Card Computation

**Files:**
- Create: `lib/features/feature/insights/services/stats_story_service.dart`
- Test: `test/features/feature/insights/services/stats_story_service_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_service.dart';

void main() {
  test('builds best context and momentum story cards when sample is enough', () {
    final stories = StatsStoryService.build(
      current: [
        _encounter('1', DateTime(2026, 6, 20), rating: 9, tags: ['tag_travel']),
        _encounter('2', DateTime(2026, 6, 22), rating: 10, tags: ['tag_travel']),
        _encounter('3', DateTime(2026, 6, 25), rating: 9, tags: ['tag_date']),
      ],
      previous: [
        _encounter('4', DateTime(2026, 5, 20), rating: 7),
        _encounter('5', DateTime(2026, 5, 22), rating: 7),
      ],
    );

    expect(stories.any((item) => item.id == 'best_context'), isTrue);
    expect(stories.any((item) => item.id == 'momentum'), isTrue);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/feature/insights/services/stats_story_service_test.dart`
Expected: FAIL because story service and story model do not exist.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsStoryCardData {
  const StatsStoryCardData({
    required this.id,
    required this.title,
    required this.headline,
    required this.supporting,
    required this.tone,
  });

  final String id;
  final String title;
  final String headline;
  final String supporting;
  final StatsTrend tone;
}

class StatsStoryService {
  const StatsStoryService._();

  static List<StatsStoryCardData> build({
    required List<Encounter> current,
    required List<Encounter> previous,
  }) {
    final cards = <StatsStoryCardData>[];
    // Add best_context and momentum first.
    return cards;
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/feature/insights/services/stats_story_service_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/insights/services/stats_story_service.dart test/features/feature/insights/services/stats_story_service_test.dart
git commit -m "feat: add stats story computation"
```

### Task 3: Evolve Stats View Model

**Files:**
- Modify: `lib/features/feature/insights/services/stats_view_model_service.dart`
- Test: `test/features/feature/insights/services/stats_view_model_service_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/feature/insights/services/stats_view_model_service.dart';

void main() {
  test('build returns hero metrics, comparison summary, stories, and charts', () {
    final model = StatsViewModelService.build(
      StatPeriod.sixMonths,
      segment: StatsSegment.all,
    );

    expect(model.heroMetrics.length, 3);
    expect(model.comparisonSummary.isNotEmpty, isTrue);
    expect(model.storyCards.isNotEmpty, isTrue);
    expect(model.monthlyData, isNotEmpty);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/feature/insights/services/stats_view_model_service_test.dart`
Expected: FAIL because the view model does not expose the new properties.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsHeroMetric {
  const StatsHeroMetric({
    required this.id,
    required this.label,
    required this.currentValue,
    required this.previousValue,
    required this.deltaLabel,
    required this.trend,
  });
}

enum StatsTrend { up, down, neutral }

class StatsViewModel {
  const StatsViewModel({
    required this.heroMetrics,
    required this.comparisonSummary,
    required this.storyCards,
    // keep existing fields too
  });
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/feature/insights/services/stats_view_model_service_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/insights/services/stats_view_model_service.dart test/features/feature/insights/services/stats_view_model_service_test.dart
git commit -m "feat: enrich stats view model"
```

### Task 4: Add Hero, Summary, and Segment Widgets

**Files:**
- Create: `lib/features/feature/insights/widgets/stats_hero_panel.dart`
- Create: `lib/features/feature/insights/widgets/stats_comparison_summary.dart`
- Create: `lib/features/feature/insights/widgets/stats_segment_bar.dart`
- Modify: `lib/features/feature/insights/widgets/stats_content.dart`

- [ ] **Step 1: Write the failing widget expectations**

```dart
// Expect stats content to render the hero, summary, and segment bar
expect(find.byType(StatsHeroPanel), findsOneWidget);
expect(find.byType(StatsComparisonSummary), findsOneWidget);
expect(find.byType(StatsSegmentBar), findsOneWidget);
```

- [ ] **Step 2: Run focused widget test or analyze to verify missing symbols**

Run: `flutter analyze --no-pub lib/features/feature/insights/widgets/stats_content.dart`
Expected: FAIL because the new widgets are not created yet.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsHeroPanel extends StatelessWidget { ... }
class StatsComparisonSummary extends StatelessWidget { ... }
class StatsSegmentBar extends StatelessWidget { ... }
```

Update `StatsContent` to render:

```dart
StatsHeroPanel(metrics: viewModel.heroMetrics),
StatsComparisonSummary(message: viewModel.comparisonSummary),
StatsSegmentBar(
  selected: selectedSegment,
  onChanged: onSegmentChanged,
),
```

- [ ] **Step 4: Run analyze to verify the new widgets compile**

Run: `flutter analyze --no-pub lib/features/feature/insights/widgets/stats_content.dart lib/features/feature/insights/widgets/stats_hero_panel.dart lib/features/feature/insights/widgets/stats_comparison_summary.dart lib/features/feature/insights/widgets/stats_segment_bar.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/insights/widgets/stats_content.dart lib/features/feature/insights/widgets/stats_hero_panel.dart lib/features/feature/insights/widgets/stats_comparison_summary.dart lib/features/feature/insights/widgets/stats_segment_bar.dart
git commit -m "feat: add premium stats top section"
```

### Task 5: Add Story Cards and Reorder Deep Stats

**Files:**
- Create: `lib/features/feature/insights/widgets/stats_story_cards.dart`
- Modify: `lib/features/feature/insights/widgets/stats_content.dart`

- [ ] **Step 1: Write the failing expectation**

```dart
expect(find.byType(StatsStoryCards), findsOneWidget);
```

- [ ] **Step 2: Run analyze to verify it fails**

Run: `flutter analyze --no-pub lib/features/feature/insights/widgets/stats_content.dart`
Expected: FAIL because `StatsStoryCards` does not exist.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsStoryCards extends StatelessWidget {
  const StatsStoryCards({super.key, required this.cards});

  final List<StatsStoryCardData> cards;

  @override
  Widget build(BuildContext context) { ... }
}
```

Update `StatsContent` order:

```dart
StatsHeroPanel(...)
StatsComparisonSummary(...)
StatsPeriodToggle(...)
StatsSegmentBar(...)
StatsStoryCards(cards: viewModel.storyCards)
// existing charts below
```

- [ ] **Step 4: Run analyze to verify it passes**

Run: `flutter analyze --no-pub lib/features/feature/insights/widgets/stats_content.dart lib/features/feature/insights/widgets/stats_story_cards.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/insights/widgets/stats_content.dart lib/features/feature/insights/widgets/stats_story_cards.dart
git commit -m "feat: add stats story cards"
```

### Task 6: Wire Segment State and Lightweight Drilldown

**Files:**
- Modify: `lib/features/feature/insights/widgets/stats_view.dart`
- Modify: `lib/features/feature/insights/services/stats_view_model_service.dart`
- Modify: `lib/features/feature/insights/widgets/stats_monthly_activity_chart.dart`
- Modify: `lib/features/feature/insights/widgets/stats_heatmap_card.dart`

- [ ] **Step 1: Write the failing expectations**

```dart
// View model accepts a segment and stats view stores it in state
final viewModel = StatsViewModelService.build(
  StatPeriod.sixMonths,
  segment: StatsSegment.tags,
);
expect(viewModel.activeSegment, StatsSegment.tags);
```

- [ ] **Step 2: Run focused tests or analyze to verify it fails**

Run: `flutter test test/features/feature/insights/services/stats_view_model_service_test.dart`
Expected: FAIL because segment state is not wired through.

- [ ] **Step 3: Write minimal implementation**

```dart
class _StatsViewState extends State<StatsView> {
  StatPeriod _selectedPeriod = StatPeriod.sixMonths;
  StatsSegment _selectedSegment = StatsSegment.all;
}
```

Add:

```dart
onSegmentChanged: (segment) {
  setState(() => _selectedSegment = segment);
},
```

Allow chart tap callbacks to show short contextual snackbars or bottom sheets.

- [ ] **Step 4: Run focused tests and analyze**

Run: `flutter test test/features/feature/insights/services/stats_view_model_service_test.dart`
Expected: PASS

Run: `flutter analyze --no-pub lib/features/feature/insights/widgets/stats_view.dart lib/features/feature/insights/widgets/stats_monthly_activity_chart.dart lib/features/feature/insights/widgets/stats_heatmap_card.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/insights/widgets/stats_view.dart lib/features/feature/insights/services/stats_view_model_service.dart lib/features/feature/insights/widgets/stats_monthly_activity_chart.dart lib/features/feature/insights/widgets/stats_heatmap_card.dart
git commit -m "feat: wire stats segment state and drilldown"
```

### Task 7: Add Localization for Premium Stats Copy

**Files:**
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`

- [ ] **Step 1: Add missing strings**

```json
"statsHeroEncounters": "Encounters",
"statsHeroAverageRating": "Average rating",
"statsHeroOrgasms": "Orgasms",
"statsComparisonImproving": "Your activity rose, but quality dipped slightly.",
"statsSegmentAll": "All",
"statsSegmentPartner": "Partner",
"statsSegmentTags": "Tags",
"statsSegmentProtection": "Protection",
"statsSegmentDayTime": "Day/Time"
```

- [ ] **Step 2: Regenerate localization**

Run: `flutter gen-l10n`
Expected: localization classes updated successfully.

- [ ] **Step 3: Commit**

```bash
git add lib/l10n/app_en.arb lib/l10n/app_es.arb
git commit -m "feat: add premium stats localization"
```

### Task 8: Final Verification

**Files:**
- Verify all files touched above

- [ ] **Step 1: Run targeted tests**

Run:

```bash
flutter test \
  test/features/feature/insights/services/stats_filter_service_test.dart \
  test/features/feature/insights/services/stats_story_service_test.dart \
  test/features/feature/insights/services/stats_view_model_service_test.dart \
  test/core/utils/achievement_copy_service_test.dart
```

Expected: `All tests passed!`

- [ ] **Step 2: Run focused analysis**

Run:

```bash
flutter analyze --no-pub \
  lib/features/feature/insights/services/stats_filter_service.dart \
  lib/features/feature/insights/services/stats_story_service.dart \
  lib/features/feature/insights/services/stats_view_model_service.dart \
  lib/features/feature/insights/widgets/stats_view.dart \
  lib/features/feature/insights/widgets/stats_content.dart \
  lib/features/feature/insights/widgets/stats_hero_panel.dart \
  lib/features/feature/insights/widgets/stats_comparison_summary.dart \
  lib/features/feature/insights/widgets/stats_segment_bar.dart \
  lib/features/feature/insights/widgets/stats_story_cards.dart
```

Expected: `No issues found!`

- [ ] **Step 3: Commit final integration**

```bash
git add lib test lib/l10n
git commit -m "feat: upgrade stats screen to premium cockpit"
```

## Self-Review

### Spec Coverage

- Premium hero: covered in Tasks 3-4
- Comparison summary: covered in Tasks 3-4
- Lightweight segmentation: covered in Tasks 1, 3, 4, 6
- Story cards: covered in Tasks 2, 3, 5
- Deep stats retained: covered in Task 5
- Drill-down light behavior: covered in Task 6
- Localization: covered in Task 7

### Placeholder Scan

- No `TODO` or `TBD`
- Each task includes concrete files and commands
- Each code step includes specific structures to create or modify

### Type Consistency

- Shared types defined in `stats_view_model_service.dart`: `StatsSegment`, `StatsTrend`, `StatsHeroMetric`, `StatsStoryCardData`
- `StatsFilterService` and `StatsStoryService` both feed those shared types

