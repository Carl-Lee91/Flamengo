import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary
  static const Color primary = Color(0xFFFF6B35);
  static const Color primaryLight = Color(0xFFFF9A6C);
  static const Color primaryDark = Color(0xFFE55A2B);

  // Secondary
  static const Color secondary = Color(0xFF004E89);
  static const Color secondaryLight = Color(0xFF336FA1);
  static const Color secondaryDark = Color(0xFF003A66);

  // Semantic
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF9A825);

  // Neutrals
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFF8F5);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1A1A1A);
  static const Color onSurface = Color(0xFF333333);

  // Grey scale
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Category
  static const Color categoryFood = Color(0xFFFF6B35);
  static const Color categoryCulture = Color(0xFF7B61FF);
  static const Color categoryNature = Color(0xFF4CAF50);
  static const Color categoryNightlife = Color(0xFF9C27B0);
  static const Color categoryShopping = Color(0xFFFF4081);
  static const Color categoryOther = Color(0xFF607D8B);

  static Color categoryColor(String category) {
    switch (category) {
      case 'food':
        return categoryFood;
      case 'culture':
        return categoryCulture;
      case 'nature':
        return categoryNature;
      case 'nightlife':
        return categoryNightlife;
      case 'shopping':
        return categoryShopping;
      default:
        return categoryOther;
    }
  }
}
