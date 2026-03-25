import 'package:flutter/material.dart';

class AppTheme {
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4D03F);
  static const Color goldDark = Color(0xFFB8860B);
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldColor, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFAFAFA);
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: goldColor,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: goldColor,
      secondary: goldLight,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: goldColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: goldColor,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: goldColor,
      secondary: goldLight,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: goldColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
