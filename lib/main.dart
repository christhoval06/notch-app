import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/core/configs/feature_flags.dart';
import 'package:notch_app/core/theme/app_theme.dart';
import 'package:notch_app/data/hive/hive_init.dart';
import 'package:notch_app/features/feature/onboarding/presentation/pages/onboarding_page.dart';
import 'package:notch_app/core/widgets/app_lifecycle_observer.dart';
import 'package:notch_app/core/utils/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/features/feature/health/services/notification_service.dart';
import 'package:notch_app/features/feature/premium/services/subscription_service.dart';
import 'package:notch_app/features/feature/auth/presentation/pages/auth_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // 1. Inicializar Flutter
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  // 2. Inicializar Hive (adapters + boxes centralizados en data/hive)
  await HiveInit.init();

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
