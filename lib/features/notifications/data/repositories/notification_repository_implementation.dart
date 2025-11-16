import 'dart:async';

import 'package:betalyze_mobile/core/errors/failures.dart';
import 'package:betalyze_mobile/core/services/notification_service.dart';
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/notifications/data/data_sources/notification_local_data_source.dart';
import 'package:betalyze_mobile/features/notifications/data/models/push_notification_model.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/notification.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/push_notification.dart';
import 'package:betalyze_mobile/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class NotificationRepositoryImpl implements NotificationRepository {

  final NotificationService notificationService;
  final NotificationLocalDataSource localDataSource;
  final Dio dio;
  final String baseUrl = String.fromEnvironment('API_BASE_URL');

  final StreamController<PushNotification> _notificationController =
  StreamController<PushNotification>.broadcast();

  NotificationRepositoryImpl({
    required this.notificationService,
    required this.localDataSource,
    required this.dio,
  }) {
    _initializeNotificationListener();
  }

  @override
  ResultFuture<void> addNotification(int userId, int matchGameId) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deleteNotification(int id) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Notification>> getNotifications(int userId) {
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> updateNotification(int id) {
    throw UnimplementedError();
  }

  void _initializeNotificationListener() {
    notificationService.onMessageReceived.listen((notification) {
      _notificationController.add(notification);
      localDataSource.saveNotification(
        PushNotificationModel(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          data: notification.data,
          receivedAt: notification.receivedAt,
          isRead: false,
          type: notification.type,
        ),
      );
    });
  }

  @override
  ResultFuture<String> getFCMToken() async {
    try {
      final token = await notificationService.getToken();
      return Right(token);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<void> sendTokenToBackend(String token) async {
    try {
      await dio.post(
        '$baseUrl/users/fcm-token',
        data: {'fcm_token': token},
      );
      return const Right(null);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<List<PushNotification>> getNotificationHistory() async {
    try {
      final notifications = await localDataSource.getNotificationHistory();
      return Right(notifications);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }
  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await localDataSource.markAsRead(notificationId);
      return const Right(null);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

  @override
  Stream<PushNotification> get notificationStream => _notificationController.stream;


  void dispose() {
    _notificationController.close();
  }
}
