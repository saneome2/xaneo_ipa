import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/emoji_smileys.dart';
import '../utils/emoji_utils.dart';

/// Кастомный пикер смайликов (только эмоции)
class CustomSmileyPicker extends StatefulWidget {
  final Function(String) onEmojiSelected;
  final VoidCallback? onBackToKeyboard;

  const CustomSmileyPicker({
    super.key,
    required this.onEmojiSelected,
    this.onBackToKeyboard,
  });

  @override
  State<CustomSmileyPicker> createState() => _CustomSmileyPickerState();
}

class _CustomSmileyPickerState extends State<CustomSmileyPicker> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                  'Смайлики',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Сетка смайликов
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8, // 8 смайликов в ряд
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: EmojiSmileys.allSmileys.length,
              itemBuilder: (context, index) {
                final emoji = EmojiSmileys.allSmileys[index];
                return _buildEmojiButton(emoji, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiButton(String emoji, bool isDark) {
    return InkWell(
      onTap: () => widget.onEmojiSelected(emoji),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        ),
        child: Center(
          child: Text(
            emoji,
            style: EmojiUtils.getEmojiTextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}