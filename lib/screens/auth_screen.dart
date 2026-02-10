import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

import 'home_screen.dart';
import 'fake_home_screen.dart';
import 'package:notch_app/widgets/pin_pad.dart';
import '../utils/constants.dart';

import 'package:notch_app/models/encounter.dart';
import 'package:notch_app/models/partner.dart';
import 'package:notch_app/models/monthly_progress.dart';
import 'package:notch_app/models/health_log.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();

  String _enteredPin = "";
  bool _isAuthenticating = false;
  bool _canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    // Intentar biometría al iniciar (opcional, o dejar que el usuario toque el botón)
    // _authenticateBiometric();

    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    bool available = false;
    try {
      available = await auth.canCheckBiometrics;
    } catch (e) {
      print("Error checking biometrics: $e");
    }
    if (mounted) {
      setState(() {
        _canCheckBiometrics = available;
      });
    }
  }

  // 1. BIOMETRÍA (Siempre va a la app REAL)
  Future<void> _authenticateBiometric() async {
    bool authenticated = false;
    final l10n = AppLocalizations.of(context);
    try {
      authenticated = await auth.authenticate(
        localizedReason: l10n.authReason,
        biometricOnly: true,
      );
    } catch (e) {
      print("Error durante la autenticación biométrica: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authBiometricError(e.toString()))),
        );
      }
    }

    if (authenticated) {
      _navigateToRealApp();
    }
  }

  // 2. LÓGICA DE PIN (Decide a dónde ir)
  Future<void> _checkPin() async {
    final l10n = AppLocalizations.of(context);
    String? realPin = await _storage.read(key: 'real_pin');
    String? fakePin = await _storage.read(key: 'fake_pin');
    String? killPin = await _storage.read(key: 'kill_pin');

    // Usamos las constantes como valor por defecto
    if (realPin == null || realPin.isEmpty) realPin = DEFAULT_REAL_PIN;
    if (fakePin == null || fakePin.isEmpty) fakePin = DEFAULT_PANIC_PIN;

    // killPin no tiene valor por defecto por seguridad, debe configurarse explícitamente

    if (_enteredPin == realPin) {
      HapticFeedback.heavyImpact();
      _navigateToRealApp();
    } else if (_enteredPin == fakePin) {
      HapticFeedback.heavyImpact();
      _navigateToFakeApp();
    } else if (killPin != null &&
        killPin.isNotEmpty &&
        _enteredPin == killPin) {
      await _executeKillSwitch();
    } else {
      HapticFeedback.vibrate();
      // PIN Incorrecto: Vibrar o limpiar
      setState(() {
        _enteredPin = "";
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.authIncorrectCode)));
    }
  }

  void _navigateToRealApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  void _navigateToFakeApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => FakeHomeScreen()),
    );
  }

  Future<void> _executeKillSwitch() async {
    // 1. Feedback Físico Intenso (Doble impacto)
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 150));
    HapticFeedback.heavyImpact();

    try {
      await Hive.close();

      // 2. BORRAR LOS ARCHIVOS FÍSICOS
      final boxes = [
        'encounters',
        'partners',
        'monthly_progress',
        'health_logs',
      ];

      for (var boxName in boxes) {
        try {
          // Ahora sí podemos borrar sin miedo porque Hive ya cerró la conexión
          await Hive.deleteBoxFromDisk(boxName);
        } catch (e) {
          print("No se pudo borrar $boxName (quizás no existía): $e");
        }
      }

      // --- FASE 2: RECONSTRUCCIÓN (Para evitar Crash) ---
      // Reabrimos las cajas vacías para que el Home y otras pantallas funcionen
      await Hive.openBox<Encounter>('encounters');
      await Hive.openBox<Partner>('partners');
      await Hive.openBox<MonthlyProgress>('monthly_progress');
      await Hive.openBox<HealthLog>('health_logs');

      // --- FASE 3: BORRADO DE CREDENCIALES ---
      // Borramos PIN Real, PIN Falso y Kill PIN
      await _storage.deleteAll();
    } catch (e) {
      print("Error crítico en Kill Switch: $e");
    }

    // 4. Limpiar UI
    setState(() => _enteredPin = "");

    if (mounted) {
      // Mostrar mensaje de alerta roja
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppLocalizations.of(context).authKillSwitchExecuted,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Opcional: Navegar explícitamente al Home (que ahora estará vacío)
      // Esto fuerza un refresco visual total
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  // Teclado numérico
  void _onDigitPress(String digit) {
    HapticFeedback.lightImpact();
    if (_enteredPin.length < 4) {
      setState(() {
        _enteredPin += digit;
      });
      if (_enteredPin.length == 4) {
        // Verificar automáticamente al llegar a 4 dígitos
        Future.delayed(Duration(milliseconds: 200), _checkPin);
      }
    }
  }

  void _onDeletePress() {
    HapticFeedback.lightImpact();
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(Icons.lock_outline, size: 60, color: Colors.grey),
            SizedBox(height: 20),

            PinDots(length: _enteredPin.length, activeColor: Colors.blueAccent),

            Spacer(),

            Numpad(onDigitPress: _onDigitPress, onDeletePress: _onDeletePress),

            SizedBox(height: 20),
            // Botón Biometría
            if (_canCheckBiometrics)
              TextButton.icon(
                onPressed: _authenticateBiometric,
                icon: Icon(Icons.fingerprint, color: Colors.blueAccent),
                label: Text(
                  l10n.authBiometricButton,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
