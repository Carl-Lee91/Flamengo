import 'package:flutter/material.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.categoryColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? categoryColor;

  @override
  Widget build(BuildContext context) {
    final color = categoryColor ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.onPrimary : color,
          ),
        ),
        backgroundColor: isSelected ? color : color.withValues(alpha: 0.1),
        side: BorderSide.none,
      ),
    );
  }
}
