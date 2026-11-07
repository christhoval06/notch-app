# Stats Activity Heatmap Motion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore the GitHub-style activity heatmap as a period-aware comparison module and add subtle motion polish to `StatsScreen`.

**Architecture:** Add a small activity composition section, make the heatmap period-aware via explicit date ranges, and use lightweight reveal/transition widgets so the screen gains motion without introducing controller-heavy animation code.

**Tech Stack:** Flutter, Dart, `flutter_heatmap_calendar`, `fl_chart`, project l10n, `flutter_test`, `flutter analyze`.

---

### Task 1: Reintroduce a period-aware activity section

**Files:**
- Create: `lib/features/insights/services/stats_period_range_service.dart`
- Create: `lib/features/insights/widgets/stats_activity_section.dart`
- Modify: `lib/features/insights/widgets/stats_heatmap_card.dart`
- Modify: `lib/features/insights/widgets/stats_monthly_activity_chart.dart`
- Modify: `lib/features/insights/widgets/stats_content.dart`

### Task 2: Add lightweight motion

**Files:**
- Create: `lib/features/insights/widgets/stats_reveal.dart`
- Modify: `lib/features/insights/widgets/stats_view.dart`
- Modify: `lib/features/insights/widgets/stats_content.dart`

### Task 3: Verify

**Files:**
- Test: `test/features/insights/services/stats_filter_service_test.dart`
- Test: `test/features/insights/services/stats_story_service_test.dart`
- Test: `test/features/insights/services/stats_view_model_service_test.dart`
