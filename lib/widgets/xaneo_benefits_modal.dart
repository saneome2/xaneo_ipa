import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../utils/currency_helper.dart';

enum SubscriptionType { monthly, yearly }

class XaneoBenefitsModal extends StatefulWidget {
  const XaneoBenefitsModal({super.key});

  @override
  State<XaneoBenefitsModal> createState() => _XaneoBenefitsModalState();
}

class _XaneoBenefitsModalState extends State<XaneoBenefitsModal>
    with TickerProviderStateMixin {
  SubscriptionType _selectedSubscription = SubscriptionType.yearly;
  late AnimationController _buttonAnimationController;
  late Animation<Color?> _buttonColorAnimation;

  // Кэшированные данные для предотвращения повторной загрузки
  String? _cachedYearlyPrice;
  String? _cachedMonthlyPrice;
  String? _cachedSavings;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // Предварительная загрузка данных
    _loadData();
  }

  Future<void> _loadData() async {
    final locale = Localizations.localeOf(context);
    const int baseYearlyPrice = 999;
    const int baseMonthlyPrice = 159;
    const double savingsPercent = 25.0;
    const double monthlyEquivalent = 83.25;

    // Загружаем данные один раз
    _cachedYearlyPrice = await CurrencyHelper.formatPrice(locale, baseYearlyPrice, baseMonthlyPrice);
    _cachedMonthlyPrice = await CurrencyHelper.formatMonthlyPrice(locale, baseMonthlyPrice);
    _cachedSavings = await CurrencyHelper.formatSavings(locale, savingsPercent, monthlyEquivalent);

    // Обновляем состояние, если виджет еще не уничтожен
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _onSubscriptionChanged(SubscriptionType? value) {
    if (value != null) {
      setState(() {
        _selectedSubscription = value;
      });
      _buttonAnimationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    // Инициализируем анимацию цвета кнопки
    _buttonColorAnimation = ColorTween(
      begin: isDarkMode ? Colors.white : Colors.black,
      end: isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
    ).animate(_buttonAnimationController);

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
                maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                          Icons.star,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Заголовок
                      Text(
                        l10n.xaneoBenefitsModalTitle,
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
                        l10n.xaneoBenefitsModalDescription,
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Варианты подписки
                      Text(
                        l10n.xaneoBenefitsSelectPlan,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      _cachedYearlyPrice == null || _cachedSavings == null
                        ? RadioListTile<SubscriptionType>(
                            value: SubscriptionType.yearly,
                            groupValue: _selectedSubscription,
                            onChanged: null, // Отключаем выбор во время загрузки
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.xaneoBenefitsYearlyPlan,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Lottie.asset(
                                        'assets/animations/loading.json',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: Lottie.asset(
                                        'assets/animations/loading.json',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            activeColor: Colors.grey.shade500,
                            tileColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          )
                        : RadioListTile<SubscriptionType>(
                            value: SubscriptionType.yearly,
                            groupValue: _selectedSubscription,
                            onChanged: (value) {
                              setState(() {
                                _onSubscriptionChanged(value);
                              });
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.xaneoBenefitsYearlyPlan,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  _cachedYearlyPrice!,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  _cachedSavings!,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            activeColor: Colors.grey.shade500,
                            tileColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                      const SizedBox(height: 12),

                      // Ежемесячная подписка
                      _cachedMonthlyPrice == null
                        ? RadioListTile<SubscriptionType>(
                            value: SubscriptionType.monthly,
                            groupValue: _selectedSubscription,
                            onChanged: null, // Отключаем выбор во время загрузки
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.xaneoBenefitsMonthlyPlan,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Lottie.asset(
                                        'assets/animations/loading.json',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            activeColor: Colors.grey.shade500,
                            tileColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          )
                        : RadioListTile<SubscriptionType>(
                            value: SubscriptionType.monthly,
                            groupValue: _selectedSubscription,
                            onChanged: (value) {
                              setState(() {
                                _onSubscriptionChanged(value);
                              });
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.xaneoBenefitsMonthlyPlan,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  _cachedMonthlyPrice!,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            activeColor: Colors.grey.shade500,
                            tileColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                      const SizedBox(height: 32),

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
                                l10n.xaneoBenefitsCloseButton,
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
                          // Кнопка оформления
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _buttonColorAnimation,
                              builder: (context, child) {
                                return ElevatedButton(
                                  onPressed: () {
                                    // Здесь можно добавить логику оформления подписки
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          _selectedSubscription == SubscriptionType.yearly
                                              ? l10n.xaneoBenefitsYearlySuccess
                                              : l10n.xaneoBenefitsMonthlySuccess,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.grey.shade800,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _buttonColorAnimation.value ?? (isDarkMode ? Colors.white : Colors.black),
                                    foregroundColor: isDarkMode ? Colors.black : Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    l10n.xaneoBenefitsSubscribeButton,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
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
  }
}
