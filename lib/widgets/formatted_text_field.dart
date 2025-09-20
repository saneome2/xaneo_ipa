import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'formatted_text_controller.dart';
import '../models/formatted_text.dart';
import '../providers/chat_settings_provider.dart';

/// Кастомные селекторы для выделения текста
class CustomTextSelectionControls extends TextSelectionControls {
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double textLineHeight, [VoidCallback? onTap]) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final handleColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: handleColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: handleColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildToolbar(BuildContext context, Rect globalEditableRegion, double textLineHeight, Offset selectionMidpoint, List<TextSelectionPoint> endpoints, TextSelectionDelegate delegate, ValueListenable<ClipboardStatus>? clipboardStatus, Offset? lastSecondaryTapDownPosition) {
    // Мы используем кастомное меню через contextMenuBuilder, поэтому toolbar не нужен
    return const SizedBox.shrink();
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    switch (type) {
      case TextSelectionHandleType.left:
        return const Offset(12, 12);
      case TextSelectionHandleType.right:
        return const Offset(12, 12);
      case TextSelectionHandleType.collapsed:
        return const Offset(12, 12);
    }
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return const Size(24, 24);
  }
}

/// Кастомный TextField, поддерживающий форматирование текста
class FormattedTextField extends StatefulWidget {
  final FormattedTextController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool isDarkTheme;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  const FormattedTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.style,
    this.hintStyle,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    required this.isDarkTheme,
    this.contextMenuBuilder,
  });

  @override
  State<FormattedTextField> createState() => _FormattedTextFieldState();
}

class _FormattedTextFieldState extends State<FormattedTextField> {
  late TextEditingController _textController;
  late FormattedTextController _formattedController;
  bool _shouldDisposeControllers = false;

  @override
  void initState() {
    super.initState();
    
    // Инициализируем контроллеры
    if (widget.controller != null) {
      _formattedController = widget.controller!;
      _textController = TextEditingController(text: _formattedController.plainText);
    } else {
      _formattedController = FormattedTextController();
      _textController = TextEditingController();
      _shouldDisposeControllers = true;
    }
    
    // Привязываем контроллеры
    _formattedController.attachTextController(_textController);
    
    // Слушаем изменения в форматированном контроллере
    _formattedController.addListener(_onFormattedTextChanged);
  }

  @override
  void didUpdateWidget(FormattedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Если контроллер изменился
    if (widget.controller != oldWidget.controller) {
      // Отвязываем старый контроллер
      _formattedController.removeListener(_onFormattedTextChanged);
      _formattedController.detachTextController();
      
      if (_shouldDisposeControllers) {
        _formattedController.dispose();
        _textController.dispose();
      }
      
      // Инициализируем новый
      if (widget.controller != null) {
        _formattedController = widget.controller!;
        _textController = TextEditingController(text: _formattedController.plainText);
        _shouldDisposeControllers = false;
      } else {
        _formattedController = FormattedTextController();
        _textController = TextEditingController();
        _shouldDisposeControllers = true;
      }
      
      // Привязываем новый контроллер
      _formattedController.attachTextController(_textController);
      _formattedController.addListener(_onFormattedTextChanged);
    }
  }

  @override
  void dispose() {
    _formattedController.removeListener(_onFormattedTextChanged);
    _formattedController.detachTextController();
    
    if (_shouldDisposeControllers) {
      _formattedController.dispose();
      _textController.dispose();
    }
    
    super.dispose();
  }

  void _onFormattedTextChanged() {
    // Принудительно перерисовываем виджет при изменении форматирования
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;
    
    return TextField(
      controller: _textController,
      focusNode: widget.focusNode,
      style: effectiveStyle.copyWith(
        // Делаем текст прозрачным, так как отображать будем через buildTextSpan
        color: Colors.transparent,
      ),
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        // Добавляем наложение для отображения форматированного текста
        prefixIcon: null,
        prefixIconConstraints: null,
      ),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      contextMenuBuilder: widget.contextMenuBuilder,
      // Кастомный билдер для отображения форматированного текста
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
        return Container(); // Убираем счетчик символов
      },
      // Создаем наложение с форматированным текстом
      // Используем Stack для наложения форматированного текста поверх невидимого TextField
    );
  }
}

/// Виджет для отображения форматированного текста поверх TextField
class _FormattedTextOverlay extends StatelessWidget {
  final FormattedTextController controller;
  final TextStyle baseStyle;
  final bool isDarkTheme;
  final String? hintText;
  final TextStyle? hintStyle;

  const _FormattedTextOverlay({
    required this.controller,
    required this.baseStyle,
    required this.isDarkTheme,
    this.hintText,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        // Если текст пустой, показываем hint
        if (controller.plainText.isEmpty && hintText != null) {
          return Text(
            hintText!,
            style: hintStyle ?? baseStyle.copyWith(
              color: isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          );
        }
        
        // Показываем форматированный текст
        return RichText(
          text: controller.buildTextSpan(
            baseStyle: baseStyle,
            isDarkTheme: isDarkTheme,
          ),
        );
      },
    );
  }
}

/// Улучшенная версия FormattedTextField с наложением
class FormattedTextFieldWithOverlay extends StatefulWidget {
  final FormattedTextController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool isDarkTheme;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  const FormattedTextFieldWithOverlay({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.style,
    this.hintStyle,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    required this.isDarkTheme,
    this.contextMenuBuilder,
  });

  @override
  State<FormattedTextFieldWithOverlay> createState() => _FormattedTextFieldWithOverlayState();
}

class _FormattedTextFieldWithOverlayState extends State<FormattedTextFieldWithOverlay> {
  late TextEditingController _textController;
  late FormattedTextController _formattedController;
  late FocusNode _focusNode;
  bool _shouldDisposeControllers = false;
  bool _shouldDisposeFocusNode = false;

  @override
  void initState() {
    super.initState();
    
    // Инициализируем FocusNode
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _shouldDisposeFocusNode = true;
    }
    
    // Инициализируем контроллеры
    if (widget.controller != null) {
      _formattedController = widget.controller!;
      _textController = TextEditingController(text: _formattedController.plainText);
    } else {
      _formattedController = FormattedTextController();
      _textController = TextEditingController();
      _shouldDisposeControllers = true;
    }
    
    // Привязываем контроллеры
    _formattedController.attachTextController(_textController);
  }

  @override
  void dispose() {
    _formattedController.detachTextController();
    
    if (_shouldDisposeControllers) {
      _formattedController.dispose();
      _textController.dispose();
    }
    
    if (_shouldDisposeFocusNode) {
      _focusNode.dispose();
    }
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final effectiveDecoration = widget.decoration ?? const InputDecoration();
    
    return Stack(
      children: [
        // Невидимый TextField для ввода
        TextField(
          controller: _textController,
          focusNode: _focusNode,
          style: effectiveStyle.copyWith(
            color: Colors.transparent, // Делаем текст невидимым
          ),
          decoration: effectiveDecoration.copyWith(
            hintText: null, // Убираем hint, будем показывать его в overlay
          ),
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          contextMenuBuilder: widget.contextMenuBuilder,
        ),
        
        // Наложение с форматированным текстом
        Positioned.fill(
          child: IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _FormattedTextOverlay(
                  controller: _formattedController,
                  baseStyle: effectiveStyle,
                  isDarkTheme: widget.isDarkTheme,
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Улучшенная версия с точным позиционированием курсора
class PreciseFormattedTextField extends StatefulWidget {
  final FormattedTextController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool isDarkTheme;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  const PreciseFormattedTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.style,
    this.hintStyle,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    required this.isDarkTheme,
    this.contextMenuBuilder,
  });

  @override
  State<PreciseFormattedTextField> createState() => _PreciseFormattedTextFieldState();
}

class _PreciseFormattedTextFieldState extends State<PreciseFormattedTextField> {
  late TextEditingController _textController;
  late FormattedTextController _formattedController;
  late FocusNode _focusNode;
  bool _shouldDisposeControllers = false;
  bool _shouldDisposeFocusNode = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _shouldDisposeFocusNode = true;
    }
    
    if (widget.controller != null) {
      _formattedController = widget.controller!;
      _textController = TextEditingController(text: _formattedController.plainText);
    } else {
      _formattedController = FormattedTextController();
      _textController = TextEditingController();
      _shouldDisposeControllers = true;
    }
    
    _formattedController.attachTextController(_textController);
  }

  @override
  void dispose() {
    _formattedController.detachTextController();
    
    if (_shouldDisposeControllers) {
      _formattedController.dispose();
      _textController.dispose();
    }
    
    if (_shouldDisposeFocusNode) {
      _focusNode.dispose();
    }
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final effectiveDecoration = widget.decoration ?? const InputDecoration();
    
    return InputDecorator(
      decoration: effectiveDecoration,
      child: ListenableBuilder(
        listenable: _formattedController,
        builder: (context, child) {
          return _FormattedEditableText(
            controller: _textController,
            focusNode: _focusNode,
            style: effectiveStyle,
            formattedController: _formattedController,
            isDarkTheme: widget.isDarkTheme,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            onChanged: widget.onChanged,
            contextMenuBuilder: _buildContextMenu,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
          );
        },
      ),
    );
  }

  /// Создает красивое контекстное меню как в chat_screen.dart
  Widget _buildContextMenu(BuildContext context, EditableTextState editableTextState) {
    print('🎨 Building custom context menu!');
    
    return Consumer<ChatSettingsProvider>(
      builder: (context, chatSettings, child) {
        return _buildFullyCustomContextMenu(context, editableTextState, chatSettings);
      },
    );
  }

  /// Создает полностью кастомное контекстное меню без стоковых шаблонов
  Widget _buildFullyCustomContextMenu(BuildContext context, EditableTextState editableTextState, ChatSettingsProvider chatSettings) {
    final selection = editableTextState.textEditingValue.selection;
    final hasSelection = !selection.isCollapsed;
    final hasText = editableTextState.textEditingValue.text.isNotEmpty;
    
    // Отладочная информация
    print('Context menu called! Selection: $selection, hasSelection: $hasSelection, hasText: $hasText');
    
    // Вычисляем позицию курсора в TextField для правильного позиционирования меню
    final textPosition = editableTextState.renderEditable.getLocalRectForCaret(
      selection.isCollapsed ? selection.base : selection.extent,
    );
    
    // Получаем глобальную позицию TextField через его RenderBox
    final textFieldRenderBox = editableTextState.renderEditable;
    final textFieldGlobalPosition = textFieldRenderBox.localToGlobal(Offset.zero);
    
    // Рассчитываем количество элементов меню для определения высоты
    int menuItemCount = 2; // "Вставить" и "Форматирование" всегда присутствуют
    if (hasSelection) {
      menuItemCount += 2; // "Копировать" и "Вырезать"
    }
    if (hasText) {
      menuItemCount += 1; // "Выбрать всё"
    }
    
    // Высота одного элемента меню
    const double menuItemHeight = 46.0;
    final double menuHeight = menuItemCount * menuItemHeight;
    
    // Получаем размеры экрана
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Проверяем, помещается ли меню снизу от курсора
    final cursorBottomY = textFieldGlobalPosition.dy + textPosition.bottom;
    final menuBottomY = cursorBottomY + menuHeight + 20; // +20 для отступа
    
    // Если меню не помещается снизу, размещаем его выше курсора
    final bool shouldPositionAbove = menuBottomY > screenHeight;
    
    final menuPosition = Offset(
      20, // Отступ от левого края экрана
      shouldPositionAbove 
        ? textFieldGlobalPosition.dy + textPosition.top - menuHeight - 10 // Выше курсора
        : textFieldGlobalPosition.dy + textPosition.top - 200, // Чуть выше курсора (как было)
    );

    return Stack(
      children: [
        // Невидимый фон для закрытия меню при тапе
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              // Закрываем меню при тапе вне его
              editableTextState.hideToolbar();
            },
            child: Container(color: Colors.transparent),
          ),
        ),
        // Само меню
        Positioned(
          left: menuPosition.dx,
          top: menuPosition.dy,
          child: _buildVerticalMenuTower(hasSelection, hasText, editableTextState, chatSettings),
        ),
      ],
    );
  }

  /// Создает вертикальную башенку элементов меню
  Widget _buildVerticalMenuTower(
    bool hasSelection, 
    bool hasText, 
    EditableTextState editableTextState,
    ChatSettingsProvider chatSettings
  ) {
    final menuItems = <Widget>[];

    if (hasSelection) {
      menuItems.add(_buildTowerMenuItem(
        icon: Icons.copy,
        text: 'Копировать',
        onPressed: () => _handleCopy(editableTextState),
        chatSettings: chatSettings,
        isFirst: true,
      ));
      
      menuItems.add(_buildTowerMenuItem(
        icon: Icons.cut,
        text: 'Вырезать',
        onPressed: () => _handleCut(editableTextState),
        chatSettings: chatSettings,
      ));
    }

    menuItems.add(_buildTowerMenuItem(
      icon: Icons.paste,
      text: 'Вставить',
      onPressed: () => _handlePaste(editableTextState),
      chatSettings: chatSettings,
      isFirst: !hasSelection,
    ));

    // Добавляем элемент форматирования
    menuItems.add(_buildTowerMenuItem(
      icon: Icons.format_bold,
      text: 'Форматирование',
      onPressed: () => _handleFormat(editableTextState),
      chatSettings: chatSettings,
    ));

    if (hasText) {
      menuItems.add(_buildTowerMenuItem(
        icon: Icons.select_all,
        text: 'Выбрать всё',
        onPressed: () => _handleSelectAll(editableTextState),
        chatSettings: chatSettings,
        isLast: true,
      ));
    }

    // Правильно помечаем первый и последний элементы
    if (menuItems.isNotEmpty) {
      // Первый элемент уже помечен как isFirst при создании
      
      // Если нет "Выбрать всё", помечаем последний элемент как последний
      if (!hasText && menuItems.length > 1) {
        final lastIndex = menuItems.length - 1;
        menuItems[lastIndex] = _buildTowerMenuItem(
          icon: Icons.format_bold,
          text: 'Форматирование',
          onPressed: () => _handleFormat(editableTextState),
          chatSettings: chatSettings,
          isLast: true,
        );
      }
    }

    return Material(
      color: Colors.transparent,
      elevation: 12,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: chatSettings.isDarkTheme ? const Color(0xFF2C2C2E) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: chatSettings.isDarkTheme 
                ? Colors.grey.shade700 
                : Colors.grey.shade300,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: menuItems,
        ),
      ),
    );
  }

  /// Создает элемент вертикальной башенки меню
  Widget _buildTowerMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required ChatSettingsProvider chatSettings,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(14) : Radius.zero,
        bottom: isLast ? const Radius.circular(14) : Radius.zero,
      ),
      child: Container(
        height: 46,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: !isLast ? Border(
            bottom: BorderSide(
              color: chatSettings.isDarkTheme 
                  ? Colors.grey.shade700 
                  : Colors.grey.shade300,
              width: 0.5,
            ),
          ) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: chatSettings.isDarkTheme ? Colors.white70 : Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: chatSettings.isDarkTheme ? Colors.white : Colors.black87,
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Обработчики кастомных действий меню
  void _handleCopy(EditableTextState editableTextState) {
    editableTextState.copySelection(SelectionChangedCause.toolbar);
  }

  void _handleCut(EditableTextState editableTextState) {
    editableTextState.cutSelection(SelectionChangedCause.toolbar);
  }

  void _handlePaste(EditableTextState editableTextState) {
    editableTextState.pasteText(SelectionChangedCause.toolbar);
  }

  void _handleSelectAll(EditableTextState editableTextState) {
    editableTextState.selectAll(SelectionChangedCause.toolbar);
  }

  void _handleFormat(EditableTextState editableTextState) {
    final selection = editableTextState.textEditingValue.selection;
    if (selection.isCollapsed) return; // Нет выделения

    // Закрываем текущее меню и показываем меню форматирования
    editableTextState.hideToolbar();
    
    // Небольшая задержка для плавного перехода
    Future.delayed(const Duration(milliseconds: 100), () {
      _showFormattingMenu(editableTextState);
    });
  }

  void _showFormattingMenu(EditableTextState editableTextState) {
    final selection = editableTextState.textEditingValue.selection;
    if (selection.isCollapsed) return;

    // Получаем позицию для меню форматирования
    final textPosition = editableTextState.renderEditable.getLocalRectForCaret(
      selection.isCollapsed ? selection.base : selection.extent,
    );
    
    final textFieldRenderBox = editableTextState.renderEditable;
    final textFieldGlobalPosition = textFieldRenderBox.localToGlobal(Offset.zero);
    
    // Показываем меню форматирования как overlay
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => _buildFormattingContextMenu(
        context, 
        editableTextState, 
        textFieldGlobalPosition, 
        textPosition,
        () => overlayEntry.remove(), // Функция для закрытия
      ),
    );
    
    overlay.insert(overlayEntry);
  }

  Widget _buildFormattingContextMenu(
    BuildContext context, 
    EditableTextState editableTextState,
    Offset textFieldGlobalPosition,
    Rect textPosition,
    VoidCallback onClose,
  ) {
    return Consumer<ChatSettingsProvider>(
      builder: (context, chatSettings, child) {
        // Рассчитываем количество элементов меню форматирования
        const int formattingItemCount = 4; // курсив, жирный, подчёркнутый, зачёркнутый
        const double menuItemHeight = 46.0;
        final double menuHeight = formattingItemCount * menuItemHeight;
        
        // Получаем размеры экрана
        final screenHeight = MediaQuery.of(context).size.height;
        
        // Проверяем, помещается ли меню снизу от курсора
        final cursorBottomY = textFieldGlobalPosition.dy + textPosition.bottom;
        final menuBottomY = cursorBottomY + menuHeight + 20;
        
        final bool shouldPositionAbove = menuBottomY > screenHeight;
        
        final menuPosition = Offset(
          20, // Отступ от левого края экрана
          shouldPositionAbove 
            ? textFieldGlobalPosition.dy + textPosition.top - menuHeight - 10
            : textFieldGlobalPosition.dy + textPosition.top - 200,
        );

        return Stack(
          children: [
            // Невидимый фон для закрытия меню при тапе
            Positioned.fill(
              child: GestureDetector(
                onTap: onClose,
                child: Container(color: Colors.transparent),
              ),
            ),
            // Само меню форматирования
            Positioned(
              left: menuPosition.dx,
              top: menuPosition.dy,
              child: _buildFormattingMenuTower(editableTextState, chatSettings, onClose),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormattingMenuTower(
    EditableTextState editableTextState,
    ChatSettingsProvider chatSettings,
    VoidCallback onClose,
  ) {
    final menuItems = <Widget>[
      _buildTowerMenuItem(
        icon: Icons.format_italic,
        text: 'Курсив',
        onPressed: () => _applyFormatting(editableTextState, 'italic', onClose),
        chatSettings: chatSettings,
        isFirst: true,
      ),
      _buildTowerMenuItem(
        icon: Icons.format_bold,
        text: 'Жирный',
        onPressed: () => _applyFormatting(editableTextState, 'bold', onClose),
        chatSettings: chatSettings,
      ),
      _buildTowerMenuItem(
        icon: Icons.format_underlined,
        text: 'Подчёркнутый',
        onPressed: () => _applyFormatting(editableTextState, 'underline', onClose),
        chatSettings: chatSettings,
      ),
      _buildTowerMenuItem(
        icon: Icons.format_strikethrough,
        text: 'Зачёркнутый',
        onPressed: () => _applyFormatting(editableTextState, 'strikethrough', onClose),
        chatSettings: chatSettings,
        isLast: true,
      ),
    ];

    return Material(
      color: Colors.transparent,
      elevation: 12,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: chatSettings.isDarkTheme ? const Color(0xFF2C2C2E) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: chatSettings.isDarkTheme 
                ? Colors.grey.shade700 
                : Colors.grey.shade300,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: menuItems,
        ),
      ),
    );
  }

  void _applyFormatting(
    EditableTextState editableTextState, 
    String formatType, 
    VoidCallback onClose,
  ) {
    final selection = editableTextState.textEditingValue.selection;
    if (selection.isCollapsed) {
      onClose();
      return;
    }

    // Преобразуем строковый тип в enum
    FormatType? format;
    switch (formatType) {
      case 'bold':
        format = FormatType.bold;
        break;
      case 'italic':
        format = FormatType.italic;
        break;
      case 'underline':
        format = FormatType.underline;
        break;
      case 'strikethrough':
        format = FormatType.strikethrough;
        break;
    }

    if (format != null) {
      // Применяем форматирование через FormattedTextController
      _formattedController.toggleFormat(format, selection: selection);
    }
    
    onClose();
  }
}

/// Кастомный EditableText с поддержкой форматированного отображения
class _FormattedEditableText extends EditableText {
  final FormattedTextController formattedController;
  final bool isDarkTheme;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  _FormattedEditableText({
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextStyle style,
    required this.formattedController,
    required this.isDarkTheme,
    this.hintText,
    this.hintStyle,
    int? maxLines,
    int? minLines,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    this.contextMenuBuilder,
  }) : super(
          controller: controller,
          focusNode: focusNode,
          style: style,
          cursorColor: isDarkTheme ? Colors.white : Colors.black,
          backgroundCursorColor: isDarkTheme ? Colors.grey.shade600 : Colors.grey.shade300,
          selectionColor: isDarkTheme ? Colors.blue.withOpacity(0.4) : Colors.blue.withOpacity(0.3),
          selectionControls: CustomTextSelectionControls(),
          showCursor: true,
          showSelectionHandles: true,
          enableInteractiveSelection: true, // Важно для контекстного меню
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          onChanged: onChanged,
          contextMenuBuilder: (context, editableTextState) {
            print('🔥 CONTEXT MENU BUILDER CALLED!');
            return contextMenuBuilder?.call(context, editableTextState) ?? const SizedBox.shrink();
          },
          strutStyle: const StrutStyle(),
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          autocorrect: true,
          enableSuggestions: true,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          // Убираем любые ограничения на взаимодействие
          expands: false,
          textCapitalization: TextCapitalization.sentences,
          // Обеспечиваем правильную работу с жестами
          dragStartBehavior: DragStartBehavior.start,
        );

  @override
  EditableTextState createState() => _FormattedEditableTextState();
}

class _FormattedEditableTextState extends EditableTextState {
  _FormattedEditableText get _widget => widget as _FormattedEditableText;
  OverlayEntry? _currentOverlay;

  @override
  void initState() {
    super.initState();
    print('FormattedEditableTextState initialized');
  }

  @override
  bool showToolbar() {
    print('🛠️ showToolbar called!');
    
    // Закрываем предыдущее меню если есть
    _hideCustomToolbar();
    
    // Принудительно вызываем наш contextMenuBuilder
    if (_widget.contextMenuBuilder != null) {
      print('We have custom contextMenuBuilder, trying to use it');
      final overlay = Overlay.of(context);
      
      _currentOverlay = OverlayEntry(
        builder: (context) => _widget.contextMenuBuilder!(context, this),
      );
      
      overlay.insert(_currentOverlay!);
      return true;
    }
    
    return super.showToolbar();
  }

  @override
  void hideToolbar([bool hideHandles = true]) {
    print('hideToolbar called in FormattedEditableTextState');
    _hideCustomToolbar();
    super.hideToolbar(hideHandles);
  }

  void _hideCustomToolbar() {
    if (_currentOverlay != null && _currentOverlay!.mounted) {
      _currentOverlay!.remove();
      _currentOverlay = null;
    }
  }

  @override
  void dispose() {
    _hideCustomToolbar();
    super.dispose();
  }

  @override
  TextSpan buildTextSpan() {
    final text = textEditingValue.text;
    
    // Если текст пустой, показываем hint
    if (text.isEmpty && _widget.hintText != null) {
      return TextSpan(
        text: _widget.hintText,
        style: _widget.hintStyle ?? _widget.style.copyWith(
          color: _widget.isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
      );
    }
    
    // Получаем форматированный TextSpан
    final formattedSpan = _widget.formattedController.buildTextSpan(
      baseStyle: _widget.style,
      isDarkTheme: _widget.isDarkTheme,
    );
    
    // Возвращаем форматированный спан как есть - EditableText сам обработает выделение
    return formattedSpan;
  }

  @override
  @override
  void userUpdateTextEditingValue(TextEditingValue value, SelectionChangedCause? cause) {
    print('Selection changed: ${value.selection}, cause: $cause');
    super.userUpdateTextEditingValue(value, cause);
    
    // Если есть выделение и оно было создано долгим нажатием или тапом, показываем toolbar
    if (!value.selection.isCollapsed && 
        (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.tap)) {
      print('Trying to show toolbar due to $cause selection');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final result = showToolbar();
        print('Manual showToolbar result: $result');
      });
    }
  }

  @override
  void requestKeyboard() {
    print('requestKeyboard called');
    super.requestKeyboard();
  }
}
