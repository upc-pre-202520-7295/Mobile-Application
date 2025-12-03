import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.imgUrl,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json['id'] as int,
    name: json['name'] as String,
    imgUrl: json['imgUrl'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imgUrl': imgUrl,
  };

  factory TeamModel.fromEntity(Team team) => TeamModel(
    id: team.id,
    name: team.name,
    imgUrl: team.imgUrl,
  );
}


class MatchModel extends MatchGame {
  const MatchModel({
    required super.id,
    required super.homeTeam,
    required super.awayTeam,
    required super.league,
    required super.homeScore,
    required super.awayScore,
    required super.matchDate,
    required super.status,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    id: json['id'] as int,
    homeTeam: TeamModel.fromJson(json['homeTeam']),
    awayTeam: TeamModel.fromJson(json['awayTeam']),
    league: json['league'] as String,
    homeScore: json['homeScore'] as int,
    awayScore: json['awayScore'] as int,
    matchDate: json['matchDate'] as String,
    status: json['status'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'homeTeam': (homeTeam as TeamModel).toJson(),
    'awayTeam': (awayTeam as TeamModel).toJson(),
    'league': league,
    'homeScore': homeScore,
    'awayScore': awayScore,
    'matchDate': matchDate,
    'status': status,
  };

  factory MatchModel.fromEntity(MatchGame match) => MatchModel(
    id: match.id,
    homeTeam: TeamModel.fromEntity(match.homeTeam),
    awayTeam: TeamModel.fromEntity(match.awayTeam),
    league: match.league,
    homeScore: match.homeScore,
    awayScore: match.awayScore,
    matchDate: match.matchDate,
    status: match.status,
  );
}
