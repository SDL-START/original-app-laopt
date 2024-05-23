import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/services/push_nitification_service.dart';

abstract class AppRemoteDatasource {
  void showNotification(RemoteMessage message);
  Future<bool?> isAuthorized();
  Future<void> setupFlutterNotifications(Future<void> Function(RemoteMessage) backgroundMessagingHandler);
  Stream<RemoteMessage> onMessageStream();
}

@LazySingleton(as: AppRemoteDatasource)
class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  final PushNotificationService _notificationService;
  AppRemoteDatasourceImpl(this._notificationService);
  @override
  Future<void> setupFlutterNotifications(Future<void> Function(RemoteMessage) backgroundMessagingHandler) async {
    await _notificationService.setupFlutterNotifications(backgroundMessagingHandler);
  }

  @override
  Future<bool?> isAuthorized() async {
    return _notificationService.isAuthorized;
  }

  @override
  Stream<RemoteMessage> onMessageStream() {
    return _notificationService.onMessageStream();
  }

  @override
  void showNotification(RemoteMessage message) {
    _notificationService.showFlutterNotification(message);
  }
}
