import 'package:betalyze_mobile/features/data_retrieval/data/models/match_game_model.dart';
import 'package:betalyze_mobile/features/notifications/domain/entities/notification.dart';
import 'package:betalyze_mobile/features/user_management/data/models/user_model.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.user,
    required super.match,
    required super.calendarLink,
    required super.scheduledAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as int,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        match: MatchGameModel.fromJson(json['match'] as Map<String, dynamic>),
        calendarLink: json['calendarLink'] as String,
        scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': (user as UserModel).toJson(),
        'match': (match as MatchGameModel).toJson(),
        'calendarLink': calendarLink,
        'scheduledAt': scheduledAt.toIso8601String(),
      };

  factory NotificationModel.fromEntity(Notification notification) =>
      NotificationModel(
        id: notification.id,
        user: notification.user,
        match: notification.match,
        calendarLink: notification.calendarLink,
        scheduledAt: notification.scheduledAt,
      );

}

