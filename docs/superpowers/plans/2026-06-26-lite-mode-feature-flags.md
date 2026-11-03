# Lite Mode Feature Flags Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add centralized feature flags that disable RevenueCat, enforce a lite monthly encounter limit of 5 records, and hide selected Trophy Room sections in lite mode.

**Architecture:** Introduce static app-level flags in `lib/core/constants`, enforce the lite cap through a small feature service used by the encounter creation flow, and gate Trophy Room and RevenueCat behavior with simple conditionals. Keep logic extracted into small files so touched Dart files stay under the project size limit.

**Tech Stack:** Flutter, Dart, Hive, flutter_test, AppLocalizations

---

### Task 1: Lite limit rule

**Files:**
- Create: `lib/core/constants/feature_flags.dart`
- Create: `lib/features/feature/encounters/services/lite_mode_service.dart`
- Create: `test/features/feature/encounters/services/lite_mode_service_test.dart`

- [ ] **Step 1: Write the failing test**
- [ ] **Step 2: Run test to verify it fails**
- [ ] **Step 3: Write minimal implementation**
- [ ] **Step 4: Run test to verify it passes**

### Task 2: Encounter save guard

**Files:**
- Modify: `lib/features/feature/encounters/presentation/pages/add_entry_page.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_es.arb`

- [ ] **Step 1: Add failing coverage or targeted verification point for the save guard where practical**
- [ ] **Step 2: Block the 6th monthly record before persistence and show localized SnackBar**
- [ ] **Step 3: Regenerate localizations if needed and verify behavior**

### Task 3: RevenueCat gating

**Files:**
- Modify: `lib/features/feature/premium/services/subscription_service.dart`

- [ ] **Step 1: Add early guards for disabled RevenueCat paths**
- [ ] **Step 2: Verify the service remains safe when flags disable SDK usage**

### Task 4: Trophy Room lite visibility

**Files:**
- Modify: `lib/features/feature/gamification/presentation/pages/trophy_room_page.dart`
- Create if needed: `lib/features/feature/gamification/widgets/*`

- [ ] **Step 1: Isolate gated sections if needed to respect file-size rules**
- [ ] **Step 2: Hide current streak, activity pace, and challenges in lite mode**
- [ ] **Step 3: Verify the page still renders remaining sections correctly**

### Task 5: Final verification

**Files:**
- Review touched files only

- [ ] **Step 1: Run focused tests for lite mode**
- [ ] **Step 2: Run any additional targeted Flutter tests that cover touched logic**
- [ ] **Step 3: Re-check file lengths and diffs for rule compliance**
