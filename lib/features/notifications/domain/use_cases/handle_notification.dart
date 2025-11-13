import '../entities/push_notification.dart';
import '../repositories/notification_repository.dart';

class HandleNotification {
  final NotificationRepository repository;

  HandleNotification(this.repository);

  Stream<PushNotification> call() {
    return repository.notificationStream;
  }
}
