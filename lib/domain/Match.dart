class PredictionResult {
  final double home_win_prob;
  final double draw_prob;
  final double away_win_prob;
  final String predicted_outcome;
  final String confidence;
  final double confidence_score;

  PredictionResult.fromJson(Map<String, dynamic> json)
      : home_win_prob = json['home_win_prob'],
        draw_prob = json['draw_prob'],
        away_win_prob = json['away_win_prob'],
        predicted_outcome = json['predicted_outcome'],
        confidence = json['confidence'],
        confidence_score = json['confidence_score'];
}

class PredictionGoals {
  final double home_expected;
  final double away_expected;
  final double total_expected;

  PredictionGoals.fromJson(Map<String, dynamic> json)
      : home_expected = json['home_expected'],
        away_expected = json['away_expected'],
        total_expected = json['total_expected'];
}

class PredictionOverUnder {
  final double over_1_5;
  final double over_2_5;
  final double over_3_5;
  final String recommendation;
  final String confidence;
  final double confidence_score;

  PredictionOverUnder.fromJson(Map<String, dynamic> json)
      : over_1_5 = json['over_1.5'],
        over_2_5 = json['over_2.5'],
        over_3_5 = json['over_3.5'],
        recommendation = json['recommendation'],
        confidence = json['confidence'],
        confidence_score = json['confidence_score'];
}

class PredictionBothTeamsScore {
  final double probability;
  final String recommendation;
  final String confidence;
  final double confidence_score;

  PredictionBothTeamsScore.fromJson(Map<String, dynamic> json)
      : probability = json['probability'],
        recommendation = json['recommendation'],
        confidence = json['confidence'],
        confidence_score = json['confidence_score'];
}

class Predictions {
  final PredictionResult result;
  final PredictionGoals goals;
  final PredictionOverUnder over_under;
  final PredictionBothTeamsScore both_teams_score;

  Predictions.fromJson(Map<String, dynamic> json)
      : result = PredictionResult.fromJson(json['result']),
        goals = PredictionGoals.fromJson(json['goals']),
        over_under = PredictionOverUnder.fromJson(json['over_under']),
        both_teams_score = PredictionBothTeamsScore.fromJson(json['both_teams_score']);
}

class MatchInfo {
  final String date;
  final String time;
  final String league;
  final String season;

  MatchInfo.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        time = json['time'],
        league = json['league'],
        season = json['season'];
}

class MatchGame {
  final Predictions predictions;
  final String home_team_name;
  final String home_team_image;
  final String away_team_name;
  final String away_team_image;
  final MatchInfo match_info;

  MatchGame.fromJson(Map<String, dynamic> json)
      : predictions = Predictions.fromJson(json['predictions']),
        home_team_name = json['home_team_name'],
        home_team_image = json['home_team_image'],
        away_team_name = json['away_team_name'],
        away_team_image = json['away_team_image'],
        match_info = MatchInfo.fromJson(json['match_info']);
}
