import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_category_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class ChallengeCategoryFilterBar extends StatelessWidget {
  const ChallengeCategoryFilterBar({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  final ChallengeCategory? selectedCategory;
  final ValueChanged<ChallengeCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _ChallengeFilterChip(
            label: l10n.challengeCategoryAll,
            icon: Icons.apps_rounded,
            isSelected: selectedCategory == null,
            onTap: () => onSelected(null),
          ),
          ...ChallengeCategory.values.map(
            (category) => _ChallengeFilterChip(
              label: ChallengeCategoryService.label(l10n, category),
              icon: ChallengeCategoryService.icon(category),
              isSelected: selectedCategory == category,
              onTap: () => onSelected(category),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}

class _ChallengeFilterChip extends StatelessWidget {
  const _ChallengeFilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        selected: isSelected,
        showCheckmark: false,
        avatar: Icon(
          icon,
          size: 18,
          color: isSelected ? scheme.onPrimary : scheme.primary,
        ),
        label: Text(label),
        onSelected: (_) => onTap(),
        selectedColor: scheme.primary,
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        labelStyle: TextStyle(
          color: isSelected ? scheme.onPrimary : scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: isSelected ? scheme.primary : scheme.outlineVariant,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}
