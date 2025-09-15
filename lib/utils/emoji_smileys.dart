/// Класс для работы со смайликами (эмоциями)
class EmojiSmileys {
  /// Основные эмоции (U+1F600-U+1F64F)
  static const List<String> basicEmotions = [
    '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂', '🙂', '🙃',
    '😉', '😊', '😇', '🥰', '😍', '🤩', '😘', '😗', '☺️', '😚',
    '😙', '🥲', '😋', '😛', '😜', '🤪', '😝', '🤑', '🤗', '🤭',
    '🤫', '🤔', '🤐', '🤨', '😐', '😑', '😶', '😏', '😒', '🙄',
    '😬', '🤥', '😔', '😪', '🤤', '😴', '😷', '🤒', '🤕', '🤢',
    '🤮', '🤧', '🥵', '🥶', '🥴', '😵', '🤯', '🤠', '🥳', '🥸',
    '😎', '🤓', '🧐', '😕', '😟', '🙁', '☹️', '😮', '😯', '😲',
    '😳', '🥺', '😦', '😧', '😨', '😰', '😥', '😢', '😭', '😱',
    '😖', '😣', '😞', '😓', '😩', '😫', '🥱', '😤', '😡', '😠',
    '🤬', '😈', '👿', '💀', '☠️', '💩', '🤡', '👹', '👺', '👻',
    '👽', '👾', '🤖', '😺', '😸', '😹', '😻', '😼', '😽', '🙀',
    '😿', '😾', '🙈', '🙉', '🙊', '💋', '💌', '💘', '💝', '💖',
    '💗', '💓', '💞', '💕', '💟', '❣️', '💔', '❤️', '🧡', '💛',
    '💚', '💙', '💜', '🖤', '🤍', '🤎', '💯', '💢', '💥', '💫',
    '💦', '💨', '🕳️', '💣', '💬', '👁️‍🗨️', '🗨️', '🗯️', '💭', '💤',
  ];

  /// Руки и жесты (дополнительные эмоции с руками)
  static const List<String> handEmotions = [
    '👋', '🤚', '🖐️', '✋', '🖖', '👌', '🤌', '🤏', '✌️', '🤞',
    '🤟', '🤘', '🤙', '👈', '👉', '👆', '🖕', '👇', '☝️', '👍',
    '👎', '👊', '✊', '🤛', '🤜', '👏', '🙌', '👐', '🤲', '🤝',
    '🙏', '✍️', '💅', '🤳', '💪', '🦾', '🦿', '🦵', '🦶', '👂',
    '🦻', '👃', '🧠', '🫀', '🫁', '🦷', '🦴', '👀', '👁️', '👅',
    '👄', '💍', '💄',
  ];

  /// Все смайлики в одном списке
  static List<String> get allSmileys => [
    ...basicEmotions,
    ...handEmotions,
  ];

  /// Получить смайлики по категориям
  static Map<String, List<String>> get categorizedSmileys => {
    'Эмоции': basicEmotions,
    'Жесты': handEmotions,
  };

  /// Проверить, является ли символ смайликом
  static bool isSmiley(String emoji) {
    return allSmileys.contains(emoji);
  }

  /// Получить случайный смайлик
  static String getRandomSmiley() {
    final random = DateTime.now().millisecondsSinceEpoch % allSmileys.length;
    return allSmileys[random];
  }

  /// Получить смайлики для сетки (группами по 8 для удобного отображения)
  static List<List<String>> getSmileysGrid() {
    final grid = <List<String>>[];
    for (var i = 0; i < allSmileys.length; i += 8) {
      final end = (i + 8 < allSmileys.length) ? i + 8 : allSmileys.length;
      grid.add(allSmileys.sublist(i, end));
    }
    return grid;
  }
}
