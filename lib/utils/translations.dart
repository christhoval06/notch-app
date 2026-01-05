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
      'save': {'es': 'Guardar Muesca', 'en': 'Save Notch'},
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

      'mood': {'es': 'Estado de Ánimo', 'en': 'Mood'},
      'protected': {'es': 'Usé Protección', 'en': 'Used Protection'},
    };
    return data[key]?[lang] ?? key;
  }
}

const List<String> tagKeys = [
  'tag_morning',
  'tag_quickie',
  'tag_oral',
  'tag_anal',
  'tag_toys',
  'tag_date',
  'tag_travel',
  'tag_kinky',
  'tag_outdoor',
  'tag_anniversary',
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
