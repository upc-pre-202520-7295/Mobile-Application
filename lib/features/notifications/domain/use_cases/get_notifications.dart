import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/notification.dart';
import 'package:betalyze_mobile/features/notifications/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {

  final NotificationRepository repository;
  GetNotificationsUseCase(this.repository);

  ResultFuture<List<Notification>> call(int id){
    return repository.getNotifications(id);
  }
}