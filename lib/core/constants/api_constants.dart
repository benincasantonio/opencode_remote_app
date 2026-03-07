class ApiConstants {
  ApiConstants._();

  static const String defaultHost = '127.0.0.1';
  static const int defaultPort = 4096;

  static String get baseUrl => 'http://$defaultHost:$defaultPort';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 10);

  static const Duration sseReconnectDelay = Duration(seconds: 3);
}
