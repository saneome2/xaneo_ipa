import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

/// Класс для управления изображениями в зависимости от темы
class ThemeAssets {
  // Приватный конструктор для предотвращения создания экземпляров
  ThemeAssets._();

  /// Получить путь к изображению в зависимости от текущей темы
  static String getImagePath(BuildContext context, String baseImageName) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final extension = baseImageName.split('.').last;
    final nameWithoutExtension = baseImageName.split('.').first;

    // Проверяем, существует ли светлая версия
    final lightVersion = 'assets/img/light/${nameWithoutExtension}_light.$extension';
    final darkVersion = 'assets/img/$baseImageName';

    // Для темной темы используем оригинальные изображения
    // Для светлой темы используем светлые версии, если они существуют
    final selectedPath = themeProvider.isDarkMode ? darkVersion : lightVersion;
    
    return selectedPath;
  }

  /// Получить изображение с автоматическим выбором версии по теме
  static Image getThemedImage(
    BuildContext context,
    String baseImageName, {
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final imagePath = getImagePath(context, baseImageName);
    
    // Добавляем уникальный ключ для принудительного обновления изображений при смене темы
    final imageKey = Key('${imagePath}_${themeProvider.isDarkMode}');
    
    return Image.asset(
      imagePath,
      key: imageKey,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        // Fallback на оригинальное изображение, если светлая версия не найдена
        final fallbackPath = 'assets/img/$baseImageName';
        return Image.asset(
          fallbackPath,
          key: Key('${fallbackPath}_fallback'),
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
          errorBuilder: (context, error2, stackTrace2) {
            return Icon(
              Icons.image_not_supported,
              size: width ?? height ?? 24,
              color: Colors.grey,
            );
          },
        );
      },
    );
  }

  // Предопределенные изображения для удобства использования

  /// Логотип приложения
  static Image logo(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'justlogo.png', width: width, height: height);
  }

  /// Большой логотип
  static Image logoLarge(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'logo.png', width: width, height: height);
  }

  /// Изображение медведя (приветствие)
  static Image bear(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'medved.png', width: width, height: height);
  }

  /// Изображение медведя (приватность)
  static Image bearPrivate(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'medvedprivate.png', width: width, height: height);
  }

  /// Изображение медведя (база данных)
  static Image bearDatabase(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'medved_database.png', width: width, height: height);
  }

  /// Иконка ограничения
  static Image restrict(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'restrict.png', width: width, height: height);
  }

  // === EMAIL ПРОВАЙДЕРЫ ===

  /// Google
  static Image google(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'google.png', width: width, height: height);
  }

  /// Outlook
  static Image outlook(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'outlook.png', width: width, height: height);
  }

  /// Yandex
  static Image yandex(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'yandex.png', width: width, height: height);
  }

  /// Mail.ru
  static Image mailru(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'mailru.png', width: width, height: height);
  }

  /// iCloud
  static Image icloud(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'icloud.png', width: width, height: height);
  }

  /// Yahoo
  static Image yahoo(BuildContext context, {double? width, double? height}) {
    return getThemedImage(context, 'yahoo.png', width: width, height: height);
  }

  /// Получить изображение email провайдера по имени
  static Image getEmailProviderIcon(BuildContext context, String providerName, {double? width, double? height}) {
    switch (providerName.toLowerCase()) {
      case 'google':
        return google(context, width: width, height: height);
      case 'outlook':
        return outlook(context, width: width, height: height);
      case 'yandex':
        return yandex(context, width: width, height: height);
      case 'mailru':
      case 'mail.ru':
        return mailru(context, width: width, height: height);
      case 'icloud':
        return icloud(context, width: width, height: height);
      case 'yahoo':
        return yahoo(context, width: width, height: height);
      default:
        return google(context, width: width, height: height); // fallback
    }
  }
}
