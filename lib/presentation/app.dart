import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../constants/theme.dart';
import '../navigation/router_delegate.dart';
import '../utils/localizations.dart';

class MainApp extends StatelessWidget {
  final FlavorConfig flavor;
  const MainApp({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('ru', 'RU'),
      ],
      locale: Locale(Platform.localeName),
      routerDelegate: MyRouterDelegate(),
      debugShowCheckedModeBanner: flavor.name == 'debug',
    );
  }
}
