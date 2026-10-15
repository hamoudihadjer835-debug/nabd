import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';

/// الـ Theme الرئيسي لتطبيق Nabd — يجمع الألوان والخط والأزرار.
class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Cairo';

  /// خانات النصوص — مطابقة لـ Text Styles في Figma.
  static final TextTheme _textTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700), // Heading/1
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // Heading/2
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400), // Body/Large
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400), // Body/Small
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600), // Caption
  ).apply(
    fontFamily: fontFamily,
    bodyColor: AppColors.text,
    displayColor: AppColors.text,
  );

  /// الألوان الأساسية للتطبيق.
  static const ColorScheme _colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.accentMint,
    onSecondary: AppColors.text, // نص غامق على النعناعي لضمان الوضوح
    error: AppColors.error,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.text,
  );

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme,

      // الزر الأساسي: Button/Primary في Figma (Padding 24/12، زوايا 12)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonBorder),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}