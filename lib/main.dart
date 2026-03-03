import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/screens/onboarding_screen.dart';
import 'package:notch_app/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/theme/app_theme.dart';

import 'package:notch_app/models/global_progress.dart';
import 'models/encounter.dart';
import 'models/partner.dart';
import 'models/monthly_progress.dart';
import 'models/health_log.dart';
import 'models/fake_task.dart';

import 'package:notch_app/widgets/app_lifecycle_observer.dart';
import 'package:notch_app/utils/locale_controller.dart';

import 'services/notification_service.dart';
import 'services/subscription_service.dart';
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

  final prefs = await SharedPreferences.getInstance();
  await AppLocaleController.instance.init(prefs);
  // Buscamos la bandera. Si no existe (es null), es la primera vez (true).
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (isFirstTime) {
    // Si es la primera vez, guardamos la bandera como 'false' para el futuro
    await prefs.setBool('isFirstTime', false);
  }

  if (FeatureFlags.enableMonetizationInitialization) {
    await SubscriptionService().init();
  }

  runApp(NotchApp(isFirstTime: isFirstTime));
}

class NotchApp extends StatelessWidget {
  final bool isFirstTime;

  const NotchApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocaleController.instance.localeNotifier,
      builder: (context, locale, _) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'NOTCH',
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.dark(),
        builder: (context, child) {
          return AppLifecycleObserver(child: child!);
        },
        home: isFirstTime ? OnboardingScreen() : AuthScreen(),
      ),
    );
  }
}
