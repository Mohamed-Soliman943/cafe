import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

Widget buildAuthButton({
  required String label,
  required VoidCallback? onPressed,
  bool isLoading = false,
}) {
  final bool isDisabled = isLoading || onPressed == null;

  return SizedBox(
    width: double.infinity,
    height: 54,
    child: ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.4,
          color: Colors.white,
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 18),
        ],
      ),
    ),
  );
}