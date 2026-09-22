import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

PreferredSizeWidget buildCustomAppBar({required String userName}) {
  return AppBar(
    backgroundColor: AppColors.trinary,
    elevation: 0,
    automaticallyImplyLeading: false,
    titleSpacing: 16,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.neutral,
          ),
        ),
        Text(
          userName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    ),
  );
}