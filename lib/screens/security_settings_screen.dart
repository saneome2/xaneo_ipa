import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/theme_assets.dart';
import '../providers/theme_provider.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
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

  bool _isTwoFactorEnabled = false;
  bool _initialTwoFactorState = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
        centerTitle: true,
        title: Text(
          l10n.securitySettings,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // Умная прокрутка - не позволяет прокручивать дальше границ
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Раздел аутентификации
            _buildSectionHeader(l10n.securityAuthentication),
            _buildSecurityItem(
              l10n.securityChangePassword,
              Icons.lock_outline,
              () => _showChangePasswordDialog(),
            ),
            _buildSecurityItem(
              l10n.securityTwoFactorAuth,
              Icons.security,
              () => _showSecurityDialog(l10n.securityTwoFactorAuth),
            ),
            _buildSecurityItem(
              l10n.securityChangeEmail,
              Icons.email_outlined,
              () => _showSecurityDialog(l10n.securityChangeEmail),
            ),
            _buildSecurityItem(
              l10n.securityPasscode,
              Icons.pin_outlined,
              () => _showSecurityDialog(l10n.securityPasscode),
            ),

            const SizedBox(height: 50),
          ],
        ),
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

  Widget _buildSecurityItem(String title, IconData icon, VoidCallback onTap) {
    final horizontalPadding = _getHorizontalPadding(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800.withOpacity(0.3) : Colors.grey.shade400.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  size: 24,
                ),
                const SizedBox(width: 16),
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
                Icon(
                  Icons.arrow_forward_ios,
                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade500 : Colors.grey.shade700,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSecurityDialog(String title) {
    final l10n = AppLocalizations.of(context);
    
    if (title == l10n.securityTwoFactorAuth) {
      _showTwoFactorDialog();
      return;
    }
    
    if (title == l10n.securityChangeEmail) {
      _showChangeEmailVerificationModal();
      return;
    }
    
    if (title == l10n.securityPasscode) {
      _showPasscodeVerificationModal();
      return;
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.white,
          title: Text(
            title,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            l10n.contentInDevelopment(title),
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.ready,
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTwoFactorDialog() {
    final l10n = AppLocalizations.of(context);
    // Сохраняем начальное состояние 2FA
    _initialTwoFactorState = _isTwoFactorEnabled;
    
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
                // Восстанавливаем исходное состояние при закрытии окна
                _isTwoFactorEnabled = _initialTwoFactorState;
                return true;
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
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
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        // Иконка
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.security,
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Заголовок
                        Text(
                          l10n.securityTwoFactorAuth,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        // Тумблер
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.securityTwoFactorAuth,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isTwoFactorEnabled ? l10n.twoFactorEnabled : l10n.twoFactorDisabled,
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: _isTwoFactorEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _isTwoFactorEnabled = value;
                                });
                                // Здесь можно добавить логику для включения/отключения 2FA
                              },
                              activeThumbColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                              activeTrackColor: Colors.grey.shade600.withOpacity(0.5),
                              inactiveThumbColor: Colors.grey.shade500,
                              inactiveTrackColor: Colors.grey.shade700,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Кнопка "Готово"
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Проверяем, изменилось ли состояние 2FA
                              if (_initialTwoFactorState != _isTwoFactorEnabled) {
                                // Состояние изменилось - показываем окно подтверждения
                                Navigator.of(context).pop(); // Закрываем текущее окно
                                _showTwoFactorVerificationModal();
                              } else {
                                // Состояние не изменилось - просто закрываем окно
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              l10n.ready,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16), // Дополнительный отступ снизу
                      ],
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

  void _showTwoFactorVerificationModal() {
    final l10n = AppLocalizations.of(context);
    final TextEditingController verificationCodeController = TextEditingController();
    bool isVerifyingCode = false;

    // Определяем, включаем или выключаем 2FA
    final isEnabling = !_initialTwoFactorState && _isTwoFactorEnabled;

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
            return WillPopScope(
              onWillPop: () async {
                // Восстанавливаем исходное состояние при закрытии окна без подтверждения
                _isTwoFactorEnabled = _initialTwoFactorState;
                return true;
              },
              child: Material(
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
                                child: const Icon(
                                  Icons.security,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Заголовок
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  l10n.verifyEmailTitle, // Используем тот же заголовок
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Описание (динамическое)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  isEnabling
                                    ? l10n.twoFactorEnableDescription('demouser@example.com')
                                    : l10n.twoFactorDisableDescription('demouser@example.com'),
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
                                        selectionColor: Colors.grey.shade400.withOpacity(0.3),
                                        selectionHandleColor: Colors.grey.shade400,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: verificationCodeController,
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
                                        setModalState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintText: l10n.verificationCodeHint,
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade400,
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
                                        counterText: "",
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
                                    onPressed: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? () {
                                      // Проверяем код
                                      setModalState(() => isVerifyingCode = true);
                                      Future.delayed(const Duration(seconds: 1), () {
                                        setModalState(() => isVerifyingCode = false);
                                        
                                        if (verificationCodeController.text.trim() == '132435') {
                                          // Код правильный - применяем изменения
                                          Fluttertoast.showToast(
                                            msg: isEnabling ? 'Двухфакторная аутентификация включена' : 'Двухфакторная аутентификация отключена',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.grey.shade800,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          Navigator.of(context).pop();
                                        } else {
                                          // Код неправильный - показываем ошибку
                                          Fluttertoast.showToast(
                                            msg: 'Неверный код подтверждения',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red.shade700,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          // Восстанавливаем исходное состояние
                                          _isTwoFactorEnabled = _initialTwoFactorState;
                                        }
                                      });
                                    } : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                                      foregroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? Colors.black : Colors.grey.shade400,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: isVerifyingCode
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          l10n.verifyButton,
                                          style: TextStyle(
                                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,  
                                            fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
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
              ),
            );
          },
        );
      },
    );
  }

  void _showChangeEmailVerificationModal() {
    final l10n = AppLocalizations.of(context);
    final TextEditingController verificationCodeController = TextEditingController();
    bool isVerifyingCode = false;

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
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),

                            // Иконка безопасности
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.email,
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Заголовок
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.verifyEmailTitle, // Используем тот же заголовок
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Описание для смены почты
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.changeEmailVerificationDescription,
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
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                      selectionColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400.withOpacity(0.3) : Colors.grey.shade700.withOpacity(0.3),
                                      selectionHandleColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: verificationCodeController,
                                    cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
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
                                      counterText: "",
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
                                  onPressed: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? () {
                                    // Проверяем код
                                    setModalState(() => isVerifyingCode = true);
                                    Future.delayed(const Duration(seconds: 1), () {
                                      setModalState(() => isVerifyingCode = false);
                                      
                                      if (verificationCodeController.text.trim() == '132435') {
                                        // Код правильный - переходим к следующему шагу
                                        Navigator.of(context).pop();
                                        _showNewEmailDialog();
                                      } else {
                                        // Код неправильный - показываем ошибку
                                        Fluttertoast.showToast(
                                          msg: 'Неверный код подтверждения',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red.shade700,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    });
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                                    foregroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? Colors.black : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: isVerifyingCode
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        l10n.verifyButton,
                                        style: TextStyle(
                                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
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

  void _showNewEmailDialog() {
    final l10n = AppLocalizations.of(context);
    final TextEditingController newEmailController = TextEditingController();
    bool showEmailError = false;
    String emailErrorType = '';

    void validateEmail(String email) {
      if (email.isEmpty) {
        showEmailError = false;
        emailErrorType = '';
        return;
      }

      if (!_isValidEmailFormat(email)) {
        showEmailError = true;
        emailErrorType = 'format';
        return;
      }

      if (!_isValidEmailDomain(email)) {
        showEmailError = true;
        emailErrorType = 'unsupported';
        return;
      }

      showEmailError = false;
      emailErrorType = '';
    }

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
                  minHeight: MediaQuery.of(context).size.height * 0.5,
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
                      minHeight: MediaQuery.of(context).size.height * 0.5,
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

                            // Иконка почты
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Заголовок
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.newEmailTitle,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Описание
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.newEmailDescription,
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

                            // Поле для новой почты
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
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
                                    controller: newEmailController,
                                    cursorColor: Colors.grey.shade400,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                    ),
                                    onChanged: (value) {
                                      validateEmail(value);
                                      setModalState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: l10n.emailFieldHint,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontFamily: 'Inter',
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Блок отображения ошибок валидации email
                            if (showEmailError && emailErrorType.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                                        _getEmailErrorMessage(emailErrorType, l10n),
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

                            // Условный отступ - меньше когда есть ошибка
                            SizedBox(height: (showEmailError && emailErrorType.isNotEmpty) ? 12 : 16),

                            // Ссылка "Какие почтовые операторы поддерживаются?"
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  _showSupportedEmailProvidersModal();
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
                            ),

                            const SizedBox(height: 32),

                            // Кнопка "Изменить"
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (newEmailController.text.trim().isNotEmpty && !showEmailError) ? () {
                                    // Закрываем текущее окно и открываем подтверждение новой почты
                                    Navigator.of(context).pop();
                                    _showNewEmailVerificationModal(newEmailController.text.trim());
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (newEmailController.text.trim().isNotEmpty && !showEmailError) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                                    foregroundColor: (newEmailController.text.trim().isNotEmpty && !showEmailError) ? Colors.black : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                      l10n.changeEmailButton,
                                      style: TextStyle(
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
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

  void _showSupportedEmailProvidersModal() {
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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

  void _showNewEmailVerificationModal(String newEmail) {
    final l10n = AppLocalizations.of(context);
    final TextEditingController verificationCodeController = TextEditingController();
    bool isVerifyingCode = false;

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
                              child: const Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Заголовок
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.verifyNewEmailTitle,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Описание для подтверждения новой почты
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.verifyNewEmailDescription(newEmail),
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
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
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
                                    controller: verificationCodeController,
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
                                      setModalState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: l10n.verificationCodeHint,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
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
                                      counterText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Кнопка "Подтвердить"
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? () {
                                    // Проверяем код
                                    setModalState(() => isVerifyingCode = true);
                                    Future.delayed(const Duration(seconds: 1), () {
                                      setModalState(() => isVerifyingCode = false);
                                      
                                      if (verificationCodeController.text.trim() == '132435') {
                                        // Код правильный - завершаем изменение почты
                                        Fluttertoast.showToast(
                                          msg: 'Почта успешно изменена на $newEmail',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green.shade700,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        
                                        Navigator.of(context).pop();
                                      } else {
                                        // Код неправильный - показываем ошибку
                                        Fluttertoast.showToast(
                                          msg: 'Неверный код подтверждения',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red.shade700,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    });
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                                    foregroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? Colors.black : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: isVerifyingCode
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        l10n.verifyNewEmailButton,
                                        style: TextStyle(
                                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
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

  void _showPasscodeVerificationModal() {
    final l10n = AppLocalizations.of(context);
    final TextEditingController verificationCodeController = TextEditingController();
    bool isVerifyingCode = false;

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
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),

                            // Иконка замка для код-пароль
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.lock,
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Заголовок
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.passcodeVerificationTitle,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Описание для включения код-пароль
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.passcodeVerificationDescription('demouser@example.com'),
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
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                      selectionColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400.withOpacity(0.3) : Colors.grey.shade700.withOpacity(0.3),
                                      selectionHandleColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: verificationCodeController,
                                    cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
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
                                      counterText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Кнопка "Включить"
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? () {
                                    // Проверяем код
                                    setModalState(() => isVerifyingCode = true);
                                    Future.delayed(const Duration(seconds: 1), () {
                                      setModalState(() => isVerifyingCode = false);
                                      
                                      if (verificationCodeController.text.trim() == '132435') {
                                        // Код правильный - переходим к установке код-пароля
                                        Navigator.of(context).pop(); // Закрываем текущее окно
                                        Future.delayed(const Duration(milliseconds: 300), () {
                                          _showSetPasscodeModal(); // Открываем окно установки код-пароля
                                        });
                                      } else {
                                        // Код неправильный - показываем ошибку
                                        Fluttertoast.showToast(
                                          msg: 'Неверный код подтверждения',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red.shade700,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    });
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                                    foregroundColor: (verificationCodeController.text.trim().length == 6 && !isVerifyingCode) ? Colors.black : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: isVerifyingCode
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        l10n.passcodeVerificationButton,
                                        style: TextStyle(
                                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
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

  void _showSetPasscodeModal() {
    final l10n = AppLocalizations.of(context);
    final TextEditingController passcodeController = TextEditingController();
    bool isSettingPasscode = false;

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

                            // Иконка замка для код-пароля
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Заголовок
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.setPasscodeTitle,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Описание
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                l10n.setPasscodeDescription,
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

                            // Поле для ввода код-пароля
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
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
                                    controller: passcodeController,
                                    cursorColor: Colors.grey.shade400,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 12,
                                    ),
                                    onChanged: (value) {
                                      setModalState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: l10n.passcodeHint,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      counterText: "",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Кнопка "Установить"
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (passcodeController.text.trim().length == 4 && !isSettingPasscode) ? () {
                                    // Устанавливаем код-пароль
                                    setModalState(() => isSettingPasscode = true);
                                    Future.delayed(const Duration(seconds: 1), () {
                                      setModalState(() => isSettingPasscode = false);
                                      
                                      // Код-пароль установлен успешно
                                      Fluttertoast.showToast(
                                        msg: 'Код-пароль успешно установлен',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.green.shade700,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      
                                      Navigator.of(context).pop();
                                    });
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (passcodeController.text.trim().length == 4 && !isSettingPasscode) ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black) : Colors.grey.shade700,
                                    foregroundColor: (passcodeController.text.trim().length == 4 && !isSettingPasscode) ? Colors.black : Colors.grey.shade400,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: isSettingPasscode
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        l10n.setPasscodeButton,
                                        style: TextStyle(
                                          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
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

  /// Проверяет, является ли email валидным по формату
  bool _isValidEmailFormat(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    return emailRegExp.hasMatch(email);
  }

  /// Проверяет, является ли email поддерживаемым
  /// Поддерживаемые домены: gmail.com, outlook.com, yandex.ru, ya.ru, mail.ru, icloud.com, yahoo.com
  bool _isValidEmailDomain(String email) {
    final supportedDomains = [
      'gmail.com',
      'outlook.com',
      'yandex.ru',
      'ya.ru', 
      'mail.ru',
      'icloud.com',
      'yahoo.com',
    ];
    
    final emailLower = email.toLowerCase();
    return supportedDomains.any((domain) => emailLower.endsWith('@$domain'));
  }

  /// Возвращает текст ошибки валидации email
  String _getEmailErrorMessage(String errorType, AppLocalizations l10n) {
    switch (errorType) {
      case 'format':
        return l10n.emailFormatError;
      case 'unsupported':
        return l10n.emailUnsupportedError;
      default:
        return '';
    }
  }

  void _showChangePasswordDialog() {
    final l10n = AppLocalizations.of(context);
    TextEditingController currentPasswordController = TextEditingController();
    bool isPasswordVisible = false;

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
            bool isValid = currentPasswordController.text.trim().isNotEmpty;
            String errorMessage = '';
            bool hasUserInteracted = false;

            void validatePassword(String password) {
              hasUserInteracted = true;
              if (password.trim().isEmpty) {
                isValid = false;
                errorMessage = l10n.passwordEmptyError;
              } else if (password.length < 5) {
                isValid = false;
                errorMessage = l10n.passwordTooShortError;
              } else {
                isValid = true;
                errorMessage = '';
              }
            }

            bool shouldShowRedBorder = hasUserInteracted && !isValid && currentPasswordController.text.trim().isNotEmpty;

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
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Иконка замка
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
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
                                l10n.securityChangePassword,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontVariations: [FontVariation('wght', 600)],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Подзаголовок
                            Center(
                              child: Text(
                                l10n.passwordEnterCurrentHint,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Поле ввода текущего пароля
                            Container(
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: shouldShowRedBorder ? Colors.red.shade700 : (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400),
                                  width: 1,
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: TextSelectionThemeData(
                                    selectionColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400.withOpacity(0.3) : Colors.grey.shade700.withOpacity(0.3),
                                    selectionHandleColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  ),
                                ),
                                child: TextField(
                                  controller: currentPasswordController,
                                  cursorColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                  obscureText: !isPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: l10n.passwordCurrentHint,
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
                                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  autofocus: true,
                                  onChanged: (value) {
                                    setState(() {
                                      validatePassword(value);
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
                                      l10n.cancel,
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
                                    onPressed: isValid && currentPasswordController.text.trim().isNotEmpty ? () {
                                      // Здесь будет логика проверки пароля и перехода к следующему шагу
                                      Navigator.pop(context);
                                      _showNewPasswordDialog();
                                    } : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isValid && currentPasswordController.text.trim().isNotEmpty
                                          ? (Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black)
                                          : Colors.grey.shade700,
                                      foregroundColor: isValid && currentPasswordController.text.trim().isNotEmpty
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      l10n.passwordNextButton,
                                      style: TextStyle(
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
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

  void _showNewPasswordDialog() {
    final l10n = AppLocalizations.of(context);
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    bool isNewPasswordVisible = false;
    bool isConfirmPasswordVisible = false;

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
            bool isValid = false;
            String errorMessage = '';
            bool hasUserInteracted = false;
            String passwordStrength = ''; // 'weak', 'medium', 'strong'
            Color passwordStrengthColor = Colors.grey;
            bool showPasswordError = false;
            String passwordErrorType = ''; // 'weak', 'medium'

            /// Оценивает силу пароля
            /// Возвращает 'weak', 'medium', 'strong' или 'invalid_chars'
            String evaluatePasswordStrength(String password) {
              // Проверка на допустимые символы (только латиница и знаки препинания)
              if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]+$').hasMatch(password)) {
                return 'invalid_chars';
              }
              
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

            /// Возвращает текст ошибки валидации пароля
            String getPasswordErrorMessage() {
              switch (passwordErrorType) {
                case 'invalid_chars':
                  return l10n.passwordInvalidCharsError;
                case 'weak':
                  return l10n.passwordWeakError;
                case 'medium':
                  return l10n.passwordMediumWarning;
                default:
                  return '';
              }
            }

            void validatePasswords() {
              hasUserInteracted = true;
              
              // Оцениваем силу пароля
              if (newPasswordController.text.isNotEmpty) {
                passwordStrength = evaluatePasswordStrength(newPasswordController.text);
                switch (passwordStrength) {
                  case 'invalid_chars':
                    // Не показываем индикатор силы при недопустимых символах
                    passwordStrengthColor = Colors.grey;
                    passwordErrorType = 'invalid_chars';
                    showPasswordError = true;
                    break;
                  case 'weak':
                    passwordStrengthColor = Colors.red;
                    passwordErrorType = 'weak';
                    showPasswordError = true;
                    break;
                  case 'medium':
                    passwordStrengthColor = Colors.orange;
                    passwordErrorType = 'medium';
                    showPasswordError = true;
                    break;
                  case 'strong':
                    passwordStrengthColor = Colors.green;
                    passwordErrorType = '';
                    showPasswordError = false;
                    break;
                }
              } else {
                passwordStrength = '';
                passwordStrengthColor = Colors.grey;
                passwordErrorType = '';
                showPasswordError = false;
              }
              
              if (newPasswordController.text.trim().isEmpty) {
                isValid = false;
                errorMessage = l10n.passwordEmptyError;
                showPasswordError = false;
              } else if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]*$').hasMatch(newPasswordController.text)) {
                isValid = false;
                errorMessage = l10n.passwordInvalidCharsError;
                showPasswordError = true;
                passwordErrorType = 'invalid_chars';
              } else if (newPasswordController.text.length < 6) {
                isValid = false;
                errorMessage = l10n.passwordTooShortError;
                showPasswordError = false;
              } else if (confirmPasswordController.text.trim().isEmpty) {
                isValid = false;
                errorMessage = l10n.passwordConfirmNewHint;
                showPasswordError = false;
              } else if (newPasswordController.text != confirmPasswordController.text) {
                isValid = false;
                errorMessage = l10n.passwordDontMatchError;
                showPasswordError = false;
              } else {
                isValid = true;
                errorMessage = '';
                showPasswordError = false;
              }
              
              // Дополнительная проверка силы пароля
              if (isValid && passwordStrength == 'weak') {
                isValid = false;
                showPasswordError = true;
                passwordErrorType = 'weak';
              } else if (isValid && passwordStrength == 'medium') {
                // Для средней силы пароля разрешаем, но показываем предупреждение
                showPasswordError = true;
                passwordErrorType = 'medium';
              }
            }

            // Инициализируем валидацию
            validatePasswords();

            return Padding(
              padding: EdgeInsets.only(
                bottom: keyboardHeight,
              ),
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

                    // Иконка замка
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.lock_reset,
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
                            Center(
                              child: Text(
                                l10n.passwordNewTitle,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontVariations: [FontVariation('wght', 600)],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Поле ввода нового пароля
                            Container(
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
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
                                  controller: newPasswordController,
                                  cursorColor: Colors.grey.shade400,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                  obscureText: !isNewPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: l10n.passwordNewHint,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
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
                                        isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isNewPasswordVisible = !isNewPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      validatePasswords();
                                    });
                                  },
                                ),
                              ),
                            ),

                            // Индикатор силы пароля
                            if (passwordStrength.isNotEmpty && passwordStrength != 'invalid_chars')
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      passwordStrength == 'weak' ? Icons.error_outline :
                                      passwordStrength == 'medium' ? Icons.error_outline :
                                      Icons.check_circle_outline,
                                      color: passwordStrengthColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        passwordStrength == 'weak' ? l10n.passwordWeakError :
                                        passwordStrength == 'medium' ? l10n.passwordMediumWarning :
                                        l10n.passwordStrongSuccess,
                                        style: TextStyle(
                                          color: passwordStrengthColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Блок отображения ошибок валидации пароля
                            if (showPasswordError && passwordErrorType.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                /*child: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: passwordErrorType == 'medium' ? Colors.orange.shade400 : Colors.red,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _getPasswordErrorMessage(),
                                        style: TextStyle(
                                          color: passwordErrorType == 'medium' ? Colors.orange.shade400 : Colors.red,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                              ),

                            const SizedBox(height: 16),

                            // Поле подтверждения пароля
                            Container(
                              decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
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
                                  controller: confirmPasswordController,
                                  cursorColor: Colors.grey.shade400,
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ),
                                  obscureText: !isConfirmPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: l10n.passwordConfirmHint,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
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
                                        isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      validatePasswords();
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
                                      l10n.cancel,
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
                                    onPressed: isValid ? () {
                                      // Здесь будет логика сохранения нового пароля
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                        msg: l10n.passwordChangedSuccess,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green.shade700,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    } : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isValid
                                          ? Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black
                                          : Colors.grey.shade700,
                                      foregroundColor: isValid
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      l10n.passwordSaveButton,
                                      style: TextStyle(
                                        color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
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
}
