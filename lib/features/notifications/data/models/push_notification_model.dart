import 'package:firebase_messaging/firebase_messaging.dart';
import '../../domain/entities/push_notification.dart';

class PushNotificationModel extends PushNotification {
  const PushNotificationModel({
    required super.id,
    required super.title,
    required super.body,
    super.data,
    required super.receivedAt,
    super.isRead,
    required super.type,
  });

  factory PushNotificationModel.fromFirebaseMessage(RemoteMessage message) {
    return PushNotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      data: message.data,
      receivedAt: DateTime.now(),
      isRead: false,
      type: _parseNotificationType(message.data['type']),
    );
  }

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) {
    return PushNotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>?,
      receivedAt: DateTime.parse(json['receivedAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      type: NotificationType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => NotificationType.general,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'data': data,
      'receivedAt': receivedAt.toIso8601String(),
      'isRead': isRead,
      'type': type.name,
    };
  }

  static NotificationType _parseNotificationType(String? type) {
    switch (type) {
      case 'match_start':
        return NotificationType.matchStart;
      case 'value_bet':
        return NotificationType.valueBet;
      case 'prediction_result':
        return NotificationType.predictionResult;
      default:
        return NotificationType.general;
    }
  }
}
