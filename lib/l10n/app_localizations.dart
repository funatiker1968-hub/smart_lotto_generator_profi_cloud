import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // DELEGATE muss existieren!
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Deutsch - Hauptsprache
  String get appTitle => 'Lotto World Pro';
  String get yourWinningNumbers => 'Deine Glückszahlen';
  String get pressSpinToStart => 'Drücke SPIN zum Starten';
  String get spin => 'SPIN';
  String get save => 'SPEICHERN';
  String get statistics => 'Statistik';
  String get tipAnalysis => 'Tipp Analyse';
  String get winSimulation => 'Gewinn Simulation';
  String get tips => 'Tipps';
  String get cost => 'Kosten';
  String get quickTips => 'Quick-Tipps';
  String get megaTips => 'Mega-Tipps';
  String get myWinningTips => 'Meine Gewinn-Tipps';
  String get noTipsYet => 'Noch keine Tipps';
  String get generateLuckyNumbers => 'Generiere deine Glückszahlen!';
  String get tipSaved => 'Tipp gespeichert!';
  String get allTipsDeleted => 'Alle Tipps gelöscht!';
  String get tipsGenerated => 'Tipps generiert!';
  String get createTipsFirst => 'Bitte erstelle zuerst Tipps!';
  String get totalTips => 'Gesamte Tipps';
  String get light => 'Hell';
  String get dark => 'Dunkel';
  String get system => 'System';
}

// DELEGATE KLASSE MUSS VORHANDEN SEIN!
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['de', 'en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
