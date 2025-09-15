import 'dart:ui';
import '../services/currency_service.dart';

class CurrencyHelper {
  static Future<String> getCurrencySymbolByLocation() async {
    try {
      final countryCode = await CurrencyService.getUserCountry();
      return _getCurrencySymbolByCountry(countryCode);
    } catch (e) {
      // В случае ошибки возвращаем рубль
      return '₽';
    }
  }

  static Future<String> getCurrencyCodeByLocation() async {
    try {
      final countryCode = await CurrencyService.getUserCountry();
      return _getCurrencyCodeByCountry(countryCode);
    } catch (e) {
      // В случае ошибки возвращаем RUB
      return 'RUB';
    }
  }

  static String _getCurrencySymbolByCountry(String countryCode) {
    switch (countryCode) {
      case 'RU':
        return '₽';
      case 'GB':
        return '£';
      case 'US':
        return '\$';
      case 'KR':
        return '₩';
      case 'CN':
        return '¥';
      case 'JP':
        return '¥';
      case 'ES':
        return '€';
      case 'FR':
        return '€';
      case 'DE':
        return '€';
      case 'IT':
        return '€';
      case 'AE':
        return 'د.إ'; // Дирхам ОАЭ
      default:
        return '₽'; // По умолчанию рубль
    }
  }

  static String _getCurrencyCodeByCountry(String countryCode) {
    switch (countryCode) {
      case 'RU':
        return 'RUB';
      case 'GB':
        return 'GBP';
      case 'US':
        return 'USD';
      case 'KR':
        return 'KRW';
      case 'CN':
        return 'CNY';
      case 'JP':
        return 'JPY';
      case 'ES':
        return 'EUR';
      case 'FR':
        return 'EUR';
      case 'DE':
        return 'EUR';
      case 'IT':
        return 'EUR';
      case 'AE':
        return 'AED';
      default:
        return 'RUB';
    }
  }

  static String getCurrencySymbol(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return '₽';
      case 'en':
        // Для английского определяем по стране
        switch (locale.countryCode) {
          case 'GB':
            return '£';
          case 'US':
            return '\$';
          default:
            return '£'; // По умолчанию фунт для английского
        }
      case 'ko':
        return '₩';
      case 'zh':
        return '¥';
      case 'ja':
        return '¥';
      case 'es':
        return '€';
      case 'fr':
        return '€';
      case 'ar':
        return 'د.إ'; // Дирхам ОАЭ
      default:
        return '₽'; // По умолчанию рубль
    }
  }

  static String getCurrencyCode(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return 'RUB';
      case 'en':
        switch (locale.countryCode) {
          case 'GB':
            return 'GBP';
          case 'US':
            return 'USD';
          default:
            return 'GBP';
        }
      case 'ko':
        return 'KRW';
      case 'zh':
        return 'CNY';
      case 'ja':
        return 'JPY';
      case 'es':
        return 'EUR';
      case 'fr':
        return 'EUR';
      case 'ar':
        return 'AED';
      default:
        return 'RUB';
    }
  }

  static Future<String> formatPrice(Locale locale, int yearlyPrice, int monthlyPrice) async {
    try {
      final rates = await CurrencyService.getExchangeRates();
      final currencySymbol = await getCurrencySymbolByLocation();
      final currencyCode = await getCurrencyCodeByLocation();

      if (currencyCode == 'RUB') {
        // Для России показываем в рублях без конвертации
        // Но текст на языке приложения, если он отличается от русского
        if (locale.languageCode == 'ru') {
          return '${yearlyPrice.toString()} $currencySymbol в год';
        } else {
          final formattedPrice = '$currencySymbol${yearlyPrice.toString()}';
          return _getPriceTextByLanguage(locale.languageCode, formattedPrice, 'yearly');
        }
      }

      // Конвертируем цену в целевую валюту
      final convertedPrice = CurrencyService.convertToCurrency(
        yearlyPrice.toDouble(),
        currencyCode,
        rates
      );

      final formattedPrice = CurrencyService.formatPrice(convertedPrice, currencySymbol);

      // Определяем язык для текста на основе геолокации
      final countryCode = await CurrencyService.getUserCountry();
      final languageText = _getPriceTextByCountry(countryCode, formattedPrice, 'yearly');

      return languageText;
    } catch (e) {
      // В случае ошибки возвращаем дефолтные значения
      final currencySymbol = await getCurrencySymbolByLocation();
      return _getFallbackPriceByLocation(yearlyPrice, currencySymbol);
    }
  }

  static Future<String> formatMonthlyPrice(Locale locale, int monthlyPrice) async {
    try {
      final rates = await CurrencyService.getExchangeRates();
      final currencySymbol = await getCurrencySymbolByLocation();
      final currencyCode = await getCurrencyCodeByLocation();

      if (currencyCode == 'RUB') {
        // Для России показываем в рублях без конвертации
        // Но текст на языке приложения, если он отличается от русского
        if (locale.languageCode == 'ru') {
          return '${monthlyPrice.toString()} $currencySymbol в месяц';
        } else {
          final formattedPrice = '$currencySymbol${monthlyPrice.toString()}';
          return _getPriceTextByLanguage(locale.languageCode, formattedPrice, 'monthly');
        }
      }

      // Конвертируем цену в целевую валюту
      final convertedPrice = CurrencyService.convertToCurrency(
        monthlyPrice.toDouble(),
        currencyCode,
        rates
      );

      final formattedPrice = CurrencyService.formatPrice(convertedPrice, currencySymbol);

      // Определяем язык для текста на основе геолокации
      final countryCode = await CurrencyService.getUserCountry();
      final languageText = _getPriceTextByCountry(countryCode, formattedPrice, 'monthly');

      return languageText;
    } catch (e) {
      // В случае ошибки возвращаем дефолтные значения
      final currencySymbol = await getCurrencySymbolByLocation();
      return _getFallbackMonthlyPriceByLocation(monthlyPrice, currencySymbol);
    }
  }

  static Future<String> formatSavings(Locale locale, double savingsPercent, double monthlyEquivalent) async {
    try {
      final rates = await CurrencyService.getExchangeRates();
      final currencySymbol = await getCurrencySymbolByLocation();
      final currencyCode = await getCurrencyCodeByLocation();

      if (currencyCode == 'RUB') {
        // Для России показываем в рублях без конвертации
        // Но текст на языке приложения, если он отличается от русского
        if (locale.languageCode == 'ru') {
          return 'Экономия ${savingsPercent.toStringAsFixed(0)}%! Всего ${monthlyEquivalent.toStringAsFixed(2)} $currencySymbol в месяц';
        } else {
          final formattedEquivalent = '$currencySymbol${monthlyEquivalent.toStringAsFixed(2)}';
          return _getSavingsTextByLanguage(locale.languageCode, savingsPercent, formattedEquivalent);
        }
      }

      // Конвертируем эквивалентную месячную цену
      final convertedEquivalent = CurrencyService.convertToCurrency(
        monthlyEquivalent,
        currencyCode,
        rates
      );

      final formattedEquivalent = CurrencyService.formatPrice(convertedEquivalent, currencySymbol);

      // Определяем язык для текста на основе геолокации
      final countryCode = await CurrencyService.getUserCountry();
      final languageText = _getSavingsTextByCountry(countryCode, savingsPercent, formattedEquivalent);

      return languageText;
    } catch (e) {
      // В случае ошибки возвращаем дефолтные значения
      final currencySymbol = await getCurrencySymbolByLocation();
      return _getFallbackSavingsByLocation(savingsPercent, monthlyEquivalent, currencySymbol);
    }
  }

  static String _getPriceTextByCountry(String countryCode, String formattedPrice, String period) {
    final isYearly = period == 'yearly';

    switch (countryCode) {
      case 'RU':
        return isYearly ? '$formattedPrice в год' : '$formattedPrice в месяц';
      case 'GB':
      case 'US':
        return isYearly ? '$formattedPrice per year' : '$formattedPrice per month';
      case 'KR':
        return isYearly ? '$formattedPrice/년' : '$formattedPrice/월';
      case 'CN':
        return isYearly ? '$formattedPrice/年' : '$formattedPrice/月';
      case 'JP':
        return isYearly ? '$formattedPrice/年' : '$formattedPrice/月';
      case 'ES':
        return isYearly ? '$formattedPrice al año' : '$formattedPrice al mes';
      case 'FR':
        return isYearly ? '$formattedPrice par an' : '$formattedPrice par mois';
      case 'DE':
        return isYearly ? '$formattedPrice pro Jahr' : '$formattedPrice pro Monat';
      case 'IT':
        return isYearly ? '$formattedPrice all\'anno' : '$formattedPrice al mese';
      case 'AE':
        return isYearly ? '$formattedPrice سنوياً' : '$formattedPrice شهرياً';
      default:
        return isYearly ? '$formattedPrice в год' : '$formattedPrice в месяц';
    }
  }

  static String _getSavingsTextByCountry(String countryCode, double savingsPercent, String formattedEquivalent) {
    switch (countryCode) {
      case 'RU':
        return 'Экономия ${savingsPercent.toStringAsFixed(0)}%! Всего $formattedEquivalent в месяц';
      case 'GB':
      case 'US':
        return 'Save ${savingsPercent.toStringAsFixed(0)}%! Only $formattedEquivalent per month';
      case 'KR':
        return '${savingsPercent.toStringAsFixed(0)}% 절약! 월 $formattedEquivalent만';
      case 'CN':
        return '节省 ${savingsPercent.toStringAsFixed(0)}%！每月仅 $formattedEquivalent';
      case 'JP':
        return '${savingsPercent.toStringAsFixed(0)}% お得！月額 $formattedEquivalent のみ';
      case 'ES':
        return '¡Ahorra ${savingsPercent.toStringAsFixed(0)}%! Solo $formattedEquivalent al mes';
      case 'FR':
        return 'Économisez ${savingsPercent.toStringAsFixed(0)}%! Seulement $formattedEquivalent par mois';
      case 'DE':
        return 'Sparen Sie ${savingsPercent.toStringAsFixed(0)}%! Nur $formattedEquivalent pro Monat';
      case 'IT':
        return 'Risparmia ${savingsPercent.toStringAsFixed(0)}%! Solo $formattedEquivalent al mese';
      case 'AE':
        return 'توفير ${savingsPercent.toStringAsFixed(0)}%! فقط $formattedEquivalent شهرياً';
      default:
        return 'Экономия ${savingsPercent.toStringAsFixed(0)}%! Всего $formattedEquivalent в месяц';
    }
  }

  static Future<String> _getFallbackPriceByLocation(int yearlyPrice, String currencySymbol) async {
    final countryCode = await CurrencyService.getUserCountry();
    final formattedPrice = '$currencySymbol${yearlyPrice.toString()}';
    return _getPriceTextByCountry(countryCode, formattedPrice, 'yearly');
  }

  static Future<String> _getFallbackMonthlyPriceByLocation(int monthlyPrice, String currencySymbol) async {
    final countryCode = await CurrencyService.getUserCountry();
    final formattedPrice = '$currencySymbol${monthlyPrice.toString()}';
    return _getPriceTextByCountry(countryCode, formattedPrice, 'monthly');
  }

  static Future<String> _getFallbackSavingsByLocation(double savingsPercent, double monthlyEquivalent, String currencySymbol) async {
    final countryCode = await CurrencyService.getUserCountry();
    final formattedEquivalent = '$currencySymbol${monthlyEquivalent.toStringAsFixed(2)}';
    return _getSavingsTextByCountry(countryCode, savingsPercent, formattedEquivalent);
  }

  static String _getPriceTextByLanguage(String languageCode, String formattedPrice, String period) {
    final isYearly = period == 'yearly';

    switch (languageCode) {
      case 'en':
        return isYearly ? '$formattedPrice per year' : '$formattedPrice per month';
      case 'ko':
        return isYearly ? '$formattedPrice/년' : '$formattedPrice/월';
      case 'zh':
        return isYearly ? '$formattedPrice/年' : '$formattedPrice/月';
      case 'ja':
        return isYearly ? '$formattedPrice/年' : '$formattedPrice/月';
      case 'es':
        return isYearly ? '$formattedPrice al año' : '$formattedPrice al mes';
      case 'fr':
        return isYearly ? '$formattedPrice par an' : '$formattedPrice par mois';
      case 'ar':
        return isYearly ? '$formattedPrice سنوياً' : '$formattedPrice شهرياً';
      default:
        return isYearly ? '$formattedPrice в год' : '$formattedPrice в месяц';
    }
  }

  static String _getSavingsTextByLanguage(String languageCode, double savingsPercent, String formattedEquivalent) {
    switch (languageCode) {
      case 'en':
        return 'Save ${savingsPercent.toStringAsFixed(0)}%! Only $formattedEquivalent per month';
      case 'ko':
        return '${savingsPercent.toStringAsFixed(0)}% 절약! 월 $formattedEquivalent만';
      case 'zh':
        return '节省 ${savingsPercent.toStringAsFixed(0)}%！每月仅 $formattedEquivalent';
      case 'ja':
        return '${savingsPercent.toStringAsFixed(0)}% お得！月額 $formattedEquivalent のみ';
      case 'es':
        return '¡Ahorra ${savingsPercent.toStringAsFixed(0)}%! Solo $formattedEquivalent al mes';
      case 'fr':
        return 'Économisez ${savingsPercent.toStringAsFixed(0)}%! Seulement $formattedEquivalent par mois';
      case 'ar':
        return 'توفير ${savingsPercent.toStringAsFixed(0)}%! فقط $formattedEquivalent شهرياً';
      default:
        return 'Экономия ${savingsPercent.toStringAsFixed(0)}%! Всего $formattedEquivalent в месяц';
    }
  }
}
