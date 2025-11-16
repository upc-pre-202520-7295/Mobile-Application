
import '../../../../core/utils/typedefs.dart';
import '../repositories/notification_repository.dart';

class InitializeNotifications {
  final NotificationRepository repository;

  InitializeNotifications(this.repository);

  ResultFuture<String> call() async {
    return repository.getFCMToken();
  }
}
