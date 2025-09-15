import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xaneomobile/utils/text_parser.dart';
import '../providers/theme_provider.dart';

// Шаблон для одного сообщения
class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSent;
  final double fontSize;
  final Color bubbleColor;
  final Color textColor;
  final String? timestamp;
  final bool showAvatar;
  final String? senderName;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isSent,
    this.fontSize = 16.0,
    this.bubbleColor = const Color(0xFF007AFF),
    this.textColor = Colors.white,
    this.timestamp,
    this.showAvatar = false,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Аватар для входящих сообщений
          if (!isSent && showAvatar)
            _buildAvatar(),
          
          if (!isSent && showAvatar)
            const SizedBox(width: 8),

          // Пузырь сообщения
          Flexible(
            child: Column(
              crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Имя отправителя (для групповых чатов)
                if (!isSent && senderName != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 2),
                    child: RichText(
                      text: TextSpan(
                        children: TextParser.parseTextWithEmojis(
                          text: senderName!,
                          textStyle: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Сам пузырь
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: _getBorderRadius(),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: TextParser.parseTextWithEmojis(
                        text: text,
                        textStyle: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Время отправки
                if (timestamp != null)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 2,
                      left: isSent ? 0 : 12,
                      right: isSent ? 12 : 0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: TextParser.parseTextWithEmojis(
                          text: timestamp!,
                          textStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Аватар для исходящих сообщений (если нужно)
          if (isSent && showAvatar)
            const SizedBox(width: 8),
          
          if (isSent && showAvatar)
            _buildAvatar(),
        ],
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    if (isSent) {
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

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 12,
      backgroundColor: isSent ? Colors.blue.shade600 : Colors.green.shade600,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: 14,
      ),
    );
  }
}

// Системное сообщение (например, "Пользователь присоединился к чату")
class SystemMessage extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const SystemMessage({
    super.key,
    required this.text,
    this.fontSize = 13.0,
    this.textColor = const Color(0xFF8E8E93),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: RichText(
            text: TextSpan(
              children: TextParser.parseTextWithEmojis(
                text: text,
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Сообщение с датой
class DateSeparator extends StatelessWidget {
  final String date;
  final double fontSize;
  final Color textColor;

  const DateSeparator({
    super.key,
    required this.date,
    this.fontSize = 13.0,
    this.textColor = const Color(0xFF8E8E93),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: RichText(
            text: TextSpan(
              children: TextParser.parseTextWithEmojis(
                text: date,
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Группировка сообщений от одного пользователя
class MessageGroup extends StatelessWidget {
  final List<MessageBubble> messages;
  final bool isSent;
  final bool showAvatar;
  final String? senderName;

  const MessageGroup({
    super.key,
    required this.messages,
    required this.isSent,
    this.showAvatar = false,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: messages.asMap().entries.map((entry) {
        final index = entry.key;
        final message = entry.value;
        final isFirst = index == 0;
        final isLast = index == messages.length - 1;

        return MessageBubble(
          text: message.text,
          isSent: message.isSent,
          fontSize: message.fontSize,
          bubbleColor: message.bubbleColor,
          textColor: message.textColor,
          timestamp: isLast ? message.timestamp : null, // Показываем время только у последнего сообщения
          showAvatar: isLast && showAvatar, // Показываем аватар только у последнего сообщения
          senderName: isFirst && !isSent ? senderName : null, // Показываем имя только у первого сообщения
        );
      }).toList(),
    );
  }
}
