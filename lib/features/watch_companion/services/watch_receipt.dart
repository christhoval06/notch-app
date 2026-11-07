import 'package:notch_app/core/constants/watch_protocol.dart';

class WatchReceipt {
  const WatchReceipt({
    required this.generation,
    required this.id,
    required this.status,
    this.reason,
  });
  final String generation, id, status;
  final String? reason;
  factory WatchReceipt.fromMap(Map<String, Object?> map) => WatchReceipt(
    generation: map['generation'] as String,
    id: map['id'] as String,
    status: map['status'] as String,
    reason: map['reason'] as String?,
  );
  Map<String, Object?> toMap() => {
    'schemaVersion': WatchProtocol.version,
    'kind': 'receipt',
    'generation': generation,
    'id': id,
    'status': status,
    if (reason != null) 'reason': reason,
  };
}
