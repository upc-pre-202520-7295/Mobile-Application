import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_details.dart';

class MatchDetailsModel extends MatchDetails {

  const MatchDetailsModel({
    required super.id,
    required super.matchWinner,
    required super.homeScore,
    required super.awayScore
  });
  factory MatchDetailsModel.fromJson(Map<String, dynamic> json) => MatchDetailsModel(
    id: json['id'] as int,
    matchWinner: json['matchWinner'] as int,
    homeScore: json['homeScore'] as int,
    awayScore: json['awayScore'] as int,
  );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'matchWinner': matchWinner,
        'homeScore': homeScore,
        'awayScore': awayScore
      };

  factory MatchDetailsModel.fromEntity(MatchDetails matchDetails) =>
      MatchDetailsModel(
        id: matchDetails.id,
        matchWinner: matchDetails.matchWinner,
        homeScore: matchDetails.homeScore,
        awayScore: matchDetails.awayScore,
      );
}