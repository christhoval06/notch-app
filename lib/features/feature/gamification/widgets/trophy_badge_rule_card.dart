import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_panel.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgeRuleCard extends StatelessWidget {
  const TrophyBadgeRuleCard({super.key, required this.id, required this.l10n});

  final String id;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final content = _contentFor(id, l10n);
    if (content == null) return const SizedBox.shrink();

    return TrophyBadgePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 18,
                color: scheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                content.title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content.body,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  _RuleCardContent? _contentFor(String badgeId, AppLocalizations l10n) {
    switch (badgeId) {
      case 'single_partner_badge':
        return _RuleCardContent(
          title: l10n.trophyBadgeRuleTitleExclusive,
          body: l10n.trophyBadgeRuleBodyExclusive,
        );
      case 'multiple_partners_badge':
        return _RuleCardContent(
          title: l10n.trophyBadgeRuleTitleVariety,
          body: l10n.trophyBadgeRuleBodyVariety,
        );
      default:
        return null;
    }
  }
}

class _RuleCardContent {
  const _RuleCardContent({required this.title, required this.body});

  final String title;
  final String body;
}
