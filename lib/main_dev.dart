// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_flavor/flutter_flavor.dart';
// import 'package:logger/logger.dart';

// import 'app.dart';
// import 'core/DI/service_locator.dart';

// void main() async {
//   FlavorConfig(name: "Development", variables: {
//     "baseUrl": "https://devapi.laospt.com",
//     // "baseUrl": "https://api-app-onef.onrender.com",
//     // "baseUrl": "https://uapi.laospt.com/",
//   });
//   await configureDependencies();
//   Logger logger = Logger(
//     printer: PrettyPrinter(),
//   );
//   logger.d('Pointing to -> https://devapi.laospt.com\nRunning on Development');
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [
//         Locale('en'),
//         Locale('lo'),
//         Locale('vi'),
//         Locale('zh'),
//       ],
//       saveLocale: true,
//       path: 'assets/translations',
//       startLocale: const Locale('en'),
//       fallbackLocale: const Locale('en'),
//       useFallbackTranslations: true,
//       useOnlyLangCode: true,
//       child: const MyApp(),
//     ),
//   );
// }
