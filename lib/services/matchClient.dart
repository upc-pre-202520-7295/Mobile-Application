import 'package:dio/dio.dart';

import '../domain/Match.dart';

final String baseUrl = 'localhost:8080/api/v1';

class MatchClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  MatchClient() {
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

  Future<List<MatchGame>> getPredictions() async {
    final response = await _dio.get('/predictions');

    if (response.statusCode != 200) {
      return [];
    } else {
      return response.data["data"].map((e) => MatchGame.fromJson(e)).toList();
    }
  }
}
