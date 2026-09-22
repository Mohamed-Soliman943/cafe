import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../data/models/item_model.dart';
import '../widgets/card_list.dart';
import '../widgets/item_card.dart';
import '../widgets/item_details_dialog.dart';
import '../widgets/section_header.dart';

class SearchScreen extends StatefulWidget {
  final List<ItemModel> hotItems;
  final List<ItemModel> coldItems;
  final Map<int, int>? quantities;
  final void Function(ItemModel item)? onIncrement;
  final void Function(ItemModel item)? onDecrement;

  const SearchScreen({
    super.key,
    required this.hotItems,
    required this.coldItems,
    this.quantities,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<ItemModel> get _filteredItems {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return const [];
    final all = [...widget.hotItems, ...widget.coldItems];
    return all.where((item) {
      final inTitle = item.title.toLowerCase().contains(query);
      final inIngredients =
      item.ingredients.any((i) => i.toLowerCase().contains(query));
      return inTitle || inIngredients;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _query.trim().isNotEmpty;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Same sizing approach as CardList, for the filtered grid.
    const int crossAxisCount = 2;
    const double spacing = 12;
    final double cellWidth =
        (screenWidth - 32 - spacing * (crossAxisCount - 1)) / crossAxisCount;
    final double cellHeight = cellWidth * 1.35;

    return Scaffold(
      backgroundColor: AppColors.trinary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- search bar with back button, autofocused ---
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 20, color: AppColors.neutral),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              onChanged: (value) => setState(() => _query = value),
                              style: const TextStyle(fontSize: 14, color: AppColors.primary),
                              decoration: const InputDecoration(
                                hintText: 'Search espresso, iced brew, pastries...',
                                hintStyle: TextStyle(fontSize: 14, color: AppColors.neutral),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (isSearching)
                            InkWell(
                              onTap: () {
                                _controller.clear();
                                setState(() => _query = '');
                              },
                              child: const Icon(Icons.close, size: 18, color: AppColors.neutral),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: !isSearching
                  ? _buildDefaultLists()
                  : _buildFilteredResults(cellWidth, cellHeight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultLists() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader(title: 'Artisan Hot Espresso'),
          const SizedBox(height: 12),
          CardList(
            items: widget.hotItems,
            quantities: widget.quantities,
            onIncrement: widget.onIncrement,
            onDecrement: widget.onDecrement,
          ),
          const SizedBox(height: 20),
          buildSectionHeader(title: 'Cold Brew & Shaken'),
          const SizedBox(height: 12),
          CardList(
            items: widget.coldItems,
            quantities: widget.quantities,
            onIncrement: widget.onIncrement,
            onDecrement: widget.onDecrement,
          ),
        ],
      ),
    );
  }

  Widget _buildFilteredResults(double cellWidth, double cellHeight) {
    final results = _filteredItems;

    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 40, color: AppColors.neutral),
              const SizedBox(height: 12),
              Text(
                'No matches for "${_query.trim()}"',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: AppColors.neutral),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: cellWidth / cellHeight,
      ),
      itemBuilder: (context, index) {
        final item = results[index];
        return buildItemCard(
          item: item,
          width: cellWidth,
          height: cellHeight,
          quantity: widget.quantities?[item.id] ?? 0,
          onIncrement: widget.onIncrement == null ? null : () => widget.onIncrement!(item),
          onDecrement: widget.onDecrement == null ? null : () => widget.onDecrement!(item),
          onTap: () => showItemDetailsDialog(context, item),
        );
      },
    );
  }
}