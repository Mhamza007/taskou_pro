import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../resources/resources.dart';
import 'app.dart';

class TaskouProApp extends StatelessWidget {
  const TaskouProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Res.string.appTitle,
      themeMode: ThemeMode.light,
      translations: Res.appTranslations,
      locale: Res.appTranslations.getLocale(),
      // locale: Res.appTranslations.locale,
      fallbackLocale: Res.appTranslations.fallbackLocale,
      localizationsDelegates: const [
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      initialRoute: Routes.initial,
      onGenerateRoute: RouteGenerator.generateRoute,
      defaultTransition: Transition.cupertino,
      theme: Res.appTheme.lightTheme,
      darkTheme: Res.appTheme.darkTheme,
    );
  }

  chagneThemeMode() {
    if (Res.appTheme.getThemeMode() == ThemeMode.light) {
      Res.appTheme.changeThemeMode(ThemeMode.dark);
    } else {
      Res.appTheme.changeThemeMode(ThemeMode.light);
    }
  }
}
