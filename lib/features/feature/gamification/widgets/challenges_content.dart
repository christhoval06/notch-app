import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_category_service.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_ui_preferences_service.dart';
import 'package:notch_app/features/feature/gamification/services/challenges_view_model_service.dart';
import 'package:notch_app/features/feature/gamification/widgets/challenge_category_section.dart';
import 'package:notch_app/features/feature/gamification/widgets/challenge_category_filter_bar.dart';
import 'package:notch_app/features/feature/gamification/widgets/gamification_premium_intro.dart';
import 'package:notch_app/features/feature/gamification/widgets/gamification_premium_panel.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class ChallengesContent extends StatefulWidget {
  const ChallengesContent({
    super.key,
    required this.challenges,
    required this.encounters,
  });

  final List<Challenge> challenges;
  final List<Encounter> encounters;

  @override
  State<ChallengesContent> createState() => _ChallengesContentState();
}

class _ChallengesContentState extends State<ChallengesContent> {
  ChallengeCategory? _selectedCategory;
  final Set<ChallengeCategory> _collapsedCategories = <ChallengeCategory>{};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await ChallengeUiPreferencesService.load();
    if (!mounted) return;
    setState(() {
      _selectedCategory = preferences.selectedCategory;
      _collapsedCategories
        ..clear()
        ..addAll(preferences.collapsedCategories);
    });
  }

  Future<void> _savePreferences() {
    return ChallengeUiPreferencesService.save(
      selectedCategory: _selectedCategory,
      collapsedCategories: _collapsedCategories,
    );
  }

  void _toggleCategory(ChallengeCategory category) {
    setState(() {
      if (_collapsedCategories.contains(category)) {
        _collapsedCategories.remove(category);
      } else {
        _collapsedCategories.add(category);
      }
    });
    _savePreferences();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final sections = ChallengeCategoryService.buildSections(widget.challenges)
        .map(
          (section) => ChallengeCategorySectionModel(
            category: section.category,
            challenges: ChallengesViewModelService.sortChallenges(
              section.challenges,
              widget.encounters,
            ),
          ),
        )
        .toList();
    final visibleSections = _selectedCategory == null
        ? sections
        : sections
              .where((section) => section.category == _selectedCategory)
              .toList();
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.surface,
            scheme.surfaceContainerHigh,
            scheme.surfaceContainerLowest,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GamificationPremiumIntro(
                title: l10n.challengesTitle,
                subtitle: l10n.challengesSubtitle,
              ),
              const SizedBox(height: 14),
              GamificationPremiumPanel(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                child: ChallengeCategoryFilterBar(
                  selectedCategory: _selectedCategory,
                  onSelected: (category) {
                    setState(() => _selectedCategory = category);
                    _savePreferences();
                  },
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: visibleSections.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final section = visibleSections[index];
                    return ChallengeCategorySection(
                      section: section,
                      encounters: widget.encounters,
                      isExpanded: !_collapsedCategories.contains(
                        section.category,
                      ),
                      onToggle: () => _toggleCategory(section.category),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
