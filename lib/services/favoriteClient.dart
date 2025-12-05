import 'package:dio/dio.dart';

import '../domain/FavoriteTeam.dart';

final String baseUrl = 'https://betalyze-tf-cjgafndmb4e4d7fx.westindia-01.azurewebsites.net/api/v1';

class FavoriteTeamClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  FavoriteTeamClient() {
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
    // token interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          var mockToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhQGdtYWlsLmNvbSIsImlhdCI6MTc2NDkwNDMxNiwiZXhwIjoxNzY0OTkwNzE2fQ.Cdqt_gK6LqOTiKcZyD6HpzJtoBHh14UjXUNPSOmnxq4";

          var token = mockToken;
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  Future<bool> addTeam(String userId, String teamId) async {
    final response = await _dio.get('/favorite');

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> removeTeam(String userId, String teamId) async {
    final response = await _dio.get('/favorite');

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<FavoriteTeam>> getFavoriteTeams(String userId) async {
    print("[FavoriteTeamClient.getFavoriteTeams] url: $baseUrl/favorites");

    final response = await _dio.get('/user/$userId/favorites');

    print("[FavoriteTeamClient.getFavoriteTeams] response.statusCode: ${response.statusCode}");
    print("[FavoriteTeamClient.getFavoriteTeams] response.data['data'].length: ${response.data}");
    print("[FavoriteTeamClient.getFavoriteTeams] response.data['data'].length: ${response.data["data"].length}");

    if (response.statusCode != 200) {
      return [];
    } else {
      return (response.data["data"] as List)
       .map((item) => FavoriteTeam.fromJson(item))
       .toList();
    }
  }
}
