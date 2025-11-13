
import 'package:betalyze_mobile/features/data_retrieval/data/models/match_details_model.dart';
import 'package:betalyze_mobile/features/data_retrieval/data/models/match_game_model.dart';
import 'package:dio/dio.dart';

abstract class MatchDataSource {
  Future<List<MatchGameModel>> getMatches();
  Future<MatchGameModel> getMatchById(int id);
  Future<MatchGameModel> getMatchByTeamName(String teamName);
  Future<MatchDetailsModel> getMatchDetailsByMatchGameId(int matchGameId);

}

class MatchDataSourceImpl implements MatchDataSource {

  final Dio dio = Dio();
  final String baseUrl = String.fromEnvironment('API_BASE_URL');

  @override
  Future<MatchGameModel> getMatchById(int id) async {
    final resp = await dio.get('$baseUrl/matches/$id');

    return MatchGameModel.fromJson(resp.data);
  }

  @override
  Future<MatchGameModel> getMatchByTeamName(String teamName) {
    final resp = dio.get('$baseUrl/matches/team/$teamName');
    return resp.then((value) => MatchGameModel.fromJson(value.data));
  }

  @override
  Future<MatchDetailsModel> getMatchDetailsByMatchGameId(int matchGameId) {
    final resp = dio.get('$baseUrl/match-details/match/$matchGameId');
    return resp.then((value) => MatchDetailsModel.fromJson(value.data));
  }

  @override
  Future<List<MatchGameModel>> getMatches() {
    final resp = dio.get('$baseUrl/matches');
    return resp.then((value) => (value.data as List)
        .map((e) => MatchGameModel.fromJson(e))
        .toList());
  }

}