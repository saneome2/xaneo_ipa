import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'lib/widgets/formatted_text_field.dart';
import 'lib/widgets/formatted_text_controller.dart';
import 'lib/models/formatted_text.dart';

void main() {
  runApp(const TestSelectionApp());
}

class TestSelectionApp extends StatelessWidget {
  const TestSelectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Selection',
      theme: ThemeData.dark(),
      home: const TestSelectionScreen(),
    );
  }
}

class TestSelectionScreen extends StatefulWidget {
  const TestSelectionScreen({super.key});

  @override
  State<TestSelectionScreen> createState() => _TestSelectionScreenState();
}

class _TestSelectionScreenState extends State<TestSelectionScreen> {
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
        title: const Text('Тест выделения'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: PreciseFormattedTextField(
                controller: _controller,
                isDarkTheme: true,
                hintText: 'Введите текст и попробуйте выделить...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                contextMenuBuilder: (context, editableTextState) {
                  print('Context menu builder called!');
                  return _buildSimpleContextMenu(context, editableTextState);
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Информация
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Инструкции:',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Введите текст в поле выше',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '2. Выделите часть текста',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '3. Проверьте, отображаются ли курсоры выделения',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '4. Попробуйте вызвать контекстное меню (долгое нажатие)',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleContextMenu(BuildContext context, EditableTextState editableTextState) {
    final selection = editableTextState.textEditingValue.selection;
    
    print('Building context menu. Selection: $selection');
    
    if (selection.isCollapsed) {
      return const SizedBox.shrink();
    }

    return Material(
      color: Colors.transparent,
      elevation: 8,
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
            ListTile(
              leading: const Icon(Icons.format_bold, color: Colors.white),
              title: const Text('Жирный', style: TextStyle(color: Colors.white)),
              onTap: () {
                print('Bold selected');
                _controller.toggleFormat(FormatType.bold, selection: selection);
                editableTextState.hideToolbar();
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_italic, color: Colors.white),
              title: const Text('Курсив', style: TextStyle(color: Colors.white)),
              onTap: () {
                print('Italic selected');
                _controller.toggleFormat(FormatType.italic, selection: selection);
                editableTextState.hideToolbar();
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.white),
              title: const Text('Копировать', style: TextStyle(color: Colors.white)),
              onTap: () {
                print('Copy selected');
                final selectedText = editableTextState.textEditingValue.text
                    .substring(selection.start, selection.end);
                Clipboard.setData(ClipboardData(text: selectedText));
                editableTextState.hideToolbar();
              },
            ),
          ],
        ),
      ),
    );
  }
}