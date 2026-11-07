# Tag Intelligence Editorial Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Upgrade `Tag Intelligence` into a premium editorial `top 5` section that visually matches the rest of the Stats redesign.

**Architecture:** Keep the existing `StatsTagInsight` data model, expand the summary service from `top 3` to `top 5`, and split the UI into a compact section widget plus a focused premium tag card widget so file sizes stay within repo rules.

**Tech Stack:** Flutter, Dart, project l10n, `flutter_test`, `flutter analyze`.

---

### Task 1: Expand tag summaries to top 5

**Files:**
- Modify: `lib/features/insights/services/stats_tag_summary_service.dart`
- Modify: `test/features/insights/services/stats_view_model_service_test.dart`

- [ ] **Step 1: Update the failing assertion**

```dart
expect(model.tagInsights.length, lessThanOrEqualTo(5));
```

- [ ] **Step 2: Run test to verify current behavior**

Run: `flutter test test/features/insights/services/stats_view_model_service_test.dart`
Expected: current test still passes, but the service still truncates at 3.

- [ ] **Step 3: Change the service limit**

```dart
}).take(5).toList();
```

- [ ] **Step 4: Run test**

Run: `flutter test test/features/insights/services/stats_view_model_service_test.dart`
Expected: PASS

### Task 2: Redesign Tag Intelligence cards

**Files:**
- Create: `lib/features/insights/widgets/stats_tag_card.dart`
- Modify: `lib/features/insights/widgets/stats_tag_intelligence_section.dart`

- [ ] **Step 1: Extract a dedicated premium card**

```dart
class StatsTagCard extends StatelessWidget {
  const StatsTagCard({
    super.key,
    required this.tag,
    required this.rank,
  });
}
```

- [ ] **Step 2: Compose the section from top 5 cards**

```dart
...tags.asMap().entries.map((entry) => StatsTagCard(
  tag: entry.value,
  rank: entry.key + 1,
))
```

- [ ] **Step 3: Preserve the existing data points**

```dart
// Show:
// count
// avg rating
// frequent partner
// dominant mood
```

- [ ] **Step 4: Run verification**

Run: `flutter analyze --no-pub lib/features/insights/widgets/stats_tag_intelligence_section.dart lib/features/insights/widgets/stats_tag_card.dart`
Expected: `No issues found!`

### Task 3: Final verification

**Files:**
- Test: `test/features/insights/services/stats_filter_service_test.dart`
- Test: `test/features/insights/services/stats_story_service_test.dart`
- Test: `test/features/insights/services/stats_view_model_service_test.dart`

- [ ] **Step 1: Run focused tests**

Run: `flutter test test/features/insights/services/stats_filter_service_test.dart test/features/insights/services/stats_story_service_test.dart test/features/insights/services/stats_view_model_service_test.dart`
Expected: PASS

- [ ] **Step 2: Run focused analyze**

Run: `flutter analyze --no-pub lib/features/insights/services/stats_tag_summary_service.dart lib/features/insights/widgets/stats_tag_intelligence_section.dart lib/features/insights/widgets/stats_tag_card.dart test/features/insights/services/stats_view_model_service_test.dart`
Expected: `No issues found!`
