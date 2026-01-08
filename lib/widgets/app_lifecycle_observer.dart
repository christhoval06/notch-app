import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/auth_screen.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  const AppLifecycleObserver({Key? key, required this.child}) : super(key: key);

  @override
  _AppLifecycleObserverState createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    print("======== [GLOBAL] App Lifecycle State ========");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // --- AÑADE ESTE PRINT ---
    print("======== [GLOBAL] App Lifecycle State Changed: $state ========");

    if (state == AppLifecycleState.paused) {
      // --- AÑADE ESTE OTRO PRINT ---
      print("======== [GLOBAL] App Paused. Locking now... ========");

      // Comprobación de seguridad
      if (navigatorKey.currentState != null) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        print(
          "======== [ERROR] navigatorKey.currentState es nulo. No se puede navegar. ========",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
