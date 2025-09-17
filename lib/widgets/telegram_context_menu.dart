import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

class TelegramContextMenu extends StatefulWidget {
  final Widget child;
  final TextEditingController controller;
  final bool isDarkTheme;

  const TelegramContextMenu({
    super.key,
    required this.child,
    required this.controller,
    required this.isDarkTheme,
  });

  @override
  State<TelegramContextMenu> createState() => _TelegramContextMenuState();
}

class _TelegramContextMenuState extends State<TelegramContextMenu> {
  OverlayEntry? _overlayEntry;

  void _showContextMenu(Offset position) {
    final selection = widget.controller.selection;
    final hasSelection = !selection.isCollapsed;
    final hasText = widget.controller.text.isNotEmpty;

    _overlayEntry = OverlayEntry(
      builder: (context) => TelegramContextMenuOverlay(
        position: position,
        isDarkTheme: widget.isDarkTheme,
        hasSelection: hasSelection,
        hasText: hasText,
        controller: widget.controller,
        onClose: _hideContextMenu,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideContextMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          () => LongPressGestureRecognizer(),
          (instance) {
            instance.onLongPressStart = (details) {
              _showContextMenu(details.globalPosition);
            };
          },
        ),
      },
      behavior: HitTestBehavior.deferToChild,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _hideContextMenu();
    super.dispose();
  }
}

class TelegramContextMenuOverlay extends StatelessWidget {
  final Offset position;
  final bool isDarkTheme;
  final bool hasSelection;
  final bool hasText;
  final TextEditingController controller;
  final VoidCallback onClose;

  const TelegramContextMenuOverlay({
    super.key,
    required this.position,
    required this.isDarkTheme,
    required this.hasSelection,
    required this.hasText,
    required this.controller,
    required this.onClose,
  });

  void _copyText() {
    if (hasSelection) {
      final selection = controller.selection;
      final text = controller.text.substring(selection.start, selection.end);
      Clipboard.setData(ClipboardData(text: text));
    }
    onClose();
  }

  void _cutText() {
    if (hasSelection) {
      final selection = controller.selection;
      final text = controller.text.substring(selection.start, selection.end);
      Clipboard.setData(ClipboardData(text: text));
      
      final newText = controller.text.replaceRange(selection.start, selection.end, '');
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start),
      );
    }
    onClose();
  }

  void _pasteText() async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text != null) {
      final selection = controller.selection;
      final newText = controller.text.replaceRange(
        selection.start,
        selection.end,
        clipboardData!.text!,
      );
      
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start + clipboardData.text!.length,
        ),
      );
    }
    onClose();
  }

  void _selectAll() {
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
    onClose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    // Вычисляем позицию меню
    double menuX = position.dx;
    double menuY = position.dy;
    
    const menuWidth = 140.0;
    const menuItemHeight = 44.0;
    
    // Определяем количество элементов
    int itemCount = 0;
    if (hasSelection) itemCount += 2; // Копировать и Вырезать
    itemCount += 1; // Вставить (всегда доступно)
    if (hasText) itemCount += 1; // Выбрать все
    
    final menuHeight = itemCount * menuItemHeight;
    
    // Корректируем позицию, чтобы меню не выходило за границы экрана
    if (menuX + menuWidth > screenSize.width) {
      menuX = screenSize.width - menuWidth - 16;
    }
    if (menuY + menuHeight > screenSize.height) {
      menuY = position.dy - menuHeight - 16;
    }

    return Positioned(
      left: menuX,
      top: menuY,
      child: GestureDetector(
        onTap: () {}, // Предотвращаем закрытие при клике на меню
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          color: isDarkTheme ? const Color(0xFF2C2C2E) : Colors.white,
          child: Container(
            width: menuWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDarkTheme ? const Color(0xFF2C2C2E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasSelection) ...[
                  _buildMenuItem(
                    icon: Icons.copy,
                    text: 'Копировать',
                    onTap: _copyText,
                  ),
                  _buildMenuItem(
                    icon: Icons.cut,
                    text: 'Вырезать',
                    onTap: _cutText,
                  ),
                ],
                _buildMenuItem(
                  icon: Icons.paste,
                  text: 'Вставить',
                  onTap: _pasteText,
                ),
                if (hasText)
                  _buildMenuItem(
                    icon: Icons.select_all,
                    text: 'Выбрать все',
                    onTap: _selectAll,
                    isLast: true,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        top: icon == Icons.copy ? const Radius.circular(12) : Radius.zero,
        bottom: isLast ? const Radius.circular(12) : Radius.zero,
      ),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
                  bottom: BorderSide(
                    color: isDarkTheme 
                        ? Colors.grey.shade700 
                        : Colors.grey.shade200,
                    width: 0.5,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDarkTheme ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black87,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}