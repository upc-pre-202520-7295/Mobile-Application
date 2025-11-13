
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/notification.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/push_notification.dart';

abstract class NotificationRepository {
  ResultFuture<List<Notification>> getNotifications(int userId);
  ResultFuture<void> updateNotification(int id);
  ResultFuture<void> deleteNotification(int id);
  ResultFuture<void> addNotification(int userId, int matchGameId);

  //Notification push
  ResultFuture<String> getFCMToken();
  ResultFuture<void> sendTokenToBackend(String token);
  ResultFuture<List<PushNotification>> getNotificationHistory();
  ResultFuture<void> markAsRead(String notificationId);
  Stream<PushNotification> get notificationStream;

}