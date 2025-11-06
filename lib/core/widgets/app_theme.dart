import 'package:flutter/material.dart';
import 'package:my_gallery/core/media/media_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      // Scaffold background
      scaffoldBackgroundColor: AppColors.background,

      // Primary color
      primaryColor: AppColors.primary,

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryForeground,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.primaryForeground,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryForeground),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryForeground,
      ),

      // TextTheme
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.textTitle,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textTitle,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textBody,
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          color: AppColors.primaryForeground,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ColorScheme
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.primaryForeground,
        secondary: AppColors.primary,
        onSecondary: AppColors.secondaryForeground,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.card,        // untuk card / container
        onSurface: AppColors.textBody,  // teks di atas card
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.textBody),
        hintStyle: const TextStyle(color: AppColors.muted),
      ),

      useMaterial3: true,
    );
  }
}
