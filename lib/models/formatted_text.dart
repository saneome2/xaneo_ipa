import 'package:flutter/material.dart';

/// Перечисление типов форматирования текста
enum FormatType {
  bold,      // жирный
  italic,    // курсив
  underline, // подчёркнутый
  strikethrough, // зачёркнутый
}

/// Класс для описания диапазона форматирования в тексте
class TextFormatRange {
  final int start;    // начальная позиция
  final int end;      // конечная позиция
  final FormatType type; // тип форматирования

  const TextFormatRange({
    required this.start,
    required this.end,
    required this.type,
  });

  /// Проверяет, пересекается ли этот диапазон с другим
  bool overlaps(TextFormatRange other) {
    return start < other.end && end > other.start;
  }

  /// Проверяет, содержит ли этот диапазон указанную позицию
  bool contains(int position) {
    return position >= start && position < end;
  }

  /// Создаёт копию с новыми параметрами
  TextFormatRange copyWith({
    int? start,
    int? end,
    FormatType? type,
  }) {
    return TextFormatRange(
      start: start ?? this.start,
      end: end ?? this.end,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'TextFormatRange(start: $start, end: $end, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextFormatRange &&
        other.start == start &&
        other.end == end &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(start, end, type);
}

/// Класс для хранения форматированного текста
class FormattedText {
  final String plainText;
  final List<TextFormatRange> formatRanges;

  const FormattedText({
    required this.plainText,
    this.formatRanges = const [],
  });

  /// Создаёт простой неформатированный текст
  FormattedText.plain(String text) 
    : plainText = text,
      formatRanges = const [];

  /// Применяет форматирование к указанному диапазону
  FormattedText applyFormat(int start, int end, FormatType formatType) {
    if (start >= end || start < 0 || end > plainText.length) {
      return this; // Некорректный диапазон
    }

    final newRanges = List<TextFormatRange>.from(formatRanges);
    
    // Удаляем существующие диапазоны того же типа, которые пересекаются
    newRanges.removeWhere((range) => 
      range.type == formatType && range.overlaps(TextFormatRange(
        start: start, 
        end: end, 
        type: formatType
      ))
    );

    // Добавляем новый диапазон
    newRanges.add(TextFormatRange(
      start: start,
      end: end,
      type: formatType,
    ));

    return FormattedText(
      plainText: plainText,
      formatRanges: newRanges,
    );
  }

  /// Удаляет форматирование указанного типа с диапазона
  FormattedText removeFormat(int start, int end, FormatType formatType) {
    if (start >= end || start < 0 || end > plainText.length) {
      return this;
    }

    final newRanges = <TextFormatRange>[];
    
    for (final range in formatRanges) {
      if (range.type != formatType) {
        // Оставляем диапазоны других типов как есть
        newRanges.add(range);
      } else {
        // Обрабатываем диапазоны того же типа
        if (!range.overlaps(TextFormatRange(start: start, end: end, type: formatType))) {
          // Диапазон не пересекается - оставляем как есть
          newRanges.add(range);
        } else {
          // Диапазон пересекается - разбиваем его
          if (range.start < start) {
            // Добавляем часть до удаляемого диапазона
            newRanges.add(range.copyWith(end: start));
          }
          if (range.end > end) {
            // Добавляем часть после удаляемого диапазона
            newRanges.add(range.copyWith(start: end));
          }
        }
      }
    }

    return FormattedText(
      plainText: plainText,
      formatRanges: newRanges,
    );
  }

  /// Переключает форматирование (применяет если нет, удаляет если есть)
  FormattedText toggleFormat(int start, int end, FormatType formatType) {
    if (start >= end || start < 0 || end > plainText.length) {
      return this;
    }

    // Проверяем, есть ли уже такое форматирование в диапазоне
    final hasFormat = formatRanges.any((range) => 
      range.type == formatType && 
      range.start <= start && 
      range.end >= end
    );

    if (hasFormat) {
      return removeFormat(start, end, formatType);
    } else {
      return applyFormat(start, end, formatType);
    }
  }

  /// Обновляет текст и корректирует диапазоны форматирования
  FormattedText updateText(String newText) {
    if (newText == plainText) return this;

    // Простая реализация: сохраняем форматирование только если текст не сильно изменился
    if (newText.length == plainText.length) {
      // Длина не изменилась - сохраняем все диапазоны
      return FormattedText(
        plainText: newText,
        formatRanges: formatRanges,
      );
    } else {
      // Длина изменилась - фильтруем диапазоны, которые выходят за пределы
      final validRanges = formatRanges
          .where((range) => range.end <= newText.length)
          .toList();
      
      return FormattedText(
        plainText: newText,
        formatRanges: validRanges,
      );
    }
  }

  /// Конвертирует в TextSpan для отображения
  TextSpan toTextSpan({required TextStyle baseStyle, required bool isDarkTheme}) {
    if (formatRanges.isEmpty) {
      return TextSpan(
        text: plainText,
        style: baseStyle,
      );
    }

    final List<TextSpan> spans = [];

    // Сортируем диапазоны по начальной позиции
    final sortedRanges = List<TextFormatRange>.from(formatRanges)
      ..sort((a, b) => a.start.compareTo(b.start));

    for (int i = 0; i < plainText.length; ) {
      // Находим все активные форматирования в текущей позиции
      final activeFormats = <FormatType>{};
      int nextChangePosition = plainText.length;

      for (final range in sortedRanges) {
        if (range.contains(i)) {
          activeFormats.add(range.type);
        }
        if (range.start > i && range.start < nextChangePosition) {
          nextChangePosition = range.start;
        }
        if (range.end > i && range.end < nextChangePosition) {
          nextChangePosition = range.end;
        }
      }

      // Создаём стиль для текущего сегмента
      final segmentStyle = _buildStyleForFormats(baseStyle, activeFormats, isDarkTheme);
      
      // Добавляем сегмент текста
      final segmentText = plainText.substring(i, nextChangePosition);
      spans.add(TextSpan(
        text: segmentText,
        style: segmentStyle,
      ));

      i = nextChangePosition;
    }

    return TextSpan(children: spans);
  }

  /// Создаёт стиль на основе активных форматирований
  TextStyle _buildStyleForFormats(TextStyle baseStyle, Set<FormatType> formats, bool isDarkTheme) {
    TextStyle style = baseStyle;

    for (final format in formats) {
      switch (format) {
        case FormatType.bold:
          style = style.copyWith(fontWeight: FontWeight.bold);
          break;
        case FormatType.italic:
          style = style.copyWith(fontStyle: FontStyle.italic);
          break;
        case FormatType.underline:
          style = style.copyWith(
            decoration: TextDecoration.combine([
              style.decoration ?? TextDecoration.none,
              TextDecoration.underline,
            ]),
          );
          break;
        case FormatType.strikethrough:
          style = style.copyWith(
            decoration: TextDecoration.combine([
              style.decoration ?? TextDecoration.none,
              TextDecoration.lineThrough,
            ]),
          );
          break;
      }
    }

    return style;
  }

  /// Получает активные форматирования в указанной позиции
  Set<FormatType> getActiveFormatsAt(int position) {
    return formatRanges
        .where((range) => range.contains(position))
        .map((range) => range.type)
        .toSet();
  }

  /// Получает активные форматирования в указанном диапазоне
  Set<FormatType> getActiveFormatsInRange(int start, int end) {
    final formats = <FormatType>{};
    
    for (final range in formatRanges) {
      if (range.start <= start && range.end >= end) {
        formats.add(range.type);
      }
    }
    
    return formats;
  }

  @override
  String toString() {
    return 'FormattedText(plainText: "$plainText", formatRanges: $formatRanges)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormattedText &&
        other.plainText == plainText &&
        other.formatRanges.length == formatRanges.length &&
        other.formatRanges.every((range) => formatRanges.contains(range));
  }

  @override
  int get hashCode => Object.hash(plainText, formatRanges);
}