import 'package:flutter/material.dart';
import '../models/chat_settings.dart';

/// Провайдер для управления настройками чата
class ChatSettingsProvider with ChangeNotifier {
  ChatSettings _settings = ChatSettings.defaultSettings();
  bool _isLoading = true;

  ChatSettings get settings => _settings;
  bool get isLoading => _isLoading;

  /// Загружает настройки из SharedPreferences
  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _settings = await ChatSettingsService.loadSettings();
    } catch (e) {
      debugPrint('Error loading settings in provider: $e');
      _settings = ChatSettings.defaultSettings();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Сохраняет настройки в SharedPreferences
  Future<bool> saveSettings(ChatSettings newSettings) async {
    final success = await ChatSettingsService.saveSettings(newSettings);
    if (success) {
      _settings = newSettings;
      notifyListeners();
    }
    return success;
  }

  /// Обновляет отдельные параметры настроек
  Future<bool> updateSettings({
    double? fontSize,
    bool? isDarkTheme,
    Color? messageBubbleColor,
    Color? receivedBubbleColor,
    int? selectedWallpaperIndex,
  }) async {
    final newSettings = _settings.copyWith(
      fontSize: fontSize,
      isDarkTheme: isDarkTheme,
      messageBubbleColor: messageBubbleColor,
      receivedBubbleColor: receivedBubbleColor,
      selectedWallpaperIndex: selectedWallpaperIndex,
    );

    return await saveSettings(newSettings);
  }

  /// Сбрасывает настройки к значениям по умолчанию
  Future<bool> resetSettings() async {
    final success = await ChatSettingsService.resetSettings();
    if (success) {
      _settings = ChatSettings.defaultSettings();
      notifyListeners();
    }
    return success;
  }

  /// Геттеры для удобного доступа к отдельным настройкам
  double get fontSize => _settings.fontSize;
  bool get isDarkTheme => _settings.isDarkTheme;
  Color get messageBubbleColor => _settings.messageBubbleColor;
  Color get receivedBubbleColor => _settings.receivedBubbleColor;
  int get selectedWallpaperIndex => _settings.selectedWallpaperIndex;
}