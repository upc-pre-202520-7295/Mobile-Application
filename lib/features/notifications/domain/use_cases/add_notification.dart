import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/notifications/domain/repositories/notification_repository.dart';

class AddNotificationUseCase{
 final NotificationRepository repository;
  AddNotificationUseCase(this.repository);

  ResultFuture<void> call(int userId, int id){
    return repository.addNotification(userId, id);
  }
}