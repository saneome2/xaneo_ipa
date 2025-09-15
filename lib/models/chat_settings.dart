import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Модель для хранения настроек чата
class ChatSettings {
  final double fontSize;
  final bool isDarkTheme;
  final Color messageBubbleColor;
  final Color receivedBubbleColor;
  final int selectedWallpaperIndex;

  const ChatSettings({
    required this.fontSize,
    required this.isDarkTheme,
    required this.messageBubbleColor,
    required this.receivedBubbleColor,
    required this.selectedWallpaperIndex,
  });

  /// Создает настройки по умолчанию
  factory ChatSettings.defaultSettings() {
    return const ChatSettings(
      fontSize: 16.0,
      isDarkTheme: true,
      messageBubbleColor: Color(0xFF007AFF),
      receivedBubbleColor: Color(0xFF3A3A3C),
      selectedWallpaperIndex: 0,
    );
  }

  /// Конвертирует настройки в JSON для сохранения
  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'isDarkTheme': isDarkTheme,
      'messageBubbleColor': messageBubbleColor.value,
      'receivedBubbleColor': receivedBubbleColor.value,
      'selectedWallpaperIndex': selectedWallpaperIndex,
    };
  }

  /// Создает настройки из JSON
  factory ChatSettings.fromJson(Map<String, dynamic> json) {
    return ChatSettings(
      fontSize: json['fontSize'] ?? 16.0,
      isDarkTheme: json['isDarkTheme'] ?? true,
      messageBubbleColor: Color(json['messageBubbleColor'] ?? 0xFF007AFF),
      receivedBubbleColor: Color(json['receivedBubbleColor'] ?? 0xFF3A3A3C),
      selectedWallpaperIndex: json['selectedWallpaperIndex'] ?? 0,
    );
  }

  /// Создает копию настроек с изменениями
  ChatSettings copyWith({
    double? fontSize,
    bool? isDarkTheme,
    Color? messageBubbleColor,
    Color? receivedBubbleColor,
    int? selectedWallpaperIndex,
  }) {
    return ChatSettings(
      fontSize: fontSize ?? this.fontSize,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      messageBubbleColor: messageBubbleColor ?? this.messageBubbleColor,
      receivedBubbleColor: receivedBubbleColor ?? this.receivedBubbleColor,
      selectedWallpaperIndex: selectedWallpaperIndex ?? this.selectedWallpaperIndex,
    );
  }
}

/// Сервис для работы с настройками чата в SharedPreferences
class ChatSettingsService {
  static const String _settingsKey = 'chat_settings';

  /// Загружает настройки чата из SharedPreferences
  static Future<ChatSettings> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);

      if (settingsJson != null) {
        final json = jsonDecode(settingsJson) as Map<String, dynamic>;
        return ChatSettings.fromJson(json);
      }
    } catch (e) {
      debugPrint('Error loading chat settings: $e');
    }

    return ChatSettings.defaultSettings();
  }

  /// Сохраняет настройки чата в SharedPreferences
  static Future<bool> saveSettings(ChatSettings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = jsonEncode(settings.toJson());
      return await prefs.setString(_settingsKey, settingsJson);
    } catch (e) {
      debugPrint('Error saving chat settings: $e');
      return false;
    }
  }

  /// Сбрасывает настройки к значениям по умолчанию
  static Future<bool> resetSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_settingsKey);
    } catch (e) {
      debugPrint('Error resetting chat settings: $e');
      return false;
    }
  }
}