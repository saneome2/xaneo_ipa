import 'package:flutter/material.dart';
import '../widgets/formatted_text_field.dart';
import '../widgets/formatted_text_controller.dart';
import '../models/formatted_text.dart';

class FormattingTestScreen extends StatefulWidget {
  const FormattingTestScreen({super.key});

  @override
  State<FormattingTestScreen> createState() => _FormattingTestScreenState();
}

class _FormattingTestScreenState extends State<FormattingTestScreen> {
  late FormattedTextController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormattedTextController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Тест форматирования', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Форматированное текстовое поле
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: PreciseFormattedTextField(
                controller: _controller,
                isDarkTheme: true,
                hintText: 'Введите текст для форматирования...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                contextMenuBuilder: (context, editableTextState) {
                  return _buildTestContextMenu(context, editableTextState);
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Кнопки для тестирования форматирования
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _testFormat(FormatType.bold),
                  icon: const Icon(Icons.format_bold, size: 16),
                  label: const Text('Bold'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _testFormat(FormatType.italic),
                  icon: const Icon(Icons.format_italic, size: 16),
                  label: const Text('Italic'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _testFormat(FormatType.underline),
                  icon: const Icon(Icons.format_underlined, size: 16),
                  label: const Text('Underline'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _testFormat(FormatType.strikethrough),
                  icon: const Icon(Icons.format_strikethrough, size: 16),
                  label: const Text('Strike'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Отображение состояния
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListenableBuilder(
                listenable: _controller,
                builder: (context, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plain text: "${_controller.plainText}"',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Format ranges: ${_controller.formatRanges.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      if (_controller.formatRanges.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        ...(_controller.formatRanges.map((range) => Text(
                          '  ${range.start}-${range.end}: ${range.type.name}',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        ))),
                      ],
                    ],
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Превью форматированного текста
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preview:',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      if (_controller.plainText.isEmpty) {
                        return Text(
                          'Текст отсутствует',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                        );
                      }
                      
                      return RichText(
                        text: _controller.buildTextSpan(
                          baseStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          isDarkTheme: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _testFormat(FormatType formatType) {
    // Применяем форматирование к выделенному тексту
    _controller.toggleFormat(formatType);
  }

  Widget _buildTestContextMenu(BuildContext context, EditableTextState editableTextState) {
    final selection = editableTextState.textEditingValue.selection;
    final hasSelection = !selection.isCollapsed;

    if (!hasSelection) {
      return const SizedBox.shrink();
    }

    return Material(
      color: Colors.transparent,
      elevation: 12,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContextMenuItem(
              icon: Icons.format_bold,
              text: 'Жирный',
              onPressed: () {
                _controller.toggleFormat(FormatType.bold, selection: selection);
                editableTextState.hideToolbar();
              },
            ),
            _buildContextMenuItem(
              icon: Icons.format_italic,
              text: 'Курсив',
              onPressed: () {
                _controller.toggleFormat(FormatType.italic, selection: selection);
                editableTextState.hideToolbar();
              },
            ),
            _buildContextMenuItem(
              icon: Icons.format_underlined,
              text: 'Подчёркнутый',
              onPressed: () {
                _controller.toggleFormat(FormatType.underline, selection: selection);
                editableTextState.hideToolbar();
              },
            ),
            _buildContextMenuItem(
              icon: Icons.format_strikethrough,
              text: 'Зачёркнутый',
              onPressed: () {
                _controller.toggleFormat(FormatType.strikethrough, selection: selection);
                editableTextState.hideToolbar();
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.vertical(
        bottom: isLast ? const Radius.circular(8) : Radius.zero,
      ),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: !isLast ? Border(
            bottom: BorderSide(color: Colors.grey.shade600, width: 0.5),
          ) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white70),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}