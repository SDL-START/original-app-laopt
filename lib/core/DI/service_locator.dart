import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/DI/service_locator.config.dart';

import '../services/push_nitification_service.dart';
import '../utils/app_navigator.dart';

final getIt = GetIt.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    FlutterLocalNotificationsPlugin().show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription:androidChannel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

@injectableInit

///Initial dependencies
Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initial localization
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //initialize navigator
  AppNavigator();
  getIt.init();
}
