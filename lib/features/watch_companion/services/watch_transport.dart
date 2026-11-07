import 'package:flutter/services.dart';
import 'package:notch_app/core/constants/watch_protocol.dart';

class WatchTransport {
  static const _channel = MethodChannel(WatchProtocol.channel);
  void Function()? onInbox;
  WatchTransport() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'inboxChanged') onInbox?.call();
    });
  }
  Future<void> activate() => _channel.invokeMethod<void>('activate');
  Future<Map<String, Object?>> pairing() async => Map<String, Object?>.from(
    await _channel.invokeMapMethod<String, Object?>('readPairingState') ?? {},
  );
  Future<List<Map<String, Object?>>> inbox() async =>
      (await _channel.invokeListMethod<Object?>('readInbox') ?? [])
          .whereType<Map>()
          .map((m) => Map<String, Object?>.from(m))
          .toList();
  Future<void> complete(Map<String, Object?> receipt) =>
      _channel.invokeMethod<void>('completeInboxItem', receipt);
  Future<void> publish(Map<String, Object?> snapshot) =>
      _channel.invokeMethod<void>('publishSnapshot', snapshot);
  Future<void> rotate() => _channel.invokeMethod<void>('rotateGeneration');
}
