import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/emoji_utils.dart';
import '../providers/theme_provider.dart';

/// Демо-виджет для показа различных способов использования iOS-эмодзи
class EmojiDemo extends StatelessWidget {
  const EmojiDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'iOS Эмодзи Демо',
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
              'Способы использования iOS-эмодзи',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),

            // 1. Прямое использование Unicode
            _buildSection(
              context,
              '1. Прямое использование Unicode',
              'Использование эмодзи напрямую в строках:',
              [
                _buildEmojiExample('Улыбка', '😊'),
                _buildEmojiExample('Сердце', '❤️'),
                _buildEmojiExample('Палец вверх', '👍'),
                _buildEmojiExample('Огонь', '🔥'),
                _buildEmojiExample('Ракета', '🚀'),
              ],
            ),

            const SizedBox(height: 32),

            // 2. Использование EmojiUtils
            _buildSection(
              context,
              '2. Через EmojiUtils',
              'Использование утилитарного класса для получения эмодзи:',
              [
                _buildEmojiExample('Улыбка', EmojiUtils.getCommonEmoji('smile')),
                _buildEmojiExample('Сердце', EmojiUtils.getCommonEmoji('heart')),
                _buildEmojiExample('Палец вверх', EmojiUtils.getCommonEmoji('thumbs_up')),
                _buildEmojiExample('Огонь', EmojiUtils.getCommonEmoji('fire')),
                _buildEmojiExample('Ракета', EmojiUtils.getCommonEmoji('rocket')),
              ],
            ),

            const SizedBox(height: 32),

            // 3. Случайные эмодзи по категориям
            _buildSection(
              context,
              '3. Случайные эмодзи по категориям',
              'Генерация случайных эмодзи из разных категорий:',
              [
                _buildEmojiExample('Лица', EmojiUtils.getRandomEmoji('faces')),
                _buildEmojiExample('Сердца', EmojiUtils.getRandomEmoji('hearts')),
                _buildEmojiExample('Животные', EmojiUtils.getRandomEmoji('animals')),
                _buildEmojiExample('Еда', EmojiUtils.getRandomEmoji('food')),
                _buildEmojiExample('Природа', EmojiUtils.getRandomEmoji('nature')),
              ],
            ),

            const SizedBox(height: 32),

            // 4. Конвертация текста
            _buildSection(
              context,
              '4. Конвертация текста в iOS-стиль',
              'Преобразование стандартных эмодзи в более яркие iOS-варианты:',
              [
                _buildEmojiExample(
                  'Оригинал',
                  '😀 ❤️ 👍 🔥 ⭐',
                ),
                _buildEmojiExample(
                  'iOS-стиль',
                  EmojiUtils.convertToIOSStyle('😀 ❤️ 👍 🔥 ⭐'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 5. Проверка наличия эмодзи
            _buildSection(
              context,
              '5. Проверка наличия эмодзи',
              'Утилиты для работы с текстом, содержащим эмодзи:',
              [
                _buildEmojiExample(
                  'Текст с эмодзи',
                  'Привет! 😊 Как дела? 👍',
                ),
                _buildEmojiExample(
                  'Содержит эмодзи',
                  EmojiUtils.hasEmoji('Привет! 😊 Как дела? 👍') ? '✅ Да' : '❌ Нет',
                ),
                _buildEmojiExample(
                  'Текст без эмодзи',
                  'Привет! Как дела?',
                ),
                _buildEmojiExample(
                  'Содержит эмодзи',
                  EmojiUtils.hasEmoji('Привет! Как дела?') ? '✅ Да' : '❌ Нет',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Советы по использованию
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
                    '💡 Советы по использованию iOS-эмодзи:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTip('• Используйте Unicode напрямую для простых случаев'),
                  _buildTip('• EmojiUtils подходит для динамического контента'),
                  _buildTip('• Случайные эмодзи хороши для разнообразия'),
                  _buildTip('• convertToIOSStyle() делает эмодзи ярче'),
                  _buildTip('• hasEmoji() помогает в валидации текста'),
                  _buildTip('• EmojiPicker виджет для пользовательского выбора'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String description, List<Widget> examples) {
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
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          ...examples,
        ],
      ),
    );
  }

  Widget _buildEmojiExample(String label, String emoji) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            emoji,
            style: EmojiUtils.getEmojiTextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
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
