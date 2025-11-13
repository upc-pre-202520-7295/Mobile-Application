import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../features/notifications/domain/entities/push_notification.dart';
import 'notification_service.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

class FirebaseNotificationService implements NotificationService {
  final FirebaseMessaging _firebaseMessaging;

  final StreamController<PushNotification> _messageController =
  StreamController<PushNotification>.broadcast();

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

  @override
  Stream<PushNotification> get onMessageReceived => _messageController.stream;

  void _handleForegroundMessage(RemoteMessage message) {
  }
  void _handleNotificationTap(RemoteMessage message) {
  }
  void dispose() {
    _messageController.close();
  }
}
