import 'package:flutter/services.dart';

/// Сервис для оптимизированной загрузки кастомных Emoji шрифтов
class EmojiLoaderService {
  static bool _isInitialized = false;
  static Uint8List? _cachedFontData;
  
  /// Предзагружает кастомный Emoji шрифт в память
  static Future<void> preloadCustomEmojiFont() async {
    if (_isInitialized) return;
    
    try {
      // Загружаем кастомный шрифт эмодзи в память
      final ByteData fontData = await rootBundle.load('assets/fonts/appleemojis.ttf');
      _cachedFontData = fontData.buffer.asUint8List();
      
      // Регистрируем шрифт для системы
      await _registerFont();
      
      _isInitialized = true;
      print('✅ Кастомный Emoji шрифт успешно предзагружен');
    } catch (e) {
      print('❌ Ошибка загрузки кастомного Emoji шрифта: $e');
    }
  }
  
  /// Регистрирует шрифт в системе Flutter
  static Future<void> _registerFont() async {
    if (_cachedFontData == null) return;
    
    try {
      // Создаем FontLoader для оптимизации
      final fontLoader = FontLoader('CustomEmojis');
      fontLoader.addFont(Future.value(_cachedFontData!.buffer.asByteData()));
      await fontLoader.load();
      
      print('📝 Кастомный Emoji шрифт зарегистрирован в FontLoader');
    } catch (e) {
      print('❌ Ошибка регистрации шрифта: $e');
    }
  }
  
  /// Проверяет, загружен ли шрифт
  static bool get isLoaded => _isInitialized && _cachedFontData != null;
  
  /// Получает размер загруженного шрифта в байтах
  static int get fontSizeBytes => _cachedFontData?.length ?? 0;
  
  /// Освобождает ресурсы шрифта из памяти
  static void dispose() {
    _cachedFontData = null;
    _isInitialized = false;
    print('🗑️ Кастомный Emoji шрифт выгружен из памяти');
  }
  
  /// Получает информацию о состоянии загрузки шрифта
  static Map<String, dynamic> getStatus() {
    return {
      'isLoaded': _isInitialized,
      'fontSizeKB': (fontSizeBytes / 1024).toStringAsFixed(2),
      'cacheStatus': _cachedFontData != null ? 'cached' : 'not_cached',
    };
  }
}
