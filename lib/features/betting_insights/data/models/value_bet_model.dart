import 'package:betalyze_mobile/features/betting_insights/domain/entities/value_bet.dart';

class ValueBetModel extends ValueBet {
  const ValueBetModel({
    required super.id,
    required super.matchId,
    required super.homeTeam,
    required super.awayTeam,
    required super.league,
    required super.matchDate,
    required super.outcome,
    required super.ourProbability,
    required super.bookmakerOdds,
    required super.impliedProbability,
    required super.valuePercentage,
    required super.confidenceLevel,
  });

  factory ValueBetModel.fromJson(Map<String, dynamic> json) {
    return ValueBetModel(
      id: json['id'] as int,
      matchId: json['match_id'] as int,
      homeTeam: json['home_team'] as String,
      awayTeam: json['away_team'] as String,
      league: json['league'] as String,
      matchDate: DateTime.parse(json['match_date'] as String),
      outcome: json['outcome'] as String,
      ourProbability: (json['our_probability'] as num).toDouble(),
      bookmakerOdds: (json['bookmaker_odds'] as num).toDouble(),
      impliedProbability: (json['implied_probability'] as num).toDouble(),
      valuePercentage: (json['value_percentage'] as num).toDouble(),
      confidenceLevel: json['confidence_level'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'match_id': matchId,
      'home_team': homeTeam,
      'away_team': awayTeam,
      'league': league,
      'match_date': matchDate.toIso8601String(),
      'outcome': outcome,
      'our_probability': ourProbability,
      'bookmaker_odds': bookmakerOdds,
      'implied_probability': impliedProbability,
      'value_percentage': valuePercentage,
      'confidence_level': confidenceLevel,
    };
  }

  factory ValueBetModel.fromEntity(ValueBet valueBet) {
    return ValueBetModel(
      id: valueBet.id,
      matchId: valueBet.matchId,
      homeTeam: valueBet.homeTeam,
      awayTeam: valueBet.awayTeam,
      league: valueBet.league,
      matchDate: valueBet.matchDate,
      outcome: valueBet.outcome,
      ourProbability: valueBet.ourProbability,
      bookmakerOdds: valueBet.bookmakerOdds,
      impliedProbability: valueBet.impliedProbability,
      valuePercentage: valueBet.valuePercentage,
      confidenceLevel: valueBet.confidenceLevel,
    );
  }
}