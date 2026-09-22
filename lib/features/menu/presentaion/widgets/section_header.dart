import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

Widget buildSectionHeader({
  required String title,
  VoidCallback? onViewAll,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        if (onViewAll != null)
          InkWell(
            onTap: onViewAll,
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                'VIEW ALL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}