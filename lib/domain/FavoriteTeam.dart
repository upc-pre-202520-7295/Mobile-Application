class FavoriteTeam {
  final String teamId;
  final String userId;
  final String teamName;
  final String teamImageUrl;

  FavoriteTeam.fromJson(Map<String, dynamic> json)
      : teamId = json['teamId'] as String,
        userId = json['userId'] as String,
        teamName = json['teamName'] as String,
        teamImageUrl = json['teamImageUrl'] as String;
}
