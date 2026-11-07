import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_partner_detail_service.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/widgets/stats_partner_card.dart';
import 'package:notch_app/features/insights/widgets/stats_partner_detail_sheet.dart';
import 'package:notch_app/features/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsTopPartnersSection extends StatelessWidget {
  const StatsTopPartnersSection({
    super.key,
    required this.partners,
    required this.encounters,
  });

  final List<StatsPartnerSummary> partners;
  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    if (partners.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsTopPartnersTitle),
        const SizedBox(height: 16),
        ...partners.asMap().entries.map((entry) {
          final badgeLabel = _badgeLabel(l10n, entry.value.badge);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StatsPartnerCard(
              partner: entry.value,
              rank: entry.key + 1,
              badgeLabel: badgeLabel,
              onTap: () => showModalBottomSheet<void>(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.surface,
                builder: (_) => StatsPartnerDetailSheet(
                  summary: StatsPartnerDetailService.build(
                    partnerName: entry.value.partnerName,
                    encounters: encounters,
                  ),
                  badgeLabel: badgeLabel,
                  badge: entry.value.badge,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  String _badgeLabel(AppLocalizations l10n, StatsPartnerBadge? badge) {
    switch (badge) {
      case StatsPartnerBadge.mostActive:
        return l10n.statsPartnerMostActive;
      case StatsPartnerBadge.bestChemistry:
        return l10n.statsPartnerBestChemistry;
      case StatsPartnerBadge.mostRecent:
        return l10n.statsPartnerMostRecent;
      case null:
        return '';
    }
  }
}
