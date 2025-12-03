import 'package:betalyze_mobile/features/favorites/data/models/favorite_team_model.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/favorite_team.dart';
import 'package:dio/dio.dart';

abstract class FavoriteTeamsRemoteDataSource {
  Future<List<FavoriteTeamModel>> getFavoriteTeams();
  Future<void> addFavoriteTeam(int id);
  Future<void> deleteFavoriteTeam(int id);
}

class FavoriteTeamsRemoteDataSourceImpl implements FavoriteTeamsRemoteDataSource {

  final Dio dio = Dio();
  final String baseUrl = String.fromEnvironment('API_BASE_URL');
  @override
  Future<void> addFavoriteTeam(int id) async{
    final response = await dio.post('$baseUrl/favorite-teams/$id');
    return;
  }

  @override
  Future<void> deleteFavoriteTeam(int id) async{
    final response = await dio.delete('$baseUrl/favorite-teams/$id');
    return;
  }

 @override
  Future<List<FavoriteTeamModel>> getFavoriteTeams() async {
    final response = await dio.get('$baseUrl/favorite-teams');
    final data = response.data as List<dynamic>;
    return data.map((e) => FavoriteTeamModel.fromJson(e as Map<String, dynamic>)).toList();
  }

}
