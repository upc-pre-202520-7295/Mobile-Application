import 'package:betalyze_mobile/features/data_retrieval/data/models/match_details_model.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/favorites/data/models/team_model.dart';

class MatchGameModel extends MatchGame {

  const MatchGameModel({
    required super.id,
    required super.homeTeam,
    required super.awayTeam,
    required super.startTime,
    required super.matchDetails,
  });

  factory MatchGameModel.fromJson(Map<String, dynamic> json) => MatchGameModel(
        id: json['id'] as int,
        homeTeam: TeamModel.fromJson(json['home_team']),
        awayTeam: TeamModel.fromJson(json['away_team']),
        startTime: DateTime.parse(json['start_time'] as String),
        matchDetails: MatchDetailsModel.fromJson(json['match_details'] as Map<String, dynamic>)
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'home_team': (homeTeam as TeamModel).toJson(),
        'away_team': (awayTeam as TeamModel).toJson(),
        'start_time': startTime.toIso8601String(),
        'match_details': (matchDetails as MatchDetailsModel).toJson(),
      };

  factory MatchGameModel.fromEntity(MatchGame match) => MatchGameModel(
        id: match.id,
        homeTeam: TeamModel.fromEntity(match.homeTeam),
        awayTeam: TeamModel.fromEntity(match.awayTeam),
        startTime: match.startTime,
        matchDetails: MatchDetailsModel.fromEntity(match.matchDetails),
      );

}

