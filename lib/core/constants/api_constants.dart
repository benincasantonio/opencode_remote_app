abstract final class ApiConstants {
  static const String defaultHost = '127.0.0.1';
  static const int defaultPort = 4096;

  static String get baseUrl => 'http://$defaultHost:$defaultPort';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 10);

  static const Duration sseReconnectDelay = Duration(seconds: 3);

  /// GET /global/health — server health and version.
  static const String healthPath = '/global/health';

  /// GET /session — list sessions.
  static const String sessionPath = '/session';

  /// GET /session/status — live status map for sessions.
  static const String sessionStatusPath = '/session/status';
}
