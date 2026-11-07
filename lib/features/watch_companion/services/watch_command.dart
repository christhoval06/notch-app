import 'package:notch_app/core/constants/encounter_options.dart';
import 'package:notch_app/core/constants/watch_protocol.dart';

class WatchCommand {
  WatchCommand._(
    this.generation,
    this.id,
    this.capturedAt,
    this.partnerLabel,
    this.rating,
    this.orgasmCount,
    this.protected,
    this.moodEmoji,
    this.tags,
  );
  final String generation, id, partnerLabel;
  final DateTime capturedAt;
  final int rating, orgasmCount;
  final bool protected;
  final String? moodEmoji;
  final List<String> tags;

  factory WatchCommand.fromMap(Map<String, Object?> map) {
    final generation = map['generation'];
    final id = map['id'];
    final timestamp = map['capturedAtMs'];
    final partner = map['partnerLabel'];
    final rating = map['rating'];
    final count = map['orgasmCount'];
    final protection = map['protected'];
    if (map['schemaVersion'] != WatchProtocol.version ||
        map['kind'] != 'entry' ||
        generation is! String ||
        generation.isEmpty ||
        generation.length > 64 ||
        id is! String ||
        !WatchProtocol.uuid.hasMatch(id) ||
        timestamp is! int ||
        timestamp < 0 ||
        timestamp > 8640000000000000 ||
        partner is! String ||
        rating is! int ||
        rating < 1 ||
        rating > 10 ||
        count is! int ||
        count < 0 ||
        count > 99 ||
        protection is! bool) {
      throw const FormatException('invalid_entry');
    }
    final normalized = partner.trim().replaceFirst(RegExp(r'^[@＠]'), '').trim();
    if (normalized.isEmpty ||
        normalized.length > WatchProtocol.maxPartnerLength) {
      throw const FormatException('invalid_partner');
    }
    final mood = map['moodEmoji'];
    final rawTags = map['tags'];
    if ((mood != null && (mood is! String || !moodEmojis.contains(mood))) ||
        (rawTags != null &&
            (rawTags is! List ||
                rawTags.any(
                  (tag) => tag is! String || !tagKeys.contains(tag),
                ) ||
                rawTags.toSet().length != rawTags.length))) {
      throw const FormatException('invalid_details');
    }
    final tags = List<String>.from(rawTags as List? ?? const [])..sort();
    return WatchCommand._(
      generation,
      id.toLowerCase(),
      DateTime.fromMillisecondsSinceEpoch(timestamp),
      normalized,
      rating,
      count,
      protection,
      mood as String?,
      List.unmodifiable(tags),
    );
  }

  String? validate(DateTime now) =>
      capturedAt.isAfter(now.add(const Duration(minutes: 5)))
      ? 'future_time'
      : null;

  Map<String, Object?> toMap() => {
    'schemaVersion': WatchProtocol.version,
    'kind': 'entry',
    'generation': generation,
    'id': id,
    'capturedAtMs': capturedAt.millisecondsSinceEpoch,
    'partnerLabel': partnerLabel,
    'rating': rating,
    'orgasmCount': orgasmCount,
    'protected': protected,
    if (moodEmoji != null) 'moodEmoji': moodEmoji,
    if (tags.isNotEmpty) 'tags': tags,
  };
}
