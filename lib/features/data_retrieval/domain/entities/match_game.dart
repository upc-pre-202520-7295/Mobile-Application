import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_details.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/team.dart';

class MatchGame {
  final int id;
  final Team homeTeam;
  final Team awayTeam;
  final DateTime startTime;
  final MatchDetails matchDetails;

  const MatchGame({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.startTime,
    required this.matchDetails,
  });

}