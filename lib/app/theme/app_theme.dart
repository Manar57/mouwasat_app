import 'package:flutter/material.dart';

class AppTheme {
  // Main Colors
  static const Color primaryColor = Color(0xFF2D2B76);
  static const Color secondaryColor = Color(0xFF4A47B3);
  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color textWhite = Colors.white;

  // Additional Greys
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);

  // Text Theme
  static TextTheme get textTheme => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          fontFamily: 'Inter',
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          fontFamily: 'Inter',
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          fontFamily: 'Inter',
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          fontFamily: 'Inter',
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimary,
          fontFamily: 'Inter',
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
          fontFamily: 'Inter',
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: textHint,
          fontFamily: 'Inter',
          height: 1.4,
        ),
      );

  // Input Field Decoration
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grey200, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grey200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1.5),
        ),
      );

  // Elevated Buttons Styling
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 55),
        ),
      );

  // Outlined Buttons Styling
  static OutlinedButtonThemeData get outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 55),
        ),
      );

  // Text Button Styling
  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      );

  // AppBar Styling
  static AppBarTheme get appBarTheme => const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: textWhite,
        elevation: 0,
        centerTitle: true,
      );

  // Card Styling
  static CardTheme get cardTheme => CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
        shadowColor: Colors.black.withOpacity(0.1),
      );

  // Dialog Styling
  static DialogTheme get dialogTheme => DialogTheme(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          fontFamily: 'Inter',
        ),
        contentTextStyle: const TextStyle(
          fontSize: 14,
          color: textSecondary,
          fontFamily: 'Inter',
        ),
      );

  // Default Container Decoration
  static BoxDecoration get containerDecoration => BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: grey200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      );

  // Success Container Decoration
  static BoxDecoration get successContainerDecoration => BoxDecoration(
        color: successColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: successColor.withOpacity(0.3), width: 1),
      );

  // Error Container Decoration
  static BoxDecoration get errorContainerDecoration => BoxDecoration(
        color: errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: errorColor.withOpacity(0.3), width: 1),
      );

  // Main App Theme
  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          background: backgroundColor,
          surface: surfaceColor,
          error: errorColor,
          onPrimary: textWhite,
          onSecondary: textWhite,
          onBackground: textPrimary,
          onSurface: textPrimary,
          onError: textWhite,
        ),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: textTheme,
        inputDecorationTheme: inputDecorationTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        textButtonTheme: textButtonTheme,
        appBarTheme: appBarTheme,
        cardTheme: cardTheme,
        dialogTheme: dialogTheme,
        useMaterial3: true,
        fontFamily: 'Inter',
      );
}
