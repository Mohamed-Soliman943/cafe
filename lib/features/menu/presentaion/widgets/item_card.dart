import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/item_model.dart';


Widget buildItemCard({
  required ItemModel item,
  double width = 170,
  double height = 236,
  int quantity = 0,
  VoidCallback? onIncrement,
  VoidCallback? onDecrement,
  VoidCallback? onRemove,
  VoidCallback? onTap,
}) {
  final bool isEditable = onIncrement != null || onDecrement != null;
  final bool inCart = quantity > 0;
  final String subtitle = item.ingredients.isNotEmpty
      ? item.ingredients.join(', ')
      : item.description;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.trinary,
                      alignment: Alignment.center,
                      child: const Icon(Icons.local_cafe, color: AppColors.neutral),
                    ),
                  ),
                  if (onRemove != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: onRemove,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: AppColors.neutral,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.neutral,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: (inCart && isEditable)
                        ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.trinary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: onDecrement,
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: onDecrement == null
                                    ? AppColors.neutral.withOpacity(0.2)
                                    : AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 22,
                            child: Text(
                              '$quantity',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onIncrement,
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: onIncrement == null
                                    ? AppColors.neutral.withOpacity(0.2)
                                    : AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : InkWell(
                      onTap: onIncrement,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}