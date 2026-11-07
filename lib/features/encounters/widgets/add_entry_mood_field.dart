import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/core/utils/translations.dart';

class AddEntryMoodField extends StatelessWidget {
  const AddEntryMoodField({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FormBuilderField<String>(
      name: 'moodEmoji',
      builder: (field) {
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: moodEmojis.length,
            itemBuilder: (context, index) {
              final emoji = moodEmojis[index];
              final isSelected = field.value == emoji;
              return GestureDetector(
                onTap: () => field.didChange(emoji),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? scheme.primary.withValues(alpha: 0.3)
                        : scheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: scheme.primary)
                        : null,
                  ),
                  child: Center(
                    child: Text(emoji, style: const TextStyle(fontSize: 28)),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
