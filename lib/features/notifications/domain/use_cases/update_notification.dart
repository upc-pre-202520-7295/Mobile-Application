
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/notifications/domain/repositories/notification_repository.dart';

class UpdateNotificationUseCase{
  final NotificationRepository repository;
  UpdateNotificationUseCase(this.repository);

  ResultFuture<void> call(int id){
    return repository.updateNotification(id);
  }
}