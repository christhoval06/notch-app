# Abstinence Achievements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert the existing abstinence badges into monthly milestones, keep `monk_mode` monthly, and add a new historical series for `45/60/90/120` days.

**Architecture:** Keep monthly and historical abstinence logic separate so the product semantics stay explicit and testable. Add a focused achievement abstinence rules service, wire `appStarted` achievements through that service, and update localization/UI mappings for the new historical badges without changing unrelated achievement flows.

**Tech Stack:** Flutter, Dart, Hive, `flutter_test`, generated l10n from ARB files

---

### Task 1: Add failing tests for monthly vs historical abstinence semantics

**Files:**
- Create: `test/features/gamification/services/achievement_abstinence_rules_test.dart`
- Modify: `test/features/gamification/services/achievement_rule_service_test.dart`

- [ ] **Step 1: Write the failing tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/achievement_abstinence_rules.dart';

void main() {
  group('AchievementAbstinenceRules', () {
    test('monthly milestones stay locked on fresh install', () {
      expect(
        AchievementAbstinenceRules.hasMonthlyMilestone(
          allEncounters: const [],
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 27),
          milestoneDays: 7,
        ),
        isFalse,
      );
    });

    test('monthly milestones unlock from current month abstinence window', () {
      final allEncounters = [
        _encounter('prior', DateTime(2026, 5, 20)),
      ];

      expect(
        AchievementAbstinenceRules.hasMonthlyMilestone(
          allEncounters: allEncounters,
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 15),
          milestoneDays: 14,
        ),
        isTrue,
      );
    });

    test('historical milestones use the best global abstinence record', () {
      final allEncounters = [
        _encounter('a', DateTime(2026, 1, 1)),
        _encounter('b', DateTime(2026, 2, 20)),
      ];

      expect(
        AchievementAbstinenceRules.hasHistoricalMilestone(
          allEncounters: allEncounters,
          now: DateTime(2026, 6, 27),
          milestoneDays: 45,
        ),
        isTrue,
      );
    });
  });
}

Encounter _encounter(String id, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: 5,
  );
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services/achievement_abstinence_rules_test.dart test/features/gamification/services/achievement_rule_service_test.dart`

Expected: FAIL with missing `achievement_abstinence_rules.dart` and/or wrong current abstinence behavior for monthly badges.

- [ ] **Step 3: Commit the red state tests if your workflow requires it**

```bash
git add test/features/gamification/services/achievement_abstinence_rules_test.dart test/features/gamification/services/achievement_rule_service_test.dart
git commit -m "test: cover monthly and historical abstinence semantics"
```

### Task 2: Implement focused abstinence achievement rules

**Files:**
- Create: `lib/features/gamification/services/achievement_abstinence_rules.dart`
- Modify: `lib/features/gamification/services/abstinence_service.dart`
- Test: `test/features/gamification/services/achievement_abstinence_rules_test.dart`

- [ ] **Step 1: Write the minimal rules service**

```dart
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/abstinence_service.dart';

class AchievementAbstinenceRules {
  const AchievementAbstinenceRules._();

  static bool hasMonthlyMilestone({
    required List<Encounter> allEncounters,
    required List<Encounter> monthlyEncounters,
    required DateTime now,
    required int milestoneDays,
  }) {
    final hasPriorHistory = allEncounters.any(
      (encounter) =>
          encounter.date.year != now.year || encounter.date.month != now.month,
    );
    if (!hasPriorHistory) return false;

    final days = AbstinenceService.currentMonthAbstinenceDays(
      monthlyEncounters: monthlyEncounters,
      now: now,
    );
    return days >= milestoneDays;
  }

  static bool hasHistoricalMilestone({
    required List<Encounter> allEncounters,
    required DateTime now,
    required int milestoneDays,
  }) {
    return AbstinenceService.longestAbstinenceDays(
          allEncounters,
          now: now,
        ) >=
        milestoneDays;
  }
}
```

- [ ] **Step 2: Add month-specific abstinence helper**

```dart
static int currentMonthAbstinenceDays({
  required List<Encounter> monthlyEncounters,
  required DateTime now,
}) {
  if (monthlyEncounters.isNotEmpty) return 0;
  return now.day;
}
```

- [ ] **Step 3: Run tests to verify they pass**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services/achievement_abstinence_rules_test.dart test/features/gamification/services/achievement_rule_service_test.dart`

Expected: PASS

- [ ] **Step 4: Commit the rules implementation**

```bash
git add lib/features/gamification/services/achievement_abstinence_rules.dart lib/features/gamification/services/abstinence_service.dart test/features/gamification/services/achievement_abstinence_rules_test.dart test/features/gamification/services/achievement_rule_service_test.dart
git commit -m "feat: separate monthly and historical abstinence rules"
```

### Task 3: Rewire app-started achievements to monthly and historical catalogs

**Files:**
- Modify: `lib/features/gamification/services/app_lifecycle_achievements.dart`
- Test: `test/features/gamification/services/achievement_catalog_test.dart`

- [ ] **Step 1: Replace the current abstinence app-started definitions**

```dart
Achievement(
  id: 'abstinence_bronze',
  name: 'Abstinencia Bronce',
  description: 'Reach 7 days of abstinence during the current month.',
  icon: '🥉',
  event: AchievementEvent.appStarted,
  condition: (data) => AchievementAbstinenceRules.hasMonthlyMilestone(
    allEncounters: data['allEncounters'] as List<Encounter>,
    monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
    now: data['now'] as DateTime,
    milestoneDays: 7,
  ),
),
```

```dart
Achievement(
  id: 'abstinence_master_45',
  name: 'Abstinencia 45',
  description: 'Reach 45 historical days of abstinence.',
  icon: '🧱',
  event: AchievementEvent.appStarted,
  condition: (data) => AchievementAbstinenceRules.hasHistoricalMilestone(
    allEncounters: data['allEncounters'] as List<Encounter>,
    now: data['now'] as DateTime,
    milestoneDays: 45,
  ),
),
```

- [ ] **Step 2: Add the remaining historical achievements for `60`, `90`, and `120`**

```dart
// Repeat the same pattern for:
// abstinence_master_60
// abstinence_master_90
// abstinence_master_120
```

- [ ] **Step 3: Keep `monk_mode` monthly and pass full context into the rule**

```dart
condition: (data) => AchievementRuleService.hasMonkMode(
  allEncounters: data['allEncounters'] as List<Encounter>,
  monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
  now: data['now'] as DateTime,
),
```

- [ ] **Step 4: Add catalog coverage for the new IDs**

```dart
expect(ids.contains('abstinence_master_45'), isTrue);
expect(ids.contains('abstinence_master_60'), isTrue);
expect(ids.contains('abstinence_master_90'), isTrue);
expect(ids.contains('abstinence_master_120'), isTrue);
```

- [ ] **Step 5: Run tests to verify the catalog stays valid**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services/achievement_catalog_test.dart`

Expected: PASS

- [ ] **Step 6: Commit the achievement catalog update**

```bash
git add lib/features/gamification/services/app_lifecycle_achievements.dart test/features/gamification/services/achievement_catalog_test.dart
git commit -m "feat: split monthly and historical abstinence achievements"
```

### Task 4: Update localization and achievement display mappings

**Files:**
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`
- Modify: `lib/core/utils/achievement_localization.dart`
- Modify: `lib/features/gamification/services/achievement_ui.dart`

- [ ] **Step 1: Update existing abstinence copy to monthly wording**

```json
"achievementAbstinenceBronzeDesc": "Reach 7 abstinence days during the current month.",
"achievementAbstinenceSilverDesc": "Reach 14 abstinence days during the current month.",
"achievementAbstinenceGoldDesc": "Reach 30 abstinence days during the current month."
```

```json
"achievementAbstinenceBronzeDesc": "Alcanza 7 dias de abstinencia durante el mes actual.",
"achievementAbstinenceSilverDesc": "Alcanza 14 dias de abstinencia durante el mes actual.",
"achievementAbstinenceGoldDesc": "Alcanza 30 dias de abstinencia durante el mes actual."
```

- [ ] **Step 2: Add new historical badge strings**

```json
"achievementAbstinenceMaster45Name": "Abstinence 45",
"achievementAbstinenceMaster45Desc": "Reach 45 historical abstinence days."
```

```json
"achievementAbstinenceMaster45Name": "Abstinencia 45",
"achievementAbstinenceMaster45Desc": "Alcanza 45 dias historicos de abstinencia."
```

- [ ] **Step 3: Map the new IDs in localization helpers**

```dart
case 'abstinence_master_45':
  return l10n.achievementAbstinenceMaster45Name;
```

- [ ] **Step 4: Add gradient mappings for the new historical series**

```dart
case 'abstinence_master_45':
case 'abstinence_master_60':
  return const LinearGradient(...);
```

- [ ] **Step 5: Regenerate l10n output**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter gen-l10n`

Expected: generated localization files update successfully

- [ ] **Step 6: Commit localization and UI mapping updates**

```bash
git add lib/l10n/app_en.arb lib/l10n/app_es.arb lib/l10n/app_localizations.dart lib/l10n/app_localizations_en.dart lib/l10n/app_localizations_es.dart lib/core/utils/achievement_localization.dart lib/features/gamification/services/achievement_ui.dart
git commit -m "feat: localize monthly and historical abstinence badges"
```

### Task 5: Run focused regression verification

**Files:**
- Verify: `test/features/gamification/services/achievement_abstinence_rules_test.dart`
- Verify: `test/features/gamification/services/achievement_rule_service_test.dart`
- Verify: `test/features/gamification/services/achievement_catalog_test.dart`

- [ ] **Step 1: Run abstinence rule tests**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services/achievement_abstinence_rules_test.dart`

Expected: PASS

- [ ] **Step 2: Run monk mode rule tests**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services/achievement_rule_service_test.dart`

Expected: PASS

- [ ] **Step 3: Run achievement catalog test**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services/achievement_catalog_test.dart`

Expected: PASS

- [ ] **Step 4: Run the combined focused suite**

Run: `/Users/alfamedic/.flutter/flutter/bin/flutter test test/features/gamification/services`

Expected: PASS with no abstinence/achievement regressions

- [ ] **Step 5: Commit the verified final state**

```bash
git add lib/features/gamification/services lib/core/utils/achievement_localization.dart lib/l10n test/features/gamification/services
git commit -m "feat: add monthly and historical abstinence achievements"
```
