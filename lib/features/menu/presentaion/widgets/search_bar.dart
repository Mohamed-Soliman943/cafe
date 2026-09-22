import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

Widget buildMenuSearchBar({
  TextEditingController? controller,
  String hintText = 'Search espresso, iced brew, pastries...',
  ValueChanged<String>? onChanged,
  VoidCallback? onFilterTap,
  VoidCallback? onTap,
}) {
  final Widget field = Container(
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
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(fontSize: 14, color: AppColors.primary),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14, color: AppColors.neutral),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    ),
  );

  return Row(
    children: [
      Expanded(
        child: onTap == null
            ? field
            : GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(child: field),
        ),
      ),
    ],
  );
}