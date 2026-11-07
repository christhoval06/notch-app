// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcome => 'Bienvenido a NOTCH';

  @override
  String get authReason => 'Por favor autentícate para acceder a tus registros';

  @override
  String get save => 'Guardar Notch';

  @override
  String get mood => 'Estado de Ánimo';

  @override
  String get partner => 'Pareja';

  @override
  String get tags => 'Etiquetas';

  @override
  String get orgasms => 'Orgasmos';

  @override
  String get usedProtection => 'Usé Protección';

  @override
  String get rating => 'Calificación';

  @override
  String get safe => 'Seguro';

  @override
  String get unsafe => 'Riesgo';

  @override
  String get tagMorning => 'Mañanero';

  @override
  String get tagQuickie => 'Rápido';

  @override
  String get tagOral => 'Oral';

  @override
  String get tagAnal => 'Anal';

  @override
  String get tagToys => 'Juguetes';

  @override
  String get tagDate => 'Cita';

  @override
  String get tagTravel => 'Viaje';

  @override
  String get tagKinky => 'Kinky';

  @override
  String get tagOutdoor => 'Aire Libre';

  @override
  String get tagAnniversary => 'Aniversario';

  @override
  String get tagOns => 'Aventura de una Noche';

  @override
  String get tagFwb => 'Amigos con Beneficios';

  @override
  String get tagReconciliation => 'Reconciliación';

  @override
  String get tagCelebration => 'Celebración';

  @override
  String get tagVanilla => 'Vainilla';

  @override
  String get tagDomsub => 'Dom/Sub';

  @override
  String get tagMassage => 'Masaje Erótico';

  @override
  String get tagCar => 'En el Coche';

  @override
  String get tagHotel => 'Hotel';

  @override
  String get tagShower => 'Ducha / Baño';

  @override
  String get insightsTitle => 'Inteligencia de Datos';

  @override
  String get insightsEmpty =>
      'Aún no hay suficientes datos para generar insights.\\n¡Sigue registrando!';

  @override
  String get insightsHeroEyebrow => 'LECTURA EDITORIAL';

  @override
  String get insightsHeroEmptyTitle =>
      'Tu capa de inteligencia está lista para aprender.';

  @override
  String get insightsHeroEmptyBody =>
      'Empieza a registrar encuentros o chequeos de salud y esta pantalla los convertirá en patrones guiados, alertas y señales premium.';

  @override
  String get insightsHeroHealthTitle =>
      'Las señales de salud merecen una mirada más atenta.';

  @override
  String get insightsHeroHealthBody =>
      'Tus datos recientes de salud sexual sugieren que este es un buen momento para bajar el ritmo, revisar hábitos de protección y mantener tus registros al día.';

  @override
  String get insightsHeroProtectionTitle =>
      'La protección está marcando una base sólida.';

  @override
  String insightsHeroProtectionBody(Object rate) {
    return '$rate% de tus encuentros fueron protegidos, lo que le da a este período un perfil más seguro y estable.';
  }

  @override
  String get insightsHeroRhythmTitle => 'Tu ritmo actual ya se puede leer.';

  @override
  String insightsHeroRhythmBody(Object rating) {
    return 'Tus encuentros recientes promedian $rating, lo que da suficiente señal para extraer patrones y alertas.';
  }

  @override
  String get insightsHeroChipStarting => 'Empezando';

  @override
  String get insightsHeroChipNoSignals => 'Sin señales aún';

  @override
  String insightsHeroProtectionChip(Object rate) {
    return '$rate% protegido';
  }

  @override
  String insightsHeroQualityChip(Object rating) {
    return 'Promedio $rating';
  }

  @override
  String insightsHeroEncountersChip(Object count) {
    return '$count encuentros registrados';
  }

  @override
  String insightsHeroHealthLogsChip(Object count) {
    return '$count registros de salud';
  }

  @override
  String get insightsBestPatternLabel => 'Mejor patrón';

  @override
  String insightsBestPatternPartnerHeadline(Object partner) {
    return '$partner es tu patrón más fuerte hasta ahora.';
  }

  @override
  String insightsBestPatternPartnerBody(Object rating) {
    return 'Esta conexión promedia $rating, convirtiéndose en tu señal de calidad más clara dentro de los datos actuales.';
  }

  @override
  String insightsBestPatternRhythmHeadline(Object day) {
    return '$day te está dando el mejor ritmo.';
  }

  @override
  String insightsBestPatternRhythmBody(Object tag) {
    return 'La etiqueta \"$tag\" aparece con más frecuencia y ayuda a definir el contexto más fuerte de tus registros.';
  }

  @override
  String insightsBestPatternPartnerDetail(Object partner) {
    return 'Dentro de tus registros actuales, esta pareja destaca como el patrón más positivo porque la calidad de la experiencia se mantiene por encima del resto del dataset. No es solo frecuencia: es calidad repetida.';
  }

  @override
  String get insightsBestPatternPartnerRecommendation =>
      'Usa este patrón como referencia: observa el contexto, el ritmo, el momento y la preparación emocional que suelen hacer que estos encuentros funcionen mejor.';

  @override
  String insightsBestPatternRhythmDetail(Object day) {
    return 'Tus datos actuales sugieren que este día crea un ritmo más favorable que el resto de la semana. Aunque la muestra siga creciendo, ya se comporta como una ventana más fuerte para mejores resultados.';
  }

  @override
  String get insightsBestPatternRhythmRecommendation =>
      'Si quieres mejorar consistencia, intenta repetir y proteger las condiciones que normalmente rodean este ritmo.';

  @override
  String get insightsWatchoutLabel => 'Atención';

  @override
  String get insightsWatchoutHealthHeadline =>
      'Los registros recientes de salud piden una lectura más cuidadosa.';

  @override
  String get insightsWatchoutHealthBody =>
      'Uno de tus últimos registros de salud está positivo o pendiente, así que este período debe leerse con más cautela de lo habitual.';

  @override
  String get insightsWatchoutHealthDetail =>
      'Esto no reemplaza guía médica, pero sí significa que tu contexto actual de salud sexual tiene una señal sin resolver. En términos de producto, es una de las razones más fuertes para pasar de una lectura de rendimiento a una lectura de cautela.';

  @override
  String get insightsWatchoutHealthRecommendation =>
      'Pausa patrones de riesgo, prioriza seguimiento y registra tu próxima actualización de salud para que esta pantalla refleje un estado más fresco.';

  @override
  String get insightsWatchoutProtectionHeadline =>
      'La protección está por debajo de tu base ideal.';

  @override
  String insightsWatchoutProtectionBody(Object rate) {
    return 'Solo $rate% de tus encuentros fueron protegidos, lo que aumenta la importancia de la cautela y el seguimiento.';
  }

  @override
  String get insightsWatchoutProtectionDetail =>
      'Tu comportamiento reciente de protección no es catastrófico, pero sí lo bastante débil como para merecer atención. Cuando la protección baja, el resto de la pantalla debe leerse con más cautela, aunque la calidad o el ritmo se vean bien.';

  @override
  String get insightsWatchoutProtectionRecommendation =>
      'Refuerza defaults más seguros en esos momentos donde la espontaneidad suele ganarle a la preparación.';

  @override
  String get insightsWatchoutQualityHeadline =>
      'La calidad muestra más fricción que fluidez.';

  @override
  String get insightsWatchoutQualityBody =>
      'Los promedios son lo bastante bajos como para sugerir que este período necesita más intención, recuperación o cambios de contexto.';

  @override
  String get insightsWatchoutQualityDetail =>
      'Los promedios bajos suelen indicar que el problema no es un solo encuentro sino una desalineación repetida de contexto, energía o conexión. Eso es útil porque apunta a un patrón que sí puedes trabajar.';

  @override
  String get insightsWatchoutQualityRecommendation =>
      'Intenta cambiar una variable por vez: timing, ritmo, contexto con la pareja o recuperación entre encuentros.';

  @override
  String get insightsWatchoutGapHeadline =>
      'La señal es limpia, pero espaciada.';

  @override
  String insightsWatchoutGapBody(Object days) {
    return 'Tu último encuentro fue hace $days días, así que los patrones actuales todavía pueden ser tempranos y poco estables.';
  }

  @override
  String get insightsWatchoutGapDetail =>
      'Los huecos largos no son malos por sí mismos, pero reducen la confianza de una lectura a corto plazo. La pantalla todavía puede interpretar tus datos, solo con menos certeza sobre qué es actual y qué es histórico.';

  @override
  String get insightsWatchoutGapRecommendation =>
      'Deja que los próximos registros reconstruyan momentum antes de tratar este ciclo como un patrón firme.';

  @override
  String get insightsHealthSnapshotLabel => 'Resumen de salud';

  @override
  String get insightsHealthSnapshotEmptyHeadline =>
      'Aún no hay registros de salud.';

  @override
  String get insightsHealthSnapshotEmptyBody =>
      'Agregar pruebas y síntomas hará esta pantalla mucho más útil, sobre todo para el radar de riesgo y la inteligencia a largo plazo.';

  @override
  String get insightsHealthSnapshotEmptyDetail =>
      'Ahora mismo la app puede leer ritmo, calidad y protección, pero todavía le falta la capa de salud que vuelve la inteligencia más sólida con el tiempo.';

  @override
  String get insightsHealthSnapshotEmptyRecommendation =>
      'Registra tu próxima prueba, resultado o síntoma relevante para que la capa de salud empiece a formar parte de tu lectura editorial.';

  @override
  String insightsHealthSnapshotHeadline(Object result, Object type) {
    return 'Última señal registrada: $result en $type.';
  }

  @override
  String insightsHealthSnapshotBody(Object months) {
    return 'Esa última actualización fue hace $months mes(es), lo que ayuda a definir qué tan fresco está tu contexto de salud.';
  }

  @override
  String insightsHealthSnapshotDetail(Object type) {
    return 'Este resumen ayuda a aterrizar el resto de la pantalla en algo más duradero que la variación encuentro por encuentro. Incluso un solo registro de salud mejora la interpretación a largo plazo.';
  }

  @override
  String get insightsHealthSnapshotRecommendation =>
      'Mantén esta capa actualizada con chequeos periódicos para que el resto de tu inteligencia siga siendo contextual y no aislada.';

  @override
  String get insightsRiskRadarTitle => 'Radar de riesgo';

  @override
  String get insightsSheetRecommendation => 'Recomendación';

  @override
  String get insightsRiskProtection => 'Protección';

  @override
  String get insightsRiskRecovery => 'Seguimiento';

  @override
  String get insightsRiskVariability => 'Variabilidad';

  @override
  String get insightsRiskLow => 'Bajo';

  @override
  String get insightsRiskGuarded => 'Cuidado';

  @override
  String get insightsRiskHigh => 'Alto';

  @override
  String get insightsDynamicFeedTitle => 'Más señales';

  @override
  String get insightsEmptyTitle => 'Tus insights premium aparecerán aquí.';

  @override
  String get insightsEmptyBody =>
      'Esta pantalla se vuelve más útil cuando registras algunos encuentros o chequeos de salud. Mientras más consistente sea la data, más precisa será la lectura editorial.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsTagline => 'Registro íntimo privado';

  @override
  String get settingsHealthPassportSubtitle =>
      'Registra chequeos de salud y programa recordatorios automáticos.';

  @override
  String get settingsGeneral => 'GENERAL';

  @override
  String get settingsAbout => 'ACERCA DE';

  @override
  String get settingsDangerZone => 'ZONA DE PELIGRO';

  @override
  String get settingsMaintenance => 'MANTENIMIENTO';

  @override
  String get settingsSecurityAccess => 'Seguridad y Accesos';

  @override
  String get settingsSecurityAccessSubtitle =>
      'Configurar PIN, Pánico y Kill Switch';

  @override
  String get settingsDataBackup => 'Datos y Respaldo';

  @override
  String get settingsDataBackupSubtitle => 'Copias de seguridad y Exportar PDF';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsAboutApp => 'Sobre la app';

  @override
  String get settingsAboutAppSubtitle =>
      'Para qué existe NOTCH y por qué se creó';

  @override
  String get settingsAboutAppTitle => 'Sobre NOTCH';

  @override
  String get settingsAboutAppDescription =>
      'NOTCH existe para ayudarte a registrar tu actividad íntima de forma privada, segura y consciente. Se creó porque los datos más sensibles no deberían vivir en servidores externos ni estar expuestos a trackers. La app te permite entender patrones, mejorar tu bienestar y mantener el control total de tu información.';

  @override
  String get settingsAboutAppPillarPrivacyTitle => 'Privacidad primero';

  @override
  String get settingsAboutAppPillarPrivacyBody =>
      'Tus datos se quedan contigo, sin servidores ni rastreadores.';

  @override
  String get settingsAboutAppPillarPurposeTitle => 'Propósito claro';

  @override
  String get settingsAboutAppPillarPurposeBody =>
      'Transformar tus registros en insights útiles para tu bienestar.';

  @override
  String get settingsAboutAppPillarControlTitle => 'Control total';

  @override
  String get settingsAboutAppPillarControlBody =>
      'Tú decides qué guardar, exportar o eliminar en cualquier momento.';

  @override
  String get settingsDeveloper => 'Desarrollador';

  @override
  String get settingsDeveloperSubtitle => 'Creado con privacidad en mente';

  @override
  String get settingsAboutDevTitle => 'Sobre el Dev';

  @override
  String get settingsAboutDevDescription =>
      'Hola, soy @christhoval, ingeniero fullstack y Tech Lead Front-End en Panamá. Trabajo con JavaScript y Python, y construyo herramientas CLI, paquetes npm y apps móviles. Me enfoco en producto, UX y privacidad por diseño. Creé NOTCH porque los datos íntimos deben quedarse en tus manos: sin servidores, sin trackers y con control total para ti.';

  @override
  String get settingsAboutDevRoleTitle => 'Rol actual';

  @override
  String get settingsAboutDevRoleBody =>
      'Ingeniero Fullstack y Tech Lead Front-End.';

  @override
  String get settingsAboutDevStackTitle => 'Stack principal';

  @override
  String get settingsAboutDevStackBody =>
      'JavaScript, TypeScript, Python, Flutter, CLI y npm.';

  @override
  String get settingsAboutDevFocusTitle => 'Enfoque';

  @override
  String get settingsAboutDevFocusBody =>
      'Producto, UX y privacidad por diseño.';

  @override
  String get settingsContactSupport => 'Contacto / Soporte';

  @override
  String get settingsContactSupportSubtitle => 'Reportar bugs o sugerir ideas';

  @override
  String get settingsResetApp => 'Restablecer App';

  @override
  String get settingsResetAppSubtitle => 'Borrar todos los datos y reiniciar';

  @override
  String get settingsRecalculateAchievements => 'Re-calcular Logros';

  @override
  String get settingsRecalculateAchievementsSubtitle =>
      'Actualiza tus medallas si crees que falta alguna.';

  @override
  String get settingsAchievementsUpdated =>
      'Logros actualizados correctamente.';

  @override
  String get settingsRecalculateXp => 'Re-calcular Experiencia (XP)';

  @override
  String get settingsRecalculateXpSubtitle =>
      'Sincroniza tu nivel con tu historial de encuentros.';

  @override
  String get settingsXpUpdated => 'Experiencia (XP) actualizada correctamente.';

  @override
  String get settingsMadeWithFlutter => 'Made with ❤️ & Flutter';

  @override
  String get settingsLanguageUpdated => 'Idioma actualizado';

  @override
  String settingsCouldNotOpen(Object url) {
    return 'No se pudo abrir $url';
  }

  @override
  String get settingsFactoryResetTitle => '¿Restablecer de Fábrica?';

  @override
  String get settingsFactoryResetMessage =>
      'Esta acción borrará TODOS tus registros, parejas, progreso y configuraciones de seguridad. No se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteAll => 'BORRAR TODO';

  @override
  String get onboardingSkip => 'Saltar';

  @override
  String get onboardingSlide1Title => 'Privacidad Absoluta. Cero Compromisos.';

  @override
  String get onboardingSlide1Description =>
      'Lo que pasa en NOTCH, se queda en NOTCH. Todos tus registros se guardan de forma encriptada solo en tu dispositivo. No usamos servidores. Tu vida íntima es solo tuya.';

  @override
  String get onboardingSlide2Title =>
      'Entiende tus Patrones. Mejora tu Bienestar.';

  @override
  String get onboardingSlide2Description =>
      'Registra tus encuentros para descubrir insights sobre tu frecuencia, satisfacción y hábitos. NOTCH es tu herramienta personal para entender mejor tu salud sexual.';

  @override
  String get onboardingSlide3Title => 'Mide tu Progreso. Celebra tus Hitos.';

  @override
  String get onboardingSlide3Description =>
      'Establece objetivos, monitorea tus rachas y sigue tu \'Camino de Maestría\'. La gamificación está diseñada para motivarte a ser más consciente y consistente con tu bienestar.';

  @override
  String get onboardingGoToApp => 'Entendido, ir a la App';

  @override
  String get onboardingPinsTitle => 'Tus Claves de Acceso';

  @override
  String get onboardingPinsDescription =>
      'Estos son tus PINs por defecto. ¡Memorízalos y cámbialos en Ajustes lo antes posible!';

  @override
  String get onboardingRealPin => 'PIN REAL';

  @override
  String get onboardingRealPinSubtitle => 'Para acceder a NOTCH.';

  @override
  String get onboardingPanicPin => 'PIN PÁNICO';

  @override
  String get onboardingPanicPinSubtitle => 'Para abrir la app falsa (tareas).';

  @override
  String get statsNoData => 'Sin datos';

  @override
  String get statsPeriod30Days => '30 Días';

  @override
  String get statsPeriod6Months => '6 Meses';

  @override
  String get statsPeriodTotal => 'Total';

  @override
  String get statsHighestRankReached => 'MAYOR RANGO ALCANZADO';

  @override
  String statsXpTotal(Object xp) {
    return '$xp XP en total';
  }

  @override
  String get pathTitle => 'Camino de Maestria';

  @override
  String pathUnlockedAtXp(Object xp) {
    return 'Desbloqueado a los $xp XP';
  }

  @override
  String get statsTotal => 'Total';

  @override
  String get statsAvgRating => 'Promedio';

  @override
  String get statsActivityDistribution => 'Distribución de Actividad';

  @override
  String get statsActivityLast6Months => 'Actividad (Últimos 6 Meses)';

  @override
  String get statsAnnualActivityMap => 'Mapa de Actividad Anual';

  @override
  String get statsActivityTrendTitle => 'Tendencia de Actividad';

  @override
  String get statsActivityMapTitle => 'Mapa de Actividad';

  @override
  String statsActivityMapSummary(Object count) {
    return '$count días activos en este período.';
  }

  @override
  String get statsActivityLegendLess => 'Menos';

  @override
  String get statsActivityLegendMore => 'Más';

  @override
  String get statsPremiumHeroEyebrow => 'INTELIGENCIA PREMIUM';

  @override
  String get statsPremiumHeroQualityTitle => 'La calidad va en modo premium';

  @override
  String get statsPremiumHeroProtectionTitle =>
      'La disciplina de protección lidera';

  @override
  String get statsPremiumHeroPartnerTitle =>
      'Este período tiene una pareja favorita';

  @override
  String get statsPremiumHeroConsistencyTitle =>
      'La consistencia se está volviendo hábito';

  @override
  String get statsPremiumHeroRhythmTitle =>
      'Tu ritmo ya tiene una franja dominante';

  @override
  String statsPremiumHeroQualityBody(Object rating) {
    return 'Tu promedio es $rating, así que la calidad es hoy tu señal más fuerte en este período.';
  }

  @override
  String statsPremiumHeroProtectionBody(Object rate) {
    return '$rate% de tus encuentros fueron protegidos, convirtiendo la seguridad en tu señal más sólida ahora mismo.';
  }

  @override
  String statsPremiumHeroPartnerBody(Object partner, Object share) {
    return '$partner representa el $share% de tus encuentros y marca el tono de este período.';
  }

  @override
  String statsPremiumHeroConsistencyBody(Object days, Object span) {
    return 'Te mantuviste activo en $days días distintos dentro de una ventana de $span días, convirtiendo repetición en momentum.';
  }

  @override
  String statsPremiumHeroRhythmBody(Object bucket, Object share) {
    return '$bucket lidera con el $share% de tus encuentros, dándole a este período una firma horaria clara.';
  }

  @override
  String statsPremiumSignalScore(Object score) {
    return '$score puntos de señal';
  }

  @override
  String get statsPremiumTrendUp => 'Sube vs período anterior';

  @override
  String get statsPremiumTrendDown => 'Baja vs período anterior';

  @override
  String get statsPremiumTrendStable => 'Estable vs período anterior';

  @override
  String get statsPremiumConsistencyTitle => 'Consistencia';

  @override
  String get statsPremiumQualityTitle => 'Momentum de calidad';

  @override
  String get statsPremiumPartnerTitle => 'Modo de parejas';

  @override
  String statsPremiumConsistencyHeadline(Object days, Object span) {
    return '$days días activos en $span días';
  }

  @override
  String statsPremiumQualityHeadline(Object rating) {
    return 'Promedio de $rating';
  }

  @override
  String statsPremiumPartnerHeadline(Object partners, Object share) {
    return '$partners pareja(s), $share% de concentración';
  }

  @override
  String statsPremiumPartnerSupporting(Object partner, Object trend) {
    return 'Pareja principal: $partner. $trend.';
  }

  @override
  String statsPremiumSignalSupporting(Object trend) {
    return '$trend.';
  }

  @override
  String get statsPremiumDeckTitle => 'Lectura premium';

  @override
  String get statsPremiumStoryQuality => 'Pulso de calidad';

  @override
  String get statsPremiumStoryProtection => 'Deriva de protección';

  @override
  String get statsPremiumStoryPartner => 'Foco de pareja';

  @override
  String get statsPremiumStoryConsistency => 'Pulso de consistencia';

  @override
  String get statsPremiumStoryRhythm => 'Dominio de ritmo';

  @override
  String statsPremiumStoryQualityHeadline(Object rating) {
    return 'La calidad promedia $rating';
  }

  @override
  String statsPremiumStoryProtectionHeadline(Object rate) {
    return 'La protección está en $rate%';
  }

  @override
  String statsPremiumStoryPartnerHeadline(Object partner) {
    return '$partner está definiendo este período';
  }

  @override
  String statsPremiumStoryConsistencyHeadline(Object days) {
    return '$days días activos están marcando tu cadencia';
  }

  @override
  String statsPremiumStoryRhythmHeadline(Object bucket) {
    return '$bucket es tu franja dominante';
  }

  @override
  String get statsPremiumStoryQualityBody =>
      'Las calificaciones altas ya aparecen como uno de los patrones más fuertes de tus datos recientes.';

  @override
  String get statsPremiumStoryProtectionBody =>
      'Tu tasa de seguridad ya se ve como una conducta sostenida, no solo como un resultado aislado.';

  @override
  String statsPremiumStoryPartnerBody(Object share) {
    return '$share% de tus encuentros se concentran alrededor de la misma pareja.';
  }

  @override
  String statsPremiumStoryConsistencyBody(Object span) {
    return 'Este ritmo cubre $span días y empieza a mostrar intención repetida en vez de registros aislados.';
  }

  @override
  String statsPremiumStoryRhythmBody(Object count) {
    return '$count encuentros ocurrieron dentro de esa ventana horaria.';
  }

  @override
  String get statsPremiumUnknownPartner => 'tu pareja principal';

  @override
  String statsActivitySelectedDay(Object count) {
    return '$count encuentros seleccionados';
  }

  @override
  String statsHeatmapSelection(Object date, Object count) {
    return '$date • $count encuentros';
  }

  @override
  String statsHeatmapSelectionCount(Object count) {
    return '$count encuentros';
  }

  @override
  String statsHeatmapDayInsight(Object count) {
    return 'Registraste $count encuentros en este dia dentro del periodo seleccionado.';
  }

  @override
  String get statsHeatmapTopPartnerLabel => 'Pareja principal';

  @override
  String get statsHeatmapTagsLabel => 'Etiquetas usadas';

  @override
  String get statsHeatmapNoTags => 'Sin etiquetas registradas';

  @override
  String get statsHeatmapProtectionSafe => 'Todo protegido';

  @override
  String get statsHeatmapProtectionMixed => 'Proteccion mixta';

  @override
  String get statsHeatmapProtectionNone => 'Sin proteccion';

  @override
  String statsHeatmapSnackBar(Object date, Object count) {
    return '$date: $count encuentros';
  }

  @override
  String get statsBusiestStreakTitle => 'Racha más activa';

  @override
  String get statsWeeklySnapshotTitle => 'Resumen semanal';

  @override
  String get statsActiveDaysLabel => 'Días activos';

  @override
  String get statsCurrentWeekLabel => 'Últimos 7 días';

  @override
  String get statsPreviousWeekLabel => '7 días anteriores';

  @override
  String statsDaysUnit(Object count) {
    return '$count días';
  }

  @override
  String get statsQualityBreakdown => 'Desglose de Calidad';

  @override
  String get statsLegendary => 'Legendario (9-10)';

  @override
  String get statsGood => 'Bueno (7-8)';

  @override
  String get statsAverage => 'Regular (5-6)';

  @override
  String get statsBad => 'Malo (1-4)';

  @override
  String get statsNoTagData => 'Sin datos de etiquetas';

  @override
  String get statsNoDescription => 'Sin descripción.';

  @override
  String get statsSegmentAll => 'Todo';

  @override
  String get statsSegmentPartner => 'Partner';

  @override
  String get statsSegmentTags => 'Etiquetas';

  @override
  String get statsSegmentProtection => 'Protección';

  @override
  String get statsSegmentDayTime => 'Día/Hora';

  @override
  String get statsFilterAll => 'Todos';

  @override
  String get statsFilterProtected => 'Con protección';

  @override
  String get statsFilterUnprotected => 'Sin protección';

  @override
  String get statsFilterMorning => 'Mañana';

  @override
  String get statsFilterAfternoon => 'Tarde';

  @override
  String get statsFilterNight => 'Noche';

  @override
  String get statsTopPartnersTitle => 'Top Partners';

  @override
  String get statsTagIntelligenceTitle => 'Inteligencia de Etiquetas';

  @override
  String get statsTagDetailSubtitle =>
      'Como se comporta esta etiqueta en el periodo actual';

  @override
  String get statsTagRelatedPartnersLabel => 'Parejas asociadas';

  @override
  String get statsTagRecentEncountersLabel =>
      'Encuentros recientes con esta etiqueta';

  @override
  String statsTagInsightHighQuality(Object partner) {
    return 'Esta etiqueta suele rendir mejor con $partner.';
  }

  @override
  String statsTagInsightSafe(Object partner) {
    return 'Esta etiqueta se mantiene muy protegida y se asocia mas con $partner.';
  }

  @override
  String statsTagInsightFrequent(Object partner) {
    return 'Esta etiqueta aparece mas seguido con $partner y marca uso repetido.';
  }

  @override
  String get statsProtectionTitle => 'Protección';

  @override
  String get statsRhythmTitle => 'Día y Hora';

  @override
  String get statsEncountersLabel => 'Encuentros';

  @override
  String get statsLastSeenLabel => 'Última vez';

  @override
  String get statsMostFrequentPartnerLabel => 'Pareja frecuente';

  @override
  String get statsDominantMoodLabel => 'Mood dominante';

  @override
  String get statsNoMoodLabel => 'Sin mood registrado';

  @override
  String get statsPartnerMostActive => 'Más activa';

  @override
  String get statsPartnerBestChemistry => 'Mejor química';

  @override
  String get statsPartnerMostRecent => 'Más reciente';

  @override
  String get statsPartnerDetailMostActive =>
      'La conexion mas activa de este periodo';

  @override
  String get statsPartnerDetailBestChemistry =>
      'La quimica mas fuerte entre tus top partners';

  @override
  String get statsPartnerDetailMostRecent =>
      'La mas reciente dentro de este periodo';

  @override
  String get statsPartnerRecentEncountersLabel => 'Encuentros recientes';

  @override
  String statsPartnerInsightHighChemistry(Object partner) {
    return '$partner combina calificaciones altas con una quimica consistente.';
  }

  @override
  String statsPartnerInsightSafety(Object partner) {
    return 'La proteccion se mantuvo alta mientras $partner seguia activa.';
  }

  @override
  String statsPartnerInsightMomentum(Object partner) {
    return '$partner lidera este periodo con un ritmo constante y repetido.';
  }

  @override
  String get statsProtectionRateLabel => 'Promedio de protección';

  @override
  String get statsLastUnprotectedPartnerLabel => 'Última pareja sin protección';

  @override
  String get statsLastUnprotectedDateLabel => 'Última fecha sin protección';

  @override
  String get statsProtectionStable =>
      'La protección se mantuvo estable en este período.';

  @override
  String get statsProtectionImproving =>
      'La protección mejoró frente al período anterior.';

  @override
  String get statsProtectionCaution =>
      'La protección bajó frente al período anterior.';

  @override
  String get statsProtectionDetailSubtitle =>
      'Cómo se comportó la protección en el periodo actual';

  @override
  String get statsProtectionInsightBody =>
      'Esta vista resalta tu consistencia de seguridad, el contexto sin protección más repetido y los momentos recientes que vale la pena notar.';

  @override
  String get statsProtectionTopRiskPartnerLabel =>
      'Pareja más asociada sin protección';

  @override
  String get statsProtectionRecentEncountersLabel =>
      'Encuentros recientes sin protección';

  @override
  String get statsStrongestWindowLabel => 'Ventana más fuerte';

  @override
  String get statsStrongestDayLabel => 'Día más fuerte';

  @override
  String statsRhythmHeadline(Object day, Object bucket) {
    return '$day en la $bucket es tu ventana más fuerte.';
  }

  @override
  String get statsRhythmDetailSubtitle =>
      'Cómo se comportó tu horario en el periodo actual';

  @override
  String get statsRhythmWeeklyPulseLabel => 'Pulso semanal';

  @override
  String get statsRhythmRecentEncountersLabel =>
      'Encuentros recientes en este ritmo';

  @override
  String get statsComparisonBaseline => 'Estás construyendo tu línea base.';

  @override
  String get statsComparisonUp =>
      'Tu actividad subió frente al período anterior.';

  @override
  String get statsComparisonDown =>
      'Tu actividad bajó frente al período anterior.';

  @override
  String get statsComparisonStable =>
      'Tu ritmo se mantuvo estable frente al período anterior.';

  @override
  String get statsStoryBestContextTitle => 'Mejor contexto';

  @override
  String statsStoryBestContextSupporting(Object rating) {
    return 'Calificación promedio $rating';
  }

  @override
  String statsStoryBestContextDetails(Object context) {
    return 'Tus mejores calificaciones de este período se concentraron alrededor de $context. Es una gran fórmula para repetir cuando buscas una experiencia más confiable.';
  }

  @override
  String get statsStoryMomentumTitle => 'Momentum';

  @override
  String get statsStoryMomentumUpHeadline => 'La actividad va al alza';

  @override
  String get statsStoryMomentumDownHeadline => 'La actividad va a la baja';

  @override
  String statsStoryMomentumSupporting(Object count) {
    return 'Cambio de $count encuentros vs el período anterior';
  }

  @override
  String statsStoryMomentumUpDetails(Object count) {
    return 'Registraste $count encuentros más que en el período anterior. Normalmente eso apunta a una mejor consistencia en tu ritmo.';
  }

  @override
  String statsStoryMomentumDownDetails(Object count) {
    return 'Registraste $count encuentros menos que en el período anterior. Vale la pena revisar si fue algo puntual o una desaceleración real.';
  }

  @override
  String get statsStoryProtectionTrendTitle => 'Tendencia de protección';

  @override
  String get statsStoryProtectionTrendUpHeadline => 'La protección subió';

  @override
  String get statsStoryProtectionTrendDownHeadline => 'La protección bajó';

  @override
  String statsStoryProtectionTrendSupporting(Object current, Object previous) {
    return '$current% vs $previous%';
  }

  @override
  String statsStoryProtectionTrendUpDetails(Object current, Object previous) {
    return 'El uso de protección subió de $previous% a $current% en este período. Es un cambio importante hacia una mayor consistencia en seguridad.';
  }

  @override
  String statsStoryProtectionTrendDownDetails(Object current, Object previous) {
    return 'El uso de protección bajó de $previous% a $current% en este período. Es una señal que conviene vigilar.';
  }

  @override
  String get statsStoryPrimeTimeTitle => 'Prime time';

  @override
  String statsStoryPrimeTimeSupporting(Object rating) {
    return 'Calificación promedio $rating';
  }

  @override
  String statsStoryPrimeTimeDetails(Object slot) {
    return 'Tus mejores calificaciones recientes se concentran alrededor de $slot. Parece una de tus ventanas con mayor potencial.';
  }

  @override
  String get statsStoryPeakMonthTitle => 'Mes pico';

  @override
  String statsStoryPeakMonthSupporting(Object rating) {
    return 'Calificación promedio $rating';
  }

  @override
  String statsStoryPeakMonthDetails(Object month) {
    return '$month destaca como tu mes más fuerte en esta vista. Es una referencia útil del ritmo que podrías intentar repetir.';
  }

  @override
  String get statsStoryWeekdayMon => 'Lunes';

  @override
  String get statsStoryWeekdayTue => 'Martes';

  @override
  String get statsStoryWeekdayWed => 'Miércoles';

  @override
  String get statsStoryWeekdayThu => 'Jueves';

  @override
  String get statsStoryWeekdayFri => 'Viernes';

  @override
  String get statsStoryWeekdaySat => 'Sábado';

  @override
  String get statsStoryWeekdaySun => 'Domingo';

  @override
  String get statsStoryDayTimeMorning => 'mañana';

  @override
  String get statsStoryDayTimeAfternoon => 'tarde';

  @override
  String get statsStoryDayTimeNight => 'noche';

  @override
  String get calendarNoActivity => 'Sin actividad este día.';

  @override
  String get calendarConfirmDeleteTitle => 'Confirmar Borrado';

  @override
  String get calendarConfirmDeleteMessage =>
      'Esta acción también ajustará tu XP y progreso. ¿Estás seguro?';

  @override
  String get delete => 'Borrar';

  @override
  String authBiometricError(Object error) {
    return 'Error de biometría: $error';
  }

  @override
  String get authIncorrectCode => 'Código Incorrecto';

  @override
  String get liteMonthlyEncounterLimitReached =>
      'El modo lite permite hasta 5 registros por mes.';

  @override
  String get authKillSwitchExecuted =>
      '⚠️ PROTOCOLO EXECUTADO. DATOS ELIMINADOS.';

  @override
  String get authBiometricButton => 'Biometría / FaceID';

  @override
  String get insightAverageSatisfactionTitle => 'Satisfacción Promedio';

  @override
  String insightAverageSatisfactionDescription(Object avg) {
    return 'Tu calificación promedio de todos los encuentros es de $avg sobre 10.';
  }

  @override
  String get insightWeeklyFrequencyTitle => 'Frecuencia Semanal';

  @override
  String insightWeeklyFrequencyDescription(Object freq) {
    return 'En promedio, registras $freq encuentros por semana.';
  }

  @override
  String get insightBestChemistryTitle => 'Mejor Química';

  @override
  String insightBestChemistryDescription(Object partner, Object avg) {
    return 'Tus encuentros con \'$partner\' tienen la calificación promedio más alta ($avg/10).';
  }

  @override
  String get insightDatesMatterTitle => 'Las Citas Importan';

  @override
  String insightDatesMatterDescription(
    Object diff,
    Object trend,
    Object tagA,
    Object tagB,
  ) {
    return 'Tu calificación promedio es un $diff% $trend en encuentros con la etiqueta \'$tagA\' en comparación con \'$tagB\'.';
  }

  @override
  String get insightHigher => 'más alta';

  @override
  String get insightLower => 'más baja';

  @override
  String get insightRhythmChangeTitle => 'Cambio de Ritmo';

  @override
  String insightRhythmChangeDescription(Object direction, Object percent) {
    return 'Tu frecuencia de actividad ha $direction un $percent% este mes en comparación con el anterior.';
  }

  @override
  String get insightIncreased => 'aumentado';

  @override
  String get insightDecreased => 'disminuido';

  @override
  String get insightHealthCheckTitle => 'Chequeo de Salud Sugerido';

  @override
  String get insightHealthCheckDescription =>
      'Han pasado más de 6 meses desde tu último registro en el Health Passport. Considera programar uno.';

  @override
  String get insightInTheZoneTitle => '¡En la Zona!';

  @override
  String insightInTheZoneDescription(Object streak) {
    return 'Estás en una racha de $streak encuentros seguidos con calificación \'Buena\' o \'Legendaria\' (8+). ¡Sigue así!';
  }

  @override
  String get insightDayMonday => 'Lunes';

  @override
  String get insightDayTuesday => 'Martes';

  @override
  String get insightDayWednesday => 'Miércoles';

  @override
  String get insightDayThursday => 'Jueves';

  @override
  String get insightDayFriday => 'Viernes';

  @override
  String get insightDaySaturday => 'Sábado';

  @override
  String get insightDaySunday => 'Domingo';

  @override
  String get insightGoldenDayTitle => 'Tu Día Dorado';

  @override
  String insightGoldenDayDescription(Object day, Object avg) {
    return 'Tus encuentros de los $day suelen tener la calificación promedio más alta ($avg/10).';
  }

  @override
  String get insightProtectionStatsTitle => 'Estadística de Protección';

  @override
  String insightProtectionStatsDescription(Object percentage) {
    return 'Has usado protección en un $percentage% de tus encuentros registrados.';
  }

  @override
  String get insightDominantStyleTitle => 'Tu Estilo Predominante';

  @override
  String insightDominantStyleDescription(Object tag) {
    return 'Tu etiqueta más frecuente es \'$tag\'. Parece que es una parte importante de tu rutina.';
  }

  @override
  String get insightBestTagComboTitle => 'Mejor Combinación de Tags';

  @override
  String insightBestTagComboDescription(Object tags, Object avg) {
    return 'Cuando $tags aparecen juntos, tu calificación promedio sube a $avg/10.';
  }

  @override
  String get insightMostConsistentPartnerTitle => 'Pareja Más Consistente';

  @override
  String insightMostConsistentPartnerDescription(Object partner, Object avg) {
    return '$partner es tu conexión más consistente, con un promedio de $avg/10.';
  }

  @override
  String get insightMostUnpredictablePartnerTitle => 'Pareja Más Impredecible';

  @override
  String insightMostUnpredictablePartnerDescription(
    Object partner,
    Object spread,
  ) {
    return '$partner muestra los cambios más bruscos recientemente, con una variabilidad de $spread.';
  }

  @override
  String get insightBestRecentPartnerTrendTitle =>
      'Mejor Tendencia Reciente por Pareja';

  @override
  String insightBestRecentPartnerTrendDescription(Object partner, Object diff) {
    return '$partner viene en alza, mejorando alrededor de $diff puntos en tus encuentros más recientes.';
  }

  @override
  String get insightRecentChemistryTitle => 'Química Reciente';

  @override
  String insightRecentChemistryDescription(Object partner, Object avg) {
    return '$partner tiene tu mejor química reciente con un promedio de $avg/10.';
  }

  @override
  String get insightProtectionRecentlyDroppedTitle =>
      'Protección Reciente a la Baja';

  @override
  String insightProtectionRecentlyDroppedDescription(
    Object recent,
    Object previous,
  ) {
    return 'Tu uso reciente de protección bajó a $recent% comparado con $previous% en tus registros anteriores.';
  }

  @override
  String get insightLongActivityPauseTitle => 'Pausa Larga de Actividad';

  @override
  String insightLongActivityPauseDescription(Object days) {
    return 'Han pasado alrededor de $days días desde tu último encuentro registrado. Puede valer la pena revisar cómo te sientes con esa pausa.';
  }

  @override
  String get insightHealthCheckOverdueTitle => 'Chequeo de Salud Atrasado';

  @override
  String insightHealthCheckOverdueDescription(Object months) {
    return 'Tu último registro en Health Passport fue hace aproximadamente $months meses. Podría ser un buen momento para programar otro chequeo.';
  }

  @override
  String get insightStrongestRecentMonthTitle => 'Mes Más Fuerte Reciente';

  @override
  String insightStrongestRecentMonthDescription(
    Object month,
    Object count,
    Object avg,
  ) {
    return '$month destaca con $count encuentros y una calificación promedio de $avg/10.';
  }

  @override
  String get homeBlackBookTitle => 'Black Book';

  @override
  String get homeTrophyRoomTitle => 'Trophy Room';

  @override
  String get homeHealthPassportTitle => 'Health Passport';

  @override
  String get homeStatsTitle => 'Estadísticas';

  @override
  String get homeTab => 'Inicio';

  @override
  String get homePeopleTab => 'Persona';

  @override
  String get homeTrophiesTab => 'Trofeos';

  @override
  String get homeHealthTab => 'Salud';

  @override
  String get homeStatsTab => 'Stats';

  @override
  String get blackBookNoRecords => 'No hay registros aún';

  @override
  String blackBookSummary(Object count, Object date) {
    return '$count Encuentros • Último: $date';
  }

  @override
  String get fakeNewTask => 'Nueva Tarea';

  @override
  String get fakeTaskHint => 'Ej. Comprar leche';

  @override
  String get fakeAdd => 'Añadir';

  @override
  String get fakeMyTasks => 'Mis Tareas';

  @override
  String get fakeAllDone => 'Todo listo por hoy.\n¡Añade una nueva tarea!';

  @override
  String get fakeToday => 'Hoy';

  @override
  String get fakeYesterday => 'Ayer';

  @override
  String get fakeFilterAll => 'Todas';

  @override
  String get fakeFilterPending => 'Pendientes';

  @override
  String get fakeFilterCompleted => 'Completas';

  @override
  String fakeTaskDeleted(Object title) {
    return 'Tarea \"$title\" eliminada';
  }

  @override
  String get pinEnter4Digits => 'Ingresa 4 dígitos';

  @override
  String get securityUpdated => 'Seguridad Actualizada ✅';

  @override
  String get securityTitle => 'Seguridad';

  @override
  String get securityConfigureKeys => 'Configura tus llaves de acceso.';

  @override
  String get securityRealPinTitle => 'PIN Real';

  @override
  String get securityRealPinDesc => 'Tu acceso principal';

  @override
  String get securityPanicPinTitle => 'PIN Pánico';

  @override
  String get securityPanicPinDesc => 'Abre la lista de tareas falsa';

  @override
  String get securityKillSwitchTitle => 'KILL SWITCH';

  @override
  String get securityKillSwitchDesc => '⚠️ BORRA TODOS LOS DATOS';

  @override
  String get securitySaveConfig => 'Guardar Configuración';

  @override
  String securityConfigurePin(Object title) {
    return 'Configurar $title';
  }

  @override
  String get securityNotSet => 'Sin definir';

  @override
  String get dataTitle => 'Datos y Respaldos';

  @override
  String get dataBackupSection => 'COPIA DE SEGURIDAD (BACKUP)';

  @override
  String get dataCreateBackup => 'Crear Respaldo Encriptado';

  @override
  String get dataCreateBackupSubtitle =>
      'Genera un archivo .notch cifrado para guardar en Drive/iCloud.';

  @override
  String get dataBackupSuccess => 'Backup generado exitosamente';

  @override
  String get dataRestoreBackup => 'Restaurar Respaldo';

  @override
  String get dataRestoreBackupSubtitle =>
      'Importa un archivo .notch. ⚠️ Sobrescribirá los datos actuales.';

  @override
  String get dataRestoreSuccess => 'Datos restaurados correctamente';

  @override
  String get dataExportSection => 'EXPORTACIÓN';

  @override
  String get dataGeneratePdf => 'Generar Reporte PDF';

  @override
  String get dataGeneratePdfSubtitle =>
      'Crea un documento visual con tus estadísticas y registros.';

  @override
  String get dataPdfSuccess => 'PDF generado';

  @override
  String dataAchievementUnlocked(Object name) {
    return '¡Logro Desbloqueado: $name!';
  }

  @override
  String dataError(Object error) {
    return 'Error: $error';
  }

  @override
  String get healthResultNegative => 'Negativo';

  @override
  String get healthResultPositive => 'Positivo';

  @override
  String get healthResultPending => 'Pendiente';

  @override
  String get healthNewRecord => 'Nuevo Registro Médico';

  @override
  String get healthAddRecordSubtitle =>
      'Mantén tu historial personal de salud al día con registros claros y privados.';

  @override
  String get healthTestTypeLabel => 'Tipo de Prueba (Ej. Panel Completo)';

  @override
  String get healthResultLabel => 'Resultado:';

  @override
  String get healthSaveAndSchedule => 'Guardar & Programar';

  @override
  String get healthSavedReminder => 'Guardado. Te avisaremos en 6 meses.';

  @override
  String get healthRegisterTest => 'Registrar Prueba';

  @override
  String get healthTestHistoryTitle => 'Historial de pruebas';

  @override
  String get healthNoRecords => 'Sin registros médicos';

  @override
  String get healthNoRecordsSubtitle => 'La salud es sexy. ¡Hazte un chequeo!';

  @override
  String get addEntryPartnerHint =>
      'Escribe \'@\' para buscar o un nombre nuevo...';

  @override
  String get addEntryPartnerRequired => 'El nombre es requerido';

  @override
  String get addEntryPartnerSheetTitle => 'Seleccionar pareja';

  @override
  String addEntryPartnerCreateOption(Object name) {
    return 'Crear \"@$name\"';
  }

  @override
  String get sharePreviewTitle => 'Previsualización';

  @override
  String get sharePreviewSubtitle =>
      'Tu resumen premium de temporada esta listo para compartir.';

  @override
  String get sharePreviewAction => 'Compartir tarjeta';

  @override
  String get shareCardText =>
      '¡Nuevo rango desbloqueado en NOTCH! 🏆 #NOTCHapp';

  @override
  String get shareCurrentSeason => 'TEMPORADA ACTUAL';

  @override
  String get shareSeasonXp => 'XP de Temporada';

  @override
  String get shareMonthEncounters => 'Encuentros del Mes';

  @override
  String get shareErrorGeneratingImage =>
      'Error al generar la imagen para compartir';

  @override
  String get partnerChangeAvatar => 'Cambiar Avatar';

  @override
  String get partnerChooseFromGallery => 'Elegir de Galería';

  @override
  String get partnerChooseEmoji => 'Elegir un Emoji';

  @override
  String get partnerChooseEmojiTitle => 'Elige un Emoji';

  @override
  String get partnerNotesSaved => 'Notas guardadas';

  @override
  String get partnerEdit => 'Editar';

  @override
  String get partnerPrivateNotes => 'NOTAS PRIVADAS';

  @override
  String get partnerNotesHint => 'Gustos, disgustos, cumpleaños...';

  @override
  String get partnerNotesTapToAdd => 'Toca el lápiz para añadir notas.';

  @override
  String get partnerHistoryTitle => 'HISTORIAL DE ENCUENTROS';

  @override
  String get partnerNoEncounters => 'Sin encuentros registrados.';

  @override
  String get trophyMonthRecord => 'RÉCORD MES';

  @override
  String get trophyHistorical => 'HISTÓRICO';

  @override
  String get trophyAbstinenceRecordsTitle => 'Récords de abstinencia';

  @override
  String get trophyAbstinenceRecordsSubtitle => 'Tus mejores marcas alcanzadas';

  @override
  String get challengesTitle => 'Retos';

  @override
  String get challengesSubtitle =>
      'Completa estos objetivos para demostrar tu maestría y compromiso.';

  @override
  String get challengeSeasonal => 'Temporada';

  @override
  String get challengeHistorical => 'Histórico';

  @override
  String challengeXpReward(Object xp) {
    return '$xp XP';
  }

  @override
  String get challengeCategoryFoundation => 'Base';

  @override
  String get challengeCategoryAll => 'Todas';

  @override
  String get challengeCategorySocial => 'Social';

  @override
  String get challengeCategoryEvents => 'Eventos';

  @override
  String get challengeCategoryRelationships => 'Relaciones';

  @override
  String get challengeCategoryMood => 'Mood';

  @override
  String get challengeCategorySkill => 'Skill';

  @override
  String get challengeCategoryLegacy => 'Legado';

  @override
  String get challengeMorningMasterTitle => 'Maestro Mañanero';

  @override
  String get challengeMorningMasterDesc =>
      'Registra 5 encuentros con la etiqueta \'Mañanero\'.';

  @override
  String get challengeWeeklyExplorerTitle => 'Explorador Semanal';

  @override
  String get challengeWeeklyExplorerDesc =>
      'Usa 3 etiquetas diferentes en los últimos 7 días.';

  @override
  String get challengeQualityWeekTitle => 'Semana de Calidad';

  @override
  String get challengeQualityWeekDesc =>
      'Registra 8 encuentros en los últimos 7 días con un promedio de 8.0+.';

  @override
  String get challengeSafetyChampionTitle => 'Campeón de la Seguridad';

  @override
  String get challengeSafetyChampionDesc =>
      'Logra 100% de protección en tus últimos 5 encuentros.';

  @override
  String get challengePreludeMasterTitle => 'Maestro del Preludio';

  @override
  String get challengePreludeMasterDesc =>
      'Promedio de 9.0+ en 5 encuentros seguidos con la etiqueta \'Oral\'.';

  @override
  String get challengeSteelConsistencyTitle => 'Constancia de Acero';

  @override
  String get challengeSteelConsistencyDesc =>
      'Registra al menos 8 encuentros en la temporada actual.';

  @override
  String get challengeQualityClubTitle => 'El Club del 9+';

  @override
  String get challengeQualityClubDesc =>
      'Logra 5 encuentros este mes con calificación de 9 o 10.';

  @override
  String get challengeQualityStreak3Title => 'Racha de Calidad';

  @override
  String get challengeQualityStreak3Desc =>
      'Logra 3 encuentros seguidos con calificación de 8 o más en la temporada actual.';

  @override
  String get challengeQualityStreak5Title => 'Calidad Imparable';

  @override
  String get challengeQualityStreak5Desc =>
      'Logra 5 encuentros seguidos con calificación de 8 o más a lo largo de tu historial.';

  @override
  String get challengeBalancedWeekTitle => 'Semana Balanceada';

  @override
  String get challengeBalancedWeekDesc =>
      'Registra encuentros en 3 días distintos dentro de los últimos 7 días.';

  @override
  String get challengeTagCombo5Title => 'Combo de Etiquetas';

  @override
  String get challengeTagCombo5Desc =>
      'Usa 5 etiquetas distintas durante la temporada actual.';

  @override
  String get challengeSocialCircle3Title => 'Circulo Social';

  @override
  String get challengeSocialCircle3Desc =>
      'Registra encuentros con 3 parejas distintas esta temporada.';

  @override
  String get challengeQualityNetwork3Title => 'Red de Calidad';

  @override
  String get challengeQualityNetwork3Desc =>
      'Registra encuentros esta temporada con 3 parejas distintas, cada una con calificacion de 8 o mas.';

  @override
  String get challengeSafeNetwork3Title => 'Red Segura';

  @override
  String get challengeSafeNetwork3Desc =>
      'Registra encuentros protegidos esta temporada con 3 parejas distintas.';

  @override
  String get challengeWeekendRun2Title => 'Racha de Weekend';

  @override
  String get challengeWeekendRun2Desc =>
      'Registra encuentros en 2 fines de semana consecutivos durante esta temporada.';

  @override
  String get challengeSocialWeekend3Title => 'Fin de Semana Social';

  @override
  String get challengeSocialWeekend3Desc =>
      'Registra encuentros de fin de semana con 3 parejas distintas esta temporada.';

  @override
  String get challengeEventMix3Title => 'Mezcla de Eventos';

  @override
  String get challengeEventMix3Desc =>
      'Usa 3 etiquetas de eventos distintas esta temporada.';

  @override
  String get challengeGetawayDuo2Title => 'Duo de Escapada';

  @override
  String get challengeGetawayDuo2Desc =>
      'Registra 2 encuentros esta temporada con etiquetas de escapada.';

  @override
  String get challengeMoodSpectrum3Title => 'Espectro de Mood';

  @override
  String get challengeMoodSpectrum3Desc =>
      'Registra 3 moods distintos en esta temporada.';

  @override
  String get challengeHighSpirits3Title => 'Moods Intensos';

  @override
  String get challengeHighSpirits3Desc =>
      'Registra 3 encuentros esta temporada con mood definido y calificacion de 8 o mas.';

  @override
  String get challengeSkillMix3Title => 'Mezcla de Practicas';

  @override
  String get challengeSkillMix3Desc =>
      'Usa 3 etiquetas de practicas distintas esta temporada.';

  @override
  String get challengePleasureCrafter3Title => 'Arquitecto del Placer';

  @override
  String get challengePleasureCrafter3Desc =>
      'Registra 3 encuentros esta temporada con practicas y calificacion de 8 o mas.';

  @override
  String get challengeConnectionArc3Title => 'Arco de Conexion';

  @override
  String get challengeConnectionArc3Desc =>
      'Usa 3 etiquetas de dinamicas relacionales esta temporada.';

  @override
  String get challengeDateNight2Title => 'Noche de Cita';

  @override
  String get challengeDateNight2Desc =>
      'Registra 2 encuentros esta temporada con etiquetas romanticas.';

  @override
  String get challengeSinglePartnerSeasonTitle => 'Solo una Pareja';

  @override
  String get challengeSinglePartnerSeasonDesc =>
      'Registra 8 encuentros esta temporada con una sola pareja. Si aparece otra, el reto se rompe.';

  @override
  String get challengeLoyalMonthTitle => 'Mes Leal';

  @override
  String get challengeLoyalMonthDesc =>
      'Registra 12 encuentros esta temporada con una sola pareja. Si aparece otra, el reto se rompe.';

  @override
  String get challengeGuardianOfSafetyTitle => 'Guardián de la Seguridad';

  @override
  String get challengeGuardianOfSafetyDesc =>
      'Logra una racha de 15 encuentros seguidos usando protección.';

  @override
  String get challengePerfectWeekendTitle => 'Fin de Semana Perfecto';

  @override
  String get challengePerfectWeekendDesc =>
      'Registra encuentros el Viernes, Sábado y Domingo en un finde, todos con calificación 8+.';

  @override
  String get challengeEpicMorningTitle => 'Muy Buenos Días';

  @override
  String get challengeEpicMorningDesc =>
      'Acumula 50 encuentros con la etiqueta \'Mañanero\'.';

  @override
  String get challengeFrequentFlyerTitle => 'Viajero Frecuente';

  @override
  String get challengeFrequentFlyerDesc =>
      'Acumula 15 encuentros con la etiqueta \'Viaje\'.';

  @override
  String get challengeStarCollectorTitle => 'Coleccionista de Estrellas';

  @override
  String get challengeStarCollectorDesc =>
      'Logra 100 encuentros con calificación de 8 o más.';

  @override
  String get challengeCenturionTitle => 'El Centurión';

  @override
  String get challengeCenturionDesc =>
      'Registra tus primeros 100 encuentros en total.';

  @override
  String get challengeLegendaryGuardianTitle => 'Guardián Legendario';

  @override
  String get challengeLegendaryGuardianDesc =>
      'Mantén una tasa de protección del 95%+ sobre al menos 50 encuentros.';

  @override
  String get challengeSinglePartner100Title => 'Una Misma Historia';

  @override
  String get challengeSinglePartner100Desc =>
      'Acumula 100 encuentros con una sola pareja.';

  @override
  String get challengeSinglePartner500Title => 'Vínculo Legendario';

  @override
  String get challengeSinglePartner500Desc =>
      'Acumula 500 encuentros con una sola pareja.';

  @override
  String get challengeSteadyBond50Title => 'Lazo Seguro';

  @override
  String get challengeSteadyBond50Desc =>
      'Acumula 50 encuentros protegidos con una sola pareja a lo largo de tu historial.';

  @override
  String get challengeConstellation10Title => 'Constelación';

  @override
  String get challengeConstellation10Desc =>
      'Registra encuentros con 10 parejas distintas a lo largo de tu historial.';

  @override
  String get challengePolymathTitle => 'El Polímata';

  @override
  String get challengePolymathDesc =>
      'Usa cada una de las etiquetas disponibles al menos una vez.';

  @override
  String get challengeAbstinence21Title => 'Abstinencia 21 Días';

  @override
  String get challengeAbstinence21Desc =>
      'Mantén 21 días seguidos sin registrar encuentros.';

  @override
  String get challengeAbstinence30Title => 'Abstinencia 30 Días';

  @override
  String get challengeAbstinence30Desc =>
      'Mantén 30 días seguidos sin registrar encuentros.';

  @override
  String get levelInitiated1Name => 'Iniciado I';

  @override
  String get levelInitiated1Desc =>
      'El primer paso en el camino del autoconocimiento íntimo.';

  @override
  String get levelInitiated2Name => 'Iniciado II';

  @override
  String get levelInitiated2Desc =>
      'Comienzas a reconocer patrones y a entender tus ritmos.';

  @override
  String get levelInitiated3Name => 'Iniciado III';

  @override
  String get levelInitiated3Desc =>
      'La curiosidad se convierte en un hábito de registro consciente.';

  @override
  String get levelPractitioner1Name => 'Practicante I';

  @override
  String get levelPractitioner1Desc =>
      'La disciplina del registro revela sus primeros frutos.';

  @override
  String get levelPractitioner2Name => 'Practicante II';

  @override
  String get levelPractitioner2Desc =>
      'Desarrollas una mayor conciencia de tus deseos y límites.';

  @override
  String get levelPractitioner3Name => 'Practicante III';

  @override
  String get levelPractitioner3Desc =>
      'La consistencia demuestra un compromiso con tu bienestar sexual.';

  @override
  String get levelAdept1Name => 'Adepto I';

  @override
  String get levelAdept1Desc =>
      'Dominas las herramientas y comienzas a experimentar con confianza.';

  @override
  String get levelAdept2Name => 'Adepto II';

  @override
  String get levelAdept2Desc =>
      'Tu entendimiento de la dinámica íntima se profundiza.';

  @override
  String get levelAdept3Name => 'Adepto III';

  @override
  String get levelAdept3Desc =>
      'La calidad de tus experiencias se vuelve tan importante como la cantidad.';

  @override
  String get levelVirtuoso1Name => 'Virtuoso I';

  @override
  String get levelVirtuoso1Desc =>
      'Tus acciones son intencionadas y tus registros, detallados.';

  @override
  String get levelVirtuoso2Name => 'Virtuoso II';

  @override
  String get levelVirtuoso2Desc =>
      'Inspiras confianza y demuestras una gran habilidad comunicativa.';

  @override
  String get levelVirtuoso3Name => 'Virtuoso III';

  @override
  String get levelVirtuoso3Desc =>
      'La intimidad se convierte en una forma de arte que dominas.';

  @override
  String get levelKnower1Name => 'Conocedor I';

  @override
  String get levelKnower1Desc =>
      'Posees un conocimiento profundo de ti mismo y de tus parejas.';

  @override
  String get levelKnower2Name => 'Conocedor II';

  @override
  String get levelKnower2Desc =>
      'Tu experiencia te permite anticipar y crear momentos inolvidables.';

  @override
  String get levelKnower3Name => 'Conocedor III';

  @override
  String get levelKnower3Desc => 'Eres un referente de madurez y salud sexual.';

  @override
  String get levelMasterName => 'Maestro';

  @override
  String get levelMasterDesc =>
      'Has alcanzado la cima del autoconocimiento y la maestría íntima.';

  @override
  String get levelGrandMasterName => 'Gran Maestro';

  @override
  String get levelGrandMasterDesc =>
      'Tu viaje inspira a otros. Has trascendido el simple acto físico.';

  @override
  String get levelLegendName => 'Leyenda';

  @override
  String get levelLegendDesc =>
      'Tu legado está escrito en las estrellas de la intimidad.';

  @override
  String get trophyActiveChallenges => 'RETOS ACTIVOS';

  @override
  String get trophyExploreGoals => 'Explora nuevos objetivos';

  @override
  String get trophyExploreGoalsSubtitle =>
      'Toca para ver todos los retos disponibles y seguir mejorando.';

  @override
  String get trophyUnlockedBadges => 'INSIGNIAS DESBLOQUEADAS';

  @override
  String get trophyRoomSubtitle =>
      'Sigue tu rango, tus rachas y tus logros de temporada en un solo espacio premium.';

  @override
  String get trophySeasonLabel => 'Temporada';

  @override
  String get trophyCurrentShort => 'Actual';

  @override
  String get trophyCurrentLevel => 'NIVEL ACTUAL';

  @override
  String get trophyFinalRank => 'RANGO FINAL';

  @override
  String trophyNextLevelInXp(Object xp) {
    return 'Siguiente nivel en $xp XP';
  }

  @override
  String get trophyCurrentStreak => 'RACHA ACTUAL';

  @override
  String get trophyActivityRhythm => 'Ritmo de actividad';

  @override
  String get trophyNightOwl => 'Eres un ave nocturna';

  @override
  String get trophyDayExplorer => 'Eres más activo durante el día';

  @override
  String trophyRhythmDetail(Object percent) {
    return 'El $percent% de tus encuentros ocurren entre las 10 PM y las 2 AM.';
  }

  @override
  String trophyRhythmPeakWindowDetail(Object percent, Object range) {
    return 'El $percent% de tus encuentros ocurren entre $range.';
  }

  @override
  String get trophyRhythmVibeNight1 => 'Eres un animal nocturno';

  @override
  String get trophyRhythmVibeNight2 => 'Modo luna: activado';

  @override
  String get trophyRhythmVibeNight3 =>
      'Tu prime time empieza cuando cae el sol';

  @override
  String get trophyRhythmVibeDay1 => 'Te mueve la energia del dia';

  @override
  String get trophyRhythmVibeDay2 => 'Campeon de la luz solar';

  @override
  String get trophyRhythmVibeDay3 => 'MVP del turno diurno';

  @override
  String get trophyRhythmDominantLabel => 'Predominio';

  @override
  String get trophyRhythmDominantDay => 'Mas diurno';

  @override
  String get trophyRhythmDominantNight => 'Mas nocturno';

  @override
  String get trophyPeakHour => 'Hora pico';

  @override
  String get trophyWeeklyActivity => 'Actividad semanal';

  @override
  String get trophyWeeklyActivityNoData => 'Sin datos suficientes';

  @override
  String get badgeLocked => 'Bloqueado';

  @override
  String get achievementUnlockedTitle => '¡Logro Desbloqueado!';

  @override
  String get achievementRookieName => 'El Debut';

  @override
  String get achievementRookieDesc => 'Registra tu primer encuentro.';

  @override
  String get achievementLegendName => 'Legendario';

  @override
  String get achievementLegendDesc =>
      'Logra una calificación perfecta de 10/10.';

  @override
  String get achievementSprinterName => 'Sprinter';

  @override
  String get achievementSprinterDesc => '3 encuentros en menos de 24 horas.';

  @override
  String get achievementSafePlayerName => 'Jugador Seguro';

  @override
  String get achievementSafePlayerDesc => 'Racha de 10 encuentros protegidos.';

  @override
  String get achievementHatTrickName => 'Hat-Trick';

  @override
  String get achievementHatTrickDesc =>
      '3 orgasmos o más en un solo encuentro.';

  @override
  String get achievementMarathonerName => 'Maratonista';

  @override
  String get achievementMarathonerDesc =>
      '5 encuentros en un fin de semana (Vie-Dom) en un mes.';

  @override
  String get achievementRenaissanceName => 'Hombre Renacentista';

  @override
  String get achievementRenaissanceDesc =>
      'Actividad en cada día de la semana en un mes.';

  @override
  String get achievementFireStreakName => 'Racha de Fuego';

  @override
  String get achievementFireStreakDesc =>
      'Mantén una racha de 7 días seguidos.';

  @override
  String get achievementAbstinenceBronzeName => 'Abstinencia Bronce';

  @override
  String get achievementAbstinenceBronzeDesc =>
      'Alcanza 7 dias de abstinencia durante el mes actual.';

  @override
  String get achievementAbstinenceSilverName => 'Abstinencia Plata';

  @override
  String get achievementAbstinenceSilverDesc =>
      'Alcanza 14 dias de abstinencia durante el mes actual.';

  @override
  String get achievementAbstinenceGoldName => 'Abstinencia Oro';

  @override
  String get achievementAbstinenceGoldDesc =>
      'Alcanza 30 dias de abstinencia durante el mes actual.';

  @override
  String get achievementAbstinenceDiamondName => 'Abstinencia Diamante';

  @override
  String get achievementAbstinenceDiamondDesc =>
      'Alcanza 60 dias historicos de abstinencia.';

  @override
  String get achievementAbstinenceMaster45Name => 'Abstinencia 45';

  @override
  String get achievementAbstinenceMaster45Desc =>
      'Alcanza 45 dias historicos de abstinencia.';

  @override
  String get achievementAbstinenceMaster90Name => 'Abstinencia 90';

  @override
  String get achievementAbstinenceMaster90Desc =>
      'Alcanza 90 dias historicos de abstinencia.';

  @override
  String get achievementAbstinenceMaster120Name => 'Abstinencia 120';

  @override
  String get achievementAbstinenceMaster120Desc =>
      'Alcanza 120 dias historicos de abstinencia.';

  @override
  String get achievementMonkModeName => 'Modo Monje';

  @override
  String get achievementMonkModeDesc =>
      'Mantén 100% de abstinencia durante el mes actual.';

  @override
  String get achievementTopCriticName => 'Crítico Exigente';

  @override
  String get achievementTopCriticDesc =>
      '5 encuentros seguidos con calificación de 9+.';

  @override
  String get achievementGrandMasterName => 'Gran Maestro';

  @override
  String get achievementGrandMasterDesc =>
      'Alcanza el rango \"Gran Maestro\" en una temporada.';

  @override
  String get achievementExplorerName => 'Explorador';

  @override
  String get achievementExplorerDesc => 'Usa 5 etiquetas diferentes en un mes.';

  @override
  String get achievementGlobetrotterName => 'Trotamundos';

  @override
  String get achievementGlobetrotterDesc =>
      'Registra un encuentro con la etiqueta \"Viaje\".';

  @override
  String get achievementNightOwlName => 'Noctámbulo';

  @override
  String get achievementNightOwlDesc =>
      '10 encuentros registrados después de la medianoche.';

  @override
  String get achievementHealthChampionName => 'Campeón de la Salud';

  @override
  String get achievementHealthChampionDesc =>
      'Registra tu primer chequeo en el Health Passport.';

  @override
  String get achievementArchivistName => 'Archivista';

  @override
  String get achievementArchivistDesc => 'Realiza tu primer Backup de datos.';

  @override
  String get trophyDays => 'días';

  @override
  String get trophyRecordReached => 'Récord alcanzado';

  @override
  String get trophyBeatingRecord => 'Superando récord';

  @override
  String get trophyNoRecord => 'Sin récord';

  @override
  String trophyPercentOfHistorical(Object percent) {
    return '$percent% del histórico';
  }

  @override
  String get trophyNoStreakThisMonth => 'Sin racha este mes';

  @override
  String trophyNextMilestoneDays(Object days) {
    return 'Próximo hito: $days días';
  }

  @override
  String trophyDaysRemaining(Object days) {
    return '$days días faltantes';
  }

  @override
  String get trophyMilestoneReached => '¡Hito alcanzado!';

  @override
  String trophyBadgeUnlockedInSeasons(Object count) {
    return 'Desbloqueada en $count temporada(s)';
  }

  @override
  String get trophyBadgeNotUnlockedHistory =>
      'Aún no has desbloqueado esta medalla.';

  @override
  String get trophyBadgeOneTimeTitle => 'Logro de una sola vez';

  @override
  String get trophyBadgeOneTimeUnlocked => 'Ya has desbloqueado esta medalla.';

  @override
  String get trophyBadgeStatusUnlocked => 'Desbloqueada';

  @override
  String get trophyBadgeStatusLocked => 'Bloqueada';

  @override
  String get trophyBadgeModalFootnote =>
      'Cada medalla refleja tu progreso entre temporadas, hitos y consistencia personal.';

  @override
  String get trophyBadgeRuleTitleExclusive =>
      'Regla de temporada: una sola pareja';

  @override
  String get trophyBadgeRuleBodyExclusive =>
      'Desbloquea esta medalla al llegar a 8 encuentros en la temporada actual y mantenerlos todos con la misma pareja.';

  @override
  String get trophyBadgeRuleTitleVariety =>
      'Regla de temporada: varias parejas';

  @override
  String get trophyBadgeRuleBodyVariety =>
      'Desbloquea esta medalla cuando la temporada actual incluya encuentros con 3 parejas distintas.';

  @override
  String get trophyShowMore => 'Ver más';

  @override
  String get trophyShowLess => 'Ver menos';

  @override
  String get homeAbstinenceTitle => 'Abstinencia';

  @override
  String get homeAbstinenceSubtitle => 'Desde tu último encuentro';

  @override
  String get homeAbstinenceNoDataSubtitle =>
      'Aún no has registrado encuentros.';

  @override
  String get homeAbstinenceNoDataValue => 'Sin datos';

  @override
  String homeAbstinenceDuration(Object days, Object hours, Object minutes) {
    return '${days}d ${hours}h ${minutes}min';
  }

  @override
  String get landingBrand => 'NOTCH';

  @override
  String get landingFeatures => 'Funciones';

  @override
  String get landingPrivacy => 'Arquitectura de privacidad';

  @override
  String get landingHealth => 'Pasaporte de salud';

  @override
  String get landingPricing => 'Precio';

  @override
  String get landingFaq => 'Preguntas';

  @override
  String get landingGet => 'Obtener NOTCH · \$1.99';

  @override
  String get landingBadge =>
      'SIN SERVIDORES · TODO EN TU DISPOSITIVO · SIN SUSCRIPCIONES';

  @override
  String get landingHeroTitle => 'Privacidad absoluta.\nSin compromisos.';

  @override
  String get landingHeroBody =>
      'El registro discreto de intimidad y bienestar personal. Comprende tus patrones, celebra tu progreso y mantén tu vida íntima solo para ti.';

  @override
  String get landingDownload => 'Descargar para iOS';

  @override
  String get landingExplore => 'Explorar funciones';

  @override
  String get landingAndroid => 'Android · Próximamente';

  @override
  String get landingOffline => 'Funciona sin conexión';

  @override
  String get landingEncrypted => 'Copias cifradas';

  @override
  String get landingNoTrackers => 'Sin rastreadores externos';

  @override
  String get landingNoAccounts => 'Sin cuentas';

  @override
  String get landingNoSubscriptions => 'Sin suscripciones';

  @override
  String get landingFoundationsLabel => 'BASES SIN COMPROMISOS';

  @override
  String get landingFoundationsTitle => 'Diseñado para la máxima discreción.';

  @override
  String get landingFoundationsBody =>
      'Tu información más personal merece un espacio que tú controles. Privado por diseño, desde el primer toque.';

  @override
  String get landingSecurityTitle => 'Privacidad y PIN señuelo';

  @override
  String get landingSecurityBody =>
      'Protege tu diario con biometría y un PIN personal. Un PIN señuelo independiente abre una interfaz cotidiana discreta cuando lo necesitas.';

  @override
  String get landingSecurityLink => 'Discreción por diseño';

  @override
  String get landingInsightsTitle => 'Intimidad e información';

  @override
  String get landingInsightsBody =>
      'Registra satisfacción, estados de ánimo, parejas y hábitos. Descubre patrones con información visual calculada en tu dispositivo.';

  @override
  String get landingInsightsLink => 'Tus patrones, más claros';

  @override
  String get landingHealthTitle => 'Salud sexual y cuidado';

  @override
  String get landingHealthBody =>
      'Reúne controles de salud, registros de protección y recordatorios. Cuida tu bienestar de forma más consciente.';

  @override
  String get landingHealthLink => 'Cuidarte empieza por conocerte';

  @override
  String get landingModuleOne => 'MÓDULO 01';

  @override
  String get landingLoggerTitle => 'Un registro intuitivo de encuentros';

  @override
  String get landingLoggerBody =>
      'Guarda los momentos que importan, sin complicaciones. Añade un estado de ánimo, etiqueta tu experiencia y registra lo que sea relevante para ti.';

  @override
  String get landingLoggerPointOne =>
      'Etiquetas, estados de ánimo y notas personales';

  @override
  String get landingLoggerPointTwo =>
      'Una cronología clara y vista de calendario';

  @override
  String get landingModuleTwo => 'MÓDULO 02';

  @override
  String get landingStatsTitle => 'Información y mapas de actividad';

  @override
  String get landingStatsBody =>
      'Transforma tus registros privados en información útil. Visualiza tu ritmo, explora tendencias y comprende tus hábitos con el tiempo. Todo se calcula localmente.';

  @override
  String get landingStatsPointOne =>
      'Mapas de actividad y tendencias personales';

  @override
  String get landingStatsPointTwo =>
      'Información calculada 100% en tu dispositivo';

  @override
  String get landingModuleThree => 'MÓDULO 03';

  @override
  String get landingBookTitle => 'Tu agenda privada y pasaporte de salud';

  @override
  String get landingBookBody =>
      'Mantén detalles de parejas, preferencias e historial de salud en un lugar discreto. Organiza tus registros y configura recordatorios a tu manera.';

  @override
  String get landingBookPointOne => 'Registros y preferencias de tus parejas';

  @override
  String get landingBookPointTwo =>
      'Controles de salud y recordatorios locales';

  @override
  String get landingModuleFour => 'MÓDULO 04';

  @override
  String get landingTrophyTitle => 'Sala de trofeos y experiencia';

  @override
  String get landingTrophyBody =>
      'Celebra el autoconocimiento, la constancia y tus logros personales. Explora retos por temporada, colecciona insignias y sigue tu propio camino.';

  @override
  String get landingTrophyPointOne =>
      'Retos por temporada e insignias coleccionables';

  @override
  String get landingTrophyPointTwo =>
      'Progreso personal, sin clasificaciones públicas';

  @override
  String get landingArchitectureLabel => 'ARQUITECTURA SIN TELEMETRÍA';

  @override
  String get landingArchitectureTitle => 'Tu vida. Tu dispositivo. Tus datos.';

  @override
  String get landingArchitectureBody =>
      'La privacidad es una base, no una mejora de pago. Así trata NOTCH tu información más sensible.';

  @override
  String get landingArchitectureVector => 'Diseñado para tu privacidad';

  @override
  String get landingArchitectureNotch => 'NOTCH';

  @override
  String get landingArchitectureOther => 'Una app conectada típica';

  @override
  String get landingStorage => 'Almacenamiento';

  @override
  String get landingStorageLocal => 'Local en tu dispositivo';

  @override
  String get landingStorageRemote => 'Servidores remotos y cuentas en la nube';

  @override
  String get landingAccount => 'Cuenta e identificación';

  @override
  String get landingAccountLocal => 'Sin cuenta ni correo obligatorio';

  @override
  String get landingAccountRemote => 'Registro y perfiles de identidad';

  @override
  String get landingTracking => 'Rastreo de terceros';

  @override
  String get landingTrackingLocal => 'Sin SDK de publicidad ni análisis';

  @override
  String get landingTrackingRemote => 'Puede incluir análisis y publicidad';

  @override
  String get landingBusiness => 'Modelo de negocio';

  @override
  String get landingBusinessLocal => 'US\$1.99 · Un solo pago';

  @override
  String get landingBusinessRemote => 'A menudo, una suscripción';

  @override
  String get landingPricingLabel => 'UN PRECIO CLARO Y HONESTO';

  @override
  String get landingPricingTitle => 'Paga una vez. Consérvalo siempre.';

  @override
  String get landingPricingBody =>
      'Una compra. Todas las funciones. Sin pagos recurrentes ni venta de tu información personal.';

  @override
  String get landingLicense => 'VERSIÓN COMPLETA · SIN SUSCRIPCIONES';

  @override
  String get landingPrice => 'US\$1.99';

  @override
  String get landingPriceUnit => 'USD · Un solo pago';

  @override
  String get landingPriceNote =>
      'Versión completa para iOS. Android próximamente. El precio puede variar según la región.';

  @override
  String get landingIncludedLogs => 'Encuentros y notas ilimitados';

  @override
  String get landingIncludedSecurity => 'Biometría y PIN señuelo';

  @override
  String get landingIncludedHealth => 'Pasaporte de salud y recordatorios';

  @override
  String get landingIncludedStats =>
      'Mapas de actividad e información personal';

  @override
  String get landingIncludedBook => 'Registros privados de parejas';

  @override
  String get landingIncludedBackup => 'Copia cifrada y restauración';

  @override
  String get landingFaqLabel => 'PREGUNTAS FRECUENTES';

  @override
  String get landingFaqTitle => 'Todo lo que necesitas saber.';

  @override
  String get landingFaqOne => '¿Cómo funciona el PIN señuelo?';

  @override
  String get landingAnswerOne =>
      'Configura un PIN señuelo independiente en Seguridad y acceso. Al introducirlo, se abre una interfaz discreta de tareas en lugar de tu diario privado. Tu PIN principal te da acceso a tus registros.';

  @override
  String get landingFaqTwo => '¿Qué ocurre si elimino la app?';

  @override
  String get landingAnswerTwo =>
      'Tus registros se guardan localmente, por lo que eliminar la app puede borrarlos. Exporta una copia cifrada antes de eliminar la app o cambiar de teléfono y guarda el archivo y la contraseña en un lugar seguro.';

  @override
  String get landingFaqThree => '¿Alguien puede ver mis datos o estadísticas?';

  @override
  String get landingAnswerThree =>
      'NOTCH calcula la información en tu dispositivo y no envía tu diario a un servidor de NOTCH. Tú controlas los archivos que decides exportar o compartir. Protege tu dispositivo y la contraseña de tus copias.';

  @override
  String get landingFaqFour => '¿Cómo funciona el borrado de emergencia?';

  @override
  String get landingAnswerFour =>
      'Configura un PIN de borrado de emergencia opcional en Seguridad y acceso. Al introducir ese PIN en la pantalla de bloqueo se eliminan tus registros locales. Revisa la configuración y conserva una copia cifrada si deseas mantener tu historial.';

  @override
  String get landingFaqFive => '¿Puedo pasar mis registros a otro teléfono?';

  @override
  String get landingAnswerFive =>
      'Sí. Exporta una copia protegida por contraseña desde Datos y copias de seguridad, transfiérela de forma segura y restáurala en NOTCH en tu nuevo dispositivo con la misma contraseña.';

  @override
  String get landingCtaTitle => 'Recupera hoy la privacidad de tu vida íntima.';

  @override
  String get landingCtaBody =>
      'Más autoconocimiento. Más tranquilidad. Tu camino de bienestar personal, en tus manos.';

  @override
  String get landingFooterBody =>
      'Registro privado de intimidad y bienestar. Diseñado para la discreción, el autoconocimiento y el control de tus registros íntimos.';

  @override
  String get landingFooterLinks => 'Explora NOTCH';

  @override
  String get landingSupport => 'Ayuda';

  @override
  String get landingContact => 'Contactar con soporte';

  @override
  String get landingCopyright => '© 2026 NOTCH. Privado por diseño.';

  @override
  String get landingStoreUnavailable => 'Disponibilidad en App Store';

  @override
  String get landingStoreMessage =>
      'El enlace de NOTCH a la tienda aún no está disponible. Vuelve pronto o contacta con soporte para conocer los detalles del lanzamiento.';

  @override
  String get landingLinkError =>
      'No se pudo abrir este enlace. Inténtalo de nuevo.';

  @override
  String get landingClose => 'Cerrar';

  @override
  String get landingMenu => 'Abrir navegación';

  @override
  String get landingScreenshot => 'Captura de pantalla de NOTCH';

  @override
  String get landingLanguageSwitch => 'English';

  @override
  String get appClipSampleBadge => 'DATOS DE EJEMPLO';

  @override
  String get appClipTitle => 'Conócete un poco más.';

  @override
  String get appClipDescription =>
      'Explora Notch con registros ficticios. Toca una fecha para descubrir cómo podría verse tu diario privado.';

  @override
  String get appClipCalendar => 'Tu calendario';

  @override
  String get appClipSampleEntry => 'Registro ficticio';

  @override
  String get appClipRating => 'Calificación';

  @override
  String get appClipProtection => 'Uso de protección';

  @override
  String get appClipProtectionUsed => 'Sí';

  @override
  String get appClipProtectionNotUsed => 'No';

  @override
  String get appClipEmptyDay => 'No hay registros de ejemplo para este día';

  @override
  String get appClipInsights => 'Estadísticas de ejemplo';

  @override
  String get appClipEntries => 'Registros del mes';

  @override
  String get appClipAverageRating => 'Calificación promedio';

  @override
  String get appClipPrivacy =>
      'Esta vista previa solo usa datos ficticios. Nada de lo que hagas aquí se guarda.';

  @override
  String get appClipGetApp => 'Obtener Notch';

  @override
  String get appClipInstallUnavailable =>
      'No se pudo abrir App Store. Inténtalo de nuevo.';

  @override
  String get watchAbstinence => 'Abstinencia';

  @override
  String watchDuration(int days, int hours, int minutes) {
    return '${days}d ${hours}h ${minutes}m';
  }

  @override
  String get watchNoHistory => 'Aún no hay actividad registrada';

  @override
  String get watchCurrentLevel => 'Nivel actual';

  @override
  String get watchXP => 'XP';

  @override
  String get watchStats => 'Estadísticas del mes';

  @override
  String get watchEntries => 'Registros';

  @override
  String get watchAverage => 'Calificación media';

  @override
  String get watchProtection => 'Protección';

  @override
  String get watchLastSync => 'Última sincronización';

  @override
  String get watchOpenPhone =>
      'Abre y desbloquea Notch en tu iPhone para sincronizar.';

  @override
  String get watchAddEntry => 'Añadir registro';

  @override
  String get watchQueueTitle => 'Cola de registros';

  @override
  String get watchRefresh => 'Sincronizar';

  @override
  String get watchNotice => 'Notch';

  @override
  String get watchOK => 'Aceptar';

  @override
  String get watchSyncUnavailable =>
      'No se puede sincronizar. Tus registros pendientes se conservan. Abre Notch en el iPhone e inténtalo de nuevo.';

  @override
  String get watchStorageUnavailable =>
      'No se pudo guardar en el reloj. Tu registro no se ha puesto en cola. Inténtalo de nuevo.';

  @override
  String get watchQueueFull =>
      'La cola está llena. Sincroniza tus registros pendientes antes de añadir más.';

  @override
  String get watchInvalidEntry =>
      'Revisa el nombre, la calificación, la protección y el número de orgasmos.';

  @override
  String get watchPartner => 'Pareja';

  @override
  String get watchRating => 'Calificación';

  @override
  String get watchOrgasms => 'Orgasmos';

  @override
  String get watchChooseProtection => 'Selecciona…';

  @override
  String get watchYes => 'Sí';

  @override
  String get watchNo => 'No';

  @override
  String get watchPendingExplanation =>
      'Este registro quedará pendiente hasta que Notch en tu iPhone desbloqueado confirme que se ha guardado.';

  @override
  String get watchSave => 'Poner en cola';

  @override
  String get watchPending => 'Pendiente de sincronizar';

  @override
  String get watchDiscard => 'Descartar';

  @override
  String get watchResetRejected =>
      'Notch se ha restablecido. Descarta este registro y vuelve a sincronizar.';

  @override
  String get watchLimitRejected =>
      'Se ha alcanzado el límite mensual de registros.';

  @override
  String get watchTimeRejected =>
      'La hora del registro es posterior a la del iPhone. Revisa el reloj.';

  @override
  String get watchResetUnavailable =>
      'No se pudo completar el restablecimiento. Inténtalo de nuevo.';

  @override
  String get watchMood => 'Ánimo';

  @override
  String get watchTags => 'Etiquetas';

  @override
  String get watchNone => 'Ninguno';

  @override
  String get watchChoosePartner => 'Elegir…';

  @override
  String get watchExistingPartners => 'Parejas existentes';

  @override
  String get watchNoPartners =>
      'Sincroniza Notch en tu iPhone para ver parejas o escribe un nombre arriba.';

  @override
  String get watchOptionsNeedSync =>
      'Abre Notch en tu iPhone para sincronizar las opciones.';

  @override
  String get watchSettingsTitle => 'Apple Watch';

  @override
  String get watchSettingsSubtitle => 'Elige y ordena las tarjetas de tu Watch';

  @override
  String get watchCardsDescription =>
      'Desliza o gira la Digital Crown para cambiar de tarjeta.';

  @override
  String get watchCardsSyncHint =>
      'Los cambios aparecen al sincronizar con tu iPhone desbloqueado.';

  @override
  String get watchCardsReorder =>
      'Arrastra las tarjetas activadas para cambiar su orden.';

  @override
  String get watchCardLevel => 'XP y nivel';

  @override
  String get watchCardOrgasms => 'Orgasmos del mes';

  @override
  String get watchCardsEmpty =>
      'No hay tarjetas activadas. Puedes seguir añadiendo registros y sincronizando.';

  @override
  String get watchCardsSaveError =>
      'No se pudieron guardar los ajustes del Watch. Inténtalo de nuevo.';

  @override
  String get watchActions => 'Acciones';

  @override
  String get watchChooseCards =>
      'Elige tarjetas en Ajustes → Apple Watch de Notch en tu iPhone.';
}
