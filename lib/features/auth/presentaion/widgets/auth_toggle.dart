import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
Widget buildAuthToggle({
  required bool isSignIn,
  required VoidCallback onSignInTap,
  required VoidCallback onCreateAccountTap,
}) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.trinary,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Row(
      children: [
        Expanded(
          child: _ToggleSegment(
            label: 'Sign In',
            isActive: isSignIn,
            onTap: onSignInTap,
          ),
        ),
        Expanded(
          child: _ToggleSegment(
            label: 'Create Account',
            isActive: !isSignIn,
            onTap: onCreateAccountTap,
          ),
        ),
      ],
    ),
  );
}

class _ToggleSegment extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleSegment({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}