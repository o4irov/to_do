import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color primaryText,
    required ColorScheme colorScheme,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: TextTheme(
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontFamily: 'Roboto-Medium',
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontFamily: 'Roboto-Medium',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        labelLarge: baseTextTheme.titleMedium?.copyWith(
          fontFamily: 'Roboto-Medium',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        bodyMedium: baseTextTheme.titleMedium?.copyWith(
          fontFamily: 'Roboto-Regular',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: primaryText,
        ),
        bodySmall: baseTextTheme.titleMedium?.copyWith(
          fontFamily: 'Roboto-Regular',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: primaryText,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        primaryText: Colors.black,
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          primary: Color.fromRGBO(0, 0, 0, 1),
          secondary: Color.fromRGBO(0, 0, 0, .6),
          tertiary: Color.fromRGBO(0, 0, 0, .3),
          background: Color.fromRGBO(247, 246, 242, 1),
        ),
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        primaryText: Colors.white,
        colorScheme: const ColorScheme.light(
          brightness: Brightness.dark,
          primary: Color.fromRGBO(255, 255, 255, 1),
          secondary: Color.fromRGBO(255, 255, 255, 0.6),
          tertiary: Color.fromRGBO(255, 255, 255, 0.4),
          background: Color.fromRGBO(22, 22, 24, 1),
        ),
      );
}
