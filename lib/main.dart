import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'screens/messenger_demo.dart';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'l10n/app_localizations.dart';
import 'styles/app_styles.dart';
import 'utils/theme_assets.dart';
import 'utils/emoji_utils.dart';
import 'services/emoji_loader_service.dart';
import 'widgets/avatar_cropper.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/chat_settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализируем и предзагружаем эмодзи для оптимизации производительности
  EmojiUtils.preloadEmojis();
  
  // Предзагружаем кастомный Emoji шрифт
  await EmojiLoaderService.preloadCustomEmojiFont();
  
  // Инициализируем настройки чата
  final chatSettingsProvider = ChatSettingsProvider();
  await chatSettingsProvider.loadSettings();
  
  // Включаем высокую частоту обновления для 120Hz экранов
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => chatSettingsProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(
      builder: (context, localeProvider, themeProvider, child) {
        // Обновляем системные цвета в зависимости от темы
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
          systemNavigationBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
        ));

        // Получаем размеры экрана
        final mediaQuery = MediaQuery.of(context);
        final screenSize = mediaQuery.size;
        
        // Вычисляем физический размер экрана в дюймах
        // Используем логические пиксели для более точного расчета
        final logicalWidth = screenSize.width;
        final logicalHeight = screenSize.height;
        final diagonalLogicalPixels = sqrt(logicalWidth * logicalWidth + logicalHeight * logicalHeight);
        
        // Преобразуем в дюймы через стандартную плотность Android (160 dpi для mdpi)
        final standardDpi = 160.0;
        final diagonalInches = diagonalLogicalPixels / standardDpi;
    
    // Устанавливаем ориентацию в зависимости от размера экрана
    // Если диагональ МЕНЬШЕ 7 дюймов, принудительно блокируем горизонтальную ориентацию
    if (diagonalInches < 7.0) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      // Для планшетов (7+ дюймов) разрешаем все ориентации
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

        
        return MaterialApp(
          title: 'XaneoMobile',
          locale: localeProvider.locale ?? const Locale('ru'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LocaleProvider.supportedLocales,
          theme: themeProvider.themeData.copyWith(
            textTheme: themeProvider.themeData.textTheme.apply(
              fontFamily: 'Inter',
            ).copyWith(
              bodyMedium: themeProvider.themeData.textTheme.bodyMedium?.copyWith(
                fontFamilyFallback: const [
                  'CustomEmojis',
                  'Apple Color Emoji',
                  'Segoe UI Emoji',
                  'Noto Color Emoji',
                ],
              ),
            ),
            // Включаем высокую частоту обновления для плавных анимаций
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const BlackScreen(),
          debugShowCheckedModeBanner: false,
          // Поддержка высокой частоты обновления
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // Включаем поддержку высокой частоты обновления
                platformBrightness: Brightness.dark,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}

class BlackScreen extends StatefulWidget {
  const BlackScreen({super.key});

  @override
  State<BlackScreen> createState() => _BlackScreenState();
}

// Анимированное уведомление об обновлении
class AnimatedUpdateNotification extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const AnimatedUpdateNotification({
    super.key,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  State<AnimatedUpdateNotification> createState() => _AnimatedUpdateNotificationState();
}

class _AnimatedUpdateNotificationState extends State<AnimatedUpdateNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Получаем полный размер экрана без учета клавиатуры
    final screenSize = View.of(context).physicalSize / View.of(context).devicePixelRatio;
    
    return Positioned(
      top: screenSize.height - 100, // Фиксированная позиция от верха экрана
      left: 16,
      right: 16,
      child: IgnorePointer(
        ignoring: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _animationController,
                    child: Material(
                      elevation: 0.5, // Минимальная высота - ниже всех элементов
                      color: Colors.transparent,
                      type: MaterialType.card,
                      child: GestureDetector(
                        onTap: () {
                          // Сразу вызываем callback без ожидания анимации
                          widget.onTap();
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 280,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(12),
                            // Убрали тень полностью для минимального слоя
                          ),
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.system_update,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context).updateAvailable,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontVariations: [FontVariation('wght', 600)],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BlackScreenState extends State<BlackScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _logoAnimationController;
  late Animation<Offset> _logoAnimation;
  late AnimationController _bearAnimationController;
  late Animation<double> _bearAnimation;
  bool _showBear = false;
  
  // Переменная для предотвращения избыточных переключений ориентации
  List<DeviceOrientation>? _lastSetOrientations;
  Timer? _orientationDebounce;
  
  // Переменные настроек
  bool _notificationsEnabled = true;

  double _fontSize = 16.0;
  Locale _currentLocale = const Locale('ru');
  
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

  // Анимация ухода приветствия влево
  late AnimationController _welcomeSlideController;
  late Animation<Offset> _welcomeSlideAnimation;
  bool _welcomeGone = false;

  // Анимация ухода второго медведя влево
  late AnimationController _privateSlideController;
  late Animation<Offset> _privateSlideAnimation;

  // Анимация появления второго мишки
  late AnimationController _privateBearController;
  late Animation<Offset> _privateBearAnimation;
  late Animation<double> _privateBearFadeAnimation;
  bool _showPrivateBear = false;
  bool _privateBearGone = false;

  // Анимация появления третьего мишки (база данных)
  late AnimationController _databaseBearController;
  late Animation<Offset> _databaseBearAnimation;
  late Animation<double> _databaseBearFadeAnimation;
  bool _showDatabaseBear = false;

  // Анимация ухода третьего медведя влево
  late AnimationController _databaseSlideController;
  late Animation<Offset> _databaseSlideAnimation;
  bool _databaseBearGone = false;

  // Анимация текстовых блоков
  late AnimationController _welcomeTextController;
  late Animation<Offset> _welcomeTextAnimation;
  late AnimationController _privateTextController;
  late Animation<Offset> _privateTextAnimation;
  late AnimationController _databaseTextController;
  late Animation<Offset> _databaseTextAnimation;

  // Анимация появления полей ввода
  late AnimationController _inputFieldsController;
  late Animation<double> _inputFieldsFadeAnimation;
  late Animation<Offset> _inputFieldsSlideAnimation;
  bool _showInputFields = false;

  // Контроллеры для полей ввода
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); // Для регистрации
  final TextEditingController _loginPasswordController = TextEditingController(); // Для входа
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _registerNicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  final TextEditingController _forgotPasswordNicknameController = TextEditingController(); // Для восстановления пароля
  final TextEditingController _forgotPasswordCodeController = TextEditingController(); // Для кода восстановления пароля

  // Отслеживание состояния полей
  bool _isNameFieldEmpty = true;
  bool _isVerificationCodeFieldEmpty = true;
  bool _isEmailFieldEmpty = true;
  bool _isEmailValid = true;
  
  // Активное уведомление об обновлении
  OverlayEntry? _activeUpdateNotification;
  bool _showUpdateNotification = false; // Новая переменная для Stack
  String _updateCurrentVersion = '';
  String _updateLatestVersion = '';
  bool _showEmailError = false;
  String _emailErrorType = ''; // 'format', 'unsupported'
  bool _isCheckingEmail = false; // Новое состояние проверки email
  bool _isEmailAvailable = false; // Новое состояние - email доступен
  Timer? _emailCheckTimer; // Таймер для задержки проверки email
  Timer? _passwordDebounce; // Таймер для дебаунса валидации пароля
  Timer? _confirmPasswordDebounce; // Таймер для дебаунса подтверждения пароля
  String _previousEmail = ''; // Предыдущее значение email для сравнения
  bool _isVerifyingCode = false; // Новое состояние - проверка кода подтверждения
  bool _isVerifyingPasswordResetCode = false; // Состояние проверки кода восстановления пароля
  bool _isVerifying2FA = false; // Состояние проверки кода 2FA
  bool _isPasswordFieldEmpty = true;
  bool _isPasswordValid = false; // Изначально пароль НЕ валиден
  bool _showPasswordError = false;
  String _passwordErrorType = ''; // 'cyrillic', 'weak', 'medium'
  String _passwordStrength = ''; // 'weak', 'medium', 'strong'
  
  // Переменные для подтверждения пароля
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isConfirmPasswordFieldEmpty = true;
  bool _passwordsMatch = true;
  bool _showPasswordMismatchError = false;
  String _originalPassword = ''; // Храним оригинальный пароль для быстрого сравнения
  bool _isPasswordVisible = false; // Переменная для показа/скрытия пароля регистрации
  bool _isLoginPasswordVisible = false; // Переменная для показа/скрытия пароля входа
  bool _isNicknameValid = true;
  bool _showNicknameError = false;
  bool _isCheckingNickname = false; // Новое состояние проверки
  bool _isNicknameAvailable = false; // Новое состояние - никнейм свободен
  bool _isNicknameTaken = false; // Новое состояние - никнейм занят
  String _generatedNickname = ''; // Заводской никнейм
  String _nicknameErrorType = ''; // 'length', 'latin', 'start', 'end', 'taken', или 'server'
  Timer? _nicknameCheckTimer; // Таймер для задержки проверки
  String _previousNickname = ''; // Предыдущее значение никнейма для сравнения

  // Отслеживание первого запуска
  bool _isFirstLaunch = true;

  // Режим формы (true - вход, false - регистрация)
  bool _isLoginMode = true;
  
  // Deep Links для авторизации по токену
  AppLinks? _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  String? _lastDeepLink;
  DateTime? _lastDeepLinkTime;
  bool _isProcessingAuthToken = false;

  // Шаги регистрации (0 - имя, 1 - дата рождения, и т.д.)
  int _registrationStep = 0;
  
  // Выбранное изображение аватара
  File? _selectedAvatarImage;
  
  // Выбранная дата рождения
  DateTime? _selectedBirthdate;

  // Анимация перехода между формами
  late AnimationController _formTransitionController;
  late Animation<double> _formFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Проверяем, первый ли это запуск
    _checkFirstLaunch();
    
    // Инициализация анимации лого с поддержкой высокой частоты обновления
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 3), // Ускорили анимацию
      vsync: this,
    );

    // Инициализация анимации мишки с поддержкой высокой частоты обновления
    _bearAnimationController = AnimationController(
      duration: const Duration(seconds: 1), // 1 секунда для появления
      vsync: this,
    );

    _bearAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bearAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimation = TweenSequence<Offset>([
      // 1 секунда в центре экрана (точно по середине oY)
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 20.0, // 1 секунда из 5
      ),
      // Немного назад (вниз) - плавный разгон
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.03))
            .chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 15.0, // 0.75 секунды
      ),
      // Идёт к целевому положению и ВЫШЕ - плавное движение
      TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0, 0.03), end: const Offset(0, -0.33))
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 40.0, // 2 секунды - больше времени на полёт
      ),
      // Опускается в финальное положение - плавное торможение (+24px как этап 2)
      TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0, -0.33), end: const Offset(0, -0.30))
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 25.0, // 1.25 секунды
      ),
    ]).animate(_logoAnimationController);

    // Запускаем анимацию лого
    _logoAnimationController.forward().then((_) {
      // Если это первый запуск, показываем онбординг
      if (_isFirstLaunch) {
        setState(() {
          _showBear = true;
        });
        _bearAnimationController.forward();
      }
      // Если не первый запуск, логика уже обработана в _skipToLogin()
    });
    
    // Запрос к серверу при запуске приложения (с задержкой)
    Future.delayed(const Duration(seconds: 1), () {
      _fetchVersionInfo();
    });

    // Анимация ухода приветствия влево
    _welcomeSlideController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _welcomeSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-2.0, 0.0), // быстро уходит влево
    ).animate(CurvedAnimation(
      parent: _welcomeSlideController,
      curve: Curves.decelerate,
    ));

    // Анимация ухода второго медведя влево
    _privateSlideController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _privateSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-2.0, 0.0), // быстро уходит влево
    ).animate(CurvedAnimation(
      parent: _privateSlideController,
      curve: Curves.decelerate,
    ));

    // Анимация появления второго мишки
    _privateBearController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _privateBearAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // появляется справа
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _privateBearController,
      curve: Curves.decelerate,
    ));
    _privateBearFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _privateBearController,
      curve: Curves.easeIn,
    ));

    // Анимация текстовых блоков
    _welcomeTextController = AnimationController(
      duration: AppStyles.animationDurationFast,
      vsync: this,
    );
    _welcomeTextAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-2.0, 0.0), // уходит влево
    ).animate(CurvedAnimation(
      parent: _welcomeTextController,
      curve: AppStyles.animationCurveDecelerate,
    ));

    // Анимация текста второго этапа (появление справа)
    _privateTextController = AnimationController(
      duration: AppStyles.animationDurationFast,
      vsync: this,
    );
    _privateTextAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // появляется справа
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _privateTextController,
      curve: AppStyles.animationCurveDecelerate,
    ));

    // Анимация появления третьего мишки (база данных)
    _databaseBearController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _databaseBearAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // появляется справа
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _databaseBearController,
      curve: Curves.decelerate,
    ));
    _databaseBearFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _databaseBearController,
      curve: Curves.easeIn,
    ));

    // Анимация ухода третьего медведя влево
    _databaseSlideController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _databaseSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-2.0, 0.0), // быстро уходит влево
    ).animate(CurvedAnimation(
      parent: _databaseSlideController,
      curve: Curves.decelerate,
    ));

    // Анимация текстового блока для третьего этапа
    _databaseTextController = AnimationController(
      duration: AppStyles.animationDurationFast,
      vsync: this,
    );
    _databaseTextAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // появляется справа
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _databaseTextController,
      curve: AppStyles.animationCurveDecelerate,
    ));

    // Анимация появления полей ввода
    _inputFieldsController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _inputFieldsFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _inputFieldsController,
      curve: Curves.easeIn,
    ));
    _inputFieldsSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5), // появляется снизу
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _inputFieldsController,
      curve: Curves.easeOutCubic,
    ));

    // Анимация перехода между формами (вход/регистрация)
    _formTransitionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formTransitionController,
      curve: Curves.easeInOut,
    ));

    // Добавляем слушатель для поля имени
    _nameController.addListener(() {
      setState(() {
        _isNameFieldEmpty = _nameController.text.trim().isEmpty;
      });
    });

    // Добавляем слушатель для поля кода верификации
    _verificationCodeController.addListener(() {
      setState(() {
        _isVerificationCodeFieldEmpty = _verificationCodeController.text.trim().isEmpty;
      });
    });

    // Добавляем слушатель для поля пароля с дебаунсом для тяжелых операций
    _passwordController.addListener(() {
      final password = _passwordController.text.trim();
      
      // Легкие операции выполняем сразу
      setState(() {
        _isPasswordFieldEmpty = password.isEmpty;
        _originalPassword = _passwordController.text; // Сохраняем текущий пароль
      });
      
      // Отменяем предыдущий таймер для тяжелых операций
      _passwordDebounce?.cancel();
      
      if (password.isEmpty) {
        setState(() {
          _isPasswordValid = false; // Пустой пароль НЕ валиден
          _showPasswordError = false;
          _passwordErrorType = '';
          _passwordStrength = '';
        });
        return;
      }
      
      // Тяжелые операции (валидация, проверка силы) выполняем с дебаунсом
      _passwordDebounce = Timer(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            // Проверяем на кириллические символы
            if (_containsCyrillic(password)) {
              _isPasswordValid = false;
              _showPasswordError = true;
              _passwordErrorType = 'cyrillic';
              _passwordStrength = '';
              return;
            }
            
            // Оцениваем силу пароля
            final strength = _evaluatePasswordStrength(password);
            _passwordStrength = strength;
            
            if (strength == 'weak') {
              _isPasswordValid = false;
              _showPasswordError = true;
              _passwordErrorType = 'weak';
            } else if (strength == 'medium') {
              _isPasswordValid = true;
              _showPasswordError = true; // Показываем предупреждение
              _passwordErrorType = 'medium';
            } else {
              _isPasswordValid = true;
              _showPasswordError = false;
              _passwordErrorType = '';
            }
            
            // Проверяем совпадение паролей, если поле подтверждения не пустое
            final confirmPassword = _confirmPasswordController.text;
            if (confirmPassword.isNotEmpty) {
              _passwordsMatch = _originalPassword == confirmPassword;
              _showPasswordMismatchError = !_passwordsMatch;
            }
          });
        }
      });
    });

    // Добавляем слушатель для поля подтверждения пароля с дебаунсом
    _confirmPasswordController.addListener(() {
      // Отменяем предыдущий таймер
      _confirmPasswordDebounce?.cancel();
      
      // Запускаем новый таймер с минимальной задержкой для клавиатурного ввода
      _confirmPasswordDebounce = Timer(const Duration(milliseconds: 50), () {
        final confirmPassword = _confirmPasswordController.text;
        
        if (mounted) {
          setState(() {
            _isConfirmPasswordFieldEmpty = confirmPassword.isEmpty;
            
            if (confirmPassword.isEmpty) {
              _passwordsMatch = true;
              _showPasswordMismatchError = false;
              return;
            }
            
            // Сравниваем с сохраненным оригинальным паролем (самое быстрое сравнение)
            _passwordsMatch = _originalPassword == confirmPassword;
            _showPasswordMismatchError = !_passwordsMatch;
          });
        }
      });
    });

    // Добавляем слушатель для поля email
    _emailController.addListener(() {
      final email = _emailController.text.trim();
      
      // Проверяем, изменился ли email на самом деле
      if (email == _previousEmail) {
        return; // Email не изменился, выходим
      }
      
      // Обновляем предыдущее значение
      _previousEmail = email;
      
      // Отменяем предыдущую проверку
      _emailCheckTimer?.cancel();
      
      setState(() {
        _isCheckingEmail = false;
        _isEmailAvailable = false; // Сбрасываем состояние "доступен"
        _isEmailFieldEmpty = email.isEmpty;
        
        if (email.isEmpty) {
          _isEmailValid = true;
          _showEmailError = false;
          _emailErrorType = '';
          return;
        }
        
        // Проверяем формат email
        if (!_isValidEmailFormat(email)) {
          _isEmailValid = false;
          _showEmailError = true;
          _emailErrorType = 'format';
          return;
        }
        
        // Проверяем поддерживаемые домены
        if (!_isValidEmailDomain(email)) {
          _isEmailValid = false;
          _showEmailError = true;
          _emailErrorType = 'unsupported';
          return;
        }
        
        // Если все базовые проверки прошли, показываем состояние проверки
        _isEmailValid = true;
        _showEmailError = false;
        _emailErrorType = '';
        _isCheckingEmail = true;
      });
      
      // Запускаем задержку проверки только если все базовые проверки пройдены
      if (_isEmailValid && _isValidEmailFormat(email) && _isValidEmailDomain(email)) {
        _emailCheckTimer = Timer(const Duration(milliseconds: 1500), () {
          if (mounted) {
            _checkEmailAvailability(email);
          }
        });
      }
    });

    // Добавляем слушатель для поля никнейма
    _registerNicknameController.addListener(() {
      final nickname = _registerNicknameController.text.trim();
      
      // Проверяем, изменился ли никнейм на самом деле
      if (nickname == _previousNickname) {
        return; // Никнейм не изменился, выходим
      }
      
      // Обновляем предыдущее значение
      _previousNickname = nickname;
      
      // Отменяем предыдущую проверку
      _nicknameCheckTimer?.cancel();
      
      setState(() {
        _isCheckingNickname = false;
        _isNicknameAvailable = false; // Сбрасываем состояние "свободен"
        
        if (nickname.isEmpty) {
          _isNicknameValid = true;
          _showNicknameError = false;
          _nicknameErrorType = '';
          return;
        }
        
        // Проверяем базовые правила валидации сразу
        if (!_isValidNicknameCharacters(nickname)) {
          _isNicknameValid = false;
          _showNicknameError = true;
          _nicknameErrorType = 'latin';
          return;
        }
        if (!_isValidNicknameStart(nickname)) {
          _isNicknameValid = false;
          _showNicknameError = true;
          _nicknameErrorType = 'start';
          return;
        }
        if (!_isValidNicknameEnd(nickname)) {
          _isNicknameValid = false;
          _showNicknameError = true;
          _nicknameErrorType = 'end';
          return;
        }
        if (nickname.isNotEmpty && nickname.length <= 4) {
          _isNicknameValid = false;
          _showNicknameError = true;
          _nicknameErrorType = 'length';
          return;
        }
        
        // Если все базовые проверки прошли, показываем состояние проверки
        _isNicknameValid = true;
        _showNicknameError = false;
        _nicknameErrorType = '';
        _isCheckingNickname = true;
      });
      
      // Запускаем задержку проверки только если все базовые проверки пройдены
      if (_isNicknameValid && nickname.length > 4) {
        _nicknameCheckTimer = Timer(const Duration(milliseconds: 1500), () {
          if (mounted) {
            _checkNicknameAvailability(nickname);
          }
        });
      }
    });
    
    // Инициализация deep links для авторизации по токену
    _initializeAuthDeepLinks();
    
    // Принудительно устанавливаем ориентацию в зависимости от размера экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setDeviceOrientation();
    });
    
    // Регистрируем наблюдатель за изменениями системы
    WidgetsBinding.instance.addObserver(this);
    
    // Синхронизируем настройки с провайдерами
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncSettingsWithProviders();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Синхронизация больше не нужна, поскольку мы используем Provider.of<ThemeProvider>(context).isDarkMode напрямую
  }

  @override
  void dispose() {
    _nicknameCheckTimer?.cancel(); // Отменяем таймер
    _emailCheckTimer?.cancel(); // Отменяем таймер email
    _passwordDebounce?.cancel(); // Отменяем таймер дебаунса пароля
    _confirmPasswordDebounce?.cancel(); // Отменяем таймер дебаунса подтверждения пароля
    _logoAnimationController.dispose();
    _bearAnimationController.dispose();
    _welcomeSlideController.dispose();
    _privateSlideController.dispose();
    _privateBearController.dispose();
    _databaseBearController.dispose();
    _databaseSlideController.dispose();
    _welcomeTextController.dispose();
    _privateTextController.dispose();
    _databaseTextController.dispose();
    _inputFieldsController.dispose();
    _formTransitionController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    _loginPasswordController.dispose();
    _nameController.dispose();
    _registerNicknameController.dispose();
    _emailController.dispose();
    _verificationCodeController.dispose();
    _confirmPasswordController.dispose();
    _forgotPasswordNicknameController.dispose();
    _forgotPasswordCodeController.dispose();
    // Убираем активное уведомление об обновлении
    _activeUpdateNotification?.remove();
    // Отменяем подписку на deep links
    _linkSubscription?.cancel();
    // Отменяем таймер дебаунса ориентации
    _orientationDebounce?.cancel();
    // Отменяем наблюдатель за изменениями системы
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Отменяем предыдущий таймер, если он есть
    _orientationDebounce?.cancel();
    
    // Устанавливаем новый таймер с задержкой 100мс для предотвращения множественных вызовов
    _orientationDebounce = Timer(const Duration(milliseconds: 100), () {
      if (mounted) {
        _setDeviceOrientation();
      }
    });
  }

  /// Устанавливает ориентацию устройства в зависимости от размера экрана
  void _setDeviceOrientation() {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    
    // Вычисляем физический размер экрана в дюймах
    // Используем логические пиксели для более точного расчета
    final logicalWidth = screenSize.width;
    final logicalHeight = screenSize.height;
    final diagonalLogicalPixels = sqrt(logicalWidth * logicalWidth + logicalHeight * logicalHeight);
    
    // Преобразуем в дюймы через стандартную плотность Android (160 dpi для mdpi)
    final standardDpi = 160.0;
    final diagonalInches = diagonalLogicalPixels / standardDpi;
    
    // Определяем нужные ориентации
    List<DeviceOrientation> targetOrientations;
    if (diagonalInches < 7.0) {
      // Для телефонов только портретная ориентация
      targetOrientations = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ];
    } else {
      // Для планшетов все ориентации
      targetOrientations = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
    }
    
    // Проверяем, отличаются ли новые ориентации от текущих
    if (_lastSetOrientations == null || !_orientationListsEqual(_lastSetOrientations!, targetOrientations)) {
      print('Смена ориентации: диагональ ${diagonalInches.toStringAsFixed(2)}" - ${targetOrientations.length == 2 ? "только портрет" : "все ориентации"}');
      _lastSetOrientations = List.from(targetOrientations);
      SystemChrome.setPreferredOrientations(targetOrientations);
    }
  }
  
  /// Сравнивает два списка ориентаций
  bool _orientationListsEqual(List<DeviceOrientation> list1, List<DeviceOrientation> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  /// Инициализация deep links для авторизации по токену
  void _initializeAuthDeepLinks() {
    _appLinks = AppLinks();
    
    // Обработка начального link (когда приложение запускается через deep link)
    _appLinks!.getInitialLink().then((Uri? uri) async {
      if (uri != null) {
        print('Initial auth deep link detected: $uri');
        _handleAuthDeepLink(uri, isInitial: true);
      }
    });
    
    // Подписка на новые deep links (когда приложение уже запущено)
    _linkSubscription = _appLinks!.uriLinkStream.listen(
      (Uri uri) {
        print('Runtime auth deep link received: $uri');
        _handleAuthDeepLink(uri, isInitial: false);
      },
      onError: (err) {
        print('Auth Deep Link Error: $err');
      },
    );
  }

  /// Обработка deep link для авторизации по токену
  void _handleAuthDeepLink(Uri uri, {bool isInitial = false}) {
    final currentTime = DateTime.now();
    final linkString = uri.toString();
    
    // Защита от дублирующих deep links в течение 2 секунд
    if (_lastDeepLink == linkString && 
        _lastDeepLinkTime != null && 
        currentTime.difference(_lastDeepLinkTime!).inSeconds < 2) {
      print('Duplicate auth deep link ignored: $linkString');
      return;
    }
    
    _lastDeepLink = linkString;
    _lastDeepLinkTime = currentTime;
    
    print('Auth Deep Link received: $uri');
    print('Auth Deep Link host: ${uri.host}');
    print('Auth Deep Link path: ${uri.path}');
    
    // Проверяем, что это наш deep link для авторизации
    // Ожидаем формат: xaneo://auth/login-success?token=xyz
    if (uri.scheme == 'xaneo' && uri.host == 'auth' && uri.path == '/login-success') {
      final token = uri.queryParameters['token'];
      
      if (token != null && token.isNotEmpty) {
        print('Found auth token: $token');
        _processAuthToken(token);
      } else {
        print('Auth deep link without token');
        _showToast('Ошибка: отсутствует токен авторизации');
      }
    } else {
      print('Unknown auth deep link format');
      _showToast('Неизвестный формат ссылки авторизации');
    }
  }

  /// Обработка токена авторизации
  Future<void> _processAuthToken(String token) async {
    if (_isProcessingAuthToken) {
      print('Already processing auth token, ignoring');
      return;
    }
    
    setState(() {
      _isProcessingAuthToken = true;
    });
    
    try {
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/mobile-auth-data/'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'XaneoMobileApp/1.0',
        },
        body: json.encode({
          'token': token,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final success = jsonData['success'] as bool? ?? false;
        final tfaRequired = jsonData['tfa_required'] as bool? ?? false;
        
        if (success) {
          final userInfo = jsonData['user_info'] as Map<String, dynamic>? ?? {};
          final message = jsonData['message'] as String? ?? 'Авторизация успешна';
          
          print('Auth success for user: ${userInfo['username']}');
          
          // Закрываем все открытые модальные окна (включая "проверьте свой email")
          if (mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
          
          _showToast(message);
          
          // Здесь можно добавить логику перехода к главному экрану приложения
          // или сохранения данных пользователя
          
        } else if (tfaRequired) {
          // Требуется двухфакторная аутентификация
          final userInfo = jsonData['user_info'] as Map<String, dynamic>? ?? {};
          final email = userInfo['email'] as String? ?? '';
          
          print('2FA required for user: ${userInfo['username']}');
          
          // Закрываем все открытые модальные окна
          if (mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            
            // Показываем модальное окно 2FA после небольшой задержки
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) {
                _show2FAModal(context, email, token);
              }
            });
          }
        } else {
          final message = jsonData['message'] as String? ?? 'Ошибка авторизации';
          _showToast(message);
        }
      } else {
        _showToast('Ошибка сервера при авторизации');
      }
    } catch (e) {
      print('Auth token processing error: $e');
      _showToast('Ошибка соединения при авторизации');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingAuthToken = false;
        });
      }
    }
  }

  /// Проверяет, содержит ли никнейм только допустимые символы
  /// (латинские буквы, цифры, точки и подчеркивание)
  bool _isValidNicknameCharacters(String nickname) {
    // Проверяем допустимые символы: только латинские буквы, цифры, точки и _
    final RegExp validChars = RegExp(r'^[a-zA-Z0-9._]+$');
    return validChars.hasMatch(nickname);
  }
  
  /// Проверяет правильность начала никнейма
  /// Правила: не может начинаться с цифры, подчеркивания или точки
  bool _isValidNicknameStart(String nickname) {
    return !nickname.startsWith(RegExp(r'[0-9._]'));
  }
  
  /// Проверяет правильность окончания никнейма
  /// Правила: не может заканчиваться точкой или подчеркиванием
  bool _isValidNicknameEnd(String nickname) {
    return !nickname.endsWith('.') && !nickname.endsWith('_');
  }

  /// Проверяет, содержит ли пароль кириллические символы
  bool _containsCyrillic(String password) {
    final RegExp cyrillicRegex = RegExp(r'[а-яё]', caseSensitive: false);
    return cyrillicRegex.hasMatch(password);
  }

  /// Оценивает силу пароля
  /// Возвращает 'weak', 'medium' или 'strong'
  String _evaluatePasswordStrength(String password) {
    int score = 0;
    
    // Длина пароля
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Содержит строчные буквы
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    
    // Содержит заглавные буквы
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    
    // Содержит цифры
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    
    // Содержит специальные символы
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;
    
    if (score <= 2) {
      return 'weak';
    } else if (score <= 4) {
      return 'medium';
    } else {
      return 'strong';
    }
  }

  /// Проверяет, является ли email поддерживаемым
  /// Поддерживаемые домены: gmail.com, outlook.com, hotmail.com, yandex.ru, ya.ru, mail.ru, icloud.com, yahoo.com
  bool _isValidEmailDomain(String email) {
    final supportedDomains = [
      'gmail.com',
      'outlook.com', 
      'hotmail.com',
      'yandex.ru',
      'ya.ru', 
      'mail.ru',
      'icloud.com',
      'yahoo.com',
    ];
    
    final emailLower = email.toLowerCase();
    return supportedDomains.any((domain) => emailLower.endsWith('@$domain'));
  }

  /// Проверяет, является ли email валидным по формату
  bool _isValidEmailFormat(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    return emailRegExp.hasMatch(email);
  }

  /// Возвращает текст ошибки валидации email на основе типа ошибки
  String _getEmailErrorMessage(AppLocalizations l10n) {
    switch (_emailErrorType) {
      case 'format':
        return l10n.emailFormatError;
      case 'unsupported':
        return l10n.emailUnsupportedError;
      case 'taken':
        return l10n.emailTakenError;
      case 'server':
        return l10n.emailServerError;
      default:
        return '';
    }
  }

  /// Возвращает текст ошибки валидации пароля на основе типа ошибки
  String _getPasswordErrorMessage(AppLocalizations l10n) {
    switch (_passwordErrorType) {
      case 'cyrillic':
        return l10n.passwordInvalidCharsError;
      case 'weak':
        return l10n.passwordWeakError;
      case 'medium':
        return l10n.passwordMediumWarning;
      default:
        return '';
    }
  }

  /// Возвращает текст ошибки валидации никнейма на основе типа ошибки
  String _getNicknameErrorMessage(AppLocalizations l10n) {
    switch (_nicknameErrorType) {
      case 'latin':
        return l10n.nicknameLatinOnlyError;
      case 'start':
        return l10n.nicknameStartError;
      case 'end':
        return l10n.nicknameEndError;
      case 'length':
        return l10n.nicknameMinLengthError;
      case 'taken':
        return l10n.nicknameTakenError;
      case 'server':
        return l10n.nicknameServerError;
      default:
        return '';
    }
  }

  /// Проверяет доступность никнейма на сервере
  Future<void> _checkNicknameAvailability(String nickname) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.192.222.215/api/v1/auth/check-username/?username=${Uri.encodeComponent(nickname)}'),
        headers: {
          'User-Agent': 'XaneoMobile Flutter App',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final isAvailable = jsonData['available'] as bool;
        
        if (mounted) {
          setState(() {
            _isCheckingNickname = false;
            
            if (isAvailable) {
              _isNicknameAvailable = true;
              _isNicknameTaken = false;
              _showNicknameError = false;
              _nicknameErrorType = '';
            } else {
              _isNicknameAvailable = false;
              _isNicknameTaken = true;
              _showNicknameError = true;
              _nicknameErrorType = 'taken';
            }
          });
        }
      } else {
        // Ошибка HTTP
        if (mounted) {
          setState(() {
            _isCheckingNickname = false;
            _isNicknameAvailable = false;
            _isNicknameTaken = false;
            _showNicknameError = true;
            _nicknameErrorType = 'server';
          });
        }
      }
    } catch (e) {
      // Ошибка сети или таймаут
      if (mounted) {
        setState(() {
          _isCheckingNickname = false;
          _isNicknameAvailable = false;
          _isNicknameTaken = false;
          _showNicknameError = true;
          _nicknameErrorType = 'server';
        });
      }
    }
  }

  /// Отправляет POST-запрос для отправки кода подтверждения на email
  Future<void> _sendVerificationCode() async {
    final email = _emailController.text.trim();
    final l10n = AppLocalizations.of(context);
    
    if (email.isEmpty) {
      return;
    }
    
    try {
      
      // Определяем никнейм для отправки
      String usernameToSend = '';
      if (_registerNicknameController.text.trim().isNotEmpty) {
        // Используем введенный пользователем никнейм
        usernameToSend = _registerNicknameController.text.trim();
      } else if (_generatedNickname.isNotEmpty) {
        // Используем заводской никнейм
        usernameToSend = _generatedNickname;
      }
      
      
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/send-verification-code/'),
        headers: {
          'User-Agent': 'XaneoMobileApp/1.0',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'username': usernameToSend,
        }),
      ).timeout(const Duration(seconds: 15));


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final success = jsonData['success'] as bool? ?? false;
        final message = jsonData['message'] as String? ?? '';
        
        if (success) {
          final expiresIn = jsonData['expires_in'] as int? ?? 600;
          _showToast(l10n.verificationCodeSent(email, expiresIn));
        } else {
          _showToast(message.isNotEmpty ? message : l10n.codeDeliveryError);
        }
      } else {
        // Ошибка HTTP
        _showToast(l10n.serverErrorCodeDelivery);
      }
    } catch (e) {
      // Ошибка сети или таймаут
      _showToast(l10n.connectionErrorCodeDelivery);
    }
  }

  /// Отправляет POST-запрос для отправки 2FA кода на email
  Future<void> _send2FACode(String token) async {
    if (token.isEmpty) {
      return;
    }
    
    try {
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/send-tfa-code/'),
        headers: {
          'User-Agent': 'XaneoMobileApp/1.0',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'token': token,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final success = jsonData['success'] as bool? ?? false;
        final message = jsonData['message'] as String? ?? '';
        
        if (success) {
          print('2FA code sent successfully');
          // Можно показать Toast или оставить без уведомления
          // _showToast('Код 2FA отправлен на почту');
        } else {
          _showToast(message.isNotEmpty ? message : 'Ошибка отправки 2FA кода');
        }
      } else {
        // Ошибка HTTP
        _showToast('Ошибка сервера при отправке 2FA кода');
      }
    } catch (e) {
      // Ошибка сети или таймаут
      print('2FA code sending error: $e');
      _showToast('Ошибка соединения при отправке 2FA кода');
    }
  }

  /// Проверяет код подтверждения email на сервере
  Future<void> _verifyEmailCode(String code, StateSetter setModalState) async {
    final email = _emailController.text.trim();
    final l10n = AppLocalizations.of(context);
    
    if (email.isEmpty || code.isEmpty) {
      return;
    }
    
    // Устанавливаем состояние загрузки
    setModalState(() {
      _isVerifyingCode = true;
    });
    
    try {
      
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/verify-email-code/'),
        headers: {
          'User-Agent': 'XaneoMobile Flutter App',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'code': code,
        }),
      ).timeout(const Duration(seconds: 15));


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final verified = jsonData['verified'] as bool? ?? false;
        
        if (verified) {
          _showToast(l10n.emailVerificationSuccess);
          
          // Закрываем модальное окно и переходим к следующему шагу (пароль)
          if (mounted) {
            Navigator.of(context).pop();
            setState(() {
              _registrationStep = 4; // Переход к шагу пароля
            });
          }
        } else {
          // Код неверный - показываем конкретное сообщение
          _showToast(l10n.invalidVerificationCode);
        }
      } else if (response.statusCode == 400) {
        // Плохой запрос - скорее всего неверный код
        _showToast(l10n.invalidVerificationCode);
      } else if (response.statusCode == 404) {
        // Email не найден
        _showToast(l10n.emailNotFound);
      } else if (response.statusCode == 410) {
        // Код истек
        _showToast(l10n.verificationCodeExpired);
      } else {
        // Другие ошибки сервера
        _showToast(l10n.serverErrorCodeVerification);
      }
    } catch (e) {
      // Ошибка сети или таймаут
      _showToast(l10n.connectionErrorCodeVerification);
    } finally {
      // Убираем состояние загрузки
      if (mounted) {
        setModalState(() {
          _isVerifyingCode = false;
        });
      }
    }
  }

  /// Проверяет код 2FA на сервере
  Future<void> _verify2FACode(String code, String authToken, StateSetter setModalState) async {
    if (code.isEmpty || authToken.isEmpty) {
      return;
    }
    
    // Устанавливаем состояние загрузки
    setModalState(() {
      _isVerifying2FA = true;
    });
    
    try {
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/verify-tfa-code/'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'XaneoMobileApp/1.0',
        },
        body: json.encode({
          'token': authToken,
          'code': code,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final success = jsonData['success'] as bool? ?? false;
        
        if (success) {
          final userInfo = jsonData['user_info'] as Map<String, dynamic>? ?? {};
          final message = jsonData['message'] as String? ?? 'Авторизация успешна';
          
          print('2FA verification successful for user: ${userInfo['username']}');
          
          // Закрываем все модальные окна
          if (mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
          
          _showToast(message);
          
          // Здесь можно добавить логику перехода к главному экрану приложения
          
        } else {
          final message = jsonData['message'] as String? ?? 'Неверный код 2FA';
          _showToast(message);
        }
      } else if (response.statusCode == 400) {
        _showToast('Неверный код 2FA');
      } else if (response.statusCode == 410) {
        _showToast('Код 2FA истек');
      } else {
        _showToast('Ошибка сервера при проверке 2FA');
      }
    } catch (e) {
      print('2FA verification error: $e');
      _showToast('Ошибка соединения при проверке 2FA');
    } finally {
      // Убираем состояние загрузки
      if (mounted) {
        setModalState(() {
          _isVerifying2FA = false;
        });
      }
    }
  }

  Future<void> _sendLoginCode(String username, StateSetter setModalState, BuildContext modalContext) async {
    if (username.isEmpty) {
      return;
    }
    
    // Устанавливаем состояние загрузки
    setModalState(() {
      _isVerifyingPasswordResetCode = true; // Используем ту же переменную для состояния загрузки
    });
    
    try {
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/send-login-code/'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'XaneoMobileApp/1.0',
        },
        body: json.encode({
          'username': username,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final success = jsonData['success'] as bool? ?? false;
        
        if (success) {
          final email = jsonData['email_masked'] as String? ?? '';
          
          // _showToast(message);
          if (mounted && email.isNotEmpty) { //какое то из условий не выполняется
            // Закрываем текущую модалку
            Navigator.of(modalContext).pop();
            
            // Показываем новую модалку после небольшой задержки
            Future.delayed(const Duration(milliseconds: 50), () {
              if (mounted) {
                _showEmailSentSuccessModal(context, email);
              }
            });
            return; // Выходим из метода, не выполняя finally блок для сброса состояния
          }
        } else {
          // Обрабатываем случай когда success = false
          final message = jsonData['message'] as String? ?? 'Неизвестная ошибка';
          final field = jsonData['field'] as String? ?? '';
          
          if (field == 'username') {
            // Никнейм не найден - показываем специальное модальное окно
            if (mounted) {
              Navigator.of(modalContext).pop();
              _showUsernameNotFoundModal(modalContext);
            }
          } else {
            _showToast(message);
          }
        }
      } else if (response.statusCode == 400) {
        // Плохой запрос
        _showToast('Неверные данные. Проверьте никнейм.');
      } else if (response.statusCode == 404) {
        // Пользователь не найден
        if (mounted) {
          Navigator.of(modalContext).pop();
          _showUsernameNotFoundModal(modalContext);
        }
      } else {
        // Другие ошибки сервера
        _showToast('Ошибка сервера. Попробуйте позже.');
      }
    } catch (e) {
      // Ошибка сети или таймаут
      _showToast('Ошибка соединения. Проверьте интернет и попробуйте снова.');
    } finally {
      // Убираем состояние загрузки
      if (mounted) {
        setModalState(() {
          _isVerifyingPasswordResetCode = false;
        });
      }
    }
  }

  /// Проверяет доступность email на сервере
  Future<void> _checkEmailAvailability(String email) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.192.222.215/api/v1/auth/check-email/?email=${Uri.encodeComponent(email)}'),
        headers: {
          'User-Agent': 'XaneoMobile Flutter App',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final isAvailable = jsonData['available'] as bool;
        
        if (mounted) {
          setState(() {
            _isCheckingEmail = false;
            
            if (isAvailable) {
              _isEmailAvailable = true;
              _showEmailError = false;
              _emailErrorType = '';
            } else {
              _isEmailAvailable = false;
              _showEmailError = true;
              _emailErrorType = 'taken';
            }
          });
        }
      } else {
        // Ошибка HTTP
        if (mounted) {
          setState(() {
            _isCheckingEmail = false;
            _isEmailAvailable = false;
            _showEmailError = true;
            _emailErrorType = 'server';
          });
        }
      }
    } catch (e) {
      // Ошибка сети или таймаут
      if (mounted) {
        setState(() {
          _isCheckingEmail = false;
          _isEmailAvailable = false;
          _showEmailError = true;
          _emailErrorType = 'server';
        });
      }
    }
  }

  /// Получает следующий ID пользователя для автогенерации никнейма
  Future<String?> _getNextUserId() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.192.222.215/api/v1/auth/next-user-id/'),
        headers: {
          'User-Agent': 'XaneoMobile Flutter App',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final nextId = jsonData['next_id'];
        return nextId.toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Генерирует заводской никнейм и сохраняет в переменной
  Future<void> _generateFactoryNickname() async {
    final nextId = await _getNextUserId();
    if (nextId != null) {
      setState(() {
        _generatedNickname = 'user$nextId';
      });
    }
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
    
    setState(() {
      _isFirstLaunch = !hasSeenOnboarding;
    });
    
    // Если это не первый запуск, сразу показываем форму входа
    if (!_isFirstLaunch) {
      _skipToLogin();
    }
  }

  Future<void> _markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
  }

  void _skipToLogin() {
    // Запускаем анимацию лого, которая приведет к форме входа
    _logoAnimationController.forward().then((_) {
      // Сразу показываем форму входа без онбординга
      setState(() {
        _showInputFields = true;
      });
      _inputFieldsController.forward();
    });
  }

  void _switchToRegisterMode() {
    print('_switchToRegisterMode called, current _isLoginMode: $_isLoginMode');
    // Запускаем анимацию исчезновения формы входа
    _formTransitionController.forward().then((_) {
      print('Animation forward completed, switching to register mode');
      // Переключаем режим на регистрацию
      setState(() {
        _isLoginMode = false;
      });
      print('setState completed, _isLoginMode now: $_isLoginMode');
      // Запускаем анимацию появления формы регистрации
      _formTransitionController.reverse();
    });
  }

  void _switchToLoginMode() {
    // Запускаем анимацию исчезновения формы регистрации
    _formTransitionController.forward().then((_) {
      // Переключаем режим на вход
      setState(() {
        _isLoginMode = true;
      });
      // Запускаем анимацию появления формы входа
      _formTransitionController.reverse();
    });
  }

  void _showDatePicker(BuildContext context) {
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
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Заголовок
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Пустое место слева для центрирования заголовка
                    const SizedBox(width: 48),
                    Text(
                      l10n.selectDate,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                    ),
                    // Кнопка с галочкой
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (_selectedBirthdate != null) {
                          // Переходим к следующему шагу
                          setState(() {
                            _registrationStep = 1;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.check_rounded,
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        size: 24,
                      ),
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(48, 48),
                      ),
                    ),
                  ],
                ),
              ),
              // iOS-стиль селектор даты
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Inter',
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _selectedBirthdate ?? DateTime(2000, 1, 1),
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year - 14, // Минимум 14 лет
                    onDateTimeChanged: (DateTime newDate) {
                      // Автоматическая коррекция даты для корректных дней месяца
                      DateTime correctedDate = _correctDate(newDate);
                      setState(() {
                        _selectedBirthdate = correctedDate;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }

  /// Корректирует дату, чтобы она была валидной
  /// Например, 31 апреля -> 30 апреля
  DateTime _correctDate(DateTime date) {
    try {
      // Пытаемся создать дату с теми же параметрами
      return DateTime(date.year, date.month, date.day);
    } catch (e) {
      // Если дата невалидна, берем последний день месяца
      int lastDayOfMonth = DateTime(date.year, date.month + 1, 0).day;
      return DateTime(date.year, date.month, lastDayOfMonth);
    }
  }

  Widget _buildNameStep() {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Подзаголовок "Как вас зовут?"
        Text(
          l10n.registerNameSubtitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Поле для ввода имени
        Container(
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.grey.shade400.withOpacity(0.3),
                selectionHandleColor: Colors.grey.shade400,
              ),
            ),
            child: TextField(
              controller: _nameController,
              cursorColor: Colors.grey.shade400,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Inter',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: l10n.nameFieldHint,
                hintStyle: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Кнопка "Далее"
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isNameFieldEmpty ? null : () {
              final name = _nameController.text.trim();
              
              if (name.isNotEmpty) {
                setState(() {
                  _registrationStep = 1;
                });
              } else {
                _showToast(l10n.fillAllFields);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isNameFieldEmpty ? Colors.red : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800),
              foregroundColor: _isNameFieldEmpty ? Colors.red : Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.nextButton,
              style: TextStyle(
                color: _isNameFieldEmpty ? Colors.grey.shade700 : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white),
                fontFamily: 'Inter',
                fontSize: 16,
                fontVariations: [FontVariation('wght', 600)],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Ссылка "Уже есть аккаунт?"
        GestureDetector(
          onTap: () {
            _switchToLoginMode();
          },
          child: Text(
            l10n.alreadyHaveAccount,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildBirthdateStep() {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Подзаголовок "Когда вы родились?"
        Text(
          l10n.registerBirthdateSubtitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Кнопка для выбора даты
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () => _showDatePicker(context),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _selectedBirthdate != null
                        ? '${_selectedBirthdate!.day.toString().padLeft(2, '0')}.${_selectedBirthdate!.month.toString().padLeft(2, '0')}.${_selectedBirthdate!.year}'
                        : l10n.selectDate,
                    style: TextStyle(
                      color: (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                      fontFamily: 'Inter',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Кнопка "Далее"
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedBirthdate != null ? () {
              // Переход к следующему шагу регистрации (никнейм)
              setState(() {
                _registrationStep = 2;
              });
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedBirthdate != null ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800) : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.nextButton,
              style: TextStyle(
                fontFamily: 'Inter',
                color: _selectedBirthdate != null ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white) : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                fontSize: 16,
                fontVariations: [FontVariation('wght', 600)],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Ссылка "Какие есть ограничения по возрасту?"
        GestureDetector(
          onTap: () {
            _showAgeRestrictionsModal(context);
          },
          child: Text(
            l10n.ageRestrictionsLink,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        // Ссылка "Уже есть аккаунт?"
        GestureDetector(
          onTap: () {
            _switchToLoginMode();
          },
          child: Text(
            l10n.alreadyHaveAccount,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildNicknameStep() {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Подзаголовок "Придумайте никнейм"
        Text(
          l10n.registerNicknameSubtitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Поле для ввода никнейма
        Container(
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.grey.shade400.withOpacity(0.3),
                selectionHandleColor: Colors.grey.shade400,
              ),
            ),
            child: TextField(
              controller: _registerNicknameController,
              cursorColor: Colors.grey.shade400,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Inter',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: l10n.nicknameFieldHint,
                hintStyle: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ),
        
        // Блок отображения ошибок валидации никнейма
        if (_showNicknameError && _nicknameErrorType.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade400,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getNicknameErrorMessage(l10n),
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // Блок отображения состояния проверки никнейма
        if (_isCheckingNickname)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Lottie.asset(
                    'assets/animations/loading.json',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    repeat: true,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const ['Circle 1', '**'],
                          value: Colors.yellow.shade600,
                        ),
                        ValueDelegate.color(
                          const ['Circle 2', '**'],
                          value: Colors.yellow.shade600,
                        ),
                        ValueDelegate.color(
                          const ['Circle 3', '**'],
                          value: Colors.yellow.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.checkingNickname,
                    style: TextStyle(
                      color: Colors.yellow.shade600,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // Блок отображения состояния "Никнейм свободен"
        if (_registerNicknameController.text.trim().isNotEmpty && _isNicknameAvailable && !_isCheckingNickname && !_showNicknameError)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.string(
                    '''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g clip-path="url(#clip0_1545_11315)">
                    <path d="M4 8L6.05 9.64C6.10506 9.68534 6.16952 9.71784 6.23872 9.73514C6.30791 9.75244 6.38009 9.7541 6.45 9.74C6.52058 9.72676 6.58749 9.69847 6.64616 9.65706C6.70483 9.61564 6.75389 9.56207 6.79 9.5L10 4" stroke="#4CAF50" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M7 13.5C10.5899 13.5 13.5 10.5899 13.5 7C13.5 3.41015 10.5899 0.5 7 0.5C3.41015 0.5 0.5 3.41015 0.5 7C0.5 10.5899 3.41015 13.5 7 13.5Z" stroke="#4CAF50" stroke-linecap="round" stroke-linejoin="round"/>
                    </g>
                    <defs>
                    <clipPath id="clip0_1545_11315">
                    <rect width="14" height="14" fill="white"/>
                    </clipPath>
                    </defs>
                    </svg>''',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.nicknameAvailable,
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        const SizedBox(height: 24), // Фиксированный отступ вместо анимированного
        // Анимированный контейнер для кнопки и ссылок
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            children: [
              // Кнопка "Далее"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final nickname = _registerNicknameController.text.trim();
                    
                    // Генерируем заводской никнейм для отображения
                    await _generateFactoryNickname();
                    
                    // Если никнейм введен, валиден и доступен - используем его
                    if (nickname.isNotEmpty && 
                        _isNicknameValid && 
                        !_isCheckingNickname && 
                        _isNicknameAvailable && 
                        !_isNicknameTaken && 
                        !_showNicknameError) {
                      // Сохраняем введенный никнейм и переходим дальше
                      setState(() {
                        _registrationStep = 3;
                      });
                    } else {
                      // В любом другом случае (пустое поле, невалидный, занят) - переходим к этапу 4 без никнейма
                      setState(() {
                        _registerNicknameController.clear(); // Очищаем поле
                        _registrationStep = 3; // Переходим к этапу 4 (ввод email)
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.nextButton,
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontVariations: [FontVariation('wght', 600)],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              // Ссылка "Не можете придумать никнейм?"
              GestureDetector(
                onTap: () {
                  _showNicknameGeneratorModal(context);
                },
                child: Text(
                  l10n.nicknameHelpLink,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              // Ссылка "Уже есть аккаунт?"
              GestureDetector(
                onTap: () {
                  _switchToLoginMode();
                },
                child: Text(
                  l10n.alreadyHaveAccount,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailStep() {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Подзаголовок "Введите e-mail"
        Text(
          l10n.registerEmailSubtitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Поле для ввода email
        Container(
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.grey.shade400.withOpacity(0.3),
                selectionHandleColor: Colors.grey.shade400,
              ),
            ),
            child: TextField(
              controller: _emailController,
              cursorColor: Colors.grey.shade400,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Inter',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: l10n.emailFieldHint,
                hintStyle: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ),
        
        // Блок отображения ошибок валидации email
        if (_showEmailError && _emailErrorType.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade400,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getEmailErrorMessage(l10n),
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // Блок отображения состояния проверки email
        if (_isCheckingEmail)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Lottie.asset(
                    'assets/animations/loading.json',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    repeat: true,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const ['Circle 1', '**'],
                          value: Colors.yellow.shade600,
                        ),
                        ValueDelegate.color(
                          const ['Circle 2', '**'],
                          value: Colors.yellow.shade600,
                        ),
                        ValueDelegate.color(
                          const ['Circle 3', '**'],
                          value: Colors.yellow.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.checkingEmail,
                    style: TextStyle(
                      color: Colors.yellow.shade600,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // Блок отображения состояния "Email доступен"
        if (_emailController.text.trim().isNotEmpty && _isEmailAvailable && !_isCheckingEmail && !_showEmailError)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.string(
                    '''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g clip-path="url(#clip0_1545_11315)">
                    <path d="M4 8L6.05 9.64C6.10506 9.68534 6.16952 9.71784 6.23872 9.73514C6.30791 9.75244 6.38009 9.7541 6.45 9.74C6.52058 9.72676 6.58749 9.69847 6.64616 9.65706C6.70483 9.61564 6.75389 9.56207 6.79 9.5L10 4" stroke="#4CAF50" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M7 13.5C10.5899 13.5 13.5 10.5899 13.5 7C13.5 3.41015 10.5899 0.5 7 0.5C3.41015 0.5 0.5 3.41015 0.5 7C0.5 10.5899 3.41015 13.5 7 13.5Z" stroke="#4CAF50" stroke-linecap="round" stroke-linejoin="round"/>
                    </g>
                    <defs>
                    <clipPath id="clip0_1545_11315">
                    <rect width="14" height="14" fill="white"/>
                    </clipPath>
                    </defs>
                    </svg>''',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.emailAvailable,
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Кнопка "Далее"
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (!_isEmailFieldEmpty && _isEmailValid && !_showEmailError && _isEmailAvailable && !_isCheckingEmail) ? () {
              final email = _emailController.text.trim();
              
              if (email.isNotEmpty) {
                // Показываем модальное окно подтверждения email
                _showEmailVerificationModal(context);
              } else {
                _showToast(l10n.fillAllFields);
              }
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: (!_isEmailFieldEmpty && _isEmailValid && !_showEmailError && _isEmailAvailable && !_isCheckingEmail) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800) : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black: Colors.grey.shade700),
              foregroundColor: (!_isEmailFieldEmpty && _isEmailValid && !_showEmailError && _isEmailAvailable && !_isCheckingEmail) ? Colors.black : Colors.grey.shade400,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.nextButton,
              style: TextStyle(
                color: (!_isEmailFieldEmpty && _isEmailValid && !_showEmailError && _isEmailAvailable && !_isCheckingEmail) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white) : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                fontFamily: 'Inter',
                fontSize: 16,
                fontVariations: [FontVariation('wght', 600)],
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        // Ссылка "Какие почтовые операторы поддерживаются?"
        GestureDetector(
          onTap: () {
            _showSupportedEmailProvidersModal(context);
          },
          child: Text(
            l10n.supportedEmailProvidersLink,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        // Ссылка "Уже есть аккаунт?"
        GestureDetector(
          onTap: () {
            _switchToLoginMode();
          },
          child: Text(
            l10n.alreadyHaveAccount,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Подзаголовок "Придумайте пароль"
        Text(
          l10n.registerPasswordSubtitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Поле для ввода пароля
        Container(
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.grey.shade400.withOpacity(0.3),
                selectionHandleColor: Colors.grey.shade400,
              ),
            ),
            child: TextField(
              controller: _passwordController,
              cursorColor: Colors.grey.shade400,
              obscureText: !_isPasswordVisible,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Inter',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: l10n.registerPasswordFieldHint,
                hintStyle: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        
        // Блок отображения ошибок валидации пароля
        if (_showPasswordError && _passwordErrorType.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: _passwordErrorType == 'medium' ? Colors.orange.shade400 : Colors.red.shade400,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getPasswordErrorMessage(l10n),
                    style: TextStyle(
                      color: _passwordErrorType == 'medium' ? Colors.orange.shade400 : Colors.red.shade400,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // Блок отображения состояния "Пароль сильный"
        if (_passwordController.text.trim().isNotEmpty && _passwordStrength == 'strong' && !_showPasswordError)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green.shade400,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.passwordStrongSuccess,
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Кнопка "Далее"
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (!_isPasswordFieldEmpty && _isPasswordValid && _passwordErrorType != 'weak' && _passwordErrorType != 'cyrillic') ? () {
              // Показываем модальное окно подтверждения пароля
              _showPasswordConfirmationModal(context);
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: (!_isPasswordFieldEmpty && _isPasswordValid && _passwordErrorType != 'weak' && _passwordErrorType != 'cyrillic') ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800) : Colors.grey.shade700,
              foregroundColor: (!_isPasswordFieldEmpty && _isPasswordValid && _passwordErrorType != 'weak' && _passwordErrorType != 'cyrillic') ? Colors.black : Colors.grey.shade400,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.nextButton,
              style: TextStyle(
                color: (!_isPasswordFieldEmpty && _isPasswordValid && _passwordErrorType != 'weak' && _passwordErrorType != 'cyrillic') ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white) : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                fontFamily: 'Inter',
                fontSize: 16,
                fontVariations: [FontVariation('wght', 600)],
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        // Ссылка "Уже есть аккаунт?"
        GestureDetector(
          onTap: () {
            _switchToLoginMode();
          },
          child: Text(
            l10n.alreadyHaveAccount,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStep() {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Подзаголовок "Выберите аватарку"
        Text(
          l10n.registerAvatarSubtitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        
        // Аватарка - большой кружок с иконкой фотки или выбранным изображением
        GestureDetector(
          onTap: () {
            _checkPhotoPermissionAndProceed();
          },
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 2,
                  ),
                ),
                child: _selectedAvatarImage != null
                    ? ClipOval(
                        child: Image.file(
                          _selectedAvatarImage!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey.shade400,
                        size: 48,
                      ),
              ),
              // Маленький кружочек с плюсом в правом нижнем углу
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _selectedAvatarImage != null ? Icons.edit : Icons.add,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Подсказка
        Text(
          l10n.addAvatarHint,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 40),
        
        // Кнопки - показываем разные в зависимости от выбора аватара
        if (_selectedAvatarImage != null) ...[
          // Основная кнопка "Продолжить" когда аватар выбран
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _registrationStep = 6; // Переход к шагу превью профиля
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.nextButton,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontVariations: [FontVariation('wght', 600)],
                ),
              ),
            ),
          ),
        ] else ...[
          // Кнопка "Пропустить" когда аватар не выбран
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Пропускаем выбор аватара и переходим к следующему шагу
                setState(() {
                  _registrationStep = 6; // Следующий шаг (пока не реализован)
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.skipButton,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontVariations: [FontVariation('wght', 600)],
                ),
              ),
            ),
          ),
        ],
        
        const SizedBox(height: 20),
        // Ссылка "Уже есть аккаунт?"
        GestureDetector(
          onTap: () {
            _switchToLoginMode();
          },
          child: Text(
            l10n.alreadyHaveAccount,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Шаг 7: Превью профиля
  Widget _buildProfilePreviewStep() {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Подзаголовок (центрированный)
        Center(
          child: Text(
            l10n.profilePreviewTitle,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Превью профиля в большом размере
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade600.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start, // Явно указываем выравнивание влево
            children: [
              // Аватарка (увеличенная версия) - интерактивная
              GestureDetector(
                onTap: _showAvatarPicker,
                child: Stack(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade600,
                          width: 2,
                        ),
                      ),
                      child: _selectedAvatarImage != null
                          ? ClipOval(
                              child: Image.file(
                                _selectedAvatarImage!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              color: Colors.grey.shade400,
                              size: 35,
                            ),
                    ),
                    // Индикатор редактирования
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade800, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
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
                      _getGreeting(),
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0, // Уменьшаем высоту строки
                      ),
                    ),
                    // Имя пользователя - интерактивное
                    GestureDetector(
                      onTap: _showNameEditDialog,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _nameController.text.isNotEmpty ? _nameController.text : 'Ваше имя',
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade900,
                                fontFamily: 'Inter',
                                fontSize: 24,
                                fontVariations: [FontVariation('wght', 600)],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.grey.shade500,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    // Никнейм (если введен) - интерактивный
                    if (_registerNicknameController.text.isNotEmpty)
                      GestureDetector(
                        onTap: _showNicknameEditDialog,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '@${_registerNicknameController.text}',
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade700,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.grey.shade600,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    // Добавить никнейм (если не введен)
                    if (_registerNicknameController.text.isEmpty)
                      GestureDetector(
                        onTap: _showNicknameEditDialog,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _generatedNickname.isNotEmpty ? '@$_generatedNickname' : 'Добавить никнейм',
                                style: TextStyle(
                                  color: _generatedNickname.isNotEmpty ? Colors.grey.shade500 : Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Icon(
                              _generatedNickname.isNotEmpty ? Icons.edit : Icons.add,
                              color: _generatedNickname.isNotEmpty ? Colors.grey.shade600 : Colors.white,
                              size: _generatedNickname.isNotEmpty ? 14 : 16,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Кнопка завершения
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              _showTermsAndConditionsDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.finishButton,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                fontFamily: 'Inter',
                fontSize: 16,
                fontVariations: [FontVariation('wght', 600)],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Получает приветствие в зависимости от времени дня
  String _getGreeting() {
    final l10n = AppLocalizations.of(context);
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 12) {
      return l10n.goodMorning;
    } else if (hour >= 12 && hour < 18) {
      return l10n.goodDay;
    } else if (hour >= 18 && hour < 22) {
      return l10n.goodEvening;
    } else {
      return l10n.goodNight;
    }
  }

  /// Проверяет разрешение на доступ к фото и показывает соответствующее окно
  Future<void> _checkPhotoPermissionAndProceed() async {
    final l10n = AppLocalizations.of(context);
    
    // Попробуем несколько вариантов разрешений
    List<Permission> permissionsToTry = [
      Permission.photos,           // Новые Android (13+)
      Permission.storage,          // Старые Android
      Permission.mediaLibrary,     // iOS и некоторые Android
    ];
    
    for (Permission permission in permissionsToTry) {
      try {
        
        // Проверяем статус разрешения
        PermissionStatus status = await permission.status;
        
        
        if (status.isGranted) {
          // Разрешение уже предоставлено - переходим к выбору изображения
          _selectImage();
          return;
        } else if (status.isPermanentlyDenied) {
          // Разрешение навсегда отклонено - направляем в настройки
          _showToast(l10n.permissionDeniedSettings);
          return;
        }
      } catch (e) {
        continue;
      }
    }
    
    // Если ни одно разрешение не предоставлено, показываем модальное окно с запросом
    _showPhotoPermissionModal();
  }

  /// Выбор изображения из галереи с последующим кропингом
  Future<void> _selectImage() async {
    final l10n = AppLocalizations.of(context);
    
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200, // Увеличили для лучшего качества при кропинге
        maxHeight: 1200, 
        imageQuality: 90, // Увеличили качество для кропинга
      );
      
      if (image != null) {
        
        // Переходим к экрану кропинга
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AvatarCropper(
                imageFile: File(image.path),
                onCropped: (croppedFile) {
                  // Когда кропинг завершен
                  setState(() {
                    _selectedAvatarImage = croppedFile;
                  });
                  Navigator.pop(context);
                  _showToast(l10n.avatarCropped);
                },
                onCancel: () {
                  // Когда пользователь отменил кропинг
                  Navigator.pop(context);
                },
              ),
            ),
          );
        }
      } else {
      }
    } catch (e) {
      _showToast(l10n.imageSelectionError);
    }
  }

  /// Показывает модальное окно с запросом разрешения на доступ к фото
  void _showPhotoPermissionModal() {
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
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8, // Только максимум для безопасности
          ),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Серая полоска сверху (как в iOS)
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Контент, который адаптируется к размеру
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Иконка изображения
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        size: 32,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Заголовок
                    Text(
                      l10n.photoPermissionTitle,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Описание (адаптивное)
                    Text(
                      l10n.photoPermissionDescription,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Кнопки
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Кнопка "Разрешить доступ"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _requestPhotoPermission();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.allowAccessButton,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Кнопка "Не сейчас"
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          l10n.notNowButton,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  /// Запрашивает разрешение на доступ к фото
  Future<void> _requestPhotoPermission() async {
    final l10n = AppLocalizations.of(context);
    
    // Попробуем несколько вариантов разрешений
    List<Permission> permissionsToTry = [
      Permission.photos,           // Новые Android (13+)
      Permission.storage,          // Старые Android
      Permission.mediaLibrary,     // iOS и некоторые Android
    ];
    
    for (Permission permission in permissionsToTry) {
      try {
        
        // Проверяем текущий статус
        PermissionStatus currentStatus = await permission.status;
        
        // Если уже предоставлено, используем его
        if (currentStatus.isGranted) {
          _selectImage();
          return;
        }
        
        // Делаем запрос разрешения
        PermissionStatus status = await permission.request();
        
        
        if (status.isGranted) {
          _selectImage();
          return;
        } else if (status.isPermanentlyDenied) {
          _showToast(l10n.permissionDeniedOpenSettings);
          return;
        } else {
          continue;
        }
      } catch (e) {
        continue;
      }
    }
    
    // Если ничего не сработало
    _showToast(l10n.photoPermissionError);
  }

  void _showEmailVerificationModal(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    // Отправляем POST-запрос для отправки кода подтверждения
    _sendVerificationCode();
    
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
          builder: (BuildContext context, StateSetter setModalState) {
            return Material(
              elevation: 6.0, // Elevation для модального окна верификации email
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
                minHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      // Серая полоска сверху (как в iOS)
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 30),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      
                      // Иконка письма
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Заголовок
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          l10n.verifyEmailTitle,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Описание
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          l10n.verifyEmailDescription,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Поле для ввода кода
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade600,
                              width: 1,
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                selectionColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                                selectionHandleColor: Colors.grey.shade100,
                              ),
                            ),
                            child: TextField(
                              controller: _verificationCodeController,
                              cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 24,
                                letterSpacing: 8,
                              ),
                              onChanged: (value) {
                                // Обновляем состояние модального окна при изменении текста
                                setModalState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: l10n.verificationCodeHint,
                                hintStyle: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                counterText: "", // Убираем счетчик символов
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Кнопка "Проверить"
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (_verificationCodeController.text.trim().length == 6 && !_isVerifyingCode) ? () {
                              final code = _verificationCodeController.text.trim();
                              _verifyEmailCode(code, setModalState);
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (_verificationCodeController.text.trim().length == 6 && !_isVerifyingCode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                              foregroundColor: (_verificationCodeController.text.trim().length == 6 && !_isVerifyingCode) ? Colors.black : Colors.grey.shade400,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _isVerifyingCode 
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Lottie.asset(
                                    'assets/anim/loading.json',
                                    repeat: true,
                                    delegates: LottieDelegates(
                                      values: [
                                        ValueDelegate.color(
                                          const ['**'],
                                          value: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Text(
                                  l10n.verifyButton,
                                  style: TextStyle(
                                    color: (_verificationCodeController.text.trim().length == 6 && !_isVerifyingCode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white) : Colors.grey.shade400,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontVariations: [FontVariation('wght', 600)],
                                  ),
                                ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                        ],
                      ),
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

  void _showPasswordConfirmationModal(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    // Сохраняем текущий пароль для быстрого сравнения
    _originalPassword = _passwordController.text;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return _PasswordConfirmationModalContent(
          originalPassword: _originalPassword,
          confirmPasswordTitle: l10n.confirmPasswordTitle,
          confirmPasswordDescription: l10n.confirmPasswordDescription,
          confirmPasswordFieldHint: l10n.confirmPasswordFieldHint,
          passwordMismatchError: l10n.passwordMismatchError,
          confirmButton: l10n.confirmButton,
          onConfirmed: () {
            Navigator.of(context).pop();
            setState(() {
              _registrationStep = 5; // Следующий шаг после подтверждения пароля
            });
          },
        );
      },
    );
  }

  void _showNicknameGeneratorModal(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) => _NicknameGeneratorModal(
        title: l10n.nicknameGeneratorTitle,
        description: l10n.nicknameGeneratorDescription,
        closeButtonText: l10n.gotIt,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _showEmailSentSuccessModal(BuildContext context, String email) {
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
        return Material(
          elevation: 6.0,
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Полоска-индикатор
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Иконка успеха
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: Icon(
                    Icons.email_outlined,
                    color: Colors.green.shade400,
                    size: 48,
                  ),
                ),
                
                // Заголовок
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: Text(
                    l10n.checkEmailTitle,
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontVariations: [FontVariation('wght', 600)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                // Описание с email
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Text(
                    l10n.checkEmailDescription(email),
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontVariations: [FontVariation('wght', 400)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                // Кнопка "Понятно" с анимацией загрузки
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: null, // Кнопка неактивна по умолчанию
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.grey.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Lottie.asset(
                          'assets/animations/loading.json',
                          repeat: true,
                          delegates: LottieDelegates(
                            values: [
                              ValueDelegate.color(
                                const ['**'],
                                value: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showForgotPasswordModal(BuildContext context) {
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Material(
                elevation: 6.0, // Elevation для модального окна восстановления пароля
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Полоска-индикатор
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      
                      // Иконка восстановления пароля
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                        child: Icon(
                          Icons.lock_reset,
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          size: 48,
                        ),
                      ),
                      
                      // Заголовок
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Text(
                          l10n.forgotPassword,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                      // Описание
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Text(
                          l10n.forgotPasswordDescription,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontVariations: [FontVariation('wght', 400)],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                      // Поле ввода никнейма
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade700,
                              width: 1,
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                selectionHandleColor: Colors.grey.shade400,
                              ),
                            ),
                            child: TextField(
                              controller: _forgotPasswordNicknameController,
                              cursorColor: Colors.grey.shade400,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                hintText: l10n.nicknameFieldHint,
                                hintStyle: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  fontFamily: 'Inter',
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                // Мгновенно обновляем состояние кнопки при вводе текста
                                setModalState(() {});
                              },
                              onSubmitted: (_) {
                                // Можно добавить логику отправки при нажатии Enter
                              },
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Кнопка "Отправить ссылку"
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (_forgotPasswordNicknameController.text.trim().isNotEmpty && !_isVerifyingPasswordResetCode) ? () {
                              final username = _forgotPasswordNicknameController.text.trim();
                              _sendLoginCode(username, setModalState, context);
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (_forgotPasswordNicknameController.text.trim().isNotEmpty) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                              foregroundColor: (_forgotPasswordNicknameController.text.trim().isNotEmpty) ? Colors.black : Colors.grey.shade900,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _isVerifyingPasswordResetCode 
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Lottie.asset(
                                    'assets/animations/loading.json',
                                    repeat: true,
                                    delegates: LottieDelegates(
                                      values: [
                                        ValueDelegate.color(
                                          const ['**'],
                                          value: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Text(
                                  l10n.nextButton,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontVariations: [FontVariation('wght', 600)],
                                  ),
                                ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showUsernameNotFoundModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Material(
          elevation: 6.0,
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Полоска-индикатор
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Иконка ошибки
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red.shade400,
                      size: 48,
                    ),
                  ),
                  
                  // Заголовок
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                    child: Text(
                      'Никнейм не найден',
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  // Описание
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Text(
                      'Пользователь с таким никнеймом не найден. Проверьте правильность написания и попробуйте еще раз.',
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontVariations: [FontVariation('wght', 400)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  // Кнопка "Понятно"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Возвращаемся к модальному окну ввода никнейма
                          _showForgotPasswordModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Понятно',
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _show2FAModal(BuildContext context, String email, String authToken) {
    final l10n = AppLocalizations.of(context);
    final TextEditingController tfaCodeController = TextEditingController();
    
    // Отправляем POST-запрос для отправки 2FA кода на email
    _send2FACode(authToken);
    
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
          builder: (BuildContext context, StateSetter setModalState) {
            return Material(
              elevation: 6.0,
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Серая полоска сверху (как в iOS)
                            Container(
                              margin: const EdgeInsets.only(top: 12, bottom: 30),
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            
                            // Иконка безопасности
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.security,
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Заголовок
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.checkEmailTitle,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontVariations: [FontVariation('wght', 600)],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Описание с упоминанием 2FA и email
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                AppLocalizations.of(context).twoFactorAuthMessage(email),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // Поле для ввода кода 2FA
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade600,
                                    width: 1,
                                  ),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                      selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                      selectionHandleColor: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: tfaCodeController,
                                    cursorColor: Colors.grey.shade400,
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      letterSpacing: 8,
                                    ),
                                    onChanged: (value) {
                                      // Обновляем состояние модального окна при изменении текста
                                      setModalState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: l10n.verificationCodeHint,
                                      hintStyle: TextStyle(
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      counterText: "", // Убираем счетчик символов
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // Кнопка "Проверить"
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (tfaCodeController.text.trim().length == 6 && !_isVerifying2FA) ? () {
                                    final code = tfaCodeController.text.trim();
                                    _verify2FACode(code, authToken, setModalState);
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (tfaCodeController.text.trim().length == 6 && !_isVerifying2FA) ? Colors.white : Colors.grey.shade700,
                                    foregroundColor: (tfaCodeController.text.trim().length == 6 && !_isVerifying2FA) ? Colors.black : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isVerifying2FA 
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Lottie.asset(
                                          'assets/animations/loading.json',
                                          repeat: true,
                                          delegates: LottieDelegates(
                                            values: [
                                              ValueDelegate.color(
                                                const ['**'],
                                                value: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Text(
                                        l10n.verifyButton,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontVariations: [FontVariation('wght', 600)],
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                          ],
                        ),
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

  void _showSupportedEmailProvidersModal(BuildContext context) {
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
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Серая полоска сверху (как в iOS)
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Бегущая строка с логотипами почтовых операторов
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 20),
                child: _emailProvidersMarquee(),
              ),
              // Основной контент
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Заголовок (центрированный)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          l10n.supportedEmailProvidersTitle,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Описание (центрированное)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          l10n.supportedEmailProvidersDescription,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              // Кнопка "Понятно" - всегда внизу
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.gotIt,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Future<void> _fetchVersionInfo() async {
    final l10n = AppLocalizations.of(context);
    
    try {
      // Получаем информацию о текущей версии приложения
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      
      final response = await http.get(
        Uri.parse('http://10.192.222.215/api/v1/app/version/'),
        headers: {
          'User-Agent': 'XaneoMobile Flutter App',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));


      if (response.statusCode == 200) {
        // Парсим JSON ответ
        final jsonData = json.decode(response.body);
        final recentVersions = List<String>.from(jsonData['recent_versions'] ?? []);
        
        // Проверяем, есть ли наша версия в списке последних версий
        if (recentVersions.contains(currentVersion)) {
          _showToast(l10n.version(currentVersion));
        } else {
          // Доступно обновление - показываем уведомление вместо модального окна
          final latestVersion = recentVersions.isNotEmpty ? recentVersions.first : 'неизвестно';
          _showAnimatedUpdateNotification(currentVersion, latestVersion);
        }
      } else {
        // Ошибка HTTP
        _showToast(l10n.httpError(response.statusCode));
      }
    } catch (e) {
      // Ошибка сети или таймаут
      _showToast(l10n.connectionError(e.toString()));
    }
  }

  void _showUpdateDialog(String currentVersion, String latestVersion) {
    final l10n = AppLocalizations.of(context);
    bool updateButtonPressed = false;
    
    // Убираем активное уведомление если оно есть
    _activeUpdateNotification?.remove();
    _activeUpdateNotification = null;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Material(
            elevation: 8.0, // Высокий elevation для модального окна
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Полоска-индикатор
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Иконка обновления
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.system_update,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Заголовок
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    l10n.updateDialogTitle,
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontVariations: [FontVariation('wght', 600)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Сообщение о версиях
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    l10n.updateDialogMessage(currentVersion, latestVersion),
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontVariations: const [FontVariation('wght', 400)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Описание способов обновления
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    l10n.updateDialogDescription,
                    style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade800,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontVariations: const [FontVariation('wght', 400)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Кнопки
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.of(context).pop();
                                // При закрытии показываем маленькое уведомление
                                _showAnimatedUpdateNotification(currentVersion, latestVersion);
                              },
                              child: Center(
                                child: Text(
                                  l10n.cancelButton,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontVariations: [FontVariation('wght', 500)],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                updateButtonPressed = true;
                                Navigator.of(context).pop();
                                _openUpdateOptions(currentVersion, latestVersion);
                              },
                              child: Center(
                                child: Text(
                                  l10n.updateButton,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontVariations: [FontVariation('wght', 600)],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
            ),
          ),
        );
      },
    ).then((_) {
      // Показываем уведомление только если модальное окно закрыто НЕ через кнопку "Обновить"
      if (!updateButtonPressed) {
        _showAnimatedUpdateNotification(currentVersion, latestVersion);
      }
    });
  }

  void _showAnimatedUpdateNotification(String currentVersion, String latestVersion) {
    // Убираем старое overlay уведомление если оно есть
    _activeUpdateNotification?.remove();
    _activeUpdateNotification = null;
    
    // Показываем уведомление через Stack
    setState(() {
      _showUpdateNotification = true;
      _updateCurrentVersion = currentVersion;
      _updateLatestVersion = latestVersion;
    });
  }

  void _openUpdateOptions(String currentVersion, String latestVersion) {
    final l10n = AppLocalizations.of(context);
    
    // Создаем системный диалог выбора приложения для открытия ссылок
    final List<Map<String, String>> updateSources = [
      {
        'key': 'googlePlay',
        'name': 'Google Play',
        'url': 'https://play.google.com/store/apps/details?id=com.xaneo.mobile'
      },
      {
        'key': 'rustore',
        'name': 'RuStore',
        'url': 'https://apps.rustore.ru/app/com.xaneo.mobile'
      },
      {
        'key': 'website',
        'name': l10n.officialXaneoWebsite,
        'url': 'https://xaneo.com/download'
      },
    ];

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
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Полоска-индикатор
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Заголовок
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  l10n.selectUpdateSource,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontVariations: [FontVariation('wght', 600)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Список источников
              ...updateSources.map((source) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      Navigator.of(context).pop();
                      final Uri url = Uri.parse(source['url']!);
                      try {
                        bool canLaunch = await canLaunchUrl(url);
                        if (canLaunch) {
                          bool launched = await launchUrl(url, mode: LaunchMode.externalApplication);
                          if (!launched) {
                            // Fallback - пробуем без указания режима
                            await launchUrl(url);
                          }
                        } else {
                          // Пробуем все равно запустить
                          await launchUrl(url);
                        }
                      } catch (e) {
                        // Последняя попытка - пробуем с другими параметрами
                        try {
                          await launchUrl(url, mode: LaunchMode.platformDefault);
                        } catch (e2) {
                          // Если ничего не помогло, игнорируем ошибку
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        children: [
                          Icon(
                            _getSourceIcon(source['key']!),
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              source['name']!,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontVariations: [FontVariation('wght', 500)],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade500,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
              
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    ).then((_) {
      // После закрытия модального окна выбора источника показываем уведомление снова
      _showAnimatedUpdateNotification(currentVersion, latestVersion);
    });
  }

  IconData _getSourceIcon(String sourceKey) {
    switch (sourceKey) {
      case 'googlePlay':
        return Icons.shop;
      case 'rustore':
        return Icons.store;
      case 'website':
        return Icons.language;
      default:
        return Icons.download;
    }
  }

  Future<void> _performLogin(String username, String password) async {
    final l10n = AppLocalizations.of(context);
    
    _showToast(l10n.loggingIn);
    
    try {
      final response = await http.post(
        Uri.parse('http://10.192.222.215/api/v1/auth/mobile-login/'),
        headers: {
          'User-Agent': 'XaneoMobile Flutter App',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));


      if (response.statusCode == 200) {
        // Парсим JSON ответ
        final jsonData = json.decode(response.body);
        final authSuccess = jsonData['auth_success'] as bool? ?? false;
        final tfaRequired = jsonData['tfa_required'] as bool? ?? false;
        
        if (authSuccess) {
          // Успешная авторизация
          final userInfo = jsonData['user_info'];
          final username = userInfo['username'];
          _showToast(l10n.welcomeUser(username));
        } else if (tfaRequired) {
          // Требуется двухфакторная аутентификация
          final userInfo = jsonData['user_info'] as Map<String, dynamic>? ?? {};
          final email = userInfo['email'] as String? ?? '';
          final token = jsonData['token'] as String? ?? '';
          final message = jsonData['message'] as String? ?? 'Требуется подтверждение 2FA';
          
          print('2FA required for user: ${userInfo['username']}');
          
          if (token.isNotEmpty) {
            // Показываем сообщение о том, что учетные данные верны
            _showToast(message);
            
            // Показываем модальное окно 2FA
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                _show2FAModal(context, email, token);
              }
            });
          } else {
            _showToast('Ошибка: отсутствует токен авторизации');
          }
        } else {
          // Неуспешная авторизация
          _showToast(l10n.invalidCredentials);
        }
      } else if (response.statusCode == 401) {
        // Неавторизованный доступ - неверные учетные данные
        _showToast(l10n.invalidCredentials);
      } else {
        // Другие ошибки HTTP
        _showToast(l10n.serverError);
      }
    } catch (e) {
      // Ошибка сети или таймаут
      _showToast(l10n.connectionErrorLogin);
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  void _completeRegistration() async {
    final l10n = AppLocalizations.of(context);
    
    // Если никнейм пустой - используем заводской
    if (_registerNicknameController.text.trim().isEmpty) {
      setState(() {
        _registerNicknameController.text = _generatedNickname;
      });
    }
    
    try {
      // Подготавливаем данные для регистрации
      final firstName = _nameController.text.trim();
      final birthDate = _selectedBirthdate;
      final username = _registerNicknameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      
      // Проверяем, что все обязательные поля заполнены
      if (firstName.isEmpty || birthDate == null || username.isEmpty || email.isEmpty || password.isEmpty) {
        _showToast(l10n.fillAllFields);
        return;
      }
      
      // Показываем индикатор загрузки
      _showToast(l10n.loggingIn); // Переиспользуем существующий перевод
      
      // Создаем multipart request для отправки данных с возможным файлом
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.192.222.215/api/v1/auth/mobile-register/'),
      );
      
      // Добавляем заголовки
      request.headers.addAll({
        'User-Agent': 'XaneoMobile Flutter App',
        'Accept': 'application/json',
      });
      
      // Добавляем обязательные поля
      final formattedBirthDate = '${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}';
      request.fields['first_name'] = firstName;
      request.fields['birth_date'] = formattedBirthDate;
      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['password'] = password;
      
      // Если есть аватар, добавляем его
      if (_selectedAvatarImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            _selectedAvatarImage!.path,
          ),
        );
      }
      
      // Отправляем запрос
      final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
      final response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 201) {
        // Успешная регистрация
        final jsonData = json.decode(response.body);
        final success = jsonData['success'] as bool? ?? false;
        
        if (success) {
          final username = jsonData['username'] as String? ?? '';
          _showToast(l10n.welcomeUser(username));
          
          // TODO: Переход к главному экрану приложения
          // Здесь можно добавить навигацию к основному интерфейсу
          
        } else {
          final message = jsonData['message'] as String? ?? 'Ошибка регистрации';
          _showToast(message);
        }
      } else if (response.statusCode == 400) {
        // Ошибки валидации
        try {
          final jsonData = json.decode(response.body);
          final success = jsonData['success'] as bool? ?? false;
          final message = jsonData['message'] as String? ?? '';
          final field = jsonData['field'] as String? ?? '';
          
          if (!success && field == 'username') {
            _showToast('Пользователь с таким именем уже существует');
          } else if (!success && field == 'email') {
            _showToast('Пользователь с таким email уже существует');
          } else {
            _showToast(message.isNotEmpty ? message : 'Ошибка при регистрации');
          }
        } catch (e) {
          _showToast('Ошибка при регистрации');
        }
      } else if (response.statusCode == 403) {
        // Нет разрешения
        _showToast('У вас нет разрешения для выполнения данного действия');
      } else if (response.statusCode == 500) {
        // Внутренняя ошибка сервера
        try {
          final jsonData = json.decode(response.body);
          final message = jsonData['message'] as String? ?? 'Произошла ошибка при регистрации пользователя';
          _showToast(message);
        } catch (e) {
          _showToast('Произошла ошибка при регистрации пользователя');
        }
      } else {
        // Другие HTTP ошибки
        _showToast(l10n.serverError);
      }
    } catch (e) {
      // Ошибка сети или таймаут
      _showToast(l10n.connectionErrorLogin);
    }
  }

  List<TextSpan> _buildTermsTextSpans(AppLocalizations l10n) {
    // Получаем полный текст с заполненными параметрами
    String termsOfUse = l10n.termsOfUse;
    String userAgreement = l10n.userAgreement;
    String fullText = l10n.acceptTermsText(termsOfUse, userAgreement);
    
    List<TextSpan> spans = [];
    String currentText = fullText;
    
    // Находим и заменяем условия использования на ссылку
    int termsIndex = currentText.indexOf(termsOfUse);
    if (termsIndex != -1) {
      // Добавляем текст до ссылки
      if (termsIndex > 0) {
        spans.add(TextSpan(text: currentText.substring(0, termsIndex)));
      }
      
      // Добавляем ссылку на условия использования
      spans.add(TextSpan(
        text: termsOfUse,
        style: TextStyle(
          color: Colors.blue.shade400,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue.shade400,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // TODO: Открыть веб-страницу с условиями использования
          },
      ));
      
      currentText = currentText.substring(termsIndex + termsOfUse.length);
    }
    
    // Находим и заменяем пользовательское соглашение на ссылку
    int agreementIndex = currentText.indexOf(userAgreement);
    if (agreementIndex != -1) {
      // Добавляем текст до ссылки
      if (agreementIndex > 0) {
        spans.add(TextSpan(text: currentText.substring(0, agreementIndex)));
      }
      
      // Добавляем ссылку на пользовательское соглашение
      spans.add(TextSpan(
        text: userAgreement,
        style: TextStyle(
          color: Colors.blue.shade400,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue.shade400,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // TODO: Открыть веб-страницу с пользовательским соглашением
          },
      ));
      
      currentText = currentText.substring(agreementIndex + userAgreement.length);
    }
    
    // Добавляем оставшийся текст
    if (currentText.isNotEmpty) {
      spans.add(TextSpan(text: currentText));
    }
    
    return spans;
  }

  TextAlign _getTextAlignForLanguage() {
    final locale = Localizations.localeOf(context);
    // Арабский язык читается справа налево
    if (locale.languageCode == 'ar') {
      return TextAlign.right;
    }
    return TextAlign.left;
  }

  TextDirection _getTextDirectionForLanguage() {
    final locale = Localizations.localeOf(context);
    // Арабский язык читается справа налево
    if (locale.languageCode == 'ar') {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }

  /// Показывает выбор аватарки (из профиля)
  void _showAvatarPicker() {
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
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Серая полоска сверху (как в iOS)
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Контент
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Заголовок
                    Center(
                      child: Text(
                        l10n.editPhoto,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontVariations: [FontVariation('wght', 600)],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Опции выбора
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          // Выбрать из галереи
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                _selectImage();
                              },
                              icon: Icon(
                                Icons.photo_library,
                                color: Colors.white,
                                size: 24,
                              ),
                              label: Text(
                                l10n.selectFromGallery,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                              ),
                            ),
                          ),
                          
                          // Удалить фото (если есть)
                          if (_selectedAvatarImage != null)
                            SizedBox(
                              width: double.infinity,
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedAvatarImage = null;
                                  });
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey.shade400,
                                  size: 24,
                                ),
                                label: Text(
                                  l10n.deletePhoto,
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Отступ снизу с учетом клавиатуры
                    SizedBox(height: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom + 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Показывает диалог редактирования имени
  void _showNameEditDialog() {
    final l10n = AppLocalizations.of(context);
    TextEditingController nameEditController = TextEditingController(text: _nameController.text);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final availableHeight = MediaQuery.of(context).size.height - keyboardHeight;
        
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Инициализируем состояние валидации
            bool isValid = nameEditController.text.trim().isNotEmpty;
            String errorMessage = '';
            bool hasUserInteracted = false; // Отслеживаем взаимодействие пользователя
            
            void validateName(String name) {
              hasUserInteracted = true;
              if (name.trim().isEmpty) {
                isValid = false;
                errorMessage = l10n.nameEmptyError;
              } else {
                isValid = true;
                errorMessage = '';
              }
            }
            
            // Показывать красную рамку только если пользователь взаимодействовал с полем
            // и есть ошибка, но поле не пустое (чтобы не подсвечивать пустое поле)
            bool shouldShowRedBorder = hasUserInteracted && !isValid && nameEditController.text.trim().isNotEmpty;
            
            return Padding(
              padding: EdgeInsets.only(
                bottom: keyboardHeight,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: availableHeight * 0.8,
                ),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Серая полоска сверху (как в iOS)
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 30),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Иконка редактирования
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Контент
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Заголовок
                          Center(
                            child: Text(
                              l10n.editName,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 24,
                                fontVariations: [FontVariation('wght', 600)],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Поле ввода
                          Container(
                            decoration: BoxDecoration(
                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: shouldShowRedBorder ? Colors.red.shade700 : Colors.grey.shade700,
                                width: 1,
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                textSelectionTheme: TextSelectionThemeData(
                                  selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                  selectionHandleColor: Colors.grey.shade400,
                                ),
                              ),
                              child: TextField(
                                controller: nameEditController,
                                cursorColor: Colors.grey.shade400,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: l10n.enterNameHint,
                                  hintStyle: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    fontFamily: 'Inter',
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  ),
                                  counterText: '', // Скрываем счетчик символов
                                ),
                                maxLength: 50,
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    validateName(value);
                                  });
                                },
                              ),
                            ),
                          ),
                          
                          // Показываем ошибку валидации если есть
                          if (!isValid && errorMessage.isNotEmpty && hasUserInteracted)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red.shade400,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      errorMessage,
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          const SizedBox(height: 30),
                          
                          // Кнопки
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    l10n.backButton,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: isValid && nameEditController.text.trim().isNotEmpty ? () {
                                    setState(() {
                                      _nameController.text = nameEditController.text.trim();
                                    });
                                    Navigator.pop(context);
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isValid && nameEditController.text.trim().isNotEmpty 
                                        ? Colors.white 
                                        : Colors.grey.shade700,
                                    foregroundColor: isValid && nameEditController.text.trim().isNotEmpty 
                                        ? Colors.black 
                                        : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    l10n.saveButton,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontVariations: [FontVariation('wght', 600)],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Отступ снизу для безопасной зоны
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ),
            );
          },
        );
      },
    );
  }

  /// Показывает диалог редактирования никнейма
  void _showNicknameEditDialog() {
    final l10n = AppLocalizations.of(context);
    TextEditingController nicknameEditController = TextEditingController(text: _registerNicknameController.text);
    
    // Переменные состояния вынесены за пределы StatefulBuilder
    bool isValid = true;
    String errorMessage = '';
    bool isCheckingServer = false;
    bool isServerAvailable = false;
    bool isServerTaken = false;
    Timer? serverCheckTimer;
    String lastCheckedNickname = ''; // Отслеживаем последний проверенный никнейм
    bool hasUserInteracted = false; // Отслеживаем, взаимодействовал ли пользователь с полем
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
            
            // Функция проверки никнейма на сервере
            Future<void> checkNicknameOnServer(String nickname) async {
              try {
                final response = await http.get(
                  Uri.parse('http://10.192.222.215/api/v1/auth/check-username/?username=${Uri.encodeComponent(nickname)}'),
                  headers: {
                    'User-Agent': 'XaneoMobile Flutter App',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  },
                ).timeout(const Duration(seconds: 10));


                if (response.statusCode == 200) {
                  final jsonData = json.decode(response.body);
                  final isAvailable = jsonData['available'] as bool;
                  
                  setModalState(() {
                    isCheckingServer = false;
                    lastCheckedNickname = nickname; // Сохраняем проверенный никнейм
                    
                    if (isAvailable) {
                      isServerAvailable = true;
                      isServerTaken = false;
                    } else {
                      isServerAvailable = false;
                      isServerTaken = true;
                    }
                  });
                } else {
                  // Ошибка HTTP
                  setModalState(() {
                    isCheckingServer = false;
                    lastCheckedNickname = ''; // Сбрасываем при ошибке
                    isServerAvailable = false;
                    isServerTaken = false;
                  });
                }
              } catch (e) {
                // Ошибка сети
                setModalState(() {
                  isCheckingServer = false;
                  lastCheckedNickname = ''; // Сбрасываем при ошибке
                  isServerAvailable = false;
                  isServerTaken = false;
                });
              }
            }
            
            // Локальная валидация
            void validateNickname(String nickname) {
              
              if (nickname.isEmpty) {
                isValid = true;
                errorMessage = '';
                // Сбрасываем состояние сервера для пустого поля
                isCheckingServer = false;
                isServerAvailable = false;
                isServerTaken = false;
                serverCheckTimer?.cancel();
                lastCheckedNickname = '';
                return;
              }
              
              // Сначала проверяем символы (более грубая ошибка)
              if (!_isValidNicknameCharacters(nickname)) {
                isValid = false;
                errorMessage = 'Только латинские буквы, цифры, точки и подчеркивания';
                lastCheckedNickname = ''; // Сбрасываем при невалидном никнейме
                return;
              }
              
              // Потом проверяем начало
              if (!_isValidNicknameStart(nickname)) {
                isValid = false;
                errorMessage = 'Не может начинаться с цифры, точки или подчеркивания';
                lastCheckedNickname = ''; // Сбрасываем при невалидном никнейме
                return;
              }
              
              // Потом проверяем конец
              if (!_isValidNicknameEnd(nickname)) {
                isValid = false;
                errorMessage = 'Не может заканчиваться точкой или подчеркиванием';
                lastCheckedNickname = ''; // Сбрасываем при невалидном никнейме
                return;
              }
              
              // И только в конце проверяем длину
              if (nickname.length <= 4) {
                isValid = false;
                errorMessage = l10n.nicknameMinLengthError;
                lastCheckedNickname = ''; // Сбрасываем при невалидном никнейме
                return;
              }
              
              if (nickname.length > 30) {
                isValid = false;
                errorMessage = l10n.nicknameMaxLengthError;
                lastCheckedNickname = ''; // Сбрасываем при невалидном никнейме
                return;
              }
              
              // Локальная валидация прошла успешно
              isValid = true;
              errorMessage = '';
              
              // Запускаем проверку сервера с задержкой
              if (nickname.length > 4) {
                // Проверяем, не был ли этот никнейм уже проверен
                if (lastCheckedNickname == nickname) {
                  return;
                }
                
                setModalState(() {
                  isCheckingServer = true;
                  isServerAvailable = false;
                  isServerTaken = false;
                });
                
                serverCheckTimer?.cancel();
                serverCheckTimer = Timer(const Duration(milliseconds: 1500), () {
                  checkNicknameOnServer(nickname);
                });
              }
            }
            
            
            // Инициальная валидация убрана - будет только при взаимодействии пользователя
            
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Серая полоска сверху (как в iOS)
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 30),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Иконка редактирования
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Контент
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Заголовок
                        Center(
                          child: Text(
                            l10n.editNickname,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontVariations: [FontVariation('wght', 600)],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Поле ввода - идентично полю из третьего раздела
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade700,
                              width: 1,
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                selectionHandleColor: Colors.grey.shade400,
                              ),
                            ),
                            child: TextField(
                              controller: nicknameEditController,
                              cursorColor: Colors.grey.shade400,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                hintText: l10n.enterNicknameHint,
                                hintStyle: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  fontFamily: 'Inter',
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                ),
                                counterText: '', // Скрываем счетчик символов
                              ),
                              maxLength: 30,
                              autofocus: true,
                              onChanged: (value) {
                                setModalState(() {
                                  hasUserInteracted = true; // Помечаем, что пользователь взаимодействовал
                                  validateNickname(value.trim());
                                });
                              },
                            ),
                          ),
                        ),
                        
                        // Отображение ошибки валидации
                        if (!isValid && errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red.shade400,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        // Отображение состояния проверки сервера
                        if (isValid && errorMessage.isEmpty && hasUserInteracted && nicknameEditController.text.trim().isNotEmpty) ...[
                          if (isCheckingServer)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFFFFD700), // Желтый цвет
                                        BlendMode.srcATop,
                                      ),
                                      child: Lottie.asset(
                                        'assets/animations/loading.json',
                                        width: 24,
                                        height: 24,
                                        repeat: true,
                                        animate: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.checkingNickname,
                                    style: const TextStyle(
                                      color: Color(0xFFFFD700), // Желтый цвет
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          if (!isCheckingServer && isServerAvailable)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green.shade400,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.nicknameAvailable,
                                    style: TextStyle(
                                      color: Colors.green.shade400,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          if (!isCheckingServer && isServerTaken)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red.shade400,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    l10n.nicknameTakenError,
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                  
                        const SizedBox(height: 30),
                        
                        // Кнопки
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  l10n.backButton,
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (_registerNicknameController.text.isNotEmpty)
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _registerNicknameController.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    l10n.deleteButton,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (isValid && !isCheckingServer && (isServerAvailable || nicknameEditController.text.trim().isEmpty)) ? () {
                                  final nickname = nicknameEditController.text.trim();
                                  setState(() {
                                    _registerNicknameController.text = nickname;
                                  });
                                  Navigator.pop(context);
                                } : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (isValid && !isCheckingServer && (isServerAvailable || nicknameEditController.text.trim().isEmpty)) ? Colors.white : Colors.grey.shade700,
                                  foregroundColor: (isValid && !isCheckingServer && (isServerAvailable || nicknameEditController.text.trim().isEmpty)) ? Colors.black : Colors.grey.shade400,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  l10n.saveButton,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontVariations: [FontVariation('wght', 600)],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Отступ снизу
                        SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        );
      },
    );
  }

  void _showTermsAndConditionsDialog() {
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
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Material(
            elevation: 5.0, // Elevation для модального окна поддерживаемых провайдеров
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Полоска-индикатор
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Иконка документа
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    Icons.description,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Контент
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Заголовок
                      Text(
                        l10n.termsAndConditionsTitle,
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontVariations: [FontVariation('wght', 600)],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Подробный текст с объяснением
                      Directionality(
                        textDirection: _getTextDirectionForLanguage(),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          child: SingleChildScrollView(
                            child: RichText(
                              textAlign: _getTextAlignForLanguage(),
                              textDirection: _getTextDirectionForLanguage(),
                            text: TextSpan(
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                              children: _buildTermsTextSpans(l10n),
                            ),
                          ),
                        ),
                      ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Кнопки
                      Row(
                        children: [
                          // Кнопка "Отклонить"
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.grey.shade500,
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.grey.shade600),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                l10n.declineButton,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontVariations: [FontVariation('wght', 600)],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Кнопка "Принять"
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _completeRegistration();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                l10n.acceptButton,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontVariations: [FontVariation('wght', 600)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                    ],
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

  void _showAgeRestrictionsModal(BuildContext context) {
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
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Серая полоска сверху (как в iOS)
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Основной контент
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Изображение restrict.png
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ThemeAssets.restrict(context,
                          width: 120,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Заголовок (центрированный)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          l10n.ageRestrictionsTitle,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Описание (центрированное) - адаптируется к содержимому
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          l10n.ageRestrictionsDescription,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              // Кнопка "Понятно" - всегда внизу
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.gotIt,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true, // Разрешаем перетаскивание для закрытия
      isDismissible: true, // Разрешаем закрытие по тапу вне области
      useSafeArea: true,
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 400), // Более плавная длительность
        reverseDuration: const Duration(milliseconds: 300), // Плавное закрытие
        vsync: Navigator.of(context),
        // Оптимизация для высокой частоты обновления
        animationBehavior: AnimationBehavior.preserve,
      )..addListener(() {}),
      builder: (BuildContext context) {
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          tween: Tween<double>(begin: 1.0, end: 0.0),
          curve: Curves.easeOutCubic, // Более плавная кривая без рывков
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, MediaQuery.of(context).size.height * value),
              child: Container(
                decoration: AppStyles.modalDecoration(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Серая полоска сверху (как в iOS)
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 20),
                      width: AppStyles.modalHandleWidth,
                      height: AppStyles.modalHandleHeight,
                      decoration: AppStyles.modalHandle(context),
                    ),
                    // Контент меню
                    Padding(
                      padding: AppStyles.paddingLarge,
                      child: Column(
                        children: [
                          // Пункт меню 1
                          ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: AppStyles.textPrimaryColor(context),
                              size: AppStyles.iconSizeSmall,
                            ),
                            title: Text(
                              l10n.settings,
                              style: AppStyles.menuItem(context),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _showSettingsBottomSheet(context);
                            },
                          ),
                          // Пункт меню 2
                          ListTile(
                            leading: Icon(
                              Icons.info_outline,
                              color: AppStyles.textPrimaryColor(context),
                              size: AppStyles.iconSizeSmall,
                            ),
                            title: Text(
                              l10n.about,
                              style: AppStyles.menuItem(context),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _showToast(l10n.about);
                            },
                          ),
                          // Пункт меню 3
                          ListTile(
                            leading: Icon(
                              Icons.help_outline,
                              color: AppStyles.textPrimaryColor(context),
                              size: AppStyles.iconSizeSmall,
                            ),
                            title: Text(
                              l10n.help,
                              style: AppStyles.menuItem(context),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _showToast(l10n.help);
                            },
                          ),
                        ],
                      ),
                    ),
                    // Отступ снизу для безопасной зоны
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 300),
        vsync: Navigator.of(context),
        animationBehavior: AnimationBehavior.preserve,
      )..addListener(() {}),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 400),
              tween: Tween<double>(begin: 1.0, end: 0.0),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, MediaQuery.of(context).size.height * value),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    decoration: AppStyles.modalDecoration(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Серая полоска сверху
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 20),
                          width: AppStyles.modalHandleWidth,
                          height: AppStyles.modalHandleHeight,
                          decoration: AppStyles.modalHandle(context),
                        ),
                        // Заголовок
                        Padding(
                          padding: AppStyles.paddingMedium,
                          child: Row(
                            children: [
                              Text(
                                l10n.settings,
                                style: AppStyles.menuTitle(context),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Содержимое настроек
                        Flexible(
                          child: ListView(
                            padding: AppStyles.paddingMedium,
                            shrinkWrap: true,
                            children: [
                              // Уведомления
                              SwitchListTile(
                                title: Text(
                                  l10n.notifications,
                                  style: AppStyles.menuItem(context),
                                ),
                                subtitle: Text(
                                  l10n.notificationsDescription,
                                  style: AppStyles.menuSubtitle(context),
                                ),
                                value: _notificationsEnabled,
                                onChanged: (value) {
                                  setModalState(() {
                                    _notificationsEnabled = value;
                                  });
                                  setState(() {
                                    _notificationsEnabled = value;
                                  });
                                },
                                activeThumbColor: AppStyles.textPrimaryColor(context),
                              ),

                              // Тёмная тема
                              SwitchListTile(
                                title: Text(
                                  l10n.darkTheme,
                                  style: AppStyles.menuItem(context),
                                ),
                                subtitle: Text(
                                  l10n.darkThemeDescription,
                                  style: AppStyles.menuSubtitle(context),
                                ),
                                value: Provider.of<ThemeProvider>(context).isDarkMode,
                                onChanged: (value) {
                                  // Обновляем глобальную тему через ThemeProvider
                                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                                  themeProvider.setTheme(value);
                                },
                                activeThumbColor: AppStyles.textPrimaryColor(context),
                              ),
                              
                              SizedBox(height: 20),
                              
                              // Размер шрифта
                              Text(
                                l10n.fontSize(_fontSize.round()),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Slider(
                                value: _fontSize,
                                min: 12.0,
                                max: 24.0,
                                divisions: 12,
                                activeColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                inactiveColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                                onChanged: (value) {
                                  setModalState(() {
                                    _fontSize = value;
                                  });
                                  setState(() {
                                    _fontSize = value;
                                  });
                                },
                              ),
                              
                              SizedBox(height: 20),
                              
                              // Выбор языка
                              ListTile(
                                title: Text(
                                  l10n.language,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  l10n.languageDescription,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Consumer<LocaleProvider>(
                                  builder: (context, localeProvider, child) {
                                    return GestureDetector(
                                      onTap: () => _showLanguagePicker(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _getLanguageNameFromLocale(localeProvider.locale),
                                              style: TextStyle(
                                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              
                              SizedBox(height: 20),
                              
                              // О приложении
                              ListTile(
                                title: Text(
                                  l10n.appVersion,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                subtitle: Text(
                                  '1.0.0',
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                trailing: Icon(Icons.info_outline, color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
                              ),
                              
                              // Демо-режим мессенджера
                              ListTile(
                                title: Text(
                                  l10n.messengerDemoMode,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios, color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700, size: 16),
                                onTap: () {
                                  Navigator.pop(context); // Закрываем меню настроек
                                  _navigateToMessengerDemo(context); // Переходим к демо-режиму
                                },
                              ),
                            ],
                          ),
                        ),
                        // Отступ снизу
                        SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'ar':
        return 'العربية';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      default:
        return 'Unknown';
    }
  }

  void _showLanguagePicker() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.isDarkMode;
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
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
                      color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade600,
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
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text(
                          l10n.selectLanguage,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.check,
                            color: isDarkMode ? Colors.white : Colors.black,
                            size: 24,
                          ),
                      onPressed: () {
                        // Получаем выбранный язык
                        final selectedLanguage = _availableLanguages[_selectedLanguageIndex];
                        final selectedLocale = Locale(selectedLanguage['code']!);
                        
                        // Изменяем язык через Provider
                        Provider.of<LocaleProvider>(context, listen: false).setLocale(selectedLocale);
                        
                        // Обновляем _currentLocale
                        setState(() {
                          _currentLocale = selectedLocale;
                        });
                        
                        // Показываем уведомление о смене языка
                        _showToast('${l10n.language}: ${_getLanguageName(selectedLocale)}');
                        
                        // Закрываем модалку выбора языка
                        Navigator.of(context).pop();
                        
                        // Закрываем меню настроек
                        Navigator.of(context).pop();
                        
                        // Открываем меню настроек заново с новой локалью после небольшой задержки
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) {
                            _showSettingsBottomSheet(context);
                          }
                        });
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
                    setState(() {
                      _selectedLanguageIndex = index;
                    });
                  },
                  children: _availableLanguages.map((language) {
                    return Center(
                      child: Text(
                        language['name']!,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ));
          },
        );
      },
    );
  }

  // Синхронизация настроек с провайдерами
  void _syncSettingsWithProviders() {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    
    // Синхронизируем язык
    if (localeProvider.locale != null) {
      setState(() {
        _currentLocale = localeProvider.locale!;
        // Синхронизируем индекс выбранного языка
        final index = _availableLanguages.indexWhere(
          (lang) => lang['code'] == localeProvider.locale!.languageCode
        );
        if (index != -1) {
          _selectedLanguageIndex = index;
        }
      });
    }
  }

  String _getLanguageNameFromLocale(Locale? locale) {
    if (locale == null) return 'Русский'; // По умолчанию
    
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
        return 'Русский';
      case 'ar':
        return 'العربية';
      case 'zh':
        return '中文';
      default:
        return 'Русский';
    }
  }

  Widget _emailProvidersMarquee() {
    final emailProviders = [
      'google',
      'outlook',
      'yandex',
      'mailru',
      'icloud',
      'yahoo',
    ];

    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 20),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.linear,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            -MediaQuery.of(context).size.width * value,
            0,
          ),
          child: Row(
            children: [
              // Первый набор логотипов
              ...emailProviders.map((provider) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ThemeAssets.getEmailProviderIcon(
                  context,
                  provider,
                  width: 32,
                  height: 32,
                ),
              )),
              // Второй набор логотипов для бесшовного повтора
              ...emailProviders.map((provider) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ThemeAssets.getEmailProviderIcon(
                  context,
                  provider,
                  width: 32,
                  height: 32,
                ),
              )),
            ],
          ),
        );
      },
      onEnd: () {
        // Рестартуем анимацию для непрерывной прокрутки
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  /// Определяет, является ли экран в горизонтальной ориентации
  bool _isLandscape(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    
    // Вычисляем физический размер экрана в дюймах
    // Используем логические пиксели для более точного расчета
    final logicalWidth = screenSize.width;
    final logicalHeight = screenSize.height;
    final diagonalLogicalPixels = sqrt(logicalWidth * logicalWidth + logicalHeight * logicalHeight);
    
    // Преобразуем в дюймы через стандартную плотность Android (160 dpi для mdpi)
    final standardDpi = 160.0;
    final diagonalInches = diagonalLogicalPixels / standardDpi;
    
    // Показываем адаптивный интерфейс только если экран больше 7 дюймов И в альбомной ориентации
    return diagonalInches >= 7.0 && mediaQuery.orientation == Orientation.landscape;
  }

  /// Получает горизонтальные отступы для полей ввода
  double _getHorizontalPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    // В горизонтальной ориентации делаем поля уже
    if (mediaQuery.orientation == Orientation.landscape) {
      // В альбомной ориентации оставляем только центральную треть экрана для полей
      return screenWidth * 0.25; // 25% отступов с каждой стороны = 50% ширины экрана для полей
    } else {
      // В портретной ориентации используем стандартные отступы
      return 20.0;
    }
  }

  // Метод для получения изображения в зависимости от типа
  Widget _getOnboardingImage(String imageType, double size) {
    switch (imageType) {
      case 'bear':
        return ThemeAssets.bear(context, width: size, height: size);
      case 'bearPrivate':
        return ThemeAssets.bearPrivate(context, width: size, height: size);
      case 'bearDatabase':
        return ThemeAssets.bearDatabase(context, width: size, height: size);
      default:
        return ThemeAssets.bear(context, width: size, height: size);
    }
  }

  /// Создает адаптивный блок онбординга для медведя и текста
  Widget _buildOnboardingSection({
    required String imageType, // 'bear', 'bearPrivate', 'bearDatabase'
    required String title,
    required String description,
    required String buttonText,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required bool isVisible,
    required VoidCallback? onButtonPressed,
  }) {
    final isLandscape = _isLandscape(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (isLandscape) {
      // Горизонтальная компоновка: медведь слева, текст справа
      return AnimatedBuilder(
        animation: Listenable.merge([fadeAnimation, slideAnimation]),
        builder: (context, child) {
          return Positioned(
            left: 20 + (slideAnimation.value.dx * screenWidth),
            right: 20 - (slideAnimation.value.dx * screenWidth),
            top: screenHeight / 2 - 120,
            bottom: MediaQuery.of(context).padding.bottom + 20,
            child: Opacity(
              opacity: fadeAnimation.value * (isVisible ? 1.0 : 0.0),
              child: Row(
                children: [
                  // Медведь слева (40% ширины)
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: _getOnboardingImage(imageType, screenWidth * 0.25),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Текст и кнопка справа (60% ширины)
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: AppStyles.textBlockDecoration,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: AppStyles.titleLarge(context),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: AppStyles.bodyMediumMuted(context),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: onButtonPressed,
                              style: AppStyles.primaryButton(context),
                              child: Text(
                                buttonText,
                                style: AppStyles.buttonText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // Вертикальная компоновка: возвращаем два отдельных виджета
      return Container(); // Заглушка, так как в вертикальной ориентации нужны два отдельных Positioned виджета
    }
  }

  // Возвращает медведя для вертикального онбординга
  Widget _buildVerticalBear({
    required String imageType,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required bool isVisible,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return AnimatedBuilder(
      animation: Listenable.merge([fadeAnimation, slideAnimation]),
      builder: (context, child) {
        return Positioned(
          left: 20 + (slideAnimation.value.dx * screenWidth),
          right: 20 - (slideAnimation.value.dx * screenWidth),
          top: screenHeight / 2 - 180,
          child: Opacity(
            opacity: fadeAnimation.value * (isVisible ? 1.0 : 0.0),
            child: Center(
              child: _getOnboardingImage(imageType, screenWidth * AppStyles.imageWidthFactor),
            ),
          ),
        );
      },
    );
  }

  // Возвращает текстовый блок для вертикального онбординга
  Widget _buildVerticalText({
    required String title,
    required String description,
    required String buttonText,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required bool isVisible,
    required VoidCallback? onButtonPressed,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return AnimatedBuilder(
      animation: Listenable.merge([fadeAnimation, slideAnimation]),
      builder: (context, child) {
        return Positioned(
          left: 20 + (slideAnimation.value.dx * screenWidth),
          right: 20 - (slideAnimation.value.dx * screenWidth),
          bottom: MediaQuery.of(context).padding.bottom + AppStyles.textBlockBottomPadding,
          child: Opacity(
            opacity: fadeAnimation.value * (isVisible ? 1.0 : 0.0),
            child: IntrinsicHeight(
              child: Container(
                decoration: AppStyles.textBlockDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyles.titleLarge(context),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          description,
                          style: AppStyles.bodyMediumMuted(context),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: screenWidth - 60,
                        child: ElevatedButton(
                          onPressed: onButtonPressed,
                          style: AppStyles.primaryButton(context),
                          child: Text(
                            buttonText,
                            style: AppStyles.buttonText(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor(context),
      // Оптимизация для производительности при работе с клавиатурой
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          // Убираем случайные нажатия для предотвращения "Подключение к серверу..."
          // _fetchVersionInfo();
        },
        child: Stack(
          children: [
            // Кнопка меню в правом верхнем углу
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: AppStyles.paddingSmall,
                  child: IconButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: AppStyles.textPrimaryColor(context),
                      size: AppStyles.iconSize,
                    ),
                    style: AppStyles.iconButton(context),
                  ),
                ),
              ),
            ),
            // Анимированное лого - независимый слой
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 35, // Центр по X (35 = половина ширины лого)
                  top: MediaQuery.of(context).size.height / 2 - 35 + (_logoAnimation.value.dy * MediaQuery.of(context).size.height),
                  child: ThemeAssets.logo(context,
                    width: 70,
                    height: 70,
                  ),
                );
              },
            ),
            // Анимированный блок с мишкой - появляется после лого (только при первом запуске)
            if (_showBear && _isFirstLaunch && _isLandscape(context))
              _buildOnboardingSection(
                imageType: 'bear',
                title: l10n.welcomeTitle,
                description: l10n.welcomeDescription,
                buttonText: l10n.getStartedButton,
                fadeAnimation: _bearAnimation,
                slideAnimation: _welcomeSlideAnimation,
                isVisible: !_welcomeGone,
                onButtonPressed: _welcomeGone
                    ? null
                    : () {
                        setState(() {
                          _showPrivateBear = true;
                        });
                        // Запускаем анимации ухода влево для медведя и текста
                        _welcomeSlideController.forward();
                        _welcomeTextController.forward();
                        // Запускаем анимации появления справа для нового медведя и текста
                        _privateBearController.forward();
                        _privateTextController.forward();
                        _showToast(l10n.welcomeMessage);
                        Future.delayed(AppStyles.animationDurationFast, () {
                          setState(() {
                            _welcomeGone = true;
                          });
                        });
                      },
              ),
            // Медведь для вертикальной ориентации (первый этап)
            if (_showBear && _isFirstLaunch && !_isLandscape(context))
              _buildVerticalBear(
                imageType: 'bear',
                fadeAnimation: _bearAnimation,
                slideAnimation: _welcomeSlideAnimation,
                isVisible: !_welcomeGone,
              ),
            // Текст для вертикальной ориентации (первый этап)
            if (_showBear && _isFirstLaunch && !_isLandscape(context))
              _buildVerticalText(
                title: l10n.welcomeTitle,
                description: l10n.welcomeDescription,
                buttonText: l10n.getStartedButton,
                fadeAnimation: _bearAnimation,
                slideAnimation: _welcomeSlideAnimation,
                isVisible: !_welcomeGone,
                onButtonPressed: _welcomeGone
                    ? null
                    : () {
                        setState(() {
                          _showPrivateBear = true;
                        });
                        // Запускаем анимации ухода влево для медведя и текста
                        _welcomeSlideController.forward();
                        _welcomeTextController.forward();
                        // Запускаем анимации появления справа для нового медведя и текста
                        _privateBearController.forward();
                        _privateTextController.forward();
                        _showToast(l10n.welcomeMessage);
                        Future.delayed(AppStyles.animationDurationFast, () {
                          setState(() {
                            _welcomeGone = true;
                          });
                        });
                      },
              ),
            // Появление второго мишки с анимацией справа налево (только при первом запуске)
            if (_showPrivateBear && _isFirstLaunch && _isLandscape(context))
              _buildOnboardingSection(
                imageType: 'bearPrivate',
                title: l10n.privacyTitle,
                description: l10n.privacyDescription,
                buttonText: l10n.continueButton,
                fadeAnimation: _privateBearFadeAnimation,
                slideAnimation: _privateSlideAnimation,
                isVisible: !_privateBearGone,
                onButtonPressed: _privateBearGone
                    ? null
                    : () {
                        setState(() {
                          _showDatabaseBear = true;
                        });
                        // Запускаем анимации ухода влево для второго медведя и текста
                        _privateSlideController.forward();
                        // Запускаем анимации появления справа для третьего медведя и текста
                        _databaseBearController.forward();
                        _databaseTextController.forward();
                        _showToast(l10n.welcomeMessage);
                        Future.delayed(AppStyles.animationDurationFast, () {
                          setState(() {
                            _privateBearGone = true;
                          });
                        });
                      },
              ),
            // Медведь для вертикальной ориентации (второй этап)
            if (_showPrivateBear && _isFirstLaunch && !_isLandscape(context))
              _buildVerticalBear(
                imageType: 'bearPrivate',
                fadeAnimation: _privateBearFadeAnimation,
                slideAnimation: _privateSlideAnimation,
                isVisible: !_privateBearGone,
              ),
            // Текст для вертикальной ориентации (второй этап)
            if (_showPrivateBear && _isFirstLaunch && !_isLandscape(context))
              _buildVerticalText(
                title: l10n.privacyTitle,
                description: l10n.privacyDescription,
                buttonText: l10n.continueButton,
                fadeAnimation: _privateBearFadeAnimation,
                slideAnimation: _privateSlideAnimation,
                isVisible: !_privateBearGone,
                onButtonPressed: _privateBearGone
                    ? null
                    : () {
                        setState(() {
                          _showDatabaseBear = true;
                        });
                        // Запускаем анимации ухода влево для второго медведя и текста
                        _privateSlideController.forward();
                        // Запускаем анимации появления справа для третьего медведя и текста
                        _databaseBearController.forward();
                        _databaseTextController.forward();
                        _showToast(l10n.welcomeMessage);
                        Future.delayed(AppStyles.animationDurationFast, () {
                          setState(() {
                            _privateBearGone = true;
                          });
                        });
                      },
              ),
            // Появление третьего мишки (база данных) с анимацией справа налево (только при первом запуске)
            if (_showDatabaseBear && _isFirstLaunch && _isLandscape(context))
              _buildOnboardingSection(
                imageType: 'bearDatabase',
                title: l10n.dataStorageTitle,
                description: l10n.dataStorageDescription,
                buttonText: l10n.finishButton,
                fadeAnimation: _databaseBearFadeAnimation,
                slideAnimation: _databaseSlideAnimation,
                isVisible: !_databaseBearGone,
                onButtonPressed: _databaseBearGone
                    ? null
                    : () {
                        // Отмечаем, что онбординг завершен
                        _markOnboardingComplete();
                        // Запускаем анимацию ухода влево для третьего медведя и текста
                        _databaseSlideController.forward();
                        _showToast(l10n.setupCompleted);
                        Future.delayed(AppStyles.animationDurationFast, () {
                          setState(() {
                            _databaseBearGone = true;
                          });
                          // После завершения анимации ухода показываем поля ввода
                          Future.delayed(const Duration(milliseconds: 50), () {
                            setState(() {
                              _showInputFields = true;
                            });
                            _inputFieldsController.forward();
                          });
                        });
                      },
              ),
            // Медведь для вертикальной ориентации (третий этап)
            if (_showDatabaseBear && _isFirstLaunch && !_isLandscape(context))
              _buildVerticalBear(
                imageType: 'bearDatabase',
                fadeAnimation: _databaseBearFadeAnimation,
                slideAnimation: _databaseSlideAnimation,
                isVisible: !_databaseBearGone,
              ),
            // Текст для вертикальной ориентации (третий этап)
            if (_showDatabaseBear && _isFirstLaunch && !_isLandscape(context))
              _buildVerticalText(
                title: l10n.dataStorageTitle,
                description: l10n.dataStorageDescription,
                buttonText: l10n.finishButton,
                fadeAnimation: _databaseBearFadeAnimation,
                slideAnimation: _databaseSlideAnimation,
                isVisible: !_databaseBearGone,
                onButtonPressed: _databaseBearGone
                    ? null
                    : () {
                        // Отмечаем, что онбординг завершен
                        _markOnboardingComplete();
                        // Запускаем анимацию ухода влево для третьего медведя и текста
                        _databaseSlideController.forward();
                        _showToast(l10n.setupCompleted);
                        Future.delayed(AppStyles.animationDurationFast, () {
                          setState(() {
                            _databaseBearGone = true;
                          });
                          // После завершения анимации ухода показываем поля ввода
                          Future.delayed(const Duration(milliseconds: 50), () {
                            setState(() {
                              _showInputFields = true;
                            });
                            _inputFieldsController.forward();
                          });
                        });
                      },
              ),
            // Поля ввода никнейма и пароля (только в режиме входа)
            if (_showInputFields && _isLoginMode)
              AnimatedBuilder(
                animation: Listenable.merge([_inputFieldsFadeAnimation, _inputFieldsSlideAnimation]),
                builder: (context, child) {
                  return Positioned(
                    left: _getHorizontalPadding(context),
                    right: _getHorizontalPadding(context),
                    top: MediaQuery.of(context).size.height / 2 - 35 + (_logoAnimation.value.dy * MediaQuery.of(context).size.height) + 120,
                    child: Transform.translate(
                      offset: Offset(0, _inputFieldsSlideAnimation.value.dy * 50),
                      child: Opacity(
                        opacity: _inputFieldsFadeAnimation.value,
                        child: AnimatedBuilder(
                          animation: _formFadeAnimation,
                          builder: (context, child) {
                            return Opacity(
                              opacity: 1.0 - _formFadeAnimation.value,
                              child: Column(
                                children: [
                                  // Динамический заголовок в зависимости от режима
                                  Text(
                                    _isLoginMode ? l10n.loginFormTitle : l10n.registerFormTitle,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      fontVariations: [FontVariation('wght', 600)],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                            const SizedBox(height: 32),
                            // Поле для ввода логина
                            Container(
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: TextSelectionThemeData(
                                    selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                    selectionHandleColor: Colors.grey.shade400,
                                  ),
                                ),
                                child: TextField(
                                  controller: _nicknameController,
                                  cursorColor: Colors.grey.shade400,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: l10n.loginFieldHint,
                                    hintStyle: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      fontFamily: 'Inter',
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Поле для ввода пароля
                            Container(
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: TextSelectionThemeData(
                                    selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                    selectionHandleColor: Colors.grey.shade400,
                                  ),
                                ),
                                child: TextField(
                                  controller: _loginPasswordController,
                                  cursorColor: Colors.grey.shade400,
                                  obscureText: !_isLoginPasswordVisible,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: l10n.passwordFieldHint,
                                    hintStyle: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      fontFamily: 'Inter',
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isLoginPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isLoginPasswordVisible = !_isLoginPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Кнопка входа
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Логика входа
                                  final login = _nicknameController.text.trim();
                                  final password = _loginPasswordController.text.trim();
                                  
                                  if (login.isNotEmpty && password.isNotEmpty) {
                                    // Выполняем запрос на авторизацию
                                    _performLogin(login, password);
                                  } else {
                                    _showToast(l10n.fillAllFields);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.grey.shade800,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  l10n.loginButton,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontVariations: [FontVariation('wght', 600)],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Ссылки внизу
                            Column(
                              children: [
                                // Ссылка "Нет аккаунта?"
                                GestureDetector(
                                  onTap: () {
                                    _switchToRegisterMode();
                                  },
                                  child: Text(
                                    l10n.noAccount,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Ссылка "Забыли пароль?" (в режиме регистрации будет "Уже есть аккаунт?")
                                GestureDetector(
                                  onTap: () {
                                    if (_isLoginMode) {
                                      _showForgotPasswordModal(context);
                                    } else {
                                      _switchToLoginMode();
                                    }
                                  },
                                  child: Text(
                                    _isLoginMode ? l10n.forgotPassword : l10n.alreadyHaveAccount,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            // Заголовок для режима регистрации (только заголовок, без полей)
            if (_showInputFields && !_isLoginMode)
              AnimatedBuilder(
                animation: Listenable.merge([_inputFieldsFadeAnimation, _inputFieldsSlideAnimation]),
                builder: (context, child) {
                  return Positioned(
                    left: _getHorizontalPadding(context),
                    right: _getHorizontalPadding(context),
                    top: MediaQuery.of(context).size.height / 2 - 35 + (_logoAnimation.value.dy * MediaQuery.of(context).size.height) + 120,
                    child: Transform.translate(
                      offset: Offset(0, _inputFieldsSlideAnimation.value.dy * 50),
                      child: Opacity(
                        opacity: _inputFieldsFadeAnimation.value,
                        child: AnimatedBuilder(
                          animation: _formFadeAnimation,
                          builder: (context, child) {
                            return Opacity(
                              opacity: 1.0 - _formFadeAnimation.value,
                              child: Column(
                                children: [
                                  // Заголовок "Давайте начнём"
                                  Text(
                                    l10n.registerFormTitle,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      fontVariations: [FontVariation('wght', 600)],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  
                                  // Условный блок в зависимости от шага регистрации
                                  if (_registrationStep == 0) ...[
                                    // Шаг 1: Ввод имени
                                    _buildNameStep(),
                                  ] else if (_registrationStep == 1) ...[
                                    // Шаг 2: Выбор даты рождения
                                    _buildBirthdateStep(),
                                  ] else if (_registrationStep == 2) ...[
                                    // Шаг 3: Выбор никнейма
                                    _buildNicknameStep(),
                                  ] else if (_registrationStep == 3) ...[
                                    // Шаг 4: Ввод email
                                    _buildEmailStep(),
                                  ] else if (_registrationStep == 4) ...[
                                    // Шаг 5: Ввод пароля
                                    _buildPasswordStep(),
                                  ] else if (_registrationStep == 5) ...[
                                    // Шаг 6: Выбор аватарки
                                    _buildAvatarStep(),
                                  ] else if (_registrationStep == 6) ...[
                                    // Шаг 7: Превью профиля
                                    _buildProfilePreviewStep(),
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            // Основная структура (пустая, только для сохранения layout)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Заполняем всё пространство
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            
            // Уведомление об обновлении - на самом низком слое
            if (_showUpdateNotification)
              AnimatedUpdateNotification(
                onTap: () {
                  setState(() {
                    _showUpdateNotification = false;
                  });
                  _showUpdateDialog(_updateCurrentVersion, _updateLatestVersion);
                },
                onDismiss: () {
                  setState(() {
                    _showUpdateNotification = false;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
  }

  // Анимация перехода к демо-режиму мессенджера
  void _navigateToMessengerDemo(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
            const MessengerDemoScreen(),
        transitionDuration: const Duration(milliseconds: 800),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Кубическая кривая с высокой скоростью в начале и низкой в конце
          const curve = Curves.fastOutSlowIn;
          
          // Анимация сдвига вправо
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Начинаем справа
            end: Offset.zero, // Заканчиваем в центре
          ).animate(CurvedAnimation(
            parent: animation,
            curve: curve,
          ));
          
          // Анимация затухания предыдущего экрана
          final fadeAnimation = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
          ));
          
          return Stack(
            children: [
              // Предыдущий экран с затуханием
              FadeTransition(
                opacity: fadeAnimation,
                child: Container(color: Colors.black),
              ),
              // Новый экран с анимацией сдвига
              SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }

class _PasswordConfirmationModalContent extends StatefulWidget {
  final String originalPassword;
  final String confirmPasswordTitle;
  final String confirmPasswordDescription;
  final String confirmPasswordFieldHint;
  final String passwordMismatchError;
  final String confirmButton;
  final VoidCallback onConfirmed;

  const _PasswordConfirmationModalContent({
    required this.originalPassword,
    required this.confirmPasswordTitle,
    required this.confirmPasswordDescription,
    required this.confirmPasswordFieldHint,
    required this.passwordMismatchError,
    required this.confirmButton,
    required this.onConfirmed,
  });

  @override
  State<_PasswordConfirmationModalContent> createState() => _PasswordConfirmationModalContentState();
}

class _PasswordConfirmationModalContentState extends State<_PasswordConfirmationModalContent> {
  final TextEditingController _localConfirmPasswordController = TextEditingController();
  Timer? _localDebounce;
  bool _isFieldEmpty = true;
  bool _passwordsMatch = false; // Изначально пароли НЕ совпадают
  bool _showMismatchError = false;
  bool _isPasswordVisible = false; // Переменная для показа/скрытия пароля в модальном окне

  @override
  void initState() {
    super.initState();
    
    // Локальный слушатель с оптимизированным дебаунсом
    _localConfirmPasswordController.addListener(() {
      final confirmPassword = _localConfirmPasswordController.text;
      
      // Отменяем предыдущий таймер
      _localDebounce?.cancel();
      
      // Мгновенно обновляем состояние пустого поля
      final isEmpty = confirmPassword.isEmpty;
      if (_isFieldEmpty != isEmpty) {
        setState(() {
          _isFieldEmpty = isEmpty;
          if (isEmpty) {
            _passwordsMatch = false; // Пароли НЕ совпадают, если поле пустое
            _showMismatchError = false;
          }
        });
      }
      
      // Если поле не пустое, проверяем совпадение с минимальным дебаунсом
      if (!isEmpty) {
        _localDebounce = Timer(const Duration(milliseconds: 30), () {
          if (mounted) {
            final matches = widget.originalPassword == confirmPassword;
            if (_passwordsMatch != matches || _showMismatchError == matches) {
              setState(() {
                _passwordsMatch = matches;
                _showMismatchError = !matches;
              });
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _localDebounce?.cancel();
    _localConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = MediaQuery.of(context).size.height - keyboardHeight;
    
    return Padding(
      padding: EdgeInsets.only(
        bottom: keyboardHeight,
      ),
      child: Material(
        elevation: 6.0, // Elevation для модального окна подтверждения пароля
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: availableHeight * 0.9,
          ),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Серая полоска сверху (как в iOS)
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 30),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Иконка пароля
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.lock_outline,
                color: Colors.white,
                      size: 40,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Контент с автоматическим размером
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Заголовок
                    Text(
                      widget.confirmPasswordTitle,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Описание
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.confirmPasswordDescription,
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Поле для подтверждения пароля
                    Container(
                      decoration: BoxDecoration(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade700,
                          width: 1,
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          textSelectionTheme: TextSelectionThemeData(
                            selectionColor: Colors.grey.shade400.withOpacity(0.3),
                            selectionHandleColor: Colors.grey.shade400,
                          ),
                        ),
                        child: TextField(
                          controller: _localConfirmPasswordController,
                          cursorColor: Colors.grey.shade400,
                          obscureText: !_isPasswordVisible,
                          autofocus: true,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: widget.confirmPasswordFieldHint,
                            hintStyle: TextStyle(
                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                              fontFamily: 'Inter',
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Блок отображения ошибки "Пароли не совпадают"
                    if (_showMismatchError)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.passwordMismatchError,
                                style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    const SizedBox(height: 32),
                    
                    // Кнопка "Подтвердить"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (!_isFieldEmpty && _passwordsMatch) ? widget.onConfirmed : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (!_isFieldEmpty && _passwordsMatch) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                          foregroundColor: (!_isFieldEmpty && _passwordsMatch) ? Colors.black : Colors.grey.shade400,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          widget.confirmButton,
                          style: TextStyle(
                            color: (!_isFieldEmpty && _passwordsMatch) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white) : Colors.grey.shade400,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Отступ снизу для безопасной зоны
            SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
          ],
        ),
        ),
      ),
    );
  }
}

class _NicknameGeneratorModal extends StatefulWidget {
  final String title;
  final String description;
  final String closeButtonText;
  final VoidCallback onClose;

  const _NicknameGeneratorModal({
    required this.title,
    required this.description,
    required this.closeButtonText,
    required this.onClose,
  });

  @override
  State<_NicknameGeneratorModal> createState() => _NicknameGeneratorModalState();
}

class _NicknameGeneratorModalState extends State<_NicknameGeneratorModal> {
  Timer? _animationTimer;
  String _displayedNickname = "user";
  final List<String> _randomNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }
  
  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }
  
  void _startAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (mounted) {
        setState(() {
          // Генерируем ровно 9 случайных цифр
          final randomSuffix = List.generate(9, 
            (index) => _randomNumbers[(timer.tick * 3 + index * 7) % _randomNumbers.length]
          ).join('');
          
          _displayedNickname = "user$randomSuffix";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.3,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Серая полоска сверху (как в iOS)
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Основной контент
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Анимированный никнейм без фонового контейнера
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Directionality(
                      textDirection: TextDirection.ltr, // Принудительно слева направо для всех языков
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Статичная часть "user"
                          Text(
                            "user",
                            style: TextStyle(
                              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 32,
                              fontVariations: [FontVariation('wght', 600)],
                            ),
                          ),
                          
                          // Анимированная часть
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 60),
                            child: Text(
                              _displayedNickname.substring(4), // убираем "user"
                              key: ValueKey(_displayedNickname),
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                                fontFamily: 'Inter',
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Заголовок (центрированный)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Описание
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          // Кнопка "Понятно" - всегда внизу
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  widget.closeButtonText,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontVariations: [FontVariation('wght', 600)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
