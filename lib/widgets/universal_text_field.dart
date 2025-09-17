import 'package:flutter/material.dart';
import '../utils/text_parser.dart';

/// Универсальное текстовое поле с поддержкой:
/// - iPhone эмодзи
/// - ZWJ последовательности 
/// - Форматирования текста (жирный, курсив, подчёркнутый)
class UniversalTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? contentPadding;
  final bool enableFormatting;
  final bool enableCustomEmojis;

  const UniversalTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.style,
    this.hintStyle,
    this.maxLines,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.contentPadding,
    this.enableFormatting = true,
    this.enableCustomEmojis = true,
  });

  @override
  State<UniversalTextField> createState() => _UniversalTextFieldState();
}

class _UniversalTextFieldState extends State<UniversalTextField> {
  late FocusNode _focusNode;
  late TextEditingValue _value;
  final Map<String, TextStyle> _formatStyles = {};

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.controller.value;
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
    
    // Инициализируем стили форматирования
    _initFormatStyles();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _initFormatStyles() {
    final baseStyle = widget.style ?? const TextStyle();
    
    _formatStyles['bold'] = baseStyle.copyWith(fontWeight: FontWeight.bold);
    _formatStyles['italic'] = baseStyle.copyWith(fontStyle: FontStyle.italic);
    _formatStyles['underline'] = baseStyle.copyWith(decoration: TextDecoration.underline);
    _formatStyles['strikethrough'] = baseStyle.copyWith(decoration: TextDecoration.lineThrough);
    _formatStyles['code'] = baseStyle.copyWith(
      fontFamily: 'Consolas',
      backgroundColor: Colors.grey.withOpacity(0.2),
    );
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _onTextChange() {
    if (_value != widget.controller.value) {
      setState(() {
        _value = widget.controller.value;
      });
      
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.text);
      }
    }
  }

  /// Парсит текст с форматированием и эмодзи
  List<InlineSpan> _parseFormattedText(String text) {
    if (text.isEmpty) return [];

    final List<InlineSpan> spans = [];
    final baseStyle = widget.style ?? const TextStyle();
    
    // Регулярные выражения для форматирования
    final formatRegexes = {
      'bold': RegExp(r'\*\*(.*?)\*\*'),
      'italic': RegExp(r'\*(.*?)\*'),
      'underline': RegExp(r'__(.*?)__'),
      'strikethrough': RegExp(r'~~(.*?)~~'),
      'code': RegExp(r'`(.*?)`'),
    };

    String remainingText = text;

    while (remainingText.isNotEmpty) {
      RegExpMatch? earliestMatch;
      String? earliestFormat;
      
      // Находим самое раннее форматирование
      for (final entry in formatRegexes.entries) {
        final match = entry.value.firstMatch(remainingText);
        if (match != null) {
          if (earliestMatch == null || match.start < earliestMatch.start) {
            earliestMatch = match;
            earliestFormat = entry.key;
          }
        }
      }

      if (earliestMatch != null && earliestFormat != null) {
        // Добавляем текст до форматирования
        if (earliestMatch.start > 0) {
          final beforeText = remainingText.substring(0, earliestMatch.start);
          spans.addAll(_parseTextWithEmojis(beforeText, baseStyle));
        }

        // Добавляем форматированный текст
        final formattedContent = earliestMatch.group(1) ?? '';
        final formattedStyle = _formatStyles[earliestFormat] ?? baseStyle;
        spans.addAll(_parseTextWithEmojis(formattedContent, formattedStyle));

        // Обновляем оставшийся текст
        remainingText = remainingText.substring(earliestMatch.end);
      } else {
        // Нет больше форматирования, добавляем оставшийся текст
        spans.addAll(_parseTextWithEmojis(remainingText, baseStyle));
        break;
      }
    }

    return spans;
  }

  /// Парсит текст с эмодзи (с поддержкой Apple эмодзи если включено)
  List<InlineSpan> _parseTextWithEmojis(String text, TextStyle style) {
    if (!widget.enableCustomEmojis) {
      return [TextSpan(text: text, style: style)];
    }

    return TextParser.parseTextWithEmojis(
      text: text,
      textStyle: style,
    );
  }

  /// Добавляет форматирование к выделенному тексту
  /*
  void _applyFormatting(String formatType) {
    if (!widget.enableFormatting) return;

    final selection = widget.controller.selection;
    if (!selection.isValid || selection.isCollapsed) return;

    final text = widget.controller.text;
    final selectedText = selection.textInside(text);
    final beforeText = selection.textBefore(text);
    final afterText = selection.textAfter(text);

    String formattedText;
    int newCursorPos;

    switch (formatType) {
      case 'bold':
        formattedText = '**$selectedText**';
        newCursorPos = beforeText.length + formattedText.length;
        break;
      case 'italic':
        formattedText = '*$selectedText*';
        newCursorPos = beforeText.length + formattedText.length;
        break;
      case 'underline':
        formattedText = '__${selectedText}__';
        newCursorPos = beforeText.length + formattedText.length;
        break;
      case 'strikethrough':
        formattedText = '~~$selectedText~~';
        newCursorPos = beforeText.length + formattedText.length;
        break;
      case 'code':
        formattedText = '`$selectedText`';
        newCursorPos = beforeText.length + formattedText.length;
        break;
      default:
        return;
    }

    final newText = beforeText + formattedText + afterText;
    widget.controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ?? Theme.of(context).textTheme.bodyMedium!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Панель форматирования (временно отключена)
        /*
        if (widget.enableFormatting && _focusNode.hasFocus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFormatButton('B', 'bold', FontWeight.bold),
                _buildFormatButton('I', 'italic', FontStyle.italic),
                _buildFormatButton('U', 'underline', TextDecoration.underline),
                _buildFormatButton('S', 'strikethrough', TextDecoration.lineThrough),
                _buildFormatButton('</>', 'code', null),
              ],
            ),
          ),
        */
        
        const SizedBox(height: 4),
        
        // Основное поле ввода
        Container(
          padding: widget.contentPadding ?? EdgeInsets.zero,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: defaultStyle,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              isDense: true,
            ),
            cursorColor: defaultStyle.color,
            enableInteractiveSelection: true,
            smartDashesType: SmartDashesType.enabled,
            smartQuotesType: SmartQuotesType.enabled,
          ),
        ),
      ],
    );
  }

  /*
  Widget _buildFormatButton(String label, String formatType, dynamic style) {
    return GestureDetector(
      onTap: () => _applyFormatting(formatType),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: style is FontWeight ? style : FontWeight.normal,
            fontStyle: style is FontStyle ? style : FontStyle.normal,
            decoration: style is TextDecoration ? style : TextDecoration.none,
          ),
        ),
      ),
    );
  }
  */
}
