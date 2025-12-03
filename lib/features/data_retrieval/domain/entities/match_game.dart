class Team {
  final int id;
  final String name;
  final String imgUrl;

  const Team({
    required this.id,
    required this.name,
    required this.imgUrl,
  });
}

class MatchGame {
  final int id;
  final Team homeTeam;
  final Team awayTeam;
  final int homeScore;
  final int awayScore;
  final String league;
  final String matchDate;
  final String status;

  const MatchGame({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.league,
    required this.awayScore,
    required this.matchDate,
    required this.status,
  });
}
