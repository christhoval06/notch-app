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
  );
  final String generation, id, partnerLabel;
  final DateTime capturedAt;
  final int rating, orgasmCount;
  final bool protected;

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
    return WatchCommand._(
      generation,
      id.toLowerCase(),
      DateTime.fromMillisecondsSinceEpoch(timestamp),
      normalized,
      rating,
      count,
      protection,
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
  };
}
