import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/push_notification_model.dart';

abstract class NotificationLocalDataSource {
  Future<List<PushNotificationModel>> getNotificationHistory();
  Future<void> saveNotification(PushNotificationModel notification);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
  Future<void> clearAll();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _notificationsKey = 'cached_notifications';

  NotificationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PushNotificationModel>> getNotificationHistory() async {
    final jsonString = sharedPreferences.getString(_notificationsKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => PushNotificationModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> saveNotification(PushNotificationModel notification) async {
    final notifications = await getNotificationHistory();
    notifications.insert(0, notification);

    if (notifications.length > 50) {
      notifications.removeRange(50, notifications.length);
    }

    await _saveNotifications(notifications);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final notifications = await getNotificationHistory();
    final index = notifications.indexWhere((n) => n.id == notificationId);

    if (index != -1) {
      final updatedNotification = PushNotificationModel(
        id: notifications[index].id,
        title: notifications[index].title,
        body: notifications[index].body,
        data: notifications[index].data,
        receivedAt: notifications[index].receivedAt,
        isRead: true,
        type: notifications[index].type,
      );

      notifications[index] = updatedNotification;
      await _saveNotifications(notifications);
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final notifications = await getNotificationHistory();
    notifications.removeWhere((n) => n.id == notificationId);
    await _saveNotifications(notifications);
  }

  @override
  Future<void> clearAll() async {
    await sharedPreferences.remove(_notificationsKey);
  }

  Future<void> _saveNotifications(List<PushNotificationModel> notifications) async {
    final jsonList = notifications.map((n) => n.toJson()).toList();
    await sharedPreferences.setString(_notificationsKey, json.encode(jsonList));
  }
}
