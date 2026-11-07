import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';

class CalendarRatingBadge extends StatelessWidget {
  const CalendarRatingBadge({super.key, required this.encounter});

  final Encounter encounter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ratingColor = _ratingColor(scheme, encounter.rating);
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ratingColor.withValues(alpha: 0.2),
            border: Border.all(color: ratingColor, width: 2),
          ),
          child: Center(
            child: Text(
              '${encounter.rating}',
              style: TextStyle(
                color: ratingColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        if (encounter.moodEmoji != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.scrim,
              ),
              child: Text(
                encounter.moodEmoji!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }

  Color _ratingColor(ColorScheme scheme, int rating) {
    if (rating >= 9) return scheme.secondary;
    if (rating >= 7) return scheme.tertiary;
    if (rating >= 5) return scheme.primary;
    return scheme.error;
  }
}
