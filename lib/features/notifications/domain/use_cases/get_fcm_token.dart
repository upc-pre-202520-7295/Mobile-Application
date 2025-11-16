
import '../../../../core/utils/typedefs.dart';
import '../repositories/notification_repository.dart';

class GetFCMToken {
  final NotificationRepository repository;

  GetFCMToken(this.repository);

  ResultFuture<String> call() {
    return repository.getFCMToken();
  }
}
