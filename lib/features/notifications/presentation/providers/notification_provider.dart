import 'package:betalyze_mobile/core/services/firebase_notification_service.dart';
import 'package:betalyze_mobile/core/services/notification_service.dart';
import 'package:betalyze_mobile/features/notifications/data/data_sources/notification_local_data_source.dart';
import 'package:betalyze_mobile/features/notifications/data/repositories/notification_repository_implementation.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/push_notification.dart';
import 'package:betalyze_mobile/features/notifications/domain/repositories/notification_repository.dart';
import 'package:betalyze_mobile/features/notifications/domain/use_cases/get_fcm_token.dart';
import 'package:betalyze_mobile/features/notifications/domain/use_cases/handle_notification.dart';
import 'package:betalyze_mobile/features/notifications/domain/use_cases/initialize_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';


// State
class NotificationState {
  final List<PushNotification> notifications;
  final int unreadCount;
  final bool isInitialized;
  final String? fcmToken;
  final String? error;

  NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.isInitialized = false,
    this.fcmToken,
    this.error,
  });

  NotificationState copyWith({
    List<PushNotification>? notifications,
    int? unreadCount,
    bool? isInitialized,
    String? fcmToken,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isInitialized: isInitialized ?? this.isInitialized,
      fcmToken: fcmToken ?? this.fcmToken,
      error: error,
    );
  }
}

// Notifier
class NotificationNotifier extends StateNotifier<NotificationState> {
  final InitializeNotifications initializeNotifications;
  final GetFCMToken getFCMToken;
  final HandleNotification handleNotification;
  final NotificationRepository repository;

  NotificationNotifier({
    required this.initializeNotifications,
    required this.getFCMToken,
    required this.handleNotification,
    required this.repository,
  }) : super(NotificationState()) {
    _initialize();
    _listenToNotifications();
  }

  Future<void> _initialize() async {
    final result = await initializeNotifications();

    result.fold(
          (failure) => state = state.copyWith(error: 'Failed to initialize'),
          (token) {
        state = state.copyWith(
          isInitialized: true,
          fcmToken: token,
        );
        _sendTokenToBackend(token);
      },
    );

    _loadHistory();
  }

  void _listenToNotifications() {
    handleNotification().listen((notification) {
      final updatedNotifications = [notification, ...state.notifications];
      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: state.unreadCount + 1,
      );
    });
  }

  Future<void> _loadHistory() async {
    final result = await repository.getNotificationHistory();

    result.fold(
          (failure) => null,
          (notifications) {
        final unread = notifications.where((n) => !n.isRead).length;
        state = state.copyWith(
          notifications: notifications,
          unreadCount: unread,
        );
      },
    );
  }

  Future<void> _sendTokenToBackend(String token) async {
    await repository.sendTokenToBackend(token);
  }

  Future<void> markAsRead(String notificationId) async {
    await repository.markAsRead(notificationId);
    await _loadHistory();
  }

}

// Providers
final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final localNotificationsProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return FirebaseNotificationService(
    firebaseMessaging: ref.read(firebaseMessagingProvider),
  );
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final notificationLocalDataSourceProvider = Provider<NotificationLocalDataSource>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider).asData?.value;
  return NotificationLocalDataSourceImpl(sharedPreferences: sharedPrefs!);
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    notificationService: ref.read(notificationServiceProvider),
    localDataSource: ref.read(notificationLocalDataSourceProvider),
    dio: Dio(),
  );
});

final initializeNotificationsUseCaseProvider = Provider((ref) {
  return InitializeNotifications(ref.read(notificationRepositoryProvider));
});

final getFCMTokenUseCaseProvider = Provider((ref) {
  return GetFCMToken(ref.read(notificationRepositoryProvider));
});

final handleNotificationUseCaseProvider = Provider((ref) {
  return HandleNotification(ref.read(notificationRepositoryProvider));
});

final notificationProvider =
StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier(
    initializeNotifications: ref.read(initializeNotificationsUseCaseProvider),
    getFCMToken: ref.read(getFCMTokenUseCaseProvider),
    handleNotification: ref.read(handleNotificationUseCaseProvider),
    repository: ref.read(notificationRepositoryProvider),
  );
});
