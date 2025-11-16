import 'package:flutter/material.dart';
import '../../features/notifications/domain/entities/push_notification.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<String> getToken();
  Stream<PushNotification> get onMessageReceived;

}
