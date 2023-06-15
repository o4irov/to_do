import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/presentation/home_screen.dart';
import 'package:to_do/utils/localizations.dart';

void main() {
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
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.light(
                primary: AppConstants.primary(context),
                secondary: AppConstants.secondary(context),
                tertiary: AppConstants.tertiary(context),
                background: AppConstants.backPrimary(context),
              ),
              scaffoldBackgroundColor: AppConstants.backPrimary(context),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppConstants.white(context)
                      : AppConstants.primary(context),
                ),
                titleMedium: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppConstants.white(context)
                      : AppConstants.primary(context),
                ),
                labelLarge: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppConstants.white(context)
                      : AppConstants.primary(context),
                ),
                bodyMedium: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppConstants.white(context)
                      : AppConstants.primary(context),
                ),
                bodySmall: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppConstants.white(context)
                      : AppConstants.primary(context),
                ),
              ),
            ),
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
            home: const ToDo(),
          );
        });
  }
}
