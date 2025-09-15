import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  // Список поддерживаемых языков
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ru'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('ar'),
    Locale('zh'),
  ];

  LocaleProvider() {
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  void setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  void clearLocale() async {
    _locale = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('language_code');
  }
}