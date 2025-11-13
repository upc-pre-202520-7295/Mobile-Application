
class PushNotification {
  final String id;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final DateTime receivedAt;
  final bool isRead;
  final NotificationType type;

  const PushNotification({
    required this.id,
    required this.title,
    required this.body,
    this.data,
    required this.receivedAt,
    this.isRead = false,
    required this.type,
  });
}

enum NotificationType {
  matchStart,
  valueBet,
  predictionResult,
  general,
}
