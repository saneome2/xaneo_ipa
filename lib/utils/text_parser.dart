import 'package:flutter/material.dart';
import 'emoji_utils.dart';

class TextParser {
  // Полная поддержка всех Unicode эмодзи включая ZWJ последовательности
  static final RegExp _emojiRegex = RegExp(
    r'(?:'
    // ZWJ последовательности (составные эмодзи)
    r'(?:\p{Emoji_Presentation}|\p{Emoji}\uFE0F)(?:\u200D(?:\p{Emoji_Presentation}|\p{Emoji}\uFE0F))*'
    r'|'
    // Одиночные эмодзи с модификаторами тона кожи
    r'(?:\p{Emoji_Presentation}|\p{Emoji}\uFE0F)[\p{Emoji_Modifier}]?'
    r'|'
    // Флаги (региональные индикаторы)
    r'[\u{1F1E6}-\u{1F1FF}]{2}'
    r'|'
    // Keycap последовательности
    r'[0-9#*]\uFE0F?\u20E3'
    r'|'
    // Skin tone модификаторы
    r'[\u{1F3FB}-\u{1F3FF}]'
    r'|'
    // Базовые эмодзи
    r'[\u{1F600}-\u{1F64F}]|'  // эмоции
    r'[\u{1F300}-\u{1F5FF}]|'  // символы и пиктограммы
    r'[\u{1F680}-\u{1F6FF}]|'  // транспорт
    r'[\u{1F700}-\u{1F77F}]|'  // алхимические символы
    r'[\u{1F780}-\u{1F7FF}]|'  // геометрические фигуры расширенные
    r'[\u{1F800}-\u{1F8FF}]|'  // дополнительные стрелки-C
    r'[\u{1F900}-\u{1F9FF}]|'  // дополнительные символы и пиктограммы
    r'[\u{1FA00}-\u{1FA6F}]|'  // шахматные символы
    r'[\u{1FA70}-\u{1FAFF}]|'  // символы и пиктограммы расширенные-A
    r'[\u{2600}-\u{26FF}]|'    // разные символы
    r'[\u{2700}-\u{27BF}]|'    // дингбаты
    r'[\u{FE00}-\u{FE0F}]|'    // селекторы вариантов
    r'[\u{1F004}]|'            // красный дракон маджонг
    r'[\u{1F0CF}]|'            // джокер
    r'[\u{1F170}-\u{1F251}]'   // квадратные латинские буквы
    r')',
    unicode: true,
    multiLine: true,
  );

  /// Базовый регекс для эмодзи (более надежный)
  static final RegExp _basicEmojiRegex = RegExp(
    r'[\u{1F600}-\u{1F64F}]|'  // эмоции
    r'[\u{1F300}-\u{1F5FF}]|'  // символы и пиктограммы
    r'[\u{1F680}-\u{1F6FF}]|'  // транспорт
    r'[\u{1F700}-\u{1F77F}]|'  // алхимические символы
    r'[\u{1F780}-\u{1F7FF}]|'  // геометрические фигуры расширенные
    r'[\u{1F800}-\u{1F8FF}]|'  // дополнительные стрелки-C
    r'[\u{1F900}-\u{1F9FF}]|'  // дополнительные символы и пиктограммы
    r'[\u{1FA00}-\u{1FA6F}]|'  // шахматные символы
    r'[\u{1FA70}-\u{1FAFF}]|'  // символы и пиктограммы расширенные-A
    r'[\u{2600}-\u{26FF}]|'    // разные символы
    r'[\u{2700}-\u{27BF}]|'    // дингбаты
    r'[\u{1F1E6}-\u{1F1FF}]',  // региональные индикаторы (флаги)
    unicode: true,
  );

  /// Продвинутый парсинг текста с полной поддержкой эмодзи
  static List<InlineSpan> parseTextWithEmojis({
    required String text, 
    required TextStyle textStyle,
  }) {
    final List<InlineSpan> spans = [];
    
    if (text.isEmpty) {
      return spans;
    }

    // Используем библиотеку characters для правильной обработки графем включая ZWJ
    final characters = text.characters;
    String currentText = '';
    
    for (final char in characters) {
      // Проверяем, содержит ли графема эмодзи (включая ZWJ последовательности)
      bool isEmojiGrapheme = _isEmojiGrapheme(char);
      
      if (isEmojiGrapheme) {
        // Если есть накопленный текст, добавляем его
        if (currentText.isNotEmpty) {
          spans.add(TextSpan(text: currentText, style: textStyle));
          currentText = '';
        }
        
        // Добавляем эмодзи с Apple шрифтом или fallback для проблемных ZWJ
        spans.add(TextSpan(
          text: char,
          style: EmojiUtils.getEmojiStyleWithFallback(
            emoji: char,
            baseStyle: textStyle,
            fontSize: (textStyle.fontSize ?? 14) * 1.1,
          ),
        ));
      } else {
        currentText += char;
      }
    }
    
    // Добавляем оставшийся текст
    if (currentText.isNotEmpty) {
      spans.add(TextSpan(text: currentText, style: textStyle));
    }
    
    return spans;
  }

  /// Проверяет, является ли графема эмодзи (включая ZWJ последовательности)
  static bool _isEmojiGrapheme(String grapheme) {
    if (grapheme.isEmpty) return false;
    
    // Проверяем все коды в графеме
    final runes = grapheme.runes.toList();
    
    // Если есть хотя бы один эмодзи код - считаем графему эмодзи
    bool hasEmojiRune = false;
    bool hasZWJ = false;
    
    for (final rune in runes) {
      if (_isEmojiByRange(rune)) {
        hasEmojiRune = true;
      }
      if (rune == 0x200D) { // ZWJ
        hasZWJ = true;
      }
    }
    
    // Графема считается эмодзи если:
    // 1. Содержит коды эмодзи
    // 2. Или содержит ZWJ (значит это ZWJ последовательность)
    return hasEmojiRune || hasZWJ;
  }

  /// Упрощенная проверка эмодзи по Unicode кодам
  static bool _isEmojiByRange(int codePoint) {
    return EmojiUtils.isEmoji(codePoint);
  }

  /// Простой парсинг с базовым регексом (fallback)
  static List<InlineSpan> parseTextWithEmojisSimple({
    required String text, 
    required TextStyle textStyle,
  }) {
    final List<InlineSpan> spans = [];
    
    if (text.isEmpty) {
      return spans;
    }
    
    final matches = _emojiRegex.allMatches(text);
    
    if (matches.isEmpty) {
      spans.add(TextSpan(text: text, style: textStyle));
      return spans;
    }
    
    int lastIndex = 0;
    
    for (final match in matches) {
      // Добавляем текст до эмодзи
      if (match.start > lastIndex) {
        final beforeText = text.substring(lastIndex, match.start);
        spans.add(TextSpan(text: beforeText, style: textStyle));
      }
      
      // Добавляем эмодзи с iPhone шрифтом или fallback
      final emoji = text.substring(match.start, match.end);
      spans.add(TextSpan(
        text: emoji,
        style: EmojiUtils.getEmojiStyleWithFallback(
          emoji: emoji,
          baseStyle: textStyle,
          fontSize: (textStyle.fontSize ?? 14) * 1.1,
        ),
      ));
      
      lastIndex = match.end;
    }
    
    // Добавляем оставшийся текст
    if (lastIndex < text.length) {
      final remainingText = text.substring(lastIndex);
      spans.add(TextSpan(text: remainingText, style: textStyle));
    }
    
    return spans;
  }
  
  /// Анализирует строку на наличие эмодзи (для отладки)
  static void debugEmojis(String text) {
    print('=== EMOJI DEBUG ===');
    print('Text: "$text"');
    print('Length: ${text.length}');
    print('Characters count: ${text.characters.length}');
    print('Runes: ${text.runes.map((r) => 'U+${r.toRadixString(16).toUpperCase().padLeft(4, '0')}').join(' ')}');
    
    final matches = _basicEmojiRegex.allMatches(text);
    print('Basic emoji matches: ${matches.length}');
    
    for (final match in matches) {
      final emoji = text.substring(match.start, match.end);
      print('  - Emoji: "$emoji" at ${match.start}-${match.end}');
      print('    Length: ${emoji.length} characters, ${emoji.characters.length} graphemes');
      print('    Runes: ${emoji.runes.map((r) => 'U+${r.toRadixString(16).toUpperCase().padLeft(4, '0')}').join(' ')}');
    }

    print('Characters analysis:');
    for (int i = 0; i < text.characters.length; i++) {
      final char = text.characters.elementAt(i);
      final isEmoji = _isEmojiGrapheme(char);
      final runes = char.runes.map((r) => 'U+${r.toRadixString(16).toUpperCase().padLeft(4, '0')}').join(' ');
      print('  [$i] "$char" - ${isEmoji ? 'EMOJI' : 'TEXT'} ($runes)');
    }
    
    print('=================');
  }

  /// Подсчитывает количество видимых символов (графем)
  static int countVisibleCharacters(String text) {
    return text.characters.length;
  }

  /// Обрезает текст по количеству видимых символов
  static String truncateByCharacters(String text, int maxLength) {
    if (text.characters.length <= maxLength) {
      return text;
    }
    return '${text.characters.take(maxLength)}...';
  }
}
