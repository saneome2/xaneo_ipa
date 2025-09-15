import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest/RUB';
  static const String _cacheKey = 'currency_rates';
  static const String _cacheTimestampKey = 'currency_rates_timestamp';
  static const String _countryCacheKey = 'user_country';
  static const String _countryCacheTimestampKey = 'user_country_timestamp';
  static const Duration _cacheDuration = Duration(hours: 1); // Кэш на 1 час
  static const Duration _countryCacheDuration = Duration(hours: 24); // Кэш страны на 24 часа

  static Future<Map<String, double>> getExchangeRates() async {
    try {
      // Проверяем кэш
      final cachedRates = await _getCachedRates();
      if (cachedRates != null) {
        return cachedRates;
      }

      // Получаем свежие данные
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = Map<String, double>.from(data['rates']);

        // Кэшируем результат
        await _cacheRates(rates);

        return rates;
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
      // Возвращаем кэшированные данные или дефолтные значения
      return await _getCachedRates() ?? _getDefaultRates();
    }
  }

  static Future<Map<String, double>?> _getCachedRates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_cacheTimestampKey);

      if (timestamp != null) {
        final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final now = DateTime.now();

        // Проверяем, не истек ли кэш
        if (now.difference(cacheTime) < _cacheDuration) {
          final cachedData = prefs.getString(_cacheKey);
          if (cachedData != null) {
            final rates = Map<String, double>.from(json.decode(cachedData));
            return rates;
          }
        }
      }
    } catch (e) {
      print('Error reading cached rates: $e');
    }
    return null;
  }

  static Future<void> _cacheRates(Map<String, double> rates) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, json.encode(rates));
      await prefs.setInt(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('Error caching rates: $e');
    }
  }

  static Map<String, double> _getDefaultRates() {
    // Дефолтные курсы на случай, если API недоступен
    return {
      'RUB': 1.0,
      'USD': 0.012,    // 1 RUB = 0.012 USD
      'EUR': 0.011,    // 1 RUB = 0.011 EUR
      'GBP': 0.0095,   // 1 RUB = 0.0095 GBP
      'KRW': 15.8,     // 1 RUB = 15.8 KRW
      'CNY': 0.087,    // 1 RUB = 0.087 CNY
      'JPY': 1.85,     // 1 RUB = 1.85 JPY
      'AED': 0.044,    // 1 RUB = 0.044 AED
    };
  }

  static double convertToCurrency(double amountInRubles, String targetCurrency, Map<String, double> rates) {
    if (!rates.containsKey(targetCurrency)) {
      return amountInRubles; // Возвращаем исходную сумму, если валюта не найдена
    }

    final rate = rates[targetCurrency]!;
    return amountInRubles * rate;
  }

  static String formatPrice(double amount, String currencySymbol, {int decimalPlaces = 0}) {
    if (currencySymbol == '₩' || currencySymbol == '¥') {
      // Для корейской воны и японской йены показываем без копеек
      return '${amount.round()}$currencySymbol';
    } else if (currencySymbol == 'د.إ') {
      // Для дирхамов ОАЭ показываем с 2 знаками
      return '${amount.toStringAsFixed(2)}$currencySymbol';
    } else {
      // Для остальных валют показываем с 2 знаками
      return '${amount.toStringAsFixed(2)}$currencySymbol';
    }
  }

  static Future<String> getUserCountry() async {
    try {
      // Проверяем кэш
      final cachedCountry = await _getCachedCountry();
      if (cachedCountry != null) {
        return cachedCountry;
      }

      // Получаем страну по IP
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final country = data['country_code'] as String;

        // Кэшируем результат
        await _cacheCountry(country);
        return country;
      } else {
        // В случае ошибки возвращаем Россию по умолчанию
        return 'RU';
      }
    } catch (e) {
      // В случае ошибки возвращаем Россию по умолчанию
      return 'RU';
    }
  }

  static Future<String?> _getCachedCountry() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_countryCacheTimestampKey);

      if (timestamp != null) {
        final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final now = DateTime.now();

        if (now.difference(cacheTime) < _countryCacheDuration) {
          return prefs.getString(_countryCacheKey);
        }
      }
    } catch (e) {
      // Игнорируем ошибки кэша
    }
    return null;
  }

  static Future<void> _cacheCountry(String country) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_countryCacheKey, country);
      await prefs.setInt(_countryCacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Игнорируем ошибки кэша
    }
  }
}
