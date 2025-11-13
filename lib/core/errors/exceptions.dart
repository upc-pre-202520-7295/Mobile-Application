class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Error de cache']);
}

class ServerException implements Exception{
  final String message;
  ServerException([this.message= 'Error del servidor']);
}