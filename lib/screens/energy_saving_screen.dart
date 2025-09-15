import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class EnergySavingScreen extends StatefulWidget {
  const EnergySavingScreen({super.key});

  @override
  State<EnergySavingScreen> createState() => _EnergySavingScreenState();
}

class _EnergySavingScreenState extends State<EnergySavingScreen> {
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

  // Состояния настроек энергосбережения
  bool _lowPowerModeEnabled = false;
  bool _messageAnimations = true;
  bool _reducedAnimations = false;
  bool _autoSleepMode = true;
  String _batteryOptimization = 'Стандартная';

  // Определение комбинаций настроек для каждого режима
  static const Map<String, Map<String, dynamic>> _optimizationPresets = {
    'Максимальная': {
      'lowPowerMode': true,
      'autoSleepMode': true,
      'messageAnimations': false,
      'reducedAnimations': true,
    },
    'Стандартная': {
      'lowPowerMode': false,
      'autoSleepMode': true,
      'messageAnimations': true,
      'reducedAnimations': false,
    },
    'Отключена': {
      'lowPowerMode': false,
      'autoSleepMode': false,
      'messageAnimations': true,
      'reducedAnimations': false,
    },
  };

  // Обновление режима оптимизации на основе текущих настроек
  void _updateOptimizationMode() {
    _batteryOptimization = _getCurrentOptimizationMode();
  }

  // Получение текущего режима оптимизации на основе настроек
  String _getCurrentOptimizationMode() {
    final currentSettings = {
      'lowPowerMode': _lowPowerModeEnabled,
      'autoSleepMode': _autoSleepMode,
      'messageAnimations': _messageAnimations,
      'reducedAnimations': _reducedAnimations,
    };

    for (final entry in _optimizationPresets.entries) {
      if (_settingsMatchPreset(currentSettings, entry.value)) {
        return entry.key;
      }
    }

    return 'Пользовательская';
  }

  // Проверка, соответствуют ли текущие настройки предустановке
  bool _settingsMatchPreset(Map<String, dynamic> current, Map<String, dynamic> preset) {
    return current['lowPowerMode'] == preset['lowPowerMode'] &&
           current['autoSleepMode'] == preset['autoSleepMode'] &&
           current['messageAnimations'] == preset['messageAnimations'] &&
           current['reducedAnimations'] == preset['reducedAnimations'];
  }

  // Применение настроек для выбранного режима оптимизации
  void _applyOptimizationPreset(String mode) {
    if (!_optimizationPresets.containsKey(mode)) return;

    final preset = _optimizationPresets[mode]!;
    setState(() {
      _lowPowerModeEnabled = preset['lowPowerMode'];
      _autoSleepMode = preset['autoSleepMode'];
      _messageAnimations = preset['messageAnimations'];
      _reducedAnimations = preset['reducedAnimations'];
      _batteryOptimization = mode;
    });

    // Сохраняем все настройки
    _saveAllSettings();
  }

  // Сохранение всех настроек
  Future<void> _saveAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('low_power_mode', _lowPowerModeEnabled);
    await prefs.setBool('auto_sleep_mode', _autoSleepMode);
    await prefs.setBool('message_animations', _messageAnimations);
    await prefs.setBool('reduced_animations', _reducedAnimations);
    await prefs.setString('battery_optimization', _batteryOptimization);
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Загрузка настроек из SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lowPowerModeEnabled = prefs.getBool('low_power_mode') ?? false;
      _autoSleepMode = prefs.getBool('auto_sleep_mode') ?? true;
      _messageAnimations = prefs.getBool('message_animations') ?? true;
      _reducedAnimations = prefs.getBool('reduced_animations') ?? false;
      _batteryOptimization = prefs.getString('battery_optimization') ?? 'Стандартная';
    });
    // После загрузки обновляем режим на основе загруженных настроек
    _updateOptimizationMode();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final backgroundColor = themeProvider.isDarkMode ? Colors.black : Colors.white;
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
    final appBarColor = themeProvider.isDarkMode ? Colors.black : Colors.white;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'Энергосбережение',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // Умная прокрутка - не позволяет прокручивать дальше границ
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Основные настройки энергосбережения
            _buildSectionHeader('Основные настройки', textColor, backgroundColor),
            _buildSwitchItem(
              'Режим экономии энергии',
              'Автоматически оптимизирует работу приложения для экономии батареи',
              Icons.battery_saver,
              _lowPowerModeEnabled,
              (value) {
                setState(() => _lowPowerModeEnabled = value);
                _updateOptimizationMode();
                _saveAllSettings();
              },
              textColor,
            ),
            _buildSwitchItem(
              'Автоматический спящий режим',
              'Переводит приложение в спящий режим при неактивности',
              Icons.bedtime,
              _autoSleepMode,
              (value) {
                setState(() => _autoSleepMode = value);
                _updateOptimizationMode();
                _saveAllSettings();
              },
              textColor,
            ),
            _buildSettingsItem(
              'Оптимизация батареи',
              _getCurrentOptimizationMode(),
              Icons.battery_charging_full,
              () => _showBatteryOptimizationDialog(),
              textColor,
            ),

            // Настройки анимаций чата
            _buildSectionHeader('Настройки анимаций чата', textColor, backgroundColor),
            _buildSwitchItem(
              'Анимации сообщений',
              'Показывать анимации при отправке и получении сообщений',
              Icons.message,
              _messageAnimations,
              (value) {
                setState(() => _messageAnimations = value);
                _updateOptimizationMode();
                _saveAllSettings();
              },
              textColor,
            ),

            // Настройки интерфейса
            _buildSectionHeader('Настройки интерфейса', textColor, backgroundColor),
            _buildSwitchItem(
              'Упрощенные анимации',
              'Уменьшает количество анимаций для экономии энергии',
              Icons.animation,
              _reducedAnimations,
              (value) {
                setState(() => _reducedAnimations = value);
                _updateOptimizationMode();
                _saveAllSettings();
              },
              textColor,
            ),
            _buildEnergyItem(
              'Темная тема',
              'Использует OLED-дисплей для экономии энергии',
              Icons.dark_mode,
              () => _toggleTheme(),
              textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color textColor, Color backgroundColor) {
    final horizontalPadding = _getHorizontalPadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      color: backgroundColor == Colors.black ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade200.withOpacity(0.8),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEnergyItem(String title, String subtitle, IconData icon, VoidCallback onTap, Color textColor) {
    final horizontalPadding = _getHorizontalPadding(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final borderColor = themeProvider.isDarkMode ? Colors.grey.shade800.withOpacity(0.3) : Colors.grey.shade300.withOpacity(0.3);
    final iconColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final subtitleColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.light_mode,
              color: iconColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String title, String subtitle, IconData icon, bool value, ValueChanged<bool> onChanged, Color textColor) {
    final horizontalPadding = _getHorizontalPadding(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final borderColor = themeProvider.isDarkMode ? Colors.grey.shade800.withOpacity(0.3) : Colors.grey.shade300.withOpacity(0.3);
    final iconColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final subtitleColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final activeThumbColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final activeTrackColor = themeProvider.isDarkMode ? Colors.grey.shade600.withOpacity(0.5) : Colors.grey.shade400.withOpacity(0.5);
    final inactiveThumbColor = themeProvider.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400;
    final inactiveTrackColor = themeProvider.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: activeThumbColor,
            activeTrackColor: activeTrackColor,
            inactiveThumbColor: inactiveThumbColor,
            inactiveTrackColor: inactiveTrackColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, String value, IconData icon, VoidCallback onTap, Color textColor) {
    final horizontalPadding = _getHorizontalPadding(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final borderColor = themeProvider.isDarkMode ? Colors.grey.shade800.withOpacity(0.3) : Colors.grey.shade300.withOpacity(0.3);
    final iconColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final valueColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _showBatteryOptimizationDialog() {
    String selectedOption = _batteryOptimization; // Локальная переменная для отслеживания выбора
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
          builder: (context, modalSetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Серая полоска сверху (как в iOS)
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Иконка
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.battery_charging_full,
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Заголовок
                      Text(
                        'Оптимизация батареи',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Опции выбора
                      Column(
                        children: [
                          _buildModalRadioOption('Максимальная', selectedOption, modalSetState, (value) => selectedOption = value),
                          const SizedBox(height: 16),
                          _buildModalRadioOption('Стандартная', selectedOption, modalSetState, (value) => selectedOption = value),
                          const SizedBox(height: 16),
                          _buildModalRadioOption('Отключена', selectedOption, modalSetState, (value) => selectedOption = value),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Кнопки
                      Row(
                        children: [
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
                                'Отмена',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _applyOptimizationPreset(selectedOption); // Применяем предустановку
                                Navigator.of(context).pop();
                                _showToast('Выбрана: $selectedOption');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Сохранить',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16), // Дополнительный отступ снизу
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }  Widget _buildModalRadioOption(String title, String selectedOption, StateSetter setState, Function(String) onChanged) {
    final isSelected = selectedOption == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          onChanged(title);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.grey.shade800.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: title,
              groupValue: selectedOption,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    onChanged(value);
                  });
                }
              },
              activeColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black;
                }
                return Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;
              }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme();
    _showToast(themeProvider.isDarkMode ? 'Темная тема включена' : 'Светлая тема включена');
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
