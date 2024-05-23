import 'package:flutter/material.dart';
import 'package:insuranceapp/core/constants/app_colors.dart';

ThemeData buildTheme() {
  final baseTheme = ThemeData(fontFamily: "NotoSansLao");
  return baseTheme.copyWith(
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      titleTextStyle: TextStyle(fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    radioTheme: const RadioThemeData().copyWith(
      fillColor: MaterialStateProperty.all(AppColors.primaryColor),
      overlayColor: MaterialStateProperty.all(AppColors.primaryColor),
    ),
    listTileTheme: const ListTileThemeData().copyWith(
      textColor: Colors.black,
    ),
    textTheme: const TextTheme().copyWith(
      displayLarge: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontFamily: 'NotoSansLao',
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'NotoSansLao',
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'NotoSansLao',
        fontWeight: FontWeight.bold,
      ),
      titleLarge: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'NotoSansLao',
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: const TextStyle(
        color: Colors.black,
        fontFamily: 'NotoSansLao',
        fontSize: 14,
      ),
      bodyMedium: const TextStyle(
        color: Colors.black,
        fontFamily: 'NotoSansLao',
        fontSize: 12,
      ),
      titleMedium: const TextStyle(color: Colors.black),
      titleSmall: const TextStyle(color: Colors.black),
    ),
  );
}
