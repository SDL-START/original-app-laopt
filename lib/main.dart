import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:logger/logger.dart';
import 'app.dart';
import 'core/DI/service_locator.dart';

void main() async {
  FlavorConfig(name: "Production", variables: {
    //my id 2803
    "baseUrl": "https://api.laospt.com",
    //url ທົດລອງ
    // "baseUrl": "https://uapi.laospt.com/",
    //connect to nodejs
    //5000 port node js
    // "baseUrl": "http://192.168.1.9:5000",

    //url ຂອງແທ້
    // "baseUrl": "https://prodapi.laospt.com",
  });
  await configureDependencies();
  Logger logger = Logger(
    printer: PrettyPrinter(),
  );
  logger.d('Pointing to -> https://api.laospt.com\nRunning on Production');
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('lo'),
        Locale('vi'),
        Locale('zh'),
      ],
      saveLocale: true,
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      useFallbackTranslations: true,
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}
