import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../providers/chat_settings_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/wallpaper_templates.dart';
import '../utils/text_parser.dart';
import '../widgets/custom_emoji_picker.dart';
import '../l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  final String? chatName;
  final String? chatAvatar;

  const ChatScreen({
    super.key,
    this.chatName,
    this.chatAvatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode(); // FocusNode для отслеживания клавиатуры
  final List<Map<String, dynamic>> _messages = [];
  bool _isVideoMode = true; // true = видео, false = голосовое
  bool _isEmojiPickerVisible = false; // Состояние показа пикера эмодзи
  Map<String, dynamic>? _replyToMessage; // Сообщение, на которое отвечаем
  String? _highlightedMessageId; // ID выделенного сообщения
  int _messageIdCounter = 0; // Счетчик для генерации уникальных ID сообщений
  
  // Переменная для хранения исходного стиля status bar
  SystemUiOverlayStyle? _originalSystemUiOverlayStyle;
  
  // Контроллеры анимации для отправки сообщений
  late AnimationController _messageAnimationController;
  late Animation<double> _messageSlideAnimation;
  late Animation<double> _messageOpacityAnimation;
  late Animation<double> _messageScaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Инициализируем контроллер анимации для отправки сообщений
    _messageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Увеличиваем скорость в 2 раза
      vsync: this,
    );
    
    // Анимация появления нового сообщения (выстрел с замедлением)
    _messageSlideAnimation = Tween<double>(
      begin: 80.0, // Начинаем из поля ввода
      end: 0.0,    // Заканчиваем в финальной позиции
    ).animate(CurvedAnimation(
      parent: _messageAnimationController,
      curve: Curves.decelerate, // Быстрый старт, плавное замедление
    ));
    
    // Анимация прозрачности нового сообщения
    _messageOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _messageAnimationController,
      curve: Curves.easeIn, // Плавное появление
    ));
    
    // Убираем масштабирование - оно мешает эффекту выстрела
    _messageScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_messageAnimationController);
    
    // Добавляем слушатель для FocusNode чтобы скрывать emoji picker при открытии клавиатуры
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _isEmojiPickerVisible) {
        setState(() {
          _isEmojiPickerVisible = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Устанавливаем стиль status bar
    final chatSettings = Provider.of<ChatSettingsProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Сохраняем текущие настройки status bar на основе themeProvider
        _originalSystemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
          systemNavigationBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
        );
        
        // Устанавливаем стиль status bar для чата
        _setSystemUiOverlayStyle(chatSettings.isDarkTheme);
      }
    });
  }

  @override
  void dispose() {
    // Восстанавливаем исходный стиль status bar
    _restoreOriginalSystemUiOverlayStyle();
    
    _messageController.dispose();
    _scrollController.dispose();
    _messageAnimationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Метод для установки стиля status bar в соответствии с темой чата
  void _setSystemUiOverlayStyle(bool isDarkTheme) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDarkTheme ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
  }

  // Метод для восстановления исходного стиля status bar
  void _restoreOriginalSystemUiOverlayStyle() {
    if (_originalSystemUiOverlayStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(_originalSystemUiOverlayStyle!);
    }
  }

  // Методы для генерации SVG иконок с правильными цветами
  String _getEmojiIconSvg(bool isDark) {
    final color = isDark ? '#FFFFFF' : '#000000';
    return '''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14" id="Happy-Face--Streamline-Core" height="14" width="14">
  <desc>
    Happy Face Streamline Icon: https://streamlinehq.com
  </desc>
  <g id="happy-face--smiley-chat-message-smile-emoji-face-satisfied">
    <path id="Vector" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M7 13.5c3.5899 0 6.5 -2.9101 6.5 -6.5C13.5 3.41015 10.5899 0.5 7 0.5 3.41015 0.5 0.5 3.41015 0.5 7c0 3.5899 2.91015 6.5 6.5 6.5Z" stroke-width="1"></path>
    <path id="Vector_2" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M3.69995 8c0.5 1.8 2.5 2.9 4.3 2.4 1.1 -0.4 2 -1.3 2.30005 -2.4" stroke-width="1"></path>
    <g id="Group 623">
      <path id="Vector_3" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M4.75 5.5c-0.13807 0 -0.25 -0.11193 -0.25 -0.25S4.61193 5 4.75 5" stroke-width="1"></path>
      <path id="Vector_4" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M4.75 5.5c0.13807 0 0.25 -0.11193 0.25 -0.25S4.88807 5 4.75 5" stroke-width="1"></path>
    </g>
    <g id="Group 624">
      <path id="Vector_5" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M9.25 5.5c-0.13807 0 -0.25 -0.11193 -0.25 -0.25S9.11193 5 9.25 5" stroke-width="1"></path>
      <path id="Vector_6" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M9.25 5.5c0.13807 0 0.25 -0.11193 0.25 -0.25S9.38807 5 9.25 5" stroke-width="1"></path>
    </g>
  </g>
</svg>''';
  }

  String _getVideoIconSvg(bool isDark) {
    final color = isDark ? '#FFFFFF' : '#000000';
    return '''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14" id="Instagram--Streamline-Core" height="14" width="14">
  <desc>
    Instagram Streamline Icon: https://streamlinehq.com
  </desc>
  <g id="instagram">
    <g id="Group 4546">
      <path id="Vector" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M10.3332 3.64404c-0.1381 0 -0.25 -0.11193 -0.25 -0.25s0.1119 -0.25 0.25 -0.25" stroke-width="1"></path>
      <path id="Vector_2" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M10.3332 3.64404c0.1381 0 0.25 -0.11193 0.25 -0.25s-0.1119 -0.25 -0.25 -0.25" stroke-width="1"></path>
    </g>
    <path id="Rectangle 2" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M0.858276 3.43141c0 -1.42103 1.151974 -2.573012 2.573014 -2.573012h6.86141c1.421 0 2.573 1.151982 2.573 2.573012v6.86139c0 1.421 -1.152 2.573 -2.573 2.573H3.43129c-1.42104 0 -2.573014 -1.152 -2.573014 -2.573V3.43141Z" stroke-width="1"></path>
    <path id="Ellipse 11" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M4.312 6.862a2.55 2.55 0 1 0 5.1 0 2.55 2.55 0 1 0 -5.1 0" stroke-width="1"></path>
  </g>
</svg>''';
  }

  String _getMicIconSvg(bool isDark) {
    final color = isDark ? '#FFFFFF' : '#000000';
    return '''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14" id="Voice-Mail--Streamline-Core" height="14" width="14">
  <desc>
    Voice Mail Streamline Icon: https://streamlinehq.com
  </desc>
  <g id="voice-mail--mic-audio-mike-music-microphone">
    <path id="Vector" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M9.5 6.5c0 0.66304 -0.26339 1.29893 -0.73223 1.76777C8.29893 8.73661 7.66304 9 7 9c-0.66304 0 -1.29893 -0.26339 -1.76777 -0.73223C4.76339 7.79893 4.5 7.16304 4.5 6.5V3c0 -0.66304 0.26339 -1.29893 0.73223 -1.76777C5.70107 0.763392 6.33696 0.5 7 0.5c0.66304 0 1.29893 0.263392 1.76777 0.73223C9.23661 1.70107 9.5 2.33696 9.5 3v3.5Z" stroke-width="1"></path>
    <path id="Vector_2" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M12 7c0.0013 0.59132 -0.1142 1.17707 -0.3398 1.72363 -0.2257 0.54656 -0.5571 1.04316 -0.9753 1.46127 -0.4181 0.4181 -0.91469 0.7496 -1.46126 0.9752 -0.54656 0.2257 -1.13231 0.3412 -1.72363 0.3399h-1c-0.59132 0.0013 -1.17707 -0.1142 -1.72363 -0.3399 -0.54656 -0.2256 -1.04316 -0.5571 -1.46129 -0.9752 -0.41813 -0.41811 -0.74954 -0.91471 -0.97522 -1.46127S1.99869 7.59132 2.00001 7" stroke-width="1"></path>
    <path id="Vector_3" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M7 11.5v2" stroke-width="1"></path>
  </g>
</svg>''';
  }

  String _getSendIconSvg(bool isDark) {
    final color = isDark ? '#FFFFFF' : '#000000';
    return '''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14" id="Send-Email--Streamline-Core" height="14" width="14">
  <desc>
    Send Email Streamline Icon: https://streamlinehq.com
  </desc>
  <g id="send-email--mail-send-email-paper-airplane">
    <path id="Vector" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="m5.81234 11.0005 2.17799 2.168c0.13363 0.1369 0.30071 0.2366 0.4847 0.2892 0.18399 0.0526 0.37852 0.0562 0.56434 0.0105 0.18698 -0.0435 0.35963 -0.1343 0.50135 -0.2638 0.14173 -0.1295 0.24776 -0.2932 0.3079 -0.4755L13.4253 2.00876c0.0747 -0.20086 0.0901 -0.41893 0.0444 -0.62829 -0.0457 -0.20937 -0.1505 -0.401209 -0.302 -0.552731 -0.1515 -0.151523 -0.3434 -0.256351 -0.5527 -0.302025 -0.2094 -0.045674 -0.4275 -0.030273 -0.6283 0.044373L1.26653 4.14679c-0.18858 0.06441 -0.356534 0.17802 -0.486508 0.32907 -0.129974 0.15105 -0.217253 0.33407 -0.252815 0.53014 -0.036707 0.17833 -0.028536 0.36298 0.02378 0.53737 0.052316 0.17438 0.147137 0.33304 0.275944 0.46171L3.56441 8.74256l-0.08992 3.46684 2.33785 -1.2089Z" stroke-width="1"></path>
    <path id="Vector_2" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="M13.1057 0.789795 3.56445 8.74247" stroke-width="1"></path>
  </g>
</svg>''';
  }

  String _getAttachIconSvg(bool isDark) {
    final color = isDark ? '#FFFFFF' : '#000000';
    return '''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14" id="Paperclip-1--Streamline-Core" height="14" width="14">
  <desc>
    Paperclip 1 Streamline Icon: https://streamlinehq.com
  </desc>
  <g id="paperclip-1--attachment-link-paperclip-unlink">
    <path id="Vector" stroke="$color" stroke-linecap="round" stroke-linejoin="round" d="m12.8581 6.7867 -5.87959 5.929c-0.22813 0.2324 -0.50031 0.4171 -0.80062 0.5431 -0.30031 0.1261 -0.62274 0.191 -0.94843 0.191 -0.3257 0 -0.64812 -0.0649 -0.94844 -0.191 -0.30031 -0.126 -0.57249 -0.3107 -0.80061 -0.5431l-1.75894 -1.7886c-0.46046 -0.4677 -0.71854 -1.09766 -0.71854 -1.75398 0 -0.65631 0.25808 -1.28631 0.71854 -1.75399L7.98644 1.1344c0.18372 -0.185239 0.40231 -0.332266 0.64314 -0.432602 0.24084 -0.100335 0.49915 -0.151993 0.76005 -0.151993s0.51922 0.051658 0.76007 0.151993c0.2408 0.100336 0.4594 0.247363 0.6431 0.432602l0.7016 0.7016c0.1853 0.18372 0.3323 0.40231 0.4326 0.64314 0.1004 0.24083 0.152 0.49915 0.152 0.76005s-0.0516 0.51922 -0.152 0.76005c-0.1003 0.24084 -0.2473 0.45942 -0.4326 0.64314L5.94094 10.2156c-0.09187 0.0927 -0.20116 0.1662 -0.32158 0.2163 -0.12041 0.0502 -0.24957 0.076 -0.38002 0.076 -0.13045 0 -0.25961 -0.0258 -0.38003 -0.076 -0.12041 -0.0501 -0.22971 -0.1236 -0.32157 -0.2163l-0.34586 -0.3557c-0.09262 -0.09187 -0.16613 -0.20116 -0.2163 -0.32158 -0.05016 -0.12041 -0.07599 -0.24957 -0.07599 -0.38002 0 -0.13045 0.02583 -0.25961 0.07599 -0.38003 0.05017 -0.12041 0.12368 -0.22971 0.2163 -0.32157l3.72539 -3.69574" stroke-width="1"></path>
  </g>
</svg>''';
  }

  // Функция для выбора сообщения для ответа
  void _selectMessageToReply(Map<String, dynamic> message) {
    setState(() {
      _replyToMessage = message;
    });
    
    // Фокусируемся на поле ввода
    _focusNode.requestFocus();
  }

  // Функция для отмены ответа
  void _cancelReply() {
    setState(() {
      _replyToMessage = null;
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final messageText = _messageController.text.trim();
      final currentTime = '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}';
      final replyTo = _replyToMessage; // Сохраняем ссылку на сообщение для ответа
      
      // Сначала очищаем поле ввода и отменяем ответ
      _messageController.clear();
      setState(() {
        _replyToMessage = null;
      });
      
      // Сразу добавляем новое сообщение пользователя
      setState(() {
        final newMessage = {
          'id': 'msg_${++_messageIdCounter}', // Уникальный ID сообщения
          'text': messageText,
          'isMe': true,
          'time': currentTime,
          'avatar': '👤',
          'isNew': true, // Маркер для анимации последнего сообщения
        };
        
        // Если это ответ на сообщение, добавляем информацию о нем
        if (replyTo != null) {
          newMessage['replyTo'] = {
            'id': replyTo['id'], // ID оригинального сообщения
            'text': replyTo['text'],
            'isMe': replyTo['isMe'],
            'avatar': replyTo['avatar'],
          };
        }
        
        _messages.add(newMessage);
      });
      
      // Запускаем анимацию появления для последнего сообщения
      await _messageAnimationController.forward();
      
      // Проверяем, если пользователь написал локализованное приветствие, добавляем ответ от собеседника
      final l10n = AppLocalizations.of(context);
      if (messageText.trim().toLowerCase() == l10n.greetingTrigger.toLowerCase()) {
        await Future.delayed(const Duration(milliseconds: 500)); // Небольшая пауза
        
        // Сбрасываем анимацию перед новым сообщением
        _messageAnimationController.reset();
        
        final responseTime = '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}';
        setState(() {
          _messages.add({
            'id': 'msg_${++_messageIdCounter}', // Уникальный ID сообщения
            'text': l10n.greetingResponse,
            'isMe': false,
            'time': responseTime,
            'avatar': widget.chatAvatar ?? '🔖',
            'isNew': true, // Маркер для анимации последнего сообщения
          });
        });
        
        // Запускаем анимацию для ответа
        await _messageAnimationController.forward();
        
        // Небольшая пауза перед сбросом
        await Future.delayed(const Duration(milliseconds: 200));
        
        // Сбрасываем анимацию и убираем маркер после анимации ответа
        _messageAnimationController.reset();
        setState(() {
          for (var message in _messages) {
            message.remove('isNew');
          }
        });
      } else {
        // Если это обычное сообщение пользователя, сбрасываем анимацию сразу
        await Future.delayed(const Duration(milliseconds: 200));
        _messageAnimationController.reset();
        setState(() {
          for (var message in _messages) {
            message.remove('isNew');
          }
        });
      }

      // Прокрутка к последнему сообщению
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  /// Функция для поиска и скролла к оригинальному сообщению
  void _scrollToMessage(String messageId) {
    final messageIndex = _messages.indexWhere((msg) => msg['id'] == messageId);
    if (messageIndex != -1) {
      // Выделяем сообщение
      setState(() {
        _highlightedMessageId = messageId;
      });

      // Вычисляем позицию для скролла (учитываем реверсивный порядок)
      final reversedIndex = _messages.length - 1 - messageIndex;
      final itemHeight = 80.0; // Примерная высота одного сообщения
      final scrollPosition = reversedIndex * itemHeight;

      // Скроллим к сообщению
      _scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Убираем выделение через 2 секунды
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _highlightedMessageId = null;
          });
        }
      });
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiPickerVisible = !_isEmojiPickerVisible;
    });

    if (_isEmojiPickerVisible) {
      // Скрываем клавиатуру при показе пикера эмодзи
      FocusScope.of(context).unfocus();
    }
  }

  void _onEmojiSelected(String emoji) {
    final currentText = _messageController.text;
    final cursorPos = _messageController.selection.start;

    final newText = currentText.substring(0, cursorPos) +
                   emoji +
                   currentText.substring(cursorPos);

    _messageController.text = newText;
    _messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: cursorPos + emoji.length),
    );
    
    // Обновляем UI для показа кнопки отправки
    setState(() {});
  }

  void _onBackToKeyboard() {
    setState(() {
      _isEmojiPickerVisible = false;
    });
    // Открываем клавиатуру
    _focusNode.requestFocus();
  }

  void _showVideoMessagePicker() {
    setState(() {
      _isVideoMode = !_isVideoMode;
    });
  }

  void _showFilePicker() {
    final l10n = AppLocalizations.of(context);
    // TODO: Реализовать функционал отправки файлов
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.fileSendingNotImplemented)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chatSettings = Provider.of<ChatSettingsProvider>(context);
    final availableWallpapers = WallpaperPresets.getAllWallpapers(chatSettings.isDarkTheme);
    final selectedWallpaper = chatSettings.selectedWallpaperIndex < availableWallpapers.length 
        ? availableWallpapers[chatSettings.selectedWallpaperIndex] 
        : null;

    return Scaffold(
      backgroundColor: chatSettings.isDarkTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: chatSettings.isDarkTheme ? Colors.grey.shade900 : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: chatSettings.isDarkTheme ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: chatSettings.isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.chatAvatar ?? '🔖',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatName ?? l10n.favoritesChat,
                  style: TextStyle(
                    color: chatSettings.isDarkTheme ? Colors.white : Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  l10n.wasOnlineRecently,
                  style: TextStyle(
                    color: chatSettings.isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontFamily: 'Inter',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: chatSettings.isDarkTheme ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Меню действий
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Обои чата
          if (selectedWallpaper != null)
            Positioned.fill(
              child: selectedWallpaper,
            ),
          // Содержимое чата
          Column(
            children: [
              // Список сообщений (убираем анимацию списка)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(2),
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _messages.length - 1 - index;
                    final message = _messages[reversedIndex];
                    return _buildMessageBubble(message, chatSettings.isDarkTheme, chatSettings);
                  },
                ),
              ),

          // Поле ввода сообщения
          Column(
            children: [
              // Индикатор ответа
              if (_replyToMessage != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: chatSettings.isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade100,
                    border: Border(
                      left: BorderSide(
                        color: _replyToMessage!['isMe'] ? chatSettings.messageBubbleColor : chatSettings.receivedBubbleColor,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (_replyToMessage!.containsKey('id')) {
                              _scrollToMessage(_replyToMessage!['id']);
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.reply,
                                    size: 16,
                                    color: chatSettings.isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Избранное',
                                    style: TextStyle(
                                      color: _getReplyPreviewTextColor(_replyToMessage!['isMe'] ? chatSettings.messageBubbleColor : chatSettings.receivedBubbleColor),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _replyToMessage!['text'].length > 30 ? '${_replyToMessage!['text'].substring(0, 30)}...' : _replyToMessage!['text'],
                                style: TextStyle(
                                  color: _getReplyPreviewTextColor(_replyToMessage!['isMe'] ? chatSettings.messageBubbleColor : chatSettings.receivedBubbleColor).withOpacity(0.8),
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _cancelReply,
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: chatSettings.isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              // Поле ввода
              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: chatSettings.isDarkTheme ? Colors.grey.shade900 : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50, right: 16, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: chatSettings.isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(
                      color: chatSettings.isDarkTheme ? Colors.white : Colors.black,
                      fontFamily: 'Inter',
                      fontSize: chatSettings.fontSize,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Сообщение',
                      hintStyle: TextStyle(
                        color: chatSettings.isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
                        fontFamily: 'Inter',
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 5),
                    ),
                    maxLines: 2,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onSubmitted: (_) => _sendMessage(),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 6,
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      onPressed: _toggleEmojiPicker,
                      icon: SvgPicture.string(
                        _getEmojiIconSvg(chatSettings.isDarkTheme),
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 6,
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: _messageController.text.trim().isNotEmpty
                        ? IconButton(
                            key: const ValueKey('send'),
                            onPressed: _sendMessage,
                            icon: SvgPicture.string(
                              _getSendIconSvg(chatSettings.isDarkTheme),
                              width: 24,
                              height: 24,
                            ),
                          )
                        : AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(scale: animation, child: child);
                            },
                            child: IconButton(
                              key: ValueKey<bool>(_isVideoMode),
                              onPressed: _showVideoMessagePicker,
                              icon: SvgPicture.string(
                                _isVideoMode ? _getVideoIconSvg(chatSettings.isDarkTheme) : _getMicIconSvg(chatSettings.isDarkTheme),
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 6,
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: _messageController.text.trim().isEmpty
                        ? IconButton(
                            key: const ValueKey('file'),
                            onPressed: _showFilePicker,
                            icon: SvgPicture.string(
                              _getAttachIconSvg(chatSettings.isDarkTheme),
                              width: 24,
                              height: 24,
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('file_hidden')),
                    ),
                  ),
                ),
              ],
            ),
          ),
            ],
          ),

          // Пикер эмодзи (показывается вместо клавиатуры)
          if (_isEmojiPickerVisible)
            CustomEmojiPicker(
              onEmojiSelected: _onEmojiSelected,
              onBackToKeyboard: _onBackToKeyboard,
            ),
        ],
      ),
    ],
    ));
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isDarkMode, ChatSettingsProvider chatSettings) {
    final isMe = message['isMe'] as bool;
    final isNewMessage = message.containsKey('isNew') && message['isNew'] == true;
    
    // Получаем индекс этого сообщения в списке
    final messageIndex = _messages.indexWhere((msg) => msg == message);
    final isLastMessage = messageIndex == _messages.length - 1;
    
    // Анимируем только последнее новое сообщение
    final shouldAnimate = isNewMessage && isLastMessage;

    Widget bubbleWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Пузырь сообщения
          Flexible(
            child: GestureDetector(
              onTap: () => _selectMessageToReply(message),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Если это ответ на сообщение, показываем оригинал
                  if (message.containsKey('replyTo')) ...[
                    _buildReplyPreview(message['replyTo'], isMe, isDarkMode, chatSettings),
                    const SizedBox(height: 4),
                  ],
                  
                  // Сам пузырь
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isMe
                          ? chatSettings.messageBubbleColor
                          : chatSettings.receivedBubbleColor,
                      borderRadius: _getBorderRadius(isMe),
                      // Добавляем выделение если это сообщение подсвечено
                      border: _highlightedMessageId == message['id']
                          ? Border.all(color: Colors.yellow, width: 2)
                          : null,
                      boxShadow: _highlightedMessageId == message['id']
                          ? [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: TextParser.parseTextWithEmojis(
                          text: message['text'],
                          textStyle: TextStyle(
                            color: isMe
                                ? Colors.white
                                : (isDarkMode ? Colors.white : Colors.black),
                            fontSize: chatSettings.fontSize,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Время отправки
                  Padding(
                    padding: EdgeInsets.only(
                      top: 2,
                      left: isMe ? 0 : 12,
                      right: isMe ? 12 : 0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: message['time'],
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    
    // Если это новое входящее сообщение от собеседника, оборачиваем в анимацию появления
    if (shouldAnimate) {
      return AnimatedBuilder(
        animation: _messageAnimationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _messageSlideAnimation.value),
            child: Transform.scale(
              scale: _messageScaleAnimation.value,
              child: Opacity(
                opacity: _messageOpacityAnimation.value,
                child: bubbleWidget,
              ),
            ),
          );
        },
      );
    }
    
    return bubbleWidget;
  }

  // Виджет для показа превью сообщения, на которое отвечаем
  Widget _buildReplyPreview(Map<String, dynamic> replyTo, bool isMe, bool isDarkMode, ChatSettingsProvider chatSettings) {
    return GestureDetector(
      onTap: () {
        if (replyTo.containsKey('id')) {
          _scrollToMessage(replyTo['id']);
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200).withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: replyTo['isMe'] ? chatSettings.messageBubbleColor : chatSettings.receivedBubbleColor,
              width: 3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Показываем "Избранное"
            Text(
              'Избранное',
              style: TextStyle(
                color: _getReplyPreviewTextColor(replyTo['isMe'] ? chatSettings.messageBubbleColor : chatSettings.receivedBubbleColor),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              replyTo['text'].length > 50 ? '${replyTo['text'].substring(0, 50)}...' : replyTo['text'],
              style: TextStyle(
                color: _getReplyPreviewTextColor(replyTo['isMe'] ? chatSettings.messageBubbleColor : chatSettings.receivedBubbleColor).withOpacity(0.8),
                fontSize: 13,
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(bool isMe) {
    if (isMe) {
      return const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(4),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    }
  }

  /// Определяет контрастный цвет текста для превью ответа
  /// Если цвет пузыря темный - возвращает белый текст
  /// Если цвет пузыря светлый - возвращает темный текст
  Color _getReplyPreviewTextColor(Color bubbleColor) {
    // Вычисляем яркость цвета (luminance)
    // Если яркость < 0.5 - цвет темный, используем белый текст
    // Если яркость >= 0.5 - цвет светлый, используем темный текст
    return bubbleColor.computeLuminance() < 0.5 ? Colors.white : Colors.black87;
  }
}
