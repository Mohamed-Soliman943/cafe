import 'package:flutter/material.dart';

import '../../data/models/item_model.dart';
import 'item_card.dart';
import 'item_details_dialog.dart';

class CardList extends StatelessWidget {
  final List<ItemModel> items;
  final Map<int, int>? quantities;
  final void Function(ItemModel item)? onIncrement;
  final void Function(ItemModel item)? onDecrement;
  final void Function(ItemModel item)? onItemTap;

  const CardList({
    super.key,
    required this.items,
    this.quantities,
    this.onIncrement,
    this.onDecrement,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth / 2.3).clamp(150.0, 200.0);
    final double cardHeight = cardWidth * 1.35;

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: buildItemCard(
              item: item,
              width: cardWidth,
              height: cardHeight,
              quantity: quantities?[item.id] ?? 0,
              onIncrement: onIncrement == null ? null : () => onIncrement!(item),
              onDecrement: onDecrement == null ? null : () => onDecrement!(item),
              onTap: () {
                showItemDetailsDialog(context, item);
                onItemTap?.call(item);
              },
            ),
          );
        },
      ),
    );
  }
}