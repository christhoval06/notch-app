import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/session/app_access_session.dart';

void main() {
  test('only a real foreground session authorizes imports', () {
    final session = AppAccessSession();
    expect(session.canImport, isFalse);
    session.unlockReal();
    expect(session.canImport, isTrue);
    session.lock();
    expect(session.canImport, isFalse);
    session.enterDecoy();
    expect(session.canImport, isFalse);
    session.unlockReal();
    expect(session.canImport, isTrue);
  });
}
