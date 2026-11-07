import 'package:flutter/material.dart';

class PartnerQuickChoices extends StatelessWidget {
  const PartnerQuickChoices({
    super.key,
    required this.names,
    required this.onSelected,
  });

  final List<String> names;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final partner = names[index];
          return ActionChip(
            label: Text('@$partner'),
            onPressed: () => onSelected(partner),
          );
        },
      ),
    );
  }
}
