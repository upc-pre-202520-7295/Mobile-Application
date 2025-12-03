
import 'package:betalyze_mobile/core/errors/failures.dart';
import 'package:betalyze_mobile/features/data_retrieval/data/models/match_game_model.dart';
import 'package:dio/dio.dart';

abstract class MatchDataSource {
  Future<List<MatchModel>> getMatches();
  Future<List<MatchModel>> getTodayMatches();
}

class MatchDataSourceImpl implements MatchDataSource {

  final Dio dio = Dio();
  final String baseUrl = String.fromEnvironment('API_BASE_URL');

  @override
  Future<List<MatchModel>> getTodayMatches() async {
    final resp = await dio.get('$baseUrl/matches/today');

    if (resp.statusCode != 200) {
      throw ServerFailure("Error while fetching matches");
    }

    return (resp.data["data"] as List)
        .map((e) => MatchModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<MatchModel>> getMatches() async {
    final resp = await dio.get('$baseUrl/matches');
    return (resp.data["data"] as List)
        .map((e) => MatchModel.fromJson(e))
        .toList();
  }
}
