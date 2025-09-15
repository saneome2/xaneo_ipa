import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class SettingsDetailScreen extends StatefulWidget {
  final String title;
  final Widget? content;
  final bool showBirthDateField;

  const SettingsDetailScreen({
    super.key,
    required this.title,
    this.content,
    this.showBirthDateField = false,
  });

  @override
  State<SettingsDetailScreen> createState() => _SettingsDetailScreenState();
}

class _SettingsDetailScreenState extends State<SettingsDetailScreen>
    with TickerProviderStateMixin {

  // Дата рождения для профиля
  DateTime _birthDate = DateTime(1990, 5, 15);
  
  // Контроллеры для полей ввода
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Устанавливаем значения по умолчанию
    _nameController.text = 'demo';
    _nicknameController.text = 'demouser';
    _phoneController.text = '+79991234567';

    // Определяем поддержку высокого обновления экрана для потенциального будущего использования
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      final pixelRatio = mediaQuery.devicePixelRatio;
      final screenSize = mediaQuery.size;

      // Для устройств с высоким DPI можно в будущем добавить оптимизацию
      if (pixelRatio >= 3.0 || (screenSize.width >= 1080 && screenSize.height >= 1920)) {
        // Будущая оптимизация для высоких частот обновления
      }
    });
  }

  // Метод для расчета горизонтального отступа (аналогично messenger_demo.dart)
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

  // Метод для выбора даты рождения (аналогично main.dart)
  Future<void> _selectBirthDate(BuildContext context) async {
    // Локальная переменная для временного хранения выбранной даты
    DateTime selectedDate = _birthDate;
    final l10n = AppLocalizations.of(context);
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (BuildContext modalContext) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.isDarkMode;
            return Container(
              height: MediaQuery.of(modalContext).size.height * 0.4,
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
                  // Заголовок
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Кнопка отмены (крестик)
                        IconButton(
                          onPressed: () {
                            Navigator.pop(modalContext); // Закрываем без результата
                          },
                          icon: Icon(
                            Icons.close,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            size: 24,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                        ),
                        Text(
                          l10n.selectDate,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                        // Кнопка с галочкой
                        IconButton(
                          onPressed: () {
                            // Возвращаем выбранную дату при нажатии на галочку
                            Navigator.pop(modalContext, selectedDate);
                          },
                          icon: Icon(
                            Icons.check_rounded,
                            color: isDarkMode ? Colors.white : Colors.black,
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
                      data: Theme.of(modalContext).copyWith(
                        textTheme: Theme.of(modalContext).textTheme.apply(
                          fontFamily: 'Inter',
                        ),
                        cupertinoOverrideTheme: CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              fontFamily: 'Inter',
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _birthDate,
                        minimumYear: 1900,
                        maximumYear: DateTime.now().year - 14, // Минимум 14 лет
                        onDateTimeChanged: (DateTime newDate) {
                          // Обновляем только локальную переменную
                          DateTime correctedDate = _correctDate(newDate);
                          selectedDate = correctedDate;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(modalContext).padding.bottom + 20),
                ],
              ),
            );
          },
        );
      },
    );

    // Если пользователь подтвердил выбор (result != null), сохраняем дату
    if (result != null) {
      setState(() {
        _birthDate = result;
      });
    }
  }

  // Метод коррекции даты (аналогично main.dart)
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

  // Метод для построения всех полей профиля
  Widget _buildProfileInfoContent() {
    final l10n = AppLocalizations.of(context);
    final horizontalPadding = _getHorizontalPadding(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Поле для ввода имени
              Text(
                l10n.name, // l10n.name,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade100.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade300.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.nameHint, // l10n.nameHint,
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
              const SizedBox(height: 16),

              // Выбор даты рождения
              Text(
                l10n.birthDate,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade100.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade300.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: InkWell(
                  onTap: () => _selectBirthDate(context),
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
                        Expanded(
                          child: Text(
                            '${_birthDate.day.toString().padLeft(2, '0')}.${_birthDate.month.toString().padLeft(2, '0')}.${_birthDate.year}',
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
                ),
              ),
              const SizedBox(height: 16),

              // Поле для ввода никнейма
              Text(
                l10n.nickname, // l10n.nickname,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade100.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade300.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _nicknameController,
                  cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.nicknameHint, // l10n.nicknameHint,
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
              const SizedBox(height: 16),

              // Поле для ввода телефона
              Text(
                l10n.phone, // l10n.phone,
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade100.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700.withOpacity(0.5) : Colors.grey.shade300.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _phoneController,
                  cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.phoneHint, // l10n.phoneHint,
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
                      Icons.phone_outlined,
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя панель с заголовком и кнопкой назад
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Кнопка "Назад"
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                      size: 24,
                    ),
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),

                  // Заголовок по центру
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Пустое пространство для симметрии
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Основной контент
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: widget.showBirthDateField
                      ? _buildProfileInfoContent()
                      : (widget.content ?? Container()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
