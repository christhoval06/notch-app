import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerPickerSheet extends StatefulWidget {
  final List<String> partnerNames;
  final Map<String, int> usageCounts;
  final String initialValue;

  const PartnerPickerSheet({
    super.key,
    required this.partnerNames,
    required this.usageCounts,
    required this.initialValue,
  });

  @override
  State<PartnerPickerSheet> createState() => _PartnerPickerSheetState();
}

class _PartnerPickerSheetState extends State<PartnerPickerSheet> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue.trim();
    _searchController = TextEditingController(
      text: initial.isEmpty ? '@' : '@$initial',
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _normalizedQuery {
    return _searchController.text.trim().replaceFirst(RegExp(r'^[@＠]'), '');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final query = _normalizedQuery.toLowerCase();
    final matches = widget.partnerNames.where((name) {
      if (query.isEmpty) return true;
      return name.toLowerCase().contains(query);
    }).toList()
      ..sort((a, b) {
        final aLower = a.toLowerCase();
        final bLower = b.toLowerCase();
        final aStarts = aLower.startsWith(query) ? 0 : 1;
        final bStarts = bLower.startsWith(query) ? 0 : 1;
        if (aStarts != bStarts) return aStarts.compareTo(bStarts);
        return aLower.compareTo(bLower);
      });
    final visibleMatches = matches.take(20).toList();

    return ProfessionalBottomSheet(
      title: l10n.addEntryPartnerSheetTitle,
      subtitle: l10n.addEntryPartnerHint,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: (_) => setState(() {}),
            style: TextStyle(color: scheme.onSurface),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email, color: scheme.primary),
              hintText: '@nombre',
              hintStyle: TextStyle(color: scheme.onSurfaceVariant),
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
                onPressed: () {
                  _searchController.text = '@';
                  _searchController.selection = const TextSelection.collapsed(
                    offset: 1,
                  );
                  setState(() {});
                },
              ),
              filled: true,
              fillColor: scheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final name in visibleMatches)
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.person, color: scheme.onSurfaceVariant),
                    title: Text('@$name'),
                    trailing: widget.usageCounts.containsKey(name)
                        ? Text(
                            '${widget.usageCounts[name]}',
                            style: TextStyle(color: scheme.onSurfaceVariant),
                          )
                        : null,
                    onTap: () => Navigator.pop(context, name),
                  ),
                if (matches.isEmpty && _normalizedQuery.isNotEmpty)
                  ListTile(
                    leading: Icon(Icons.add, color: scheme.primary),
                    title: Text(
                      l10n.addEntryPartnerCreateOption(_normalizedQuery),
                    ),
                    onTap: () => Navigator.pop(context, _normalizedQuery),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
