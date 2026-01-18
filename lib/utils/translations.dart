class AppStrings {
  static String get(String key, {String lang = 'es'}) {
    final Map<String, Map<String, String>> data = {
      'welcome': {'es': 'Bienvenido a NOTCH', 'en': 'Welcome to NOTCH'},
      'auth_reason': {
        'es': 'Por favor autentícate para acceder a tus registros',
        'en': 'Please authenticate to access your logs',
      },
      'partner': {'es': 'Pareja', 'en': 'Partner'},
      'orgasms': {'es': 'Orgasmos', 'en': 'Orgasms'},
      'rating': {'es': 'Calificación', 'en': 'Rating'},
      'save': {'es': 'Guardar Notch', 'en': 'Save Notch'},
      'stats': {'es': 'Estadísticas', 'en': 'Statistics'},

      'tag_morning': {'es': 'Mañanero', 'en': 'Morning Wood'},
      'tag_quickie': {'es': 'Rápido', 'en': 'Quickie'},
      'tag_oral': {'es': 'Oral', 'en': 'Oral'},
      'tag_anal': {'es': 'Anal', 'en': 'Anal'},
      'tag_toys': {'es': 'Juguetes', 'en': 'Toys'},
      'tag_date': {'es': 'Cita', 'en': 'Date Night'},
      'tag_travel': {'es': 'Viaje', 'en': 'Travel'},
      'tag_kinky': {'es': 'Kinky', 'en': 'Kinky'},
      'tag_outdoor': {'es': 'Aire Libre', 'en': 'Outdoor'},
      'tag_anniversary': {'es': 'Aniversario', 'en': 'Anniversary'},

      // Nuevos - Contexto y Situación
      'tag_ons': {'es': 'Aventura de una Noche', 'en': 'One-Night Stand'},
      'tag_fwb': {'es': 'Amigos con Beneficios', 'en': 'Friends w/ Benefits'},
      'tag_reconciliation': {'es': 'Reconciliación', 'en': 'Make-up Sex'},
      'tag_celebration': {'es': 'Celebración', 'en': 'Celebration'},

      // Nuevos - Prácticas y Estilos
      'tag_vanilla': {'es': 'Vainilla', 'en': 'Vanilla'},
      'tag_domsub': {'es': 'Dom/Sub', 'en': 'Dom/Sub'},
      'tag_massage': {'es': 'Masaje Erótico', 'en': 'Erotic Massage'},

      // Nuevos - Ubicación y Ambiente
      'tag_car': {'es': 'En el Coche', 'en': 'Car Sex'},
      'tag_hotel': {'es': 'Hotel', 'en': 'Hotel'},
      'tag_shower': {'es': 'Ducha / Baño', 'en': 'Shower / Bath'},

      'mood': {'es': 'Estado de Ánimo', 'en': 'Mood'},
      'protected': {'es': 'Usé Protección', 'en': 'Used Protection'},
    };
    return data[key]?[lang] ?? key;
  }
}

const List<String> tagKeys = [
  // Originales
  'tag_morning', 'tag_quickie', 'tag_date', 'tag_travel',
  'tag_anniversary', 'tag_celebration',

  // Prácticas
  'tag_oral', 'tag_anal', 'tag_toys', 'tag_kinky', 'tag_vanilla',
  'tag_domsub', 'tag_massage',

  // Ubicación
  'tag_outdoor', 'tag_car', 'tag_hotel', 'tag_shower',

  // Contexto
  'tag_ons', 'tag_fwb', 'tag_reconciliation',
];

const List<String> moodEmojis = [
  '🔥',
  '😈',
  '🥰',
  '😎',
  '😴',
  '🦄',
  '🤯',
  '💦',
  '🧘‍♂️',
  '🏆',
];

String currentLang = 'es';
