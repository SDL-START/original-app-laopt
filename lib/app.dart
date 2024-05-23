import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_navigator.dart';
import 'core/utils/custom_theme.dart';
import 'core/utils/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(),
      title: "LAOPT",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppRoute.generateRoute,
      initialRoute: AppRoute.initialRoute,
    );
  }
}