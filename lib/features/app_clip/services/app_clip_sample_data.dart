import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/core/constants/app_clip_config.dart';

class AppClipSampleData {
  AppClipSampleData({required DateTime month, required String partnerLabel})
    : encounters = List.unmodifiable([
        for (final (day, rating, protected) in AppClipConfig.samples)
          Encounter(
            id: 'sample-$day',
            date: DateTime(month.year, month.month, day),
            partnerName: partnerLabel,
            orgasmCount: 1,
            rating: rating,
            protected: protected,
          ),
      ]);

  final List<Encounter> encounters;

  List<Encounter> forDay(DateTime day) => encounters
      .where((entry) {
        return entry.date.year == day.year &&
            entry.date.month == day.month &&
            entry.date.day == day.day;
      })
      .toList(growable: false);

  double get averageRating =>
      encounters.fold(0, (sum, entry) => sum + entry.rating) /
      encounters.length;

  int get orgasmCount =>
      encounters.fold(0, (sum, entry) => sum + entry.orgasmCount);
}
