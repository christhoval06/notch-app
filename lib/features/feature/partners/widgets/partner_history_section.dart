import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/features/feature/partners/services/partner_history_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerHistorySection extends StatelessWidget {
  const PartnerHistorySection({super.key, required this.partnerName});

  final String partnerName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
      valueListenable: EncounterRepository.listenable(),
      builder: (context, _, _) {
        final history = PartnerHistoryService.getHistory(partnerName);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                l10n.partnerHistoryTitle,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (history.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    l10n.partnerNoEncounters,
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return PartnerHistoryTile(item: history[index]);
                },
              ),
          ],
        );
      },
    );
  }
}

class PartnerHistoryTile extends StatelessWidget {
  const PartnerHistoryTile({super.key, required this.item});

  final Encounter item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final ratingColor = _ratingColor(context, item.rating);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ratingColor, width: 2),
          color: ratingColor.withValues(alpha: 0.1),
        ),
        child: Text(
          '${item.rating}',
          style: TextStyle(color: ratingColor, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        DateFormat('EEEE, d MMMM y', locale).format(item.date),
        style: TextStyle(color: scheme.onSurface),
      ),
      subtitle: Row(
        children: [
          if (item.moodEmoji != null) Text('${item.moodEmoji!} '),
          Icon(Icons.bolt, size: 14, color: scheme.onSurfaceVariant),
          Text(
            ' ${item.orgasmCount}',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
      trailing: item.protected
          ? Icon(Icons.security, color: scheme.success, size: 18)
          : null,
    );
  }

  Color _ratingColor(BuildContext context, int rating) {
    final scheme = Theme.of(context).colorScheme;
    if (rating >= 9) return scheme.secondary;
    if (rating >= 7) return scheme.success;
    if (rating >= 5) return scheme.primary;
    return scheme.onSurfaceVariant;
  }
}
