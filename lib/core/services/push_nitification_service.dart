import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
  'laopt_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

@lazySingleton
class PushNotificationService {
  final FirebaseMessaging firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool? isAuthorized;
  PushNotificationService(
    this.firebaseMessaging,
    this.flutterLocalNotificationsPlugin,
  );

  Future<String?> getFirebaseToken() async {
    return await firebaseMessaging.getToken();
  }

  Future<NotificationSettings> requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    return settings;
  }

  Future<void> setupFlutterNotifications(
      Future<void> Function(RemoteMessage) backgroundMessagingHandler) async {
    final String? token = await getFirebaseToken();
    print("FirebaseMessaging token: $token");

    NotificationSettings settings = await requestPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    AndroidInitializationSettings androidSetting =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings iOSSettings =
        const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: iOSSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      isAuthorized = true;
    } else {
      isAuthorized = false;
    }
  }

  Stream<RemoteMessage> onMessageStream() {
    return FirebaseMessaging.onMessage;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }
}
