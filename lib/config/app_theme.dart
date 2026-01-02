import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppConstants.primaryMagenta,
        secondary: AppConstants.primaryBlue,
        tertiary: AppConstants.accentOrange,
        error: AppConstants.errorColor,
        surface: AppConstants.surfaceColor,
        background: AppConstants.backgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppConstants.textPrimaryColor,
        onBackground: AppConstants.textPrimaryColor,
      ),
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.backgroundColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConstants.headingSmall,
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: AppConstants.surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: AppConstants.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: AppConstants.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: AppConstants.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: AppConstants.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide(color: AppConstants.errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMedium,
          vertical: AppConstants.spacingMedium,
        ),
        hintStyle: TextStyle(color: AppConstants.textHintColor),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryMagenta,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLarge,
            vertical: AppConstants.spacingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          elevation: 2,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryBlue,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.primaryBlue,
          side: BorderSide(color: AppConstants.primaryBlue, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLarge,
            vertical: AppConstants.spacingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppConstants.accentOrange,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppConstants.headingLarge,
        displayMedium: AppConstants.headingMedium,
        displaySmall: AppConstants.headingSmall,
        headlineMedium: AppConstants.headingMedium,
        headlineSmall: AppConstants.headingSmall,
        titleLarge: AppConstants.headingSmall,
        bodyLarge: AppConstants.bodyLarge,
        bodyMedium: AppConstants.bodyMedium,
        bodySmall: AppConstants.bodySmall,
      ),
      
      fontFamily: 'Roboto',
    );
  }
}
