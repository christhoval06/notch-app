# Health Passport Premium Editorial Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Redesign Health Passport into a premium editorial health record with a strong summary hero, richer history cards, and a more polished add-log flow.

**Architecture:** Keep all persistence and submission behavior intact, and move new presentation-specific derivations into small health feature services. Build the redesign from small widgets so the screen, hero, history, and sheet can evolve independently while staying under the repository file-size limit.

**Tech Stack:** Flutter, Dart, Material 3 `ColorScheme`, project l10n ARB files, existing `HealthLogRepository`, `HealthLogsViewService`, and feature widgets/services under `lib/features/feature/health`

---

## File Structure

### Create

- `lib/features/feature/health/services/health_passport_summary_service.dart`
  - derives latest log, time-since-last-check copy inputs, and follow-up status from existing logs
- `lib/features/feature/health/widgets/health_passport_hero_card.dart`
  - premium editorial hero with status summary and add-record CTA
- `lib/features/feature/health/widgets/health_passport_summary_row.dart`
  - compact stat chips below the hero
- `lib/features/feature/health/widgets/health_passport_section_header.dart`
  - reusable section label for history
- `lib/features/feature/health/widgets/health_passport_result_chip.dart`
  - premium result chip used across hero/history/sheet
- `lib/features/feature/health/widgets/health_log_record_card.dart`
  - upgraded history card replacing current simple list tile
- `test/features/feature/health/services/health_passport_summary_service_test.dart`
  - tests for latest-log, empty-state, and follow-up summary derivation

### Modify

- `lib/features/feature/health/widgets/health_passport_view.dart`
  - replace raw scaffold/list layout with hero + summary + history composition
- `lib/features/feature/health/widgets/health_logs_list.dart`
  - switch to premium history list composition and empty-state integration
- `lib/features/feature/health/widgets/health_logs_empty_state.dart`
  - premium empty state aligned with the new visual system
- `lib/features/feature/health/widgets/health_logs_tile.dart`
  - either simplify into wrapper compatibility or replace usage with the new record card
- `lib/features/feature/health/widgets/health_add_log_sheet.dart`
  - premium bottom sheet styling and spacing polish
- `lib/features/feature/health/widgets/health_result_choice_row.dart`
  - ensure result selector matches the new premium segmented treatment
- `lib/l10n/app_en.arb`
- `lib/l10n/app_es.arb`
- generated l10n outputs after `flutter gen-l10n`

### Verify

- `flutter test test/features/feature/health/services/health_passport_summary_service_test.dart`
- `flutter analyze lib/features/feature/health/widgets lib/features/feature/health/services`

## Task 1: Add Summary Derivation Service

**Files:**
- Create: `lib/features/feature/health/services/health_passport_summary_service.dart`
- Test: `test/features/feature/health/services/health_passport_summary_service_test.dart`

- [ ] **Step 1: Write the failing tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/health/services/health_passport_summary_service.dart';

void main() {
  test('returns empty summary when there are no health logs', () {
    final summary = HealthPassportSummaryService.build(
      logs: const <HealthLog>[],
      now: DateTime(2026, 6, 30),
    );

    expect(summary.hasLogs, isFalse);
    expect(summary.latestLog, isNull);
    expect(summary.monthsSinceLatest, 0);
  });

  test('uses the most recent log and calculates elapsed months', () {
    final summary = HealthPassportSummaryService.build(
      logs: [
        HealthLog(
          date: DateTime(2026, 1, 10),
          testType: 'HIV',
          result: 'Negative',
        ),
        HealthLog(
          date: DateTime(2026, 5, 12),
          testType: 'STI Panel',
          result: 'Pending',
        ),
      ],
      now: DateTime(2026, 6, 30),
    );

    expect(summary.hasLogs, isTrue);
    expect(summary.latestLog?.testType, 'STI Panel');
    expect(summary.monthsSinceLatest, 1);
  });

  test('marks follow-up as overdue after six or more months', () {
    final summary = HealthPassportSummaryService.build(
      logs: [
        HealthLog(
          date: DateTime(2025, 12, 20),
          testType: 'General Check',
          result: 'Negative',
        ),
      ],
      now: DateTime(2026, 6, 30),
    );

    expect(summary.isFollowUpRecommended, isTrue);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/feature/health/services/health_passport_summary_service_test.dart`

Expected: FAIL with missing `HealthPassportSummaryService` or summary model symbols.

- [ ] **Step 3: Write minimal implementation**

```dart
import 'package:notch_app/data/models/health_log.dart';

class HealthPassportSummary {
  const HealthPassportSummary({
    required this.hasLogs,
    required this.latestLog,
    required this.monthsSinceLatest,
    required this.isFollowUpRecommended,
  });

  final bool hasLogs;
  final HealthLog? latestLog;
  final int monthsSinceLatest;
  final bool isFollowUpRecommended;
}

class HealthPassportSummaryService {
  const HealthPassportSummaryService._();

  static HealthPassportSummary build({
    required List<HealthLog> logs,
    required DateTime now,
  }) {
    if (logs.isEmpty) {
      return const HealthPassportSummary(
        hasLogs: false,
        latestLog: null,
        monthsSinceLatest: 0,
        isFollowUpRecommended: false,
      );
    }

    final sorted = [...logs]..sort((a, b) => b.date.compareTo(a.date));
    final latest = sorted.first;
    final months = (now.year - latest.date.year) * 12 + now.month - latest.date.month;

    return HealthPassportSummary(
      hasLogs: true,
      latestLog: latest,
      monthsSinceLatest: months < 0 ? 0 : months,
      isFollowUpRecommended: months >= 6,
    );
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/feature/health/services/health_passport_summary_service_test.dart`

Expected: PASS with 3 tests passed.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/feature/health/services/health_passport_summary_service.dart \
  test/features/feature/health/services/health_passport_summary_service_test.dart
git commit -m "feat: add health passport summary service"
```

## Task 2: Build Premium Health Passport Primitives

**Files:**
- Create: `lib/features/feature/health/widgets/health_passport_hero_card.dart`
- Create: `lib/features/feature/health/widgets/health_passport_summary_row.dart`
- Create: `lib/features/feature/health/widgets/health_passport_section_header.dart`
- Create: `lib/features/feature/health/widgets/health_passport_result_chip.dart`
- Modify: `lib/features/feature/health/services/health_log_result_style_service.dart`

- [ ] **Step 1: Write the failing widget/service expectations**

```dart
testWidgets('hero card shows CTA and latest summary content', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: HealthPassportHeroCard(
          title: 'Health Passport',
          subtitle: 'Personal record',
          primaryLabel: 'Log Test',
          latestDateLabel: '12 June 2026',
          followUpLabel: 'Follow-up on track',
          onPrimaryTap: () {},
          resultChild: const Text('Negative'),
        ),
      ),
    ),
  );

  expect(find.text('Health Passport'), findsOneWidget);
  expect(find.text('Log Test'), findsOneWidget);
  expect(find.text('12 June 2026'), findsOneWidget);
});
```

- [ ] **Step 2: Run targeted test shell to verify it fails**

Run: `flutter test test/features/feature/health/services/health_passport_summary_service_test.dart`

Expected: existing tests still pass, but new widget test file or symbols are still missing if added next.

- [ ] **Step 3: Implement the reusable UI primitives**

```dart
class HealthPassportResultChip extends StatelessWidget {
  const HealthPassportResultChip({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
```

```dart
class HealthPassportSectionHeader extends StatelessWidget {
  const HealthPassportSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
```

- [ ] **Step 4: Run analyze on the created primitives**

Run: `flutter analyze lib/features/feature/health/widgets lib/features/feature/health/services`

Expected: PASS with no analyzer issues in the new widget files.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/feature/health/widgets/health_passport_hero_card.dart \
  lib/features/feature/health/widgets/health_passport_summary_row.dart \
  lib/features/feature/health/widgets/health_passport_section_header.dart \
  lib/features/feature/health/widgets/health_passport_result_chip.dart \
  lib/features/feature/health/services/health_log_result_style_service.dart
git commit -m "feat: add health passport premium UI primitives"
```

## Task 3: Recompose the Main Health Passport Screen

**Files:**
- Modify: `lib/features/feature/health/widgets/health_passport_view.dart`
- Modify: `lib/features/feature/health/widgets/health_logs_list.dart`
- Use: `lib/features/feature/health/services/health_passport_summary_service.dart`
- Use: `lib/features/feature/health/widgets/health_passport_hero_card.dart`
- Use: `lib/features/feature/health/widgets/health_passport_summary_row.dart`
- Use: `lib/features/feature/health/widgets/health_passport_section_header.dart`

- [ ] **Step 1: Add a failing widget test for populated view composition**

```dart
testWidgets('health passport view shows hero and history section', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: HealthPassportView()));

  expect(find.text('Health Passport'), findsWidgets);
});
```

- [ ] **Step 2: Run analyze/test to confirm the composition still does not exist**

Run: `flutter analyze lib/features/feature/health/widgets/health_passport_view.dart`

Expected: current file passes analyze, but target UI structure is not yet implemented.

- [ ] **Step 3: Replace raw list composition with premium structure**

```dart
return ValueListenableBuilder(
  valueListenable: HealthLogRepository.listenable(),
  builder: (context, _, _) {
    final logs = HealthLogsViewService.getSortedLogs();
    final summary = HealthPassportSummaryService.build(
      logs: logs,
      now: DateTime.now(),
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HealthPassportHeroCard(...),
                const SizedBox(height: 16),
                HealthPassportSummaryRow(...),
                const SizedBox(height: 24),
                HealthPassportSectionHeader(...),
              ],
            ),
          ),
        ),
        HealthLogsList(logs: logs),
      ],
    );
  },
);
```

- [ ] **Step 4: Run analyze on recomposed files**

Run: `flutter analyze lib/features/feature/health/widgets/health_passport_view.dart lib/features/feature/health/widgets/health_logs_list.dart`

Expected: PASS with no issues.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/feature/health/widgets/health_passport_view.dart \
  lib/features/feature/health/widgets/health_logs_list.dart
git commit -m "feat: redesign health passport screen layout"
```

## Task 4: Upgrade History Cards and Empty State

**Files:**
- Create: `lib/features/feature/health/widgets/health_log_record_card.dart`
- Modify: `lib/features/feature/health/widgets/health_logs_empty_state.dart`
- Modify: `lib/features/feature/health/widgets/health_logs_tile.dart`
- Modify: `lib/features/feature/health/widgets/health_logs_list.dart`

- [ ] **Step 1: Write the failing history-card test**

```dart
testWidgets('record card renders test type, date, and result chip', (tester) async {
  final log = HealthLog(
    date: DateTime(2026, 6, 12),
    testType: 'STI Panel',
    result: 'Negative',
  );

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: HealthLogRecordCard(log: log, isLatest: true)),
    ),
  );

  expect(find.text('STI Panel'), findsOneWidget);
  expect(find.text('Negative'), findsOneWidget);
});
```

- [ ] **Step 2: Run test or analyze to verify the widget is missing**

Run: `flutter analyze lib/features/feature/health/widgets`

Expected: PASS before implementation, but `HealthLogRecordCard` is not yet present.

- [ ] **Step 3: Implement editorial history cards and premium empty state**

```dart
class HealthLogRecordCard extends StatelessWidget {
  const HealthLogRecordCard({
    super.key,
    required this.log,
    required this.isLatest,
  });

  final HealthLog log;
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    final localeCode = Localizations.localeOf(context).toString();
    final color = HealthLogResultStyleService.color(context, log.result);
    final icon = HealthLogResultStyleService.icon(context, log.result);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLatest) const Text('Most recent'),
          Text(log.testType),
          Text(DateFormat('d MMMM y', localeCode).format(log.date)),
          HealthPassportResultChip(label: log.result, color: color, icon: icon),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Run analyze on the history widgets**

Run: `flutter analyze lib/features/feature/health/widgets/health_log_record_card.dart lib/features/feature/health/widgets/health_logs_empty_state.dart lib/features/feature/health/widgets/health_logs_list.dart`

Expected: PASS with no issues.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/feature/health/widgets/health_log_record_card.dart \
  lib/features/feature/health/widgets/health_logs_empty_state.dart \
  lib/features/feature/health/widgets/health_logs_tile.dart \
  lib/features/feature/health/widgets/health_logs_list.dart
git commit -m "feat: upgrade health passport history cards"
```

## Task 5: Redesign the Add Log Bottom Sheet

**Files:**
- Modify: `lib/features/feature/health/widgets/health_add_log_sheet.dart`
- Modify: `lib/features/feature/health/widgets/health_result_choice_row.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`

- [ ] **Step 1: Add failing expectations for premium sheet labels if new copy is introduced**

```dart
testWidgets('add log sheet shows premium header and save CTA', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: Scaffold(body: HealthAddLogSheet())),
  );

  expect(find.text('New Health Record'), findsOneWidget);
});
```

- [ ] **Step 2: Run analyze before changing the sheet**

Run: `flutter analyze lib/features/feature/health/widgets/health_add_log_sheet.dart lib/features/feature/health/widgets/health_result_choice_row.dart`

Expected: PASS before redesign.

- [ ] **Step 3: Implement the premium sheet treatment**

```dart
return SafeArea(
  top: false,
  child: SingleChildScrollView(
    padding: EdgeInsets.only(
      left: 20,
      right: 20,
      top: 12,
      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _SheetHandle()),
        const SizedBox(height: 16),
        Text(l10n.healthNewRecord, ...),
        const SizedBox(height: 8),
        Text(l10n.healthPassportSheetSubtitle, ...),
        ...
      ],
    ),
  ),
);
```

- [ ] **Step 4: Regenerate l10n and re-run analyze**

Run: `flutter gen-l10n`

Expected: generated localization files updated successfully.

Run: `flutter analyze lib/features/feature/health/widgets lib/features/feature/health/services`

Expected: PASS with no issues.

- [ ] **Step 5: Commit**

```bash
git add \
  lib/features/feature/health/widgets/health_add_log_sheet.dart \
  lib/features/feature/health/widgets/health_result_choice_row.dart \
  lib/l10n/app_en.arb \
  lib/l10n/app_es.arb \
  lib/l10n/app_localizations.dart \
  lib/l10n/app_localizations_en.dart \
  lib/l10n/app_localizations_es.dart
git commit -m "feat: redesign health passport add log sheet"
```

## Task 6: Final Verification and Narrow-Width Hardening

**Files:**
- Verify all touched health files
- Optionally adjust `health_passport_hero_card.dart` and `health_passport_summary_row.dart` if width issues appear

- [ ] **Step 1: Run targeted health tests**

Run: `flutter test test/features/feature/health/services/health_passport_summary_service_test.dart`

Expected: PASS.

- [ ] **Step 2: Run feature analyze**

Run: `flutter analyze lib/features/feature/health/widgets lib/features/feature/health/services`

Expected: PASS with no issues.

- [ ] **Step 3: Perform small-screen manual check**

Run:

```bash
flutter run -d <device_id>
```

Manual expectations:
- hero stacks cleanly on narrow widths
- history cards do not overflow
- bottom sheet clears keyboard and content remains reachable
- empty state still looks premium and centered

- [ ] **Step 4: Fix any discovered small-screen issues and re-run analyze**

Run: `flutter analyze lib/features/feature/health/widgets lib/features/feature/health/services`

Expected: PASS after any responsive adjustments.

- [ ] **Step 5: Commit**

```bash
git add lib/features/feature/health/widgets lib/features/feature/health/services
git commit -m "fix: polish health passport responsive layout"
```

## Self-Review

### Spec Coverage

- hero summary: covered in Tasks 2 and 3
- summary metrics: covered in Tasks 2 and 3
- editorial history: covered in Task 4
- premium empty state: covered in Task 4
- add-log sheet polish: covered in Task 5
- no persistence/model changes: preserved by Tasks 1-6 scope
- small-screen safety: covered in Task 6

### Placeholder Scan

- no `TODO` or `TBD` placeholders remain
- each task includes exact files and commands
- all implementation tasks show concrete code shapes

### Type Consistency

- `HealthPassportSummaryService.build` is used consistently
- `HealthPassportSummary` is the shared derived model
- `HealthPassportResultChip` is the reusable semantic result surface
- `HealthLogRecordCard` is the target replacement for the current tile presentation

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-06-30-health-passport-premium-editorial.md`. Two execution options:

1. Subagent-Driven (recommended) - I dispatch a fresh subagent per task, review between tasks, fast iteration

2. Inline Execution - Execute tasks in this session using executing-plans, batch execution with checkpoints

Which approach?
