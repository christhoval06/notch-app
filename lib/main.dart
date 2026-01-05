import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';

import 'models/encounter.dart';
import 'models/partner.dart';
import 'models/user_progress.dart';
import 'models/health_log.dart';

import 'services/notification_service.dart';
import 'screens/auth_screen.dart';

void main() async {
  // 1. Inicializar Flutter
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  // 2. Inicializar Hive (Base de Datos)
  await Hive.initFlutter();

  // 3. Registrar el Adaptador (Generado por build_runner)
  Hive.registerAdapter(EncounterAdapter());
  Hive.registerAdapter(PartnerAdapter());
  Hive.registerAdapter(UserProgressAdapter());
  Hive.registerAdapter(HealthLogAdapter());

  // 4. Abrir la caja de datos (Si no existe, la crea)
  await Hive.openBox<Encounter>('encounters');
  await Hive.openBox<Partner>('partners');
  await Hive.openBox<UserProgress>('user_progress');
  await Hive.openBox<HealthLog>('health_logs');

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
    return MaterialApp(
      title: 'NOTCH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema Oscuro General
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.blueAccent,
        // Usamos fuente Google Fonts "Lato" para estilo moderno
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white, displayColor: Colors.white),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.purpleAccent,
        ),
      ),
      // La primera pantalla es la de Seguridad (Biometría)
      home: AuthScreen(),
    );
  }
}
