import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_do/presentation/home_screen/home_screen.dart';
import 'package:to_do/utils/localizations.dart';
import 'package:to_do/utils/logger.dart';

import 'constants/theme.dart';

void main() {
  final uncaughtExceptionsController = StreamController<void>.broadcast();
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.e(
      'Uncaught exception',
      error,
      stackTrace,
    );

    uncaughtExceptionsController.addError(error, stackTrace);

    return true;
  };

  FlutterError.onError = (details) {
    logger.e(
      'Uncaught exception',
      details.exception,
      details.stack,
    );

    if (!details.silent) {
      uncaughtExceptionsController.addError(details.exception, details.stack);
    }
  };
  runApp(const MainApp());
}

var vl = ValueNotifier<ThemeMode>(ThemeMode.light);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: vl,
        builder: (context, value, child) {
          return MaterialApp(
            theme: ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            themeMode: ThemeMode.system,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ru', ''),
            ],
            locale: const Locale('ru' ''),
            home: const HomeScreen(),
          );
        });
  }
}
