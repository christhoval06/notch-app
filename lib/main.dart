import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/models/global_progress.dart';

import 'models/encounter.dart';
import 'models/partner.dart';
import 'models/monthly_progress.dart';
import 'models/health_log.dart';
import 'models/fake_task.dart';

import 'package:notch_app/widgets/app_lifecycle_observer.dart';

import 'services/notification_service.dart';
import 'screens/auth_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // 1. Inicializar Flutter
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  // 2. Inicializar Hive (Base de Datos)
  await Hive.initFlutter();

  // 3. Registrar el Adaptador (Generado por build_runner)
  Hive.registerAdapter(GlobalProgressAdapter());
  Hive.registerAdapter(EncounterAdapter());
  Hive.registerAdapter(PartnerAdapter());
  Hive.registerAdapter(AvatarTypeAdapter());
  Hive.registerAdapter(MonthlyProgressAdapter());
  Hive.registerAdapter(HealthLogAdapter());
  Hive.registerAdapter(FakeTaskAdapter());

  // 4. Abrir la caja de datos (Si no existe, la crea)
  await Hive.openBox<Encounter>('encounters');
  await Hive.openBox<Partner>('partners');
  await Hive.openBox<MonthlyProgress>('monthly_progress');
  await Hive.openBox<HealthLog>('health_logs');
  await Hive.openBox<FakeTask>('fake_tasks');
  await Hive.openBox<GlobalProgress>('global_progress');

  // 5. Formato de fechas
  await initializeDateFormatting();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(NotchApp());
}

class NotchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.dark();

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'NOTCH',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: base.textTheme
            .apply(
              fontFamily: 'Lato',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            )
            .copyWith(
              headlineSmall: base.textTheme.headlineSmall?.copyWith(
                fontFamily: 'BebasNeue',
              ),
              headlineMedium: base.textTheme.headlineMedium?.copyWith(
                fontFamily: 'BebasNeue',
              ),
            ),

        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.blueAccent,
        colorScheme: base.colorScheme.copyWith(
          primary: Colors.blueAccent,
          secondary: Colors.purpleAccent,
          brightness: Brightness.dark,
        ),

        appBarTheme: base.appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
            fontFamily: 'BebasNeue', // Fuente especial para títulos de AppBar
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      builder: (context, child) {
        return AppLifecycleObserver(child: child!);
      },
      home: AuthScreen(),
    );
  }
}
