import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'appLanguage';
  
  static const Map<String, Map<String, String>> _translations = {
    'de': {
      'appTitle': 'Lotto World Pro',
      'generateTip': 'Tipp generieren',
      'saveTip': 'Tipp speichern',
      'currentTip': 'Aktueller Tipp',
      'noTip': 'Kein Tipp generiert',
      'savedTips': 'Gespeicherte Tipps',
      'noSavedTips': 'Keine gespeicherten Tipps',
      'deleteAll': 'Alle Tipps löschen',
      'stats': 'Statistiken',
      'analysis': 'Analyse',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'created': 'Erstellt',
    },
    'en': {
      'appTitle': 'Lotto World Pro',
      'generateTip': 'Generate Tip',
      'saveTip': 'Save Tip',
      'currentTip': 'Current Tip',
      'noTip': 'No tip generated',
      'savedTips': 'Saved Tips',
      'noSavedTips': 'No saved tips',
      'deleteAll': 'Delete All',
      'stats': 'Statistics',
      'analysis': 'Analysis',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'created': 'Created',
    },
    'tr': {
      'appTitle': 'Lotto World Pro',
      'generateTip': 'Tip Oluştur',
      'saveTip': 'Tipi Kaydet',
      'currentTip': 'Mevcut Tip',
      'noTip': 'Tip oluşturulmadı',
      'savedTips': 'Kayıtlı Tüyolar',
      'noSavedTips': 'Kayıtlı tüyo yok',
      'deleteAll': 'Tümünü Sil',
      'stats': 'İstatistikler',
      'analysis': 'Analiz',
      'darkMode': 'Karanlık Mod',
      'lightMode': 'Aydınlık Mod',
      'created': 'Oluşturuldu',
    },
  };

  String _currentLanguage = 'de';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? 'de';
  }

  // NEUE METHODE: Sprachwechsel
  Future<void> switchLanguage() async {
    final languages = ['de', 'en', 'tr'];
    final currentIndex = languages.indexOf(_currentLanguage);
    final nextIndex = (currentIndex + 1) % languages.length;
    
    _currentLanguage = languages[nextIndex];
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, _currentLanguage);
  }

  String getCurrentLanguage() {
    return _currentLanguage;
  }

  String translate(String key) {
    return _translations[_currentLanguage]?[key] ?? key;
  }
}
