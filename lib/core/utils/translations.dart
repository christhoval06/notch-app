import 'package:notch_app/l10n/app_localizations.dart';

import 'locale_controller.dart';

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

String get currentLang => AppLocaleController.instance.languageCode;

String tagLabelFromL10n(AppLocalizations l10n, String tagKey) {
  switch (tagKey) {
    case 'tag_morning':
      return l10n.tagMorning;
    case 'tag_quickie':
      return l10n.tagQuickie;
    case 'tag_oral':
      return l10n.tagOral;
    case 'tag_anal':
      return l10n.tagAnal;
    case 'tag_toys':
      return l10n.tagToys;
    case 'tag_date':
      return l10n.tagDate;
    case 'tag_travel':
      return l10n.tagTravel;
    case 'tag_kinky':
      return l10n.tagKinky;
    case 'tag_outdoor':
      return l10n.tagOutdoor;
    case 'tag_anniversary':
      return l10n.tagAnniversary;
    case 'tag_ons':
      return l10n.tagOns;
    case 'tag_fwb':
      return l10n.tagFwb;
    case 'tag_reconciliation':
      return l10n.tagReconciliation;
    case 'tag_celebration':
      return l10n.tagCelebration;
    case 'tag_vanilla':
      return l10n.tagVanilla;
    case 'tag_domsub':
      return l10n.tagDomsub;
    case 'tag_massage':
      return l10n.tagMassage;
    case 'tag_car':
      return l10n.tagCar;
    case 'tag_hotel':
      return l10n.tagHotel;
    case 'tag_shower':
      return l10n.tagShower;
    default:
      return tagKey;
  }
}

String tagLabelFromLanguageCode(String tagKey, String languageCode) {
  final bool isEnglish = languageCode.toLowerCase() == 'en';
  switch (tagKey) {
    case 'tag_morning':
      return isEnglish ? 'Morning Wood' : 'Mananero';
    case 'tag_quickie':
      return isEnglish ? 'Quickie' : 'Rapido';
    case 'tag_oral':
      return 'Oral';
    case 'tag_anal':
      return 'Anal';
    case 'tag_toys':
      return isEnglish ? 'Toys' : 'Juguetes';
    case 'tag_date':
      return isEnglish ? 'Date Night' : 'Cita';
    case 'tag_travel':
      return isEnglish ? 'Travel' : 'Viaje';
    case 'tag_kinky':
      return 'Kinky';
    case 'tag_outdoor':
      return isEnglish ? 'Outdoor' : 'Aire Libre';
    case 'tag_anniversary':
      return isEnglish ? 'Anniversary' : 'Aniversario';
    case 'tag_ons':
      return isEnglish ? 'One-Night Stand' : 'Aventura de una Noche';
    case 'tag_fwb':
      return isEnglish ? 'Friends w/ Benefits' : 'Amigos con Beneficios';
    case 'tag_reconciliation':
      return isEnglish ? 'Make-up Sex' : 'Reconciliacion';
    case 'tag_celebration':
      return isEnglish ? 'Celebration' : 'Celebracion';
    case 'tag_vanilla':
      return isEnglish ? 'Vanilla' : 'Vainilla';
    case 'tag_domsub':
      return 'Dom/Sub';
    case 'tag_massage':
      return isEnglish ? 'Erotic Massage' : 'Masaje Erotico';
    case 'tag_car':
      return isEnglish ? 'Car Sex' : 'En el Coche';
    case 'tag_hotel':
      return 'Hotel';
    case 'tag_shower':
      return isEnglish ? 'Shower / Bath' : 'Ducha / Bano';
    default:
      return tagKey;
  }
}
