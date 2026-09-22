import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/item_model.dart';

void showItemDetailsDialog(BuildContext context, ItemModel item) {
  final screenSize = MediaQuery.of(context).size;
  final dialogWidth = screenSize.width * 0.9 > 420 ? 420.0 : screenSize.width * 0.9;
  final maxDialogHeight = screenSize.height * 0.8;

  showDialog(
    context: context,
    barrierColor: AppColors.primary.withOpacity(0.4),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: dialogWidth,
            maxHeight: maxDialogHeight,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.network(
                          item.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.trinary,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.local_cafe,
                              size: 40,
                              color: AppColors.neutral,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        if (item.description.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.neutral,
                              height: 1.5,
                            ),
                          ),
                        ],
                        if (item.ingredients.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: item.ingredients
                                .map(
                                  (ingredient) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.trinary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  ingredient,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ],
                      ],
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