import 'dart:convert';

import 'package:dio/dio.dart';

import '../domain/Match.dart';

final String baseUrl = 'https://betalyze-tf-cjgafndmb4e4d7fx.westindia-01.azurewebsites.net/api/v1';

class MatchClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  MatchClient() {
    // _dio.interceptors.add(
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );
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

  Future<List<MatchGame>> getPredictions(String? season, String? startDate, String? endDate) async {
    var queryParams = new Map<String, String>();
    if (season != null) {
      queryParams["season"] = season;
    }

    if (startDate != null) {
      queryParams["startDate"] = startDate;
    }

    if (endDate != null) {
      queryParams["endDate"] = endDate;
    }

    print("[MatchClient.getPredictions] url: $baseUrl/predictions");
    print("[MatchClient.getPredictions] queryParams: $queryParams");

    final response = await _dio.get('/predictions', queryParameters: queryParams);

    print("[MatchClient.getPredictions] response.statusCode: ${response.statusCode}");
    print("[MatchClient.getPredictions] response.data['data'].length: ${response.data["data"].length}");

    if (response.statusCode != 200) {
      print("[MatchClient.getPredictions] No matches found");
      return [];
    } else {
      print("[MatchClient.getPredictions] Matches found");
      return (response.data["data"] as List)
       .map((item) => MatchGame.fromJson(item))
       .toList();
    }
  }
}
