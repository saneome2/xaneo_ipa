import 'package:flutter/material.dart';
import '../models/formatted_text.dart';

/// Контроллер для управления форматированием текста в TextField
class FormattedTextController extends ChangeNotifier {
  FormattedText _formattedText = FormattedText.plain('');
  TextEditingController? _textController;
  
  /// Получение текущего форматированного текста
  FormattedText get formattedText => _formattedText;
  
  /// Получение обычного текста без форматирования
  String get plainText => _formattedText.plainText;
  
  /// Получение списка диапазонов форматирования
  List<TextFormatRange> get formatRanges => _formattedText.formatRanges;
  
  /// Привязка к TextEditingController
  void attachTextController(TextEditingController controller) {
    _textController = controller;
    
    // Синхронизируем начальный текст
    if (controller.text != _formattedText.plainText) {
      _updateText(controller.text);
    }
    
    // Слушаем изменения в TextEditingController
    controller.addListener(_onTextControllerChanged);
  }
  
  /// Отвязка от TextEditingController
  void detachTextController() {
    _textController?.removeListener(_onTextControllerChanged);
    _textController = null;
  }
  
  /// Обработчик изменений в TextEditingController
  void _onTextControllerChanged() {
    if (_textController == null) return;
    
    final newText = _textController!.text;
    if (newText != _formattedText.plainText) {
      _updateText(newText);
    }
  }
  
  /// Обновление текста с сохранением форматирования
  void _updateText(String newText) {
    _formattedText = _formattedText.updateText(newText);
    notifyListeners();
  }
  
  /// Установка текста (сбрасывает форматирование)
  void setText(String text) {
    _formattedText = FormattedText.plain(text);
    
    // Обновляем TextEditingController если он привязан
    if (_textController != null && _textController!.text != text) {
      _textController!.removeListener(_onTextControllerChanged);
      _textController!.text = text;
      _textController!.addListener(_onTextControllerChanged);
    }
    
    notifyListeners();
  }
  
  /// Очистка текста и форматирования
  void clear() {
    setText('');
  }
  
  /// Применение форматирования к выделенному тексту
  void applyFormat(FormatType formatType, {TextSelection? selection}) {
    selection ??= _textController?.selection ?? const TextSelection.collapsed(offset: 0);
    
    if (selection.isCollapsed) {
      return; // Нет выделения
    }
    
    final start = selection.start;
    final end = selection.end;
    
    _formattedText = _formattedText.applyFormat(start, end, formatType);
    notifyListeners();
  }
  
  /// Удаление форматирования с выделенного текста
  void removeFormat(FormatType formatType, {TextSelection? selection}) {
    selection ??= _textController?.selection ?? const TextSelection.collapsed(offset: 0);
    
    if (selection.isCollapsed) {
      return; // Нет выделения
    }
    
    final start = selection.start;
    final end = selection.end;
    
    _formattedText = _formattedText.removeFormat(start, end, formatType);
    notifyListeners();
  }
  
  /// Переключение форматирования (применяет если нет, убирает если есть)
  void toggleFormat(FormatType formatType, {TextSelection? selection}) {
    selection ??= _textController?.selection ?? const TextSelection.collapsed(offset: 0);
    
    if (selection.isCollapsed) {
      return; // Нет выделения
    }
    
    final start = selection.start;
    final end = selection.end;
    
    _formattedText = _formattedText.toggleFormat(start, end, formatType);
    notifyListeners();
  }
  
  /// Проверка, активно ли форматирование в выделенном тексте
  bool isFormatActive(FormatType formatType, {TextSelection? selection}) {
    selection ??= _textController?.selection ?? const TextSelection.collapsed(offset: 0);
    
    if (selection.isCollapsed) {
      // Для курсора проверяем позицию
      if (selection.baseOffset > 0) {
        return _formattedText.getActiveFormatsAt(selection.baseOffset - 1).contains(formatType);
      }
      return false;
    }
    
    // Для выделения проверяем, покрывает ли форматирование весь диапазон
    final activeFormats = _formattedText.getActiveFormatsInRange(selection.start, selection.end);
    return activeFormats.contains(formatType);
  }
  
  /// Получение активных форматирований в текущей позиции курсора
  Set<FormatType> getActiveFormats({TextSelection? selection}) {
    selection ??= _textController?.selection ?? const TextSelection.collapsed(offset: 0);
    
    if (selection.isCollapsed) {
      // Для курсора получаем форматирование предыдущего символа
      if (selection.baseOffset > 0) {
        return _formattedText.getActiveFormatsAt(selection.baseOffset - 1);
      }
      return {};
    }
    
    // Для выделения получаем пересечение всех активных форматирований
    return _formattedText.getActiveFormatsInRange(selection.start, selection.end);
  }
  
  /// Конвертация в TextSpan для отображения
  TextSpan buildTextSpan({
    required TextStyle baseStyle, 
    required bool isDarkTheme,
  }) {
    return _formattedText.toTextSpan(
      baseStyle: baseStyle,
      isDarkTheme: isDarkTheme,
    );
  }
  
  /// Копирование форматированного текста
  FormattedTextController copy() {
    final controller = FormattedTextController();
    controller._formattedText = FormattedText(
      plainText: _formattedText.plainText,
      formatRanges: List.from(_formattedText.formatRanges),
    );
    return controller;
  }
  
  /// Установка форматированного текста
  void setFormattedText(FormattedText formattedText) {
    _formattedText = formattedText;
    
    // Обновляем TextEditingController если он привязан
    if (_textController != null && _textController!.text != formattedText.plainText) {
      _textController!.removeListener(_onTextControllerChanged);
      _textController!.text = formattedText.plainText;
      _textController!.addListener(_onTextControllerChanged);
    }
    
    notifyListeners();
  }
  
  /// Вставка текста в позицию курсора (с сохранением форматирования)
  void insertText(String text, {TextSelection? selection}) {
    selection ??= _textController?.selection ?? TextSelection.collapsed(offset: plainText.length);
    
    final offset = selection.baseOffset;
    final newText = plainText.substring(0, offset) + text + plainText.substring(offset);
    
    // Обновляем форматированный текст
    final newFormattedText = _formattedText.updateText(newText);
    
    // Сдвигаем диапазоны форматирования, которые находятся после позиции вставки
    final adjustedRanges = newFormattedText.formatRanges.map((range) {
      if (range.start >= offset) {
        return range.copyWith(
          start: range.start + text.length,
          end: range.end + text.length,
        );
      } else if (range.end > offset) {
        return range.copyWith(
          end: range.end + text.length,
        );
      }
      return range;
    }).toList();
    
    _formattedText = FormattedText(
      plainText: newText,
      formatRanges: adjustedRanges,
    );
    
    // Обновляем TextEditingController
    if (_textController != null) {
      _textController!.removeListener(_onTextControllerChanged);
      _textController!.text = newText;
      _textController!.selection = TextSelection.collapsed(offset: offset + text.length);
      _textController!.addListener(_onTextControllerChanged);
    }
    
    notifyListeners();
  }
  
  @override
  void dispose() {
    detachTextController();
    super.dispose();
  }
}