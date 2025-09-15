import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji_picker;
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

/// Виджет для выбора эмодзи, который заменяет клавиатуру
class EmojiPicker extends StatefulWidget {
  final Function(String) onEmojiSelected;
  final VoidCallback? onBackToKeyboard;

  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
    this.onBackToKeyboard,
  });

  @override
  State<EmojiPicker> createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      color: isDark ? Colors.grey.shade900 : Colors.white,
      child: Column(
        children: [
          // Верхняя панель с кнопкой возврата к клавиатуре
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Кнопка возврата к клавиатуре
                IconButton(
                  icon: Icon(
                    Icons.keyboard,
                    color: isDark ? Colors.white70 : Colors.black54,
                    size: 20,
                  ),
                  onPressed: widget.onBackToKeyboard,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                Text(
                  'Эмодзи',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Стоковый пикер эмодзи
          Expanded(
            child: Builder(
              builder: (context) {
                return emoji_picker.EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    widget.onEmojiSelected(emoji.emoji);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}