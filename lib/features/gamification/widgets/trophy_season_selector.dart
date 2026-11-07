import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophySeasonSelector extends StatelessWidget {
  const TrophySeasonSelector({
    super.key,
    required this.monthIds,
    required this.selectedMonthId,
    required this.onChanged,
  });

  final List<String> monthIds;
  final String? selectedMonthId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeCode = Localizations.localeOf(context).toString();
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMonthId,
          isExpanded: true,
          dropdownColor: scheme.surfaceContainerHighest,
          icon: Icon(Icons.arrow_drop_down, color: scheme.primary),
          style: TextStyle(color: scheme.onSurface, fontSize: 16),
          items: monthIds.map((id) {
            final date = DateFormat('yyyy-MM').parse(id);
            final formatted = DateFormat('MMMM yyyy', localeCode).format(date);
            final isCurrent =
                id == DateFormat('yyyy-MM').format(DateTime.now());
            return DropdownMenuItem(
              value: id,
              child: Text(
                '${l10n.trophySeasonLabel}: $formatted ${isCurrent ? '(${l10n.trophyCurrentShort})' : ''}',
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}
