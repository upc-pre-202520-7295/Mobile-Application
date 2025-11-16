
class ValueBet {
  final int id;
  final int matchId;

  final String homeTeam;
  final String awayTeam;
  final String league;
  final DateTime matchDate;

  final String outcome;
  final double ourProbability;

  final double bookmakerOdds;
  final double impliedProbability;

  final double valuePercentage;
  final String confidenceLevel;

  const ValueBet({
  required this.id,
  required this.matchId,
  required this.homeTeam,
  required this.awayTeam,
  required this.league,
  required this.matchDate,
  required this.outcome,
  required this.ourProbability,
  required this.bookmakerOdds,
  required this.impliedProbability,
  required this.valuePercentage,
  required this.confidenceLevel,
  });
}
