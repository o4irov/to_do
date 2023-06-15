import 'package:flutter/material.dart';

class AppConstants {
  static Color separator(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 0, 0, .2)
        : const Color.fromRGBO(255, 255, 255, 0.2);
  }

  static Color overlay(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 0, 0, .06)
        : const Color.fromRGBO(0, 0, 0, 0.32);
  }

  static Color primary(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 0, 0, 1)
        : const Color.fromRGBO(255, 255, 255, 1);
  }

  static Color secondary(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 0, 0, .6)
        : const Color.fromRGBO(255, 255, 255, 0.6);
  }

  static Color tertiary(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 0, 0, .3)
        : const Color.fromRGBO(255, 255, 255, 0.4);
  }

  static Color disable(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 0, 0, .15)
        : const Color.fromRGBO(255, 255, 255, 0.15);
  }

  static Color red(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(255, 59, 48, 1)
        : const Color.fromRGBO(255, 69, 58, 1);
  }

  static Color green(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(52, 199, 89, 1)
        : const Color.fromRGBO(50, 215, 75, 1);
  }

  static Color blue(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(0, 122, 255, 1)
        : const Color.fromRGBO(10, 132, 255, 1);
  }

  static Color gray(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(142, 142, 147, 1)
        : const Color.fromRGBO(142, 142, 147, 1);
  }

  static Color graydark(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(209, 209, 214, 1)
        : const Color.fromRGBO(72, 72, 74, 1);
  }

  static Color white(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(255, 255, 255, 1)
        : const Color.fromRGBO(255, 255, 255, 1);
  }

  static Color backPrimary(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(247, 246, 242, 1)
        : const Color.fromRGBO(22, 22, 24, 1);
  }

  static Color backSecondary(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(255, 255, 255, 1)
        : const Color.fromRGBO(37, 37, 40, 1);
  }

  static Color backElevated(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return themeData.brightness != Brightness.dark
        ? const Color.fromRGBO(255, 255, 255, 1)
        : const Color.fromRGBO(37, 37, 40, 1);
  }
}
