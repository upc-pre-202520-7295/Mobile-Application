import 'package:dio/dio.dart';

import '../domain/FavoriteTeam.dart';

final String baseUrl = 'localhost:8080/api/v1';

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
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  Future<bool> addTeam(String teamId) async {
    final response = await _dio.get('/favorite');

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> removeTeam(String teamId) async {
    final response = await _dio.get('/favorite');

    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<FavoriteTeam>> getFavoriteTeams() async {
    final response = await _dio.get('/favorites');

    if (response.statusCode != 200) {
      return [];
    } else {
      return response.data["data"].map((e) => FavoriteTeam.fromJson(e)).toList();
    }
  }
}
