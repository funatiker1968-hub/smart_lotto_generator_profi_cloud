import './theme_service.dart';
import './language_service.dart';

class AppState {
  final ThemeService _themeService = ThemeService();
  final LanguageService _languageService = LanguageService();

  bool _isDarkMode = false;
  String _currentLanguage = 'de';

  AppState() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    await _themeService.init();
    await _languageService.init();
    
    _isDarkMode = _themeService.isDarkMode;
    _currentLanguage = _languageService.getCurrentLanguage();
  }

  // Theme Methods
  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme() async {
    await _themeService.toggleTheme();
    _isDarkMode = _themeService.isDarkMode;
  }

  // Language Methods
  String get currentLanguage => _currentLanguage;

  Future<void> switchLanguage() async {
    await _languageService.switchLanguage();
    _currentLanguage = _languageService.getCurrentLanguage();
  }

  String translate(String key) {
    return _languageService.translate(key);
  }

  // Utility Methods
  Future<void> refresh() async {
    await _loadPreferences();
  }
}
