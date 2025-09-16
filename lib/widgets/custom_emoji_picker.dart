import 'package:flutter/material.dart';
import '../models/emoji_data.dart';

/// Кастомный пикер эмодзи с использованием emoji_data.dart
class CustomEmojiPicker extends StatefulWidget {
  final Function(String) onEmojiSelected;
  final VoidCallback? onBackToKeyboard;

  const CustomEmojiPicker({
    super.key,
    required this.onEmojiSelected,
    this.onBackToKeyboard,
  });

  @override
  State<CustomEmojiPicker> createState() => _CustomEmojiPickerState();
}

class _CustomEmojiPickerState extends State<CustomEmojiPicker>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredEmojis = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: EmojiData.categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredEmojis.clear();
      });
    } else {
      setState(() {
        _isSearching = true;
        _filteredEmojis = EmojiData.searchEmojis(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // Верхняя панель с поиском и кнопкой возврата
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // Индикатор перетаскивания
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                // Строка поиска и кнопка клавиатуры
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade700,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: _onSearchChanged,
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Поиск эмодзи...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Кнопка возврата к клавиатуре
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.grey.shade700,
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.keyboard,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: widget.onBackToKeyboard,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Контент: поиск или категории
          Expanded(
            child: _isSearching
                ? _buildSearchResults()
                : _buildCategorizedView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredEmojis.isEmpty) {
      return Center(
        child: Text(
          'Эмодзи не найдены',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: _filteredEmojis.length,
      itemBuilder: (context, index) {
        final emoji = _filteredEmojis[index];
        return _buildEmojiButton(emoji);
      },
    );
  }

  Widget _buildCategorizedView() {
    return Column(
      children: [
        // Табы категорий
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade800,
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.white,
            indicatorWeight: 2,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade500,
            dividerHeight: 0,
            padding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            indicatorPadding: EdgeInsets.zero,
            tabs: EmojiData.categories.map((category) {
              return Tab(
                child: Text(
                  category.icon,
                  style: const TextStyle(fontSize: 22),
                ),
              );
            }).toList(),
          ),
        ),

        // Содержимое категорий
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: EmojiData.categories.map((category) {
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: category.emojis.length,
                itemBuilder: (context, index) {
                  final emoji = category.emojis[index];
                  return _buildEmojiButton(emoji);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmojiButton(String emoji) {
    return InkWell(
      onTap: () => widget.onEmojiSelected(emoji),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}