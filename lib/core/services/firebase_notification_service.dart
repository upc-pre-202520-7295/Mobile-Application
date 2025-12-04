import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

class FirebaseNotificationService implements NotificationService {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseNotificationService({required FirebaseMessaging firebaseMessaging}) : _firebaseMessaging = firebaseMessaging;

  @override
  Future<void> initialize() async {

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  @override
  Future<String> getToken() async {
    final token = await _firebaseMessaging.getToken();
    return token ?? '';
  }

  void _handleForegroundMessage(RemoteMessage message) {
  }
  void _handleNotificationTap(RemoteMessage message) {
  }
}
