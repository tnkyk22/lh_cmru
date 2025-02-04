import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFFCC04),
  onPrimary: Color(0xFF262626),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFCC04),
  background: Color(0xFFFCFDF6),
  onBackground: Color(0xFF1A1C18),
  shadow: Color(0xFF262626),
  outlineVariant: Color(0xFFC2C8BC),
  surface: Color(0xFFFFCC04),
  onSurface: Color(0xFF262626),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor:
          WidgetStateProperty.all<Color>(Color(0xFF262626)), // text color
      elevation: WidgetStateProperty.all<double>(5.0), // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Adjust as needed
        ),
      ),
    ),
  ),
);