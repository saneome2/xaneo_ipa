import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
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

  // Моковые данные для сессий
  final List<SessionData> _sessions = [
    SessionData(
      id: '1',
      deviceName: 'Windows PC',
      platform: 'Windows 11',
      browser: 'Chrome 118',
      location: 'Москва, Россия',
      ipAddress: '192.168.1.100',
      lastActive: DateTime.now(),
      isCurrentDevice: true,
      icon: Icons.computer,
    ),
    SessionData(
      id: '2',
      deviceName: 'iPhone 15',
      platform: 'iOS 17.1',
      browser: 'Safari',
      location: 'Москва, Россия',
      ipAddress: '10.0.0.5',
      lastActive: DateTime.now().subtract(const Duration(hours: 2)),
      isCurrentDevice: false,
      icon: Icons.phone_iphone,
    ),
    SessionData(
      id: '3',
      deviceName: 'MacBook Pro',
      platform: 'macOS Sonoma',
      browser: 'Safari 17',
      location: 'Санкт-Петербург, Россия',
      ipAddress: '172.16.0.10',
      lastActive: DateTime.now().subtract(const Duration(days: 1)),
      isCurrentDevice: false,
      icon: Icons.laptop_mac,
    ),
    SessionData(
      id: '4',
      deviceName: 'Android Phone',
      platform: 'Android 14',
      browser: 'Chrome Mobile',
      location: 'Екатеринбург, Россия',
      ipAddress: '203.0.113.45',
      lastActive: DateTime.now().subtract(const Duration(days: 3)),
      isCurrentDevice: false,
      icon: Icons.phone_android,
    ),
    SessionData(
      id: '5',
      deviceName: 'Web Browser',
      platform: 'Web',
      browser: 'Firefox 120',
      location: 'Новосибирск, Россия',
      ipAddress: '185.76.11.25',
      lastActive: DateTime.now().subtract(const Duration(hours: 6)),
      isCurrentDevice: false,
      icon: Icons.web,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        centerTitle: true,
        title: Text(
          l10n.sessions,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Раздел активных устройств
            _buildSectionHeader(l10n.activeDevices),
            
            // Список сессий
            ..._sessions.map((session) => _buildSessionItem(session)),
            
            const SizedBox(height: 20),
            
            // Кнопка завершения всех остальных сессий
            _buildTerminateAllButton(),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final horizontalPadding = _getHorizontalPadding(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      color: isDarkMode 
        ? Colors.grey.shade900.withValues(alpha: 0.3) 
        : Colors.grey.shade200.withValues(alpha: 0.5),
      child: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSessionItem(SessionData session) {
    final horizontalPadding = _getHorizontalPadding(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDarkMode 
              ? Colors.grey.shade800.withValues(alpha: 0.3) 
              : Colors.grey.shade400.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Иконка устройства
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Colors.grey.shade800 
                : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              session.icon,
              color: isDarkMode ? Colors.white70 : Colors.black54,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Информация о сессии
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        session.deviceName,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (session.isCurrentDevice)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l10n.currentDevice,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  '${l10n.sessionPlatform}: ${session.platform}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                
                Text(
                  '${l10n.sessionBrowser}: ${session.browser}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                
                // Показываем IP адрес только для веб-сессий
                if (session.platform == 'Web') ...[
                  Text(
                    '${l10n.sessionIPAddress}: ${session.ipAddress}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
                
                Text(
                  '${l10n.sessionLocation}: ${session.location}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  '${l10n.sessionLastActive}: ${_formatLastActive(session.lastActive)}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade500,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          
          // Кнопка завершения сессии (только для не текущих устройств)
          if (!session.isCurrentDevice) ...[
            const SizedBox(width: 16),
            IconButton(
              onPressed: () => _showTerminateSessionDialog(session),
              icon: Icon(
                Icons.close,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTerminateAllButton() {
    final horizontalPadding = _getHorizontalPadding(context);
    final l10n = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    final otherSessionsCount = _sessions.where((s) => !s.isCurrentDevice).length;
    
    if (otherSessionsCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _showTerminateAllSessionsDialog(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode ? Colors.white : Colors.black,
            foregroundColor: isDarkMode ? Colors.black : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            l10n.terminateAllOtherSessions,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _formatLastActive(DateTime lastActive) {
    final now = DateTime.now();
    final difference = now.difference(lastActive);

    if (difference.inMinutes < 1) {
      return 'Только что';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} мин назад';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} ч назад';
    } else {
      return '${difference.inDays} дн назад';
    }
  }

  void _showTerminateSessionDialog(SessionData session) {
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
                            Icons.warning,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Заголовок
                        Text(
                          l10n.terminateSession,
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
                          l10n.confirmTerminateSession,
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
                            // Кнопка отмены
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
                            // Кнопка завершения
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _terminateSession(session);
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
                                  l10n.confirmButton,
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
            ));
          },
        );
      },
    );
  }

  void _showTerminateAllSessionsDialog() {
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
                            Icons.warning,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Заголовок
                        Text(
                          l10n.terminateAllOtherSessions,
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
                          l10n.confirmTerminateAllSessions,
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
                            // Кнопка отмены
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
                            // Кнопка завершения всех
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _terminateAllOtherSessions();
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
                                  l10n.confirmButton,
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
            ));
          },
        );
      },
    );
  }

  void _terminateSession(SessionData session) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    setState(() {
      _sessions.removeWhere((s) => s.id == session.id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Сессия ${session.deviceName} завершена',
          style: const TextStyle(fontFamily: 'Inter'),
        ),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _terminateAllOtherSessions() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    setState(() {
      _sessions.removeWhere((s) => !s.isCurrentDevice);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Все остальные сессии завершены',
          style: TextStyle(fontFamily: 'Inter'),
        ),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class SessionData {
  final String id;
  final String deviceName;
  final String platform;
  final String browser;
  final String location;
  final String ipAddress;
  final DateTime lastActive;
  final bool isCurrentDevice;
  final IconData icon;

  SessionData({
    required this.id,
    required this.deviceName,
    required this.platform,
    required this.browser,
    required this.location,
    required this.ipAddress,
    required this.lastActive,
    required this.isCurrentDevice,
    required this.icon,
  });
}
