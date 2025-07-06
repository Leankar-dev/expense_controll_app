import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class AppTheme {
  static const Color primaryColor = Color(0xFF081F5C);
  static const Color secondaryColor = Color(0xFFD0E3FF);

  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    useMaterial3: true,
  );
}
