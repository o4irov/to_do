import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_do/presentation/home_screen/home_screen.dart';
import 'package:to_do/utils/localizations.dart';
import 'package:to_do/utils/logger.dart';

import 'constants/theme.dart';
import 'domain/global.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        Locale('en', 'EN'),
        Locale('ru', 'RU'),
      ],
      locale: Locale(Platform.localeName),
      home: const HomeScreen(),
    );
  }
}
