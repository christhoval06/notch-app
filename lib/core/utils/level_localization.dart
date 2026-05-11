import 'package:notch_app/l10n/app_localizations.dart';

String localizeLevelName(AppLocalizations l10n, String raw) {
  switch (raw) {
    case 'Iniciado I':
      return l10n.levelInitiated1Name;
    case 'Iniciado II':
      return l10n.levelInitiated2Name;
    case 'Iniciado III':
      return l10n.levelInitiated3Name;
    case 'Practicante I':
      return l10n.levelPractitioner1Name;
    case 'Practicante II':
      return l10n.levelPractitioner2Name;
    case 'Practicante III':
      return l10n.levelPractitioner3Name;
    case 'Adepto I':
      return l10n.levelAdept1Name;
    case 'Adepto II':
      return l10n.levelAdept2Name;
    case 'Adepto III':
      return l10n.levelAdept3Name;
    case 'Virtuoso I':
      return l10n.levelVirtuoso1Name;
    case 'Virtuoso II':
      return l10n.levelVirtuoso2Name;
    case 'Virtuoso III':
      return l10n.levelVirtuoso3Name;
    case 'Conocedor I':
      return l10n.levelKnower1Name;
    case 'Conocedor II':
      return l10n.levelKnower2Name;
    case 'Conocedor III':
      return l10n.levelKnower3Name;
    case 'Maestro':
      return l10n.levelMasterName;
    case 'Gran Maestro':
      return l10n.levelGrandMasterName;
    case 'Leyenda':
      return l10n.levelLegendName;
    default:
      return raw;
  }
}

String localizeLevelDescription(AppLocalizations l10n, String raw) {
  switch (raw) {
    case 'Iniciado I':
      return l10n.levelInitiated1Desc;
    case 'Iniciado II':
      return l10n.levelInitiated2Desc;
    case 'Iniciado III':
      return l10n.levelInitiated3Desc;
    case 'Practicante I':
      return l10n.levelPractitioner1Desc;
    case 'Practicante II':
      return l10n.levelPractitioner2Desc;
    case 'Practicante III':
      return l10n.levelPractitioner3Desc;
    case 'Adepto I':
      return l10n.levelAdept1Desc;
    case 'Adepto II':
      return l10n.levelAdept2Desc;
    case 'Adepto III':
      return l10n.levelAdept3Desc;
    case 'Virtuoso I':
      return l10n.levelVirtuoso1Desc;
    case 'Virtuoso II':
      return l10n.levelVirtuoso2Desc;
    case 'Virtuoso III':
      return l10n.levelVirtuoso3Desc;
    case 'Conocedor I':
      return l10n.levelKnower1Desc;
    case 'Conocedor II':
      return l10n.levelKnower2Desc;
    case 'Conocedor III':
      return l10n.levelKnower3Desc;
    case 'Maestro':
      return l10n.levelMasterDesc;
    case 'Gran Maestro':
      return l10n.levelGrandMasterDesc;
    case 'Leyenda':
      return l10n.levelLegendDesc;
    default:
      return l10n.statsNoDescription;
  }
}
