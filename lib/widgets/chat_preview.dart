import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'message_templates.dart';
import 'wallpaper_templates.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../providers/chat_settings_provider.dart';

class ChatPreview extends StatelessWidget {
  final double fontSize;
  final bool isDarkTheme;
  final Color messageBubbleColor;
  final Color receivedBubbleColor;
  final WallpaperTemplate? wallpaper;

  const ChatPreview({
    super.key,
    this.fontSize = 16.0,
    this.isDarkTheme = true,
    this.messageBubbleColor = const Color(0xFF007AFF),
    this.receivedBubbleColor = const Color(0xFF3A3A3C),
    this.wallpaper,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final backgroundColor = isDarkTheme ? Colors.black : Colors.white;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final defaultWallpaper = SolidWallpaper(
      isDarkTheme: isDarkTheme,
      color: backgroundColor,
    );

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade700.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Обои чата
            Positioned.fill(
              child: wallpaper ?? defaultWallpaper,
            ),
            
            // Содержимое чата
            Column(
              children: [
                // Заголовок чата
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkTheme 
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.9),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade700.withOpacity(0.3),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue.shade600,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Demo User',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            l10n.onlineStatus,
                            style: TextStyle(
                              color: Colors.green.shade400,
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Сообщения
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      
                      // Разделитель даты
                      DateSeparator(date: l10n.demoDateSeparator),
                      
                      // Группа сообщений
                      MessageBubble(
                        text: l10n.demoMessage1,
                        isSent: false,
                        fontSize: fontSize,
                        bubbleColor: receivedBubbleColor,
                        textColor: isDarkTheme ? Colors.white : Colors.black,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      MessageBubble(
                        text: l10n.demoMessage2,
                        isSent: true,
                        fontSize: fontSize,
                        bubbleColor: messageBubbleColor,
                        textColor: Colors.white,
                        timestamp: '14:32',
                      ),
                      
                      const SizedBox(height: 4),
                      
                      MessageBubble(
                        text: l10n.demoMessage3,
                        isSent: false,
                        fontSize: fontSize,
                        bubbleColor: receivedBubbleColor,
                        textColor: isDarkTheme ? Colors.white : Colors.black,
                        timestamp: '14:35',
                      ),
                      
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет для настроек сообщений
class ChatSettingsContent extends StatefulWidget {
  const ChatSettingsContent({super.key});

  @override
  State<ChatSettingsContent> createState() => _ChatSettingsContentState();
}

class _ChatSettingsContentState extends State<ChatSettingsContent> {
  late ChatSettingsProvider _chatSettingsProvider;

  @override
  void initState() {
    super.initState();
    _chatSettingsProvider = Provider.of<ChatSettingsProvider>(context, listen: false);
  }

  // Метод для расчета горизонтального отступа в зависимости от ориентации
  double _getHorizontalPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    // В горизонтальной ориентации делаем поля уже
    if (mediaQuery.orientation == Orientation.landscape) {
      // В альбомной ориентации оставляем только центральную треть экрана для полей
      return screenWidth * 0.25; // 25% отступов с каждой стороны = 50% ширины экрана для полей
    } else {
      // В портретной ориентации используем меньшие отступы для большей ширины
      return 16.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatSettingsProvider>(
      builder: (context, chatSettingsProvider, child) {
        final l10n = AppLocalizations.of(context);
        final availableWallpapers = WallpaperPresets.getAllWallpapers(chatSettingsProvider.isDarkTheme);
        final selectedWallpaper = chatSettingsProvider.selectedWallpaperIndex < availableWallpapers.length 
            ? availableWallpapers[chatSettingsProvider.selectedWallpaperIndex] 
            : null;
    
    final horizontalPadding = _getHorizontalPadding(context);
    
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120, // Высота экрана минус заголовок
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // Умная прокрутка - не позволяет прокручивать дальше границ
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Предварительный просмотр чата
          _buildSectionHeader(l10n.chatPreview),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: ChatPreview(
              fontSize: _chatSettingsProvider.fontSize,
              isDarkTheme: _chatSettingsProvider.isDarkTheme,
              messageBubbleColor: _chatSettingsProvider.messageBubbleColor,
              receivedBubbleColor: _chatSettingsProvider.receivedBubbleColor,
              wallpaper: selectedWallpaper,
            ),
          ),

          /* Разделитель
          Container(
            height: 8,
            color: Colors.grey.shade900.withOpacity(0.3),
          ), */

          // Настройки
          _buildSectionHeader(l10n.settings),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Размер текста
                Text(
                  l10n.textSize,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  /* decoration: BoxDecoration(
                    color: Colors.grey.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade700.withOpacity(0.5),
                      width: 1,
                    ),
                  ), */
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.textSizeValue(_chatSettingsProvider.fontSize.toInt().toString()),
                            style: TextStyle(
                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            l10n.textExample,
                            style: TextStyle(
                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                              fontSize: _chatSettingsProvider.fontSize,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
                          inactiveTrackColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                          thumbColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          overlayColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400.withOpacity(0.2) : Colors.grey.shade700.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: _chatSettingsProvider.fontSize,
                          min: 12.0,
                          max: 24.0,
                          divisions: 12,
                          onChanged: (value) {
                            _chatSettingsProvider.updateSettings(fontSize: value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Переключение темы
                _buildSwitchSetting(
                  l10n.darkTheme,
                  l10n.useDarkTheme,
                  _chatSettingsProvider.isDarkTheme,
                  (value) {
                    _chatSettingsProvider.updateSettings(
                      isDarkTheme: value,
                      receivedBubbleColor: value ? const Color(0xFF3A3A3C) : Colors.grey.shade200,
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Настройка обоев
                Text(
                  l10n.chatWallpapers,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                _buildWallpaperSetting(availableWallpapers),
                const SizedBox(height: 16),

                // Настройка цветов сообщений
                Text(
                  l10n.messageColors,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                _buildColorSetting(
                  l10n.myMessages,
                  _chatSettingsProvider.messageBubbleColor,
                  (color) {
                    _chatSettingsProvider.updateSettings(messageBubbleColor: color);
                  },
                ),
                const SizedBox(height: 12),
                _buildColorSetting(
                  l10n.receivedMessages,
                  _chatSettingsProvider.receivedBubbleColor,
                  (color) {
                    _chatSettingsProvider.updateSettings(receivedBubbleColor: color);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
    },
  );
  }

  Widget _buildWallpaperSetting(List<WallpaperTemplate> availableWallpapers) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.chooseWallpaper,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          // Сетка превью обоев
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: availableWallpapers.length,
            itemBuilder: (context, index) {
              final wallpaper = availableWallpapers[index];
              final isSelected = _chatSettingsProvider.selectedWallpaperIndex == index;
              
              return GestureDetector(
                onTap: () {
                  _chatSettingsProvider.updateSettings(selectedWallpaperIndex: index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: wallpaper,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      /* decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade700.withOpacity(0.5),
          width: 1,
        ),
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.chatTheme,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                activeTrackColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600.withOpacity(0.5) : Colors.grey.shade400.withOpacity(0.5),
                inactiveThumbColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade300,
                inactiveTrackColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSetting(
    String title,
    Color color,
    ValueChanged<Color> onChanged,
  ) {
    final predefinedColors = [
      const Color(0xFF007AFF), // Синий
      const Color(0xFF34C759), // Зелёный
      const Color(0xFFFF9500), // Оранжевый
      const Color(0xFFFF3B30), // Красный
      const Color(0xFF5856D6), // Фиолетовый
      const Color(0xFFFF2D92), // Розовый
      const Color(0xFF3A3A3C), // Тёмно-серый
      Colors.grey.shade200,     // Светло-серый
    ];

    return SizedBox(
      width: double.infinity,
      /* decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade700.withOpacity(0.5),
          width: 1,
        ),
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 8,
              runSpacing: 12,
              children: predefinedColors.map((presetColor) {
              final isSelected = presetColor.value == color.value;
              return GestureDetector(
                onTap: () => onChanged(presetColor),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: presetColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final horizontalPadding = _getHorizontalPadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade200.withOpacity(0.5),
      child: Text(
        title,
        style: TextStyle(
          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
