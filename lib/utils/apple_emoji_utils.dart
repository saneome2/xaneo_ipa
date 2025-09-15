import 'package:flutter/material.dart';

/// Утилиты для работы с Apple эмодзи шрифтом
class AppleEmojiUtils {
  /// Возвращает TextStyle для Apple эмодзи
  static TextStyle getAppleEmojiStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextStyle? baseStyle,
  }) {
    final style = baseStyle ?? const TextStyle();
    
    return style.copyWith(
      fontFamily: 'AppleEmojis',
      fontFamilyFallback: const [
        'Apple Color Emoji',
        'Segoe UI Emoji',
        'Noto Color Emoji',
        'Twemoji Mozilla',
        'Android Emoji',
        'EmojiOne Color',
      ],
      fontSize: fontSize ?? (style.fontSize ?? 14) * 1.1,
      color: color ?? style.color,
      fontWeight: fontWeight ?? style.fontWeight,
    );
  }

  /// Проверяет, является ли символ эмодзи по Unicode диапазонам
  static bool isEmoji(int codePoint) {
    return (codePoint >= 0x1F600 && codePoint <= 0x1F64F) ||  // эмоции
           (codePoint >= 0x1F300 && codePoint <= 0x1F5FF) ||  // символы и пиктограммы
           (codePoint >= 0x1F680 && codePoint <= 0x1F6FF) ||  // транспорт
           (codePoint >= 0x1F700 && codePoint <= 0x1F77F) ||  // алхимические символы
           (codePoint >= 0x1F780 && codePoint <= 0x1F7FF) ||  // геометрические фигуры
           (codePoint >= 0x1F800 && codePoint <= 0x1F8FF) ||  // дополнительные стрелки
           (codePoint >= 0x1F900 && codePoint <= 0x1F9FF) ||  // дополнительные символы
           (codePoint >= 0x1FA00 && codePoint <= 0x1FA6F) ||  // шахматы
           (codePoint >= 0x1FA70 && codePoint <= 0x1FAFF) ||  // расширенные символы
           (codePoint >= 0x2600 && codePoint <= 0x26FF) ||    // разные символы
           (codePoint >= 0x2700 && codePoint <= 0x27BF) ||    // дингбаты
           (codePoint >= 0x1F1E6 && codePoint <= 0x1F1FF) ||  // региональные индикаторы
           (codePoint >= 0x1F3FB && codePoint <= 0x1F3FF) ||  // модификаторы тона кожи
           (codePoint == 0x200D) ||                           // Zero Width Joiner
           (codePoint == 0xFE0F) ||                           // Variation Selector-16
           (codePoint == 0x20E3) ||                           // Combining Enclosing Keycap
           // Стрелки для направленных эмодзи
           (codePoint == 0x2194) ||                           // ↔ Left Right Arrow
           (codePoint == 0x2195) ||                           // ↕ Up Down Arrow
           (codePoint == 0x2196) ||                           // ↖ North West Arrow
           (codePoint == 0x2197) ||                           // ↗ North East Arrow  
           (codePoint == 0x2198) ||                           // ↘ South East Arrow
           (codePoint == 0x2199) ||                           // ↙ South West Arrow
           (codePoint == 0x21A9) ||                           // ↩ Leftwards Arrow with Hook
           (codePoint == 0x21AA);                             // ↪ Rightwards Arrow with Hook
  }

  /// Проверяет, содержит ли строка ZWJ последовательность
  static bool isZwjSequence(String text) {
    return text.contains('\u200D'); // Zero Width Joiner
  }

  /// Список ZWJ последовательностей, которые могут не поддерживаться в Apple шрифте
  static const Set<String> problematicZwjEmojis = {
    '🙂‍↔️',  // кивающее лицо влево-вправо
    '🙂‍↕️',  // кивающее лицо вверх-вниз
    '😵‍💫',  // лицо с крестиками в глазах
    '😮‍💨',  // выдыхающее лицо
    '🫨',    // встряхивающее лицо (если не поддерживается)
    '🧑‍🧒‍🧒', // взрослый с детьми
    '🧑‍🧒',   // взрослый с ребёнком
    '🧑‍🧑‍🧒‍🧒', // семья со взрослыми и детьми
    '🧑‍🧑‍🧒', // семья со взрослыми и ребёнком
  };

  /// Возвращает fallback стиль для проблемных ZWJ эмодзи
  static TextStyle getFallbackEmojiStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextStyle? baseStyle,
  }) {
    final style = baseStyle ?? const TextStyle();
    
    return style.copyWith(
      // Используем системные шрифты для fallback
      fontFamily: null, // Используем системный шрифт
      fontFamilyFallback: const [
        'Segoe UI Emoji',
        'Noto Color Emoji',
        'Apple Color Emoji', // Apple как fallback
        'Twemoji Mozilla',
        'Android Emoji',
        'EmojiOne Color',
      ],
      fontSize: fontSize ?? (style.fontSize ?? 14) * 1.0, // Не увеличиваем для fallback
      color: color ?? style.color,
      fontWeight: fontWeight ?? style.fontWeight,
    );
  }

  /// Возвращает TextStyle для Apple эмодзи с fallback логикой
  static TextStyle getEmojiStyleWithFallback({
    required String emoji,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextStyle? baseStyle,
  }) {
    // Если это проблемная ZWJ последовательность - используем fallback
    if (problematicZwjEmojis.contains(emoji) || 
        (isZwjSequence(emoji) && _isLikelyUnsupported(emoji))) {
      return getFallbackEmojiStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        baseStyle: baseStyle,
      );
    }
    
    // Иначе используем Apple шрифт
    return getAppleEmojiStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      baseStyle: baseStyle,
    );
  }

  /// Проверяет, является ли ZWJ последовательность вероятно неподдерживаемой
  static bool _isLikelyUnsupported(String emoji) {
    // Проверяем на наличие новых Unicode символов (стрелки направления)
    final runes = emoji.runes.toList();
    
    for (final rune in runes) {
      // Стрелки направления, которые могут не поддерживаться
      if (rune == 0x2194 || // ↔
          rune == 0x2195 || // ↕
          rune == 0x2196 || // ↖
          rune == 0x2197 || // ↗
          rune == 0x2198 || // ↘
          rune == 0x2199) { // ↙
        return true;
      }
    }
    
    return false;
  }

  /// Список популярных ZWJ эмодзи для демонстрации
  static const List<String> zjwEmojiExamples = [
    '👨‍👩‍👧‍👦',      // семья: мужчина, женщина, девочка, мальчик
    '👨‍👩‍👧',        // семья: мужчина, женщина, девочка
    '👨‍👩‍👦',        // семья: мужчина, женщина, мальчик
    '👩‍👩‍👧‍👦',      // семья: женщина, женщина, девочка, мальчик
    '👨‍👨‍👧‍👦',      // семья: мужчина, мужчина, девочка, мальчик
    '👨‍👩‍👧‍👧',      // семья: мужчина, женщина, девочка, девочка
    '👨‍👩‍👦‍👦',      // семья: мужчина, женщина, мальчик, мальчик
    '👨🏻‍💻',        // мужчина-технолог: светлый тон кожи
    '👩🏾‍🚀',        // женщина-космонавт: темно-средний тон кожи
    '🧑‍💻',          // технолог
    '🧑‍🚀',          // космонавт
    '👨‍⚕️',          // мужчина-медработник
    '👩‍⚕️',          // женщина-медработник
    '👨‍🏫',          // мужчина-учитель
    '👩‍🏫',          // женщина-учитель
    '👨‍🚒',          // мужчина-пожарный
    '👩‍🚒',          // женщина-пожарный
    '🏳️‍🌈',          // радужный флаг
    '🏳️‍⚧️',          // трансгендерный флаг
    '🫱🏻‍🫲🏾',       // рукопожатие: светлый тон кожи, темно-средний тон кожи
    '❤️‍🔥',          // сердце в огне
    '❤️‍🩹',          // заживающее сердце
    '😮‍💨',          // выдыхающее лицо
    '😵‍💫',          // лицо с крестиками в глазах
    '🙂‍↔️',          // кивающее лицо (влево-вправо)
    '🙂‍↕️',          // кивающее лицо (вверх-вниз)
  ];

  /// Получает случайный ZWJ эмодзи
  static String getRandomZjwEmoji() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final index = (now / 1000).round() % zjwEmojiExamples.length;
    return zjwEmojiExamples[index];
  }
}
