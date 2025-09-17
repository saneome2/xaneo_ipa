import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Кастомное контекстное меню для поля ввода
class CustomContextMenu extends StatelessWidget {
  final Widget child;
  final TextEditingController? controller;
  final bool isDarkTheme;

  const CustomContextMenu({
    super.key,
    required this.child,
    this.controller,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        _showContextMenu(context, details.globalPosition);
      },
      onLongPress: () {
        // Для мобильных устройств - долгое нажатие
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        _showContextMenu(context, position);
      },
      child: child,
    );
  }

  void _showContextMenu(BuildContext context, Offset position) {
    if (controller == null) return;

    final selection = controller!.selection;
    final hasSelection = selection.isValid && !selection.isCollapsed;

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 1,
        position.dy + 1,
      ),
      color: isDarkTheme ? Colors.grey.shade800 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      items: [
        if (hasSelection)
          PopupMenuItem<String>(
            value: 'cut',
            child: _buildMenuItem(Icons.content_cut, 'Вырезать'),
          ),
        if (hasSelection)
          PopupMenuItem<String>(
            value: 'copy',
            child: _buildMenuItem(Icons.content_copy, 'Копировать'),
          ),
        PopupMenuItem<String>(
          value: 'paste',
          child: _buildMenuItem(Icons.content_paste, 'Вставить'),
        ),
        PopupMenuItem<String>(
          value: 'selectAll',
          child: _buildMenuItem(Icons.select_all, 'Выделить всё'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _handleMenuAction(value);
      }
    });
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDarkTheme ? Colors.white : Colors.black87,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black87,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  void _handleMenuAction(String action) {
    if (controller == null) return;

    switch (action) {
      case 'cut':
        _handleCut();
        break;
      case 'copy':
        _handleCopy();
        break;
      case 'paste':
        _handlePaste();
        break;
      case 'selectAll':
        _handleSelectAll();
        break;
    }
  }

  void _handleCut() {
    if (controller == null) return;
    
    final selection = controller!.selection;
    if (selection.isValid && !selection.isCollapsed) {
      final selectedText = controller!.text.substring(
        selection.start,
        selection.end,
      );
      
      // Копируем в буфер обмена
      Clipboard.setData(ClipboardData(text: selectedText));
      
      // Удаляем выделенный текст
      final newText = controller!.text.replaceRange(
        selection.start,
        selection.end,
        '',
      );
      
      controller!.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start),
      );
    }
  }

  void _handleCopy() {
    if (controller == null) return;
    
    final selection = controller!.selection;
    if (selection.isValid && !selection.isCollapsed) {
      final selectedText = controller!.text.substring(
        selection.start,
        selection.end,
      );
      Clipboard.setData(ClipboardData(text: selectedText));
    }
  }

  void _handlePaste() async {
    if (controller == null) return;
    
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData?.text != null) {
      final selection = controller!.selection;
      final text = controller!.text;
      
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        clipboardData!.text!,
      );
      
      final newOffset = selection.start + clipboardData.text!.length;
      
      controller!.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newOffset),
      );
    }
  }

  void _handleSelectAll() {
    if (controller == null) return;
    
    controller!.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller!.text.length,
    );
  }
}