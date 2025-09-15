import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

/// Виджет для отображения текстового блока с поддержкой RTL языков (третий раздел)
class TextBlockRTL extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final bool isVisible;

  const TextBlockRTL({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onButtonPressed,
    required this.fadeAnimation,
    required this.slideAnimation,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    // Определяем, является ли текущий язык RTL
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';
    
    return AnimatedBuilder(
      animation: Listenable.merge([fadeAnimation, slideAnimation]),
      builder: (context, child) {
        return Positioned(
          left: 20 + (slideAnimation.value.dx * MediaQuery.of(context).size.width),
          right: 20 - (slideAnimation.value.dx * MediaQuery.of(context).size.width),
          bottom: MediaQuery.of(context).padding.bottom + AppStyles.textBlockBottomPadding,
          child: Opacity(
            opacity: fadeAnimation.value * (isVisible ? 1.0 : 0.0),
            child: IntrinsicHeight(
              child: Container(
                decoration: AppStyles.textBlockDecoration,
                child: Column(
                  crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end, // Выравнивание к низу
                  mainAxisSize: MainAxisSize.min, // Минимальный размер
                  children: [
                    // Заголовок и описание
                    Column(
                      crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyles.titleLarge(context),
                          textAlign: isRTL ? TextAlign.right : TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          description,
                          style: AppStyles.bodyMediumMuted(context),
                          textAlign: isRTL ? TextAlign.right : TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Кнопка
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
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
}
