import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_ui.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_history_card.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_info_header.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_rule_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgeInfoSheet extends StatefulWidget {
  const TrophyBadgeInfoSheet({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    required this.isSeasonal,
    required this.seasonMonthIds,
  });

  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isUnlocked;
  final bool isSeasonal;
  final List<String> seasonMonthIds;

  @override
  State<TrophyBadgeInfoSheet> createState() => _TrophyBadgeInfoSheetState();
}

class _TrophyBadgeInfoSheetState extends State<TrophyBadgeInfoSheet> {
  bool _showAllSeasons = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final localeCode = Localizations.localeOf(context).toString();
    final gradient = widget.id.achievementGradient;
    final showRuleCard =
        widget.id == 'single_partner_badge' ||
        widget.id == 'multiple_partners_badge';
    final currentMonthId = DateFormat('yyyy-MM').format(DateTime.now());
    final seasonLabels = widget.seasonMonthIds.map((monthId) {
      final date = DateFormat('yyyy-MM').parse(monthId);
      final formatted = DateFormat('MMMM yyyy', localeCode).format(date);
      return monthId == currentMonthId
          ? '$formatted (${l10n.trophyCurrentShort})'
          : formatted;
    }).toList();
    final visibleSeasons = _showAllSeasons
        ? seasonLabels
        : seasonLabels.take(6).toList();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),
                TrophyBadgeInfoHeader(
                  gradient: gradient,
                  icon: widget.icon,
                  name: widget.name,
                  description: widget.description,
                  isUnlocked: widget.isUnlocked,
                  isSeasonal: widget.isSeasonal,
                ),
                if (showRuleCard) ...[
                  const SizedBox(height: 18),
                  TrophyBadgeRuleCard(id: widget.id, l10n: l10n),
                ],
                const SizedBox(height: 18),
                TrophyBadgeHistoryCard(
                  l10n: l10n,
                  isUnlocked: widget.isUnlocked,
                  isSeasonal: widget.isSeasonal,
                  seasonLabels: seasonLabels,
                  visibleSeasons: visibleSeasons,
                  showAllSeasons: _showAllSeasons,
                  onToggle: () {
                    setState(() => _showAllSeasons = !_showAllSeasons);
                  },
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: scheme.primaryContainer,
                    foregroundColor: scheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
