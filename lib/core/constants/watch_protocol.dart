abstract final class WatchProtocol {
  static const version = 1;
  static const channel = 'dev.christhoval.apps.notch/watch_companion';
  static const queueLimit = 100;
  static const maxPartnerLength = 80;
  static final uuid = RegExp(r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$');
}
