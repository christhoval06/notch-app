import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    // Configuración Android (usa el icono de la app)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración iOS
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Programar recordatorio en X meses
  Future<void> scheduleCheckupReminder({int months = 6}) async {
    // Calculamos la fecha futura
    final now = DateTime.now();
    // Convertimos la fecha a una Zona Horaria válida (TZDateTime)
    final scheduledDate = tz.TZDateTime.from(
      now.add(Duration(days: months * 30)),
      tz.local,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // ID
      'Mantenimiento Sugerido 🏥', // Título
      'Han pasado $months meses desde tu último chequeo. Es hora de cuidar tu salud.', // Cuerpo
      scheduledDate, // Fecha (tipo TZDateTime)

      const NotificationDetails(
        android: AndroidNotificationDetails(
          'health_channel',
          'Salud Sexual',
          channelDescription: 'Recordatorios de chequeos médicos',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),

      // ESTOS PARÁMETROS VAN AQUÍ, AFUERA DE NotificationDetails
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
