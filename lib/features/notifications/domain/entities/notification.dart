import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/user_management/domain/entities/user.dart';

class Notification {
  final int id;
  final User user;
  final MatchGame match;
  final String calendarLink;
  final DateTime scheduledAt;

  const Notification({
    required this.id,
    required this.user,
    required this.match,
    required this.calendarLink,
    required this.scheduledAt,
  });
}