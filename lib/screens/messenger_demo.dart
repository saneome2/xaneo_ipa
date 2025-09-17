import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/chat_preview.dart';
import '../widgets/xaneo_benefits_modal.dart';
import 'settings_detail_screen.dart';
import 'privacy_settings_screen.dart';
import 'security_settings_screen.dart';
import 'energy_saving_screen.dart';
import 'sessions_screen.dart';
import 'chat_screen.dart';

enum SettingsType {
  profileInfo,
  chatSettings,
  privacy,
  security,
  powerSaving,
  sessions,
  support,
  xaneoBenefits,
  language,
}

class MessengerDemoScreen extends StatefulWidget {
  const MessengerDemoScreen({super.key});

  @override
  State<MessengerDemoScreen> createState() => _MessengerDemoScreenState();
}

class _MessengerDemoScreenState extends State<MessengerDemoScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _previousIndex = 0;
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _iconColorController;
  late Animation<Color?> _iconColorAnimation;

  // Контроллеры для полей ввода профиля
  final TextEditingController _nameController = TextEditingController(text: 'demo');
  final TextEditingController _nicknameController = TextEditingController(text: 'demouser');
  final TextEditingController _phoneController = TextEditingController(text: '+7 (999) 123-45-67');
  // DateTime _birthDate = DateTime(1990, 5, 15); // Рандомная дата рождения - перенесено в SettingsDetailScreen

  // Контроллер для умной прокрутки
  final ScrollController _scrollController = ScrollController();

  // Состояние для выбранного языка
  int _selectedLanguageIndex = 5; // Индекс русского языка в списке

  // Список доступных языков
  final List<Map<String, String>> _availableLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'fr', 'name': 'Français'},
    {'code': 'ja', 'name': '日本語'},
    {'code': 'ko', 'name': '한국어'},
    {'code': 'ru', 'name': 'Русский'},
    {'code': 'ar', 'name': 'العربية'},
    {'code': 'zh', 'name': '中文'},
  ];

  // Поддержка высокого обновления экрана
  bool _isHighRefreshRate = false;
  DisplayMode? _currentDisplayMode;

  // Список чатов (один чат "Избранное")
  List<Map<String, dynamic>> _getFavoriteChats(AppLocalizations l10n) => [
    {
      'name': l10n.favoritesChat,
      'lastMessage': l10n.favoritesChatDescription,
      'time': '14:30',
      'unread': 0,
      'avatar': '🔖',
      'online': false,
    },
  ];

  // Метод для показа модального окна выбора языка
  void _showLanguagePicker() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Серая полоска сверху (как в iOS)
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Заголовок и кнопки
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.close,
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        size: 24,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      l10n.selectLanguage,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.check,
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        size: 24,
                      ),
                      onPressed: () {
                        // Получаем выбранный язык
                        final selectedLanguage = _availableLanguages[_selectedLanguageIndex];
                        final selectedLocale = Locale(selectedLanguage['code']!);
                        
                        // Изменяем язык через Provider
                        Provider.of<LocaleProvider>(context, listen: false).setLocale(selectedLocale);
                        
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // CupertinoPicker
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(initialItem: _selectedLanguageIndex),
                  onSelectedItemChanged: (int index) {
                    _selectedLanguageIndex = index;
                  },
                  children: _availableLanguages.map((language) {
                    return Center(
                      child: Text(
                        language['name']!,
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showXaneoBenefitsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const XaneoBenefitsModal();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _selectedIndex);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Анимация для изменения цвета иконок
    _iconColorController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _iconColorAnimation = ColorTween(
      begin: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.white : Colors.black,
      end: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6),
    ).animate(CurvedAnimation(
      parent: _iconColorController,
      curve: Curves.easeInOut,
    ));

    // Настраиваем высокий режим отображения
    _setupHighRefreshRateDisplay();
    
    // Инициализируем индекс языка после построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateLanguageIndex();
    });
  }

  // Обновляем индекс языка на основе текущей локали
  void _updateLanguageIndex() {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
    
    if (currentLocale != null) {
      final index = _availableLanguages.indexWhere(
        (lang) => lang['code'] == currentLocale.languageCode
      );
      if (index != -1) {
        setState(() {
          _selectedLanguageIndex = index;
        });
      }
    }
  }

  // Настройка высокого режима отображения
  Future<void> _setupHighRefreshRateDisplay() async {
    try {
      // Получаем список доступных режимов отображения
      final List<DisplayMode> modes = await FlutterDisplayMode.supported;

      // Ищем режим с самой высокой частотой обновления
      DisplayMode? highestMode;
      for (final mode in modes) {
        if (highestMode == null || mode.refreshRate > highestMode.refreshRate) {
          highestMode = mode;
        }
      }

      // Если нашли режим с частотой > 60Hz, устанавливаем его
      if (highestMode != null && highestMode.refreshRate > 60.0) {
        await FlutterDisplayMode.setPreferredMode(highestMode);
        _currentDisplayMode = highestMode;
        _isHighRefreshRate = true;

        // Настраиваем анимации для высокого обновления
        _setupHighRefreshRateAnimations();

        print('✅ Установлен режим отображения: ${highestMode.refreshRate}Hz (${highestMode.width}x${highestMode.height})');
      } else {
        _isHighRefreshRate = false;
        print('ℹ️ Доступен только стандартный режим отображения (60Hz)');
      }
    } catch (e) {
      print('⚠️ Ошибка настройки режима отображения: $e');
      _isHighRefreshRate = false;
    }
  }  // Настройка анимаций для высокого обновления экрана
  void _setupHighRefreshRateAnimations() {
    // Для экранов с высокой частотой обновления используем более плавные анимации
    if (_isHighRefreshRate) {
      // Увеличиваем продолжительность анимаций для более плавного эффекта
      _animationController.duration = const Duration(milliseconds: 250);
      _iconColorController.duration = const Duration(milliseconds: 300);

      // Используем более плавные кривые для высокого обновления
      _iconColorAnimation = ColorTween(
        begin: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.white : Colors.black,
        end: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6),
      ).animate(CurvedAnimation(
        parent: _iconColorController,
        curve: Curves.easeInOutCubic, // Более плавная кривая
      ));
    }
  }

  @override
  void dispose() {
    // Логируем информацию о режиме отображения при закрытии
    if (_currentDisplayMode != null) {
      print('📱 Текущий режим отображения: ${_currentDisplayMode!.refreshRate}Hz (${_currentDisplayMode!.width}x${_currentDisplayMode!.height})');
    }

    _pageController.dispose();
    _animationController.dispose();
    _iconColorController.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      // Сохраняем предыдущий индекс для анимации
      _previousIndex = _selectedIndex;
      
      // Легкая вибрация при переключении
      HapticFeedback.lightImpact();
      
      // Запускаем анимацию цвета иконки
      _iconColorController.forward(from: 0.0);
      
      // Плавная смена страницы с эффектом Telegram
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Основное содержимое с PageView и Telegram-стилем анимации
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  // Обработка свайпов для переключения между вкладками
                  if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 300) {
                    if (details.primaryVelocity! < 0 && _selectedIndex == 0) {
                      // Свайп влево - переходим к профилю
                      _onItemTapped(1);
                    } else if (details.primaryVelocity! > 0 && _selectedIndex == 1) {
                      // Свайп вправо - переходим к мессенджеру
                      _onItemTapped(0);
                    }
                  }
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _selectedIndex == 0
                    ? Container(
                        key: const ValueKey<int>(0),
                        child: _buildMessengerContent(),
                      )
                    : Container(
                        key: const ValueKey<int>(1),
                        child: _buildProfileContent(),
                      ),
                ),
              ),
            ),
            
            // Навигационная панель
            _buildBottomNavigation(l10n),
          ],
        ),
      ),
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    // В горизонтальной ориентации делаем поля уже
    if (mediaQuery.orientation == Orientation.landscape) {
      // В альбомной ориентации оставляем только центральную треть экрана для полей
      return screenWidth * 0.25; // 25% отступов с каждой стороны = 50% ширины экрана для полей
    } else {
      // В портретной ориентации используем меньшие отступы для большей ширины
      return 6.0;
    }
  }

  Widget _buildMessengerContent() {
    final horizontalPadding = _getHorizontalPadding(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Заголовок и кнопка поиска
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Заголовок
              Expanded(
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              // Кнопка поиска
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.white : Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    // Обработчик поиска
                    print('Поиск нажат');
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Список чатов
          Expanded(
            child: ListView.builder(
              itemCount: _getFavoriteChats(AppLocalizations.of(context)).length,
              itemBuilder: (context, index) {
                final chat = _getFavoriteChats(AppLocalizations.of(context))[index];
                return _buildChatItem(chat);
              },
            ),
            ),
        ],
      ),
    );
  }  Widget _buildChatItem(Map<String, dynamic> chat) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return GestureDetector(
      onTap: () {
        // Переход к экрану чата с анимацией как у экрана безопасности
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
              chatName: chat['name'],
              chatAvatar: chat['avatar'],
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black.withOpacity(0.1) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
        children: [
          // Аватар
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                chat['avatar'],
                style: TextStyle(
                  fontSize: 24,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Информация о чате
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat['name'],
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      chat['time'],
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        fontFamily: 'Inter',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat['lastMessage'],
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (chat['unread'] > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          chat['unread'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Статус онлайн
          if (chat['online'])
            Container(
              margin: const EdgeInsets.only(left: 8),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    ));
  }

  Widget _buildProfileContent() {
    final l10n = AppLocalizations.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final horizontalPadding = _getHorizontalPadding(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          // Умная прокрутка: останавливаемся при достижении границ
          if (notification is ScrollUpdateNotification) {
            final metrics = notification.metrics;
            
            // Если достигли верхней границы и пытаемся прокрутить вверх
            if (metrics.pixels <= 0 && notification.scrollDelta! < 0) {
              return true; // Блокируем прокрутку
            }
            
            // Если достигли нижней границы и пытаемся прокрутить вниз
            if (metrics.pixels >= metrics.maxScrollExtent && notification.scrollDelta! > 0) {
              return true; // Блокируем прокрутку
            }
          }
          
          return false; // Продолжаем нормальную прокрутку
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(), // Заменяем BouncingScrollPhysics на ClampingScrollPhysics
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Подзаголовок (центрированный)
            /*Center(
              child: Text(
                l10n.profileDemo, // Вместо l10n.profilePreviewTitle
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),*/
          
          const SizedBox(height: 8),
          
          // Превью профиля в большом размере
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start, // Явно указываем выравнивание влево
              children: [
                // Аватарка (увеличенная версия)
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.purple.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'D',
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Уменьшили отступ с 20 до 12
                
                // Текстовая информация
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Приветствие с временем дня
                      Text(
                        _getDemoGreeting(l10n),
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.0, // Уменьшаем высоту строки
                        ),
                      ),
                      // Имя пользователя
                      Text(
                        'demo', // Вместо _nameController.text
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontVariations: [FontVariation('wght', 600)],
                        ),
                      ),
                      // Никнейм
                      Text(
                        '@demouser', // Вместо '@${_registerNicknameController.text}'
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade700,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Информация
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsSection,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSettingsItem(l10n.personalInfo, Icons.person_outline),
                _buildSettingsItem(l10n.chatSettings, Icons.chat_bubble_outline),
                _buildSettingsItem(l10n.privacySettings, Icons.lock_outline),
                _buildSettingsItem(l10n.securitySettings, Icons.security_outlined),
                _buildSettingsItem(l10n.powerSettings, Icons.battery_saver_outlined),
                _buildSettingsItemLast(l10n.sessions, Icons.devices_outlined),
                
                const SizedBox(height: 12),
                
                // Разделитель
                Container(
                  height: 1,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade400.withOpacity(0.5),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                ),
                
                // Заголовок "Ещё"
                Text(
                  l10n.more,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSettingsItem(l10n.support, Icons.support_agent),
                _buildSettingsItem(l10n.xaneoBenefits, Icons.star_outline),
                _buildLanguageItem(l10n.languageSelect, _getLanguageNameFromLocale(localeProvider.locale, l10n)),
              ],
            ),
          ),
        ],
        ),
      ),
      ),
    );
  }

  /// Получает приветствие в зависимости от времени дня
  String _getDemoGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 12) {
      return l10n.goodMorning; // l10n.goodMorning
    } else if (hour >= 12 && hour < 18) {
      return l10n.goodDay; // l10n.goodDay
    } else if (hour >= 18 && hour < 22) {
      return l10n.goodEvening; // l10n.goodEvening
    } else {
      return l10n.goodNight; // l10n.goodNight
    }
  }

  Widget _buildBottomNavigation(AppLocalizations l10n) {
    return AnimatedBuilder(
      animation: _iconColorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
            border: Border(
              top: BorderSide(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  // 
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(0),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat,
                              size: 24,
                              color: _getIconColor(context, 0),
                            ),
                            SizedBox(height: 4),
                            Text(
                              l10n.messenger,
                              style: TextStyle(
                                color: _getIconColor(context, 0),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Профиль
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(1),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 24,
                              color: _getIconColor(context, 1),
                            ),
                            SizedBox(height: 4),
                            Text(
                              l10n.profile,
                              style: TextStyle(
                                color: _getIconColor(context, 1),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getIconColor(BuildContext context, int index) {
    final isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    final activeColor = isDarkMode ? Colors.white : Colors.black;
    final inactiveColor = isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5);
    
    if (_selectedIndex == index) {
      return activeColor;
    } else if (_previousIndex == index && _iconColorController.isAnimating) {
      // Во время анимации предыдущая иконка плавно меняет цвет
      return _iconColorAnimation.value ?? inactiveColor;
    } else {
      return inactiveColor;
    }
  }

  Widget _buildSettingsItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _onSettingsItemTap(title),
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade400.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade500,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItemLast(String title, IconData icon) {
    return GestureDetector(
      onTap: () => _onSettingsItemTap(title),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        constraints: const BoxConstraints(minHeight: 48),
        decoration: BoxDecoration(
          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade200.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade400.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade500,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _onSettingsItemTap(String title) {
    final l10n = AppLocalizations.of(context);
    Widget content;

    // Определяем контент по локализованному названию
    if (title == l10n.personalInfo) {
      // Для персональной информации используем специальный экран с полем даты рождения
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SettingsDetailScreen(
            title: title,
            showBirthDateField: true, // Показываем поле даты рождения
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            var fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        ),
      );
      return; // Выходим из метода раньше
    } else if (title == l10n.chatSettings) {
      // Для настроек сообщений используем специальный экран с предварительным просмотром
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SettingsDetailScreen(
            title: title,
            content: const ChatSettingsContent(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            var fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        ),
      );
      return; // Выходим из метода раньше
    } else if (title == l10n.privacySettings) {
      // Открываем экран конфиденциальности как отдельный экран
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => PrivacySettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            var fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
      return; // Выходим из метода раньше
    } else if (title == l10n.securitySettings) {
      // Открываем отдельный экран безопасности
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SecuritySettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
      return; // Выходим из метода раньше
    } else if (title == l10n.powerSettings) {
      // Открываем отдельный экран энергосбережения
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const EnergySavingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
      return; // Выходим из метода раньше
    } else if (title == l10n.sessions) {
      // Открываем отдельный экран сессий
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SessionsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
      return; // Выходим из метода раньше
    } else if (title == l10n.support) {
      _showSupportModal();
      return; // Выходим из метода, не открывая новый экран
    } else if (title == l10n.xaneoBenefits) {
      _showXaneoBenefitsModal();
      return; // Выходим из метода, не открывая новый экран
    } else if (title == l10n.languageSelect) {
      // Показываем модальное окно выбора языка вместо перехода на экран настроек
      _showLanguagePicker();
      return; // Выходим из метода, не открывая новый экран
    } else {
      content = _buildDefaultContent(title);
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SettingsDetailScreen(
          title: title,
          content: content,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          var fadeAnimation = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: curve,
          ));

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showSupportModal() {
    final l10n = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Серая полоска сверху (как в iOS)
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          // Иконка
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.support_agent,
                              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Заголовок
                          Text(
                            l10n.support,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          // Описание
                          Text(
                            l10n.supportContent,
                            style: TextStyle(
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          // Кнопки
                          Row(
                            children: [
                              // Кнопка закрытия
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    l10n.cancel,
                                    style: TextStyle(
                                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Кнопка связи
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Здесь можно добавить логику для связи со службой поддержки
                                    // Например, открыть email клиент или перейти в чат
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                                    foregroundColor: isDarkMode ? Colors.black : Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    l10n.contactSupport,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDefaultContent(String title) {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.contentInDevelopmentMessage(title),
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageItem(String title, String selectedLanguage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _showLanguagePicker(), // Изменено: напрямую вызываем модальное окно
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade400.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.language,
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                selectedLanguage,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade700,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade500,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Метод для получения названия языка по коду локали
  String _getLanguageNameFromLocale(Locale? locale, AppLocalizations l10n) {
    if (locale == null) return l10n.russianLanguage; // По умолчанию
    
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'ru':
        return l10n.russianLanguage;
      case 'ar':
        return 'العربية';
      case 'zh':
        return '中文';
      case 'de':
        return 'Deutsch';
      case 'it':
        return 'Italiano';
      case 'pt':
        return 'Português';
      default:
        return l10n.russianLanguage;
    }
  }
}
