import 'package:flutter/material.dart';
import '../utils/emoji_utils.dart';
import '../services/emoji_loader_service.dart';

/// Виджет для мониторинга производительности эмодзи загрузки
class EmojiPerformanceMonitor extends StatefulWidget {
  const EmojiPerformanceMonitor({super.key});

  @override
  State<EmojiPerformanceMonitor> createState() => _EmojiPerformanceMonitorState();
}

class _EmojiPerformanceMonitorState extends State<EmojiPerformanceMonitor> {
  Map<String, int> _cacheInfo = {};
  Map<String, dynamic> _fontStatus = {};

  @override
  void initState() {
    super.initState();
    _updateStats();
  }

  void _updateStats() {
    setState(() {
      _cacheInfo = EmojiUtils.getCacheInfo();
      _fontStatus = EmojiLoaderService.getStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '📊 Производительность Эмодзи',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _updateStats,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Информация о кэше эмодзи
            _buildInfoCard(
              'Кэш эмодзи',
              [
                'Размер кэша эмодзи: ${_cacheInfo['emoji_cache_size'] ?? 0}',
                'Размер кэша стилей: ${_cacheInfo['style_cache_size'] ?? 0}',
              ],
              Colors.blue,
            ),
            
            const SizedBox(height: 16),
            
            // Информация о шрифте
            _buildInfoCard(
              'Кастомный Emoji шрифт',
              [
                'Статус: ${_fontStatus['isLoaded'] == true ? '✅ Загружен' : '❌ Не загружен'}',
                'Размер: ${_fontStatus['fontSizeKB'] ?? '0'} KB',
                'Кэш: ${_fontStatus['cacheStatus'] ?? 'unknown'}',
              ],
              Colors.green,
            ),
            
            const SizedBox(height: 16),
            
            // Действия для оптимизации
            _buildActionCard(),
            
            const SizedBox(height: 16),
            
            // Тест производительности
            _buildPerformanceTest(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> info, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          ...info.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              item,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionCard() {
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
            '🛠️ Действия',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    EmojiUtils.clearCache();
                    _updateStats();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Кэш очищен')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Очистить кэш',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    EmojiUtils.preloadEmojis();
                    _updateStats();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Кэш обновлен')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Обновить кэш',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTest() {
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
            '⚡ Тест производительности',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Часто используемые эмодзи:',
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'smile', 'heart', 'fire', 'star', 'rocket', 'check'
            ].map((type) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                EmojiUtils.getCommonEmoji(type),
                style: EmojiUtils.getEmojiTextStyle(fontSize: 20),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
