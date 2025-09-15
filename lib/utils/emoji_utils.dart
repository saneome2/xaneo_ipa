import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

/// Утилитарный класс для работы с iOS-эмодзи с оптимизацией загрузки
class EmojiUtils {
  static final EmojiParser _parser = EmojiParser();
  
  // Кэш для часто используемых эмодзи
  static final Map<String, String> _emojiCache = {};
  
  // Кэш для TextStyle объектов
  static final Map<String, TextStyle> _styleCache = {};
  
  // Предзагруженные часто используемые эмодзи
  static const Map<String, String> _preloadedEmojis = {
    'smile': '😊',
    'heart': '❤️',
    'thumbs_up': '👍',
    'fire': '🔥',
    'star': '⭐',
    'moon': '🌙',
    'sun': '☀️',
    'rocket': '🚀',
    'check': '✅',
    'warning': '⚠️',
  };

  /// Инициализация и предзагрузка критичных эмодзи
  static void preloadEmojis() {
    // Заполняем кэш предзагруженными эмодзи
    _emojiCache.addAll(_preloadedEmojis);
    
    // Предзагружаем базовые стили
    _preloadStyles();
  }

  /// Предзагрузка базовых стилей
  static void _preloadStyles() {
    const baseSizes = [12.0, 14.0, 16.0, 18.0, 20.0, 24.0];
    for (final size in baseSizes) {
      final key = 'size_$size';
      _styleCache[key] = TextStyle(
        fontFamily: 'AppleEmojis',
        fontSize: size,
        height: 1.0,
      );
    }
  }

  /// Получить iOS-стиль эмодзи по имени с кэшированием
  static String getEmoji(String name) {
    // Проверяем кэш
    if (_emojiCache.containsKey(name)) {
      return _emojiCache[name]!;
    }
    
    try {
      final emoji = _parser.get(name).code;
      // Кэшируем результат
      _emojiCache[name] = emoji;
      return emoji;
    } catch (e) {
      // Если эмодзи не найден, возвращаем стандартный и кэшируем
      final fallback = _getFallbackEmoji(name);
      _emojiCache[name] = fallback;
      return fallback;
    }
  }

  /// Получить TextStyle для отображения эмодзи с Apple шрифтом (оптимизированная версия)
  static TextStyle getEmojiTextStyle({
    double fontSize = 16.0,
    Color? color,
  }) {
    // Проверяем кэш для стандартных размеров без цвета
    if (color == null) {
      final key = 'size_$fontSize';
      if (_styleCache.containsKey(key)) {
        return _styleCache[key]!;
      }
    }
    
    // Создаем новый стиль
    final style = TextStyle(
      fontFamily: 'AppleEmojis',
      fontSize: fontSize,
      color: color,
      height: 1.0, // Чтобы эмодзи не имели лишнего пространства
    );
    
    // Кэшируем только базовые стили без цвета
    if (color == null && fontSize <= 32.0) {
      _styleCache['size_$fontSize'] = style;
    }
    
    return style;
  }

  /// Получить эмодзи с iOS-стилем для часто используемых (оптимизированная версия)
  static String getCommonEmoji(String type) {
    // Сначала проверяем предзагруженные эмодзи
    final lowerType = type.toLowerCase();
    if (_preloadedEmojis.containsKey(lowerType)) {
      return _preloadedEmojis[lowerType]!;
    }
    
    // Если нет в предзагруженных, ищем в расширенном списке
    switch (lowerType) {
      case 'smile':
      case 'happy':
        return _cacheEmoji('smile', '😊');
      case 'heart':
        return _cacheEmoji('heart', '❤️');
      case 'thumbs_up':
        return _cacheEmoji('thumbs_up', '👍');
      case 'fire':
        return _cacheEmoji('fire', '🔥');
      case 'star':
        return _cacheEmoji('star', '⭐');
      case 'moon':
        return _cacheEmoji('moon', '🌙');
      case 'sun':
        return _cacheEmoji('sun', '☀️');
      case 'cloud':
        return _cacheEmoji('cloud', '☁️');
      case 'rain':
        return _cacheEmoji('rain', '🌧️');
      case 'snow':
        return _cacheEmoji('snow', '❄️');
      case 'lightning':
        return _cacheEmoji('lightning', '⚡');
      case 'rocket':
        return _cacheEmoji('rocket', '🚀');
      case 'plane':
        return _cacheEmoji('plane', '✈️');
      case 'car':
        return _cacheEmoji('car', '🚗');
      case 'bike':
        return _cacheEmoji('bike', '🚲');
      case 'phone':
        return _cacheEmoji('phone', '📱');
      case 'camera':
        return _cacheEmoji('camera', '📷');
      case 'music':
        return _cacheEmoji('music', '🎵');
      case 'game':
        return _cacheEmoji('game', '🎮');
      case 'book':
        return _cacheEmoji('book', '📚');
      case 'coffee':
        return _cacheEmoji('coffee', '☕');
      case 'pizza':
        return _cacheEmoji('pizza', '🍕');
      case 'cake':
        return _cacheEmoji('cake', '🎂');
      case 'gift':
        return _cacheEmoji('gift', '🎁');
      case 'balloon':
        return _cacheEmoji('balloon', '🎈');
      case 'party':
        return _cacheEmoji('party', '🎉');
      case 'trophy':
        return _cacheEmoji('trophy', '🏆');
      case 'medal':
        return _cacheEmoji('medal', '🥇');
      case 'clock':
        return _cacheEmoji('clock', '🕐');
      case 'calendar':
        return _cacheEmoji('calendar', '📅');
      case 'pin':
        return _cacheEmoji('pin', '📍');
      case 'lock':
        return _cacheEmoji('lock', '🔒');
      case 'key':
        return _cacheEmoji('key', '🔑');
      case 'bell':
        return _cacheEmoji('bell', '🔔');
      case 'warning':
        return _cacheEmoji('warning', '⚠️');
      case 'check':
        return _cacheEmoji('check', '✅');
      case 'cross':
        return _cacheEmoji('cross', '❌');
      case 'question':
        return _cacheEmoji('question', '❓');
      case 'exclamation':
        return _cacheEmoji('exclamation', '❗');
      default:
        return _cacheEmoji('default', '😊');
    }
  }

  /// Вспомогательный метод для кэширования эмодзи
  static String _cacheEmoji(String key, String emoji) {
    _emojiCache[key] = emoji;
    return emoji;
  }

  /// Получить случайный эмодзи из категории (с кэшированием)
  static String getRandomEmoji(String category) {
    final categoryKey = category.toLowerCase();
    
    // Предзагруженные списки для быстрого доступа
    const Map<String, List<String>> emojiCategories = {
      'faces': ['😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣', '😊', '😇'],
      'hearts': ['❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍', '🤎', '💔'],
      'animals': ['🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼', '🐨', '🐯'],
      'food': ['🍎', '🍌', '🍊', '🍋', '🍉', '🍇', '🍓', '🫐', '🍈', '🍒'],
      'nature': ['🌱', '🌿', '☘️', '🍀', '🎋', '🎍', '🌾', '🌵', '🌲', '🌳'],
    };
    
    final emojis = emojiCategories[categoryKey];
    if (emojis != null) {
      final emoji = emojis[DateTime.now().millisecond % emojis.length];
      _cacheEmoji('random_${categoryKey}_${DateTime.now().millisecond}', emoji);
      return emoji;
    }
    
    return _cacheEmoji('default_random', '🎉');
  }

  /// Преобразовать текст с эмодзи в iOS-стиль (оптимизированная версия)
  static String convertToIOSStyle(String text) {
    // Используем кэшированные замены для часто используемых комбинаций
    const Map<String, String> replacements = {
      '😀': '😊',  // Более мягкая улыбка
      '👍': '👍🏻', // С тоном кожи
      '❤️': '💖',  // Более яркое сердце
      '🔥': '🔥',  // Оставляем как есть
      '⭐': '🌟', // Более яркая звезда
    };
    
    String result = text;
    for (final entry in replacements.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    
    return result;
  }

  /// Получить резервный эмодзи если основной не найден (с кэшированием)
  static String _getFallbackEmoji(String name) {
    // Проверяем предзагруженные эмодзи
    if (_preloadedEmojis.containsKey(name.toLowerCase())) {
      return _preloadedEmojis[name.toLowerCase()]!;
    }
    
    switch (name.toLowerCase()) {
      case 'smile':
        return _cacheEmoji('fallback_smile', '😊');
      case 'heart':
        return _cacheEmoji('fallback_heart', '💖');
      case 'thumbsup':
        return _cacheEmoji('fallback_thumbsup', '👍🏻');
      case 'fire':
        return _cacheEmoji('fallback_fire', '🔥');
      case 'star':
        return _cacheEmoji('fallback_star', '🌟');
      case 'moon':
        return _cacheEmoji('fallback_moon', '🌙');
      case 'sun':
        return _cacheEmoji('fallback_sun', '☀️');
      default:
        return _cacheEmoji('fallback_default', '😊');
    }
  }

  /// Проверить, содержит ли текст эмодзи (оптимизированная версия)
  static bool hasEmoji(String text) {
    // Кэшированный regex для производительности
    _emojiRegex ??= RegExp(
      r'[\u{1F600}-\u{1F64F}]|' // Emoticons
      r'[\u{1F300}-\u{1F5FF}]|' // Misc Symbols and Pictographs
      r'[\u{1F680}-\u{1F6FF}]|' // Transport and Map
      r'[\u{1F1E0}-\u{1F1FF}]|' // Regional country flags
      r'[\u{2600}-\u{26FF}]|'   // Misc symbols
      r'[\u{2700}-\u{27BF}]',   // Dingbats
      unicode: true,
    );
    return _emojiRegex!.hasMatch(text);
  }

  // Статические переменные для кэширования regex
  static RegExp? _emojiRegex;

  /// Очистить кэш эмодзи (для управления памятью)
  static void clearCache() {
    _emojiCache.clear();
    _styleCache.clear();
    // Восстанавливаем предзагруженные эмодзи
    _emojiCache.addAll(_preloadedEmojis);
    _preloadStyles();
  }

  /// Получить информацию о кэше
  static Map<String, int> getCacheInfo() {
    return {
      'emoji_cache_size': _emojiCache.length,
      'style_cache_size': _styleCache.length,
    };
  }
}
