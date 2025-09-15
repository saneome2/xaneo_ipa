import 'package:flutter/material.dart';
import '../utils/emoji_utils.dart';

/// Простой виджет для демонстрации Apple эмодзи
class AppleEmojiDemo extends StatelessWidget {
  const AppleEmojiDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Apple Эмодзи Демо 🎉',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Text(
              'Теперь эмодзи используют Apple шрифт! 🍎',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),

            // Примеры с новым шрифтом
            _buildEmojiShowcase('Лица', ['😀', '😊', '😍', '🤔', '😎', '🥳']),
            const SizedBox(height: 24),
            _buildEmojiShowcase('Сердца', ['❤️', '💛', '💚', '💙', '💜', '🖤']),
            const SizedBox(height: 24),
            _buildEmojiShowcase('Животные', ['🐶', '🐱', '🐼', '🦁', '🐸', '🐵']),
            const SizedBox(height: 24),
            _buildEmojiShowcase('Еда', ['🍎', '🍕', '🍔', '🍦', '☕', '🍰']),
            const SizedBox(height: 24),
            _buildEmojiShowcase('Природа', ['🌸', '🌺', '🌻', '🌴', '🌈', '⭐']),

            const SizedBox(height: 32),

            // Информация о шрифте
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ℹ️ О новом шрифте:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoPoint('• Используется шрифт AppleEmojis.ttf'),
                  _buildInfoPoint('• Эмодзи выглядят как на iOS устройствах'),
                  _buildInfoPoint('• EmojiUtils.getEmojiTextStyle() для стилизации'),
                  _buildInfoPoint('• Работает во всех виджетах приложения'),
                  _buildInfoPoint('• EmojiPicker тоже использует новый шрифт'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiShowcase(String category, List<String> emojis) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: emojis.map((emoji) => Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: EmojiUtils.getEmojiTextStyle(fontSize: 24),
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade300,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
