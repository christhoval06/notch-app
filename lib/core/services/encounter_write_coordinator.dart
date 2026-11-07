import 'dart:async';

abstract final class EncounterWriteCoordinator {
  static Future<void> _tail = Future.value();
  static Future<T> run<T>(Future<T> Function() operation) {
    final next = _tail.then((_) => operation());
    _tail = next.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return next;
  }
}
