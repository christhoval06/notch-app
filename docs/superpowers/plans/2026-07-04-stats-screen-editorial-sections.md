# Stats Screen Editorial Sections Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the segmented `StatsScreen` flow with a premium editorial layout built around fixed overview, partner, tag, protection, and rhythm sections.

**Architecture:** Keep `StatsView` as the page shell and convert the screen to section-oriented summaries. Move partner, tag, protection, and rhythm calculations into focused services, expose them through a slimmer `StatsViewModel`, and render each major block from its own widget so `StatsContent` stays compositional and within file-size limits.

**Tech Stack:** Flutter, Dart, project l10n ARB files, existing `EncounterRepository`, existing stats widgets/services, `flutter_test`, `flutter analyze`.

---

### Task 1: Replace segmented state with editorial screen state

**Files:**
- Modify: `lib/features/insights/widgets/stats_view.dart`
- Modify: `lib/features/insights/widgets/stats_content.dart`
- Modify: `lib/features/insights/services/stats_models.dart`
- Modify: `lib/features/insights/services/stats_view_model_service.dart`
- Test: `test/features/insights/services/stats_view_model_service_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
test('buildFromData returns editorial section summaries', () {
  final model = StatsViewModelService.buildFromData(
    period: StatPeriod.sixMonths,
    encounters: [_encounter('1', DateTime(2026, 6, 20), tags: ['tag_travel'])],
    highestRank: const StatsRankData(rawLevelName: 'Iniciado III', totalXp: 320),
    now: DateTime(2026, 7, 4),
  );

  expect(model.topPartners, isNotEmpty);
  expect(model.tagInsights, isNotEmpty);
  expect(model.protectionSummary.protectionRate, greaterThanOrEqualTo(0));
  expect(model.rhythmSummary.topBucket, isNotEmpty);
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/insights/services/stats_view_model_service_test.dart`
Expected: FAIL because the editorial section fields do not exist yet.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsViewModel {
  const StatsViewModel({
    required this.heroMetrics,
    required this.comparisonState,
    required this.storyCards,
    required this.topPartners,
    required this.tagInsights,
    required this.protectionSummary,
    required this.rhythmSummary,
    required this.highestRank,
    required this.monthlyData,
    required this.heatmapData,
    required this.encounters,
  });
}

class _StatsViewState extends State<StatsView> {
  StatPeriod _selectedPeriod = StatPeriod.sixMonths;
}
```

- [ ] **Step 4: Remove segmented UI wiring**

```dart
body: StatsContent(
  viewModel: viewModel,
  selectedPeriod: _selectedPeriod,
  onPeriodChanged: (period) => setState(() => _selectedPeriod = period),
),
```

- [ ] **Step 5: Run tests to verify they pass**

Run: `flutter test test/features/insights/services/stats_view_model_service_test.dart`
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/features/insights/widgets/stats_view.dart \
  lib/features/insights/widgets/stats_content.dart \
  lib/features/insights/services/stats_models.dart \
  lib/features/insights/services/stats_view_model_service.dart \
  test/features/insights/services/stats_view_model_service_test.dart
git commit -m "refactor: remove stats segmentation state"
```

### Task 2: Add partner and tag editorial summaries

**Files:**
- Create: `lib/features/insights/services/stats_partner_summary_service.dart`
- Create: `lib/features/insights/services/stats_tag_summary_service.dart`
- Create: `lib/features/insights/widgets/stats_top_partners_section.dart`
- Create: `lib/features/insights/widgets/stats_tag_intelligence_section.dart`
- Modify: `lib/features/insights/services/stats_models.dart`
- Modify: `lib/features/insights/services/stats_view_model_service.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`
- Test: `test/features/insights/services/stats_view_model_service_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
expect(model.topPartners.length, lessThanOrEqualTo(3));
expect(model.topPartners.first.partnerName, 'Partner A');
expect(model.tagInsights.first.tagKey, 'tag_travel');
expect(model.tagInsights.first.topPartnerName, isNotEmpty);
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/insights/services/stats_view_model_service_test.dart`
Expected: FAIL because partner/tag summaries are not computed.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsPartnerSummaryService {
  static List<StatsPartnerSummary> build(List<Encounter> encounters) {
    return grouped.take(3).toList();
  }
}

class StatsTagSummaryService {
  static List<StatsTagInsight> build(List<Encounter> encounters) {
    return grouped.take(3).toList();
  }
}
```

- [ ] **Step 4: Render the two sections**

```dart
children: [
  StatsTopPartnersSection(partners: viewModel.topPartners),
  const SizedBox(height: 32),
  StatsTagIntelligenceSection(tags: viewModel.tagInsights),
]
```

- [ ] **Step 5: Add localized section copy**

```json
"statsTopPartnersTitle": "Top Partners",
"statsTagIntelligenceTitle": "Tag Intelligence",
"statsPartnerMostActive": "Most active",
"statsPartnerBestChemistry": "Best chemistry",
"statsPartnerMostRecent": "Most recent"
```

- [ ] **Step 6: Run tests and l10n generation**

Run: `flutter gen-l10n`
Expected: localization files regenerate without errors

Run: `flutter test test/features/insights/services/stats_view_model_service_test.dart`
Expected: PASS

- [ ] **Step 7: Commit**

```bash
git add lib/features/insights/services/stats_partner_summary_service.dart \
  lib/features/insights/services/stats_tag_summary_service.dart \
  lib/features/insights/widgets/stats_top_partners_section.dart \
  lib/features/insights/widgets/stats_tag_intelligence_section.dart \
  lib/features/insights/services/stats_models.dart \
  lib/features/insights/services/stats_view_model_service.dart \
  lib/l10n/app_en.arb lib/l10n/app_es.arb \
  test/features/insights/services/stats_view_model_service_test.dart
git commit -m "feat: add partner and tag editorial stats sections"
```

### Task 3: Add protection and rhythm summaries

**Files:**
- Create: `lib/features/insights/services/stats_protection_summary_service.dart`
- Create: `lib/features/insights/services/stats_rhythm_summary_service.dart`
- Create: `lib/features/insights/widgets/stats_protection_section.dart`
- Create: `lib/features/insights/widgets/stats_rhythm_section.dart`
- Modify: `lib/features/insights/services/stats_models.dart`
- Modify: `lib/features/insights/services/stats_view_model_service.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`
- Test: `test/features/insights/services/stats_filter_service_test.dart`
- Test: `test/features/insights/services/stats_view_model_service_test.dart`

- [ ] **Step 1: Write the failing tests**

```dart
expect(model.protectionSummary.protectionRate, closeTo(0.66, 0.01));
expect(model.protectionSummary.lastUnprotectedPartnerName, 'Partner B');
expect(model.rhythmSummary.topBucket, 'night');
expect(model.rhythmSummary.topWeekday, isNotEmpty);
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/features/insights/services/stats_filter_service_test.dart test/features/insights/services/stats_view_model_service_test.dart`
Expected: FAIL because protection/rhythm summaries are missing.

- [ ] **Step 3: Write minimal implementation**

```dart
class StatsProtectionSummaryService {
  static StatsProtectionSummary build(
    List<Encounter> current,
    List<Encounter> previous,
  ) {
    return StatsProtectionSummary(
      protectionRate: currentRate,
      lastUnprotectedPartnerName: last?.partnerName,
    );
  }
}

class StatsRhythmSummaryService {
  static StatsRhythmSummary build(List<Encounter> encounters) {
    return StatsRhythmSummary(
      topBucket: 'night',
      topWeekday: 'Friday',
    );
  }
}
```

- [ ] **Step 4: Render the sections**

```dart
children: [
  StatsProtectionSection(summary: viewModel.protectionSummary),
  const SizedBox(height: 32),
  StatsRhythmSection(summary: viewModel.rhythmSummary),
]
```

- [ ] **Step 5: Add localized labels**

```json
"statsProtectionTitle": "Protection",
"statsRhythmTitle": "Day & Time",
"statsProtectionProtected": "Protected",
"statsProtectionUnprotected": "Unprotected"
```

- [ ] **Step 6: Run tests and l10n generation**

Run: `flutter gen-l10n`
Expected: success

Run: `flutter test test/features/insights/services/stats_filter_service_test.dart test/features/insights/services/stats_view_model_service_test.dart`
Expected: PASS

- [ ] **Step 7: Commit**

```bash
git add lib/features/insights/services/stats_protection_summary_service.dart \
  lib/features/insights/services/stats_rhythm_summary_service.dart \
  lib/features/insights/widgets/stats_protection_section.dart \
  lib/features/insights/widgets/stats_rhythm_section.dart \
  lib/features/insights/services/stats_models.dart \
  lib/features/insights/services/stats_view_model_service.dart \
  lib/l10n/app_en.arb lib/l10n/app_es.arb \
  test/features/insights/services/stats_filter_service_test.dart \
  test/features/insights/services/stats_view_model_service_test.dart
git commit -m "feat: add protection and rhythm editorial sections"
```

### Task 4: Compose the final editorial layout and verify

**Files:**
- Modify: `lib/features/insights/widgets/stats_content.dart`
- Modify: `lib/features/insights/widgets/stats_story_cards.dart`
- Modify: `lib/features/insights/widgets/stats_hero_panel.dart`
- Modify: `lib/features/insights/widgets/stats_comparison_summary.dart`
- Test: `test/features/insights/services/stats_story_service_test.dart`

- [ ] **Step 1: Integrate the final section order**

```dart
children: [
  StatsPeriodToggle(...),
  StatsHeroPanel(metrics: viewModel.heroMetrics),
  StatsComparisonSummary(state: viewModel.comparisonState),
  StatsStoryCards(cards: viewModel.storyCards),
  StatsTopPartnersSection(partners: viewModel.topPartners),
  StatsTagIntelligenceSection(tags: viewModel.tagInsights),
  StatsProtectionSection(summary: viewModel.protectionSummary),
  StatsRhythmSection(summary: viewModel.rhythmSummary),
]
```

- [ ] **Step 2: Remove obsolete segmented widgets and wiring**

```dart
// Remove these from StatsContent:
// StatsSegmentBar
// StatsSegmentSelector
```

- [ ] **Step 3: Run focused verification**

Run: `flutter test test/features/insights/services/stats_filter_service_test.dart test/features/insights/services/stats_story_service_test.dart test/features/insights/services/stats_view_model_service_test.dart`
Expected: PASS

Run: `flutter analyze --no-pub lib/features/insights/services lib/features/insights/widgets test/features/insights/services`
Expected: `No issues found!`

- [ ] **Step 4: Commit**

```bash
git add lib/features/insights/widgets/stats_content.dart \
  lib/features/insights/widgets/stats_story_cards.dart \
  lib/features/insights/widgets/stats_hero_panel.dart \
  lib/features/insights/widgets/stats_comparison_summary.dart \
  test/features/insights/services/stats_story_service_test.dart
git commit -m "feat: deliver editorial stats screen layout"
```
