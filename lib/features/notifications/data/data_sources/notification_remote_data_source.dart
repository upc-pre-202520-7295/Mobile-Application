import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/notifications/data/models/notification_model.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/notification.dart';
import 'package:dio/dio.dart';

abstract class NotificationRemoteDataSource{
  Future<List<Notification>> getNotifications(int userId);
  Future<void> updateNotification(int id);
  Future<void> deleteNotification(int id);
  Future<void> addNotification(int userId, int matchGameId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio dio = Dio();
  final String baseUrl = String.fromEnvironment('API_BASE_URL');

  @override
  Future<void> addNotification(int userId, int matchGameId) async {
    final response = await dio.post('$baseUrl/notifications');
    return;
  }

  @override
  Future<void> deleteNotification(int id) async{
    final response = dio.delete('$baseUrl/notifications/$id');
    return;
  }

  @override
  Future<List<Notification>> getNotifications(int userId) async{
    final Response response = await dio.get('$baseUrl/notifications/user/$userId');
    final List<dynamic> data = (response.data as List<dynamic>?) ?? <dynamic>[];
    final List<NotificationModel> models = data
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return models.cast<Notification>();
  }

  @override
  Future<void> updateNotification(int id) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }


}