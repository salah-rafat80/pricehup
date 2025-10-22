import 'package:flutter/material.dart';

/// App color constants
const Color kPrimaryColor = Color(0xFFE81923); // Soft gold
const Color kSecondaryColor = Color(0xFF2E2E2E); // Dark gray
const Color kBackgroundColor = Colors.white; // Ivory

/// Centralized app theme following Material 3 design
ThemeData getAppTheme(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  // حساب حجم الخط الأساسي بناءً على عرض الشاشة
  double getTextSize(double baseSize) {
    return baseSize * (screenWidth / 400).clamp(0.8, 1.5);
  }

  return ThemeData(
    fontFamily: 'Cairo',
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      surface: kBackgroundColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: kSecondaryColor,
        size: getTextSize(24),
      ),
      titleTextStyle: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.w500,
        fontSize: getTextSize(22),
        fontFamily: 'Cairo',
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kPrimaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kPrimaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.03,
      ),
      labelStyle: TextStyle(fontSize: getTextSize(16), fontWeight: FontWeight.w500),
      hintStyle: TextStyle(fontSize: getTextSize(16), fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w500,
          fontSize: getTextSize(18),
        ),
        elevation: 2,
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      color: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: getTextSize(32), fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          fontSize: getTextSize(28), fontWeight: FontWeight.w500),
      displaySmall: TextStyle(
          fontSize: getTextSize(24), fontWeight: FontWeight.w500),
      headlineLarge: TextStyle(
          fontSize: getTextSize(22), fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(
          fontSize: getTextSize(20), fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(
          fontSize: getTextSize(18), fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
          fontSize: getTextSize(18), fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
          fontSize: getTextSize(16), fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontSize: getTextSize(14), fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: getTextSize(16), fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: getTextSize(14), fontWeight: FontWeight.w500),
      bodySmall: TextStyle(fontSize: getTextSize(12), fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          fontSize: getTextSize(16), fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: getTextSize(14), fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: getTextSize(12), fontWeight: FontWeight.w500),
    ),
  );
}

// الثيم الثابت للتوافق مع الكود القديم
final ThemeData appTheme = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    surface: kBackgroundColor,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kBackgroundColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: kSecondaryColor),
    titleTextStyle: TextStyle(
      color: kSecondaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 22,
      fontFamily: 'Cairo',
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: kPrimaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      elevation: 2,
    ),
  ),
  cardTheme: const CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    color: Colors.white,
  ),
);
