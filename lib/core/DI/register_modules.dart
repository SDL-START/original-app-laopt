import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_path.dart';

@module
abstract class InjectionModule {
  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  @lazySingleton
  FlutterLocalNotificationsPlugin get flutterLocalNotificationPlugin =>
      FlutterLocalNotificationsPlugin();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  Dio get dio => Dio(BaseOptions(baseUrl: APIPath.baseUrl));
  
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
  Location get location => Location();
  Logger get logger => Logger();
  @lazySingleton
  FirebaseFirestore get fireStore =>FirebaseFirestore.instance;
}
