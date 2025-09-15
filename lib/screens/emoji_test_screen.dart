import 'package:flutter/material.dart';
import '../widgets/emoji_demo.dart';
import '../widgets/apple_emoji_demo.dart';
import '../widgets/emoji_performance_monitor.dart';
import '../utils/emoji_utils.dart';

/// Тестовый экран для демонстрации iOS-эмодзи
class EmojiTestScreen extends StatelessWidget {
  const EmojiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Тест iOS Эмодзи',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎉 Добро пожаловать в мир iOS-эмодзи! 🎉',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Здесь вы можете увидеть различные способы использования эмодзи в вашем приложении:',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),

            // Примеры использования
            _buildExampleCard(
              'Простое использование',
              '😊 ❤️ 👍 🔥 🚀 ⭐',
            ),

            const SizedBox(height: 16),

            _buildExampleCard(
              'В тексте сообщений',
              'Привет! 😊 Как твои дела? 👍',
            ),

            const SizedBox(height: 16),

            _buildExampleCard(
              'В интерфейсе',
              '❤️ Избранное  •  ⭐ Оценка  •  🔥 Популярное',
            ),

            const SizedBox(height: 16),

            // Кнопка для Apple эмодзи демо
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppleEmojiDemo(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '🍎 Apple Эмодзи Демо',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Кнопка для подробного демо
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmojiDemo(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '📚 Подробное демо',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Кнопка для мониторинга производительности
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmojiPerformanceMonitor(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '📊 Производительность эмодзи',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Советы
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
                    '💡 Полезные советы:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTip('• Эмодзи автоматически адаптируются под платформу'),
                  _buildTip('• Используйте Unicode для лучшей совместимости'),
                  _buildTip('• EmojiUtils помогает с динамическим контентом'),
                  _buildTip('• EmojiPicker для пользовательского выбора'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(String title, String content) {
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
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: _buildTextSpansWithEmoji(content),
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Создает TextSpan'ы с правильными шрифтами для текста и эмодзи
  List<TextSpan> _buildTextSpansWithEmoji(String text) {
    final List<TextSpan> spans = [];
    final emojiRegex = RegExp(r'[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{1F1E0}-\u{1F1FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]', unicode: true);
    
    int lastIndex = 0;
    for (final match in emojiRegex.allMatches(text)) {
      // Добавляем текст до эмодзи
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: const TextStyle(fontFamily: 'Inter'),
        ));
      }
      
      // Добавляем эмодзи с Apple шрифтом
      spans.add(TextSpan(
        text: match.group(0),
        style: EmojiUtils.getEmojiTextStyle(fontSize: 16),
      ));
      
      lastIndex = match.end;
    }
    
    // Добавляем оставшийся текст
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: const TextStyle(fontFamily: 'Inter'),
      ));
    }
    
    return spans;
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
