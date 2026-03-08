/// Structured exception hierarchy for the OpenCode Remote app.
///
/// [AppException] is sealed so downstream code can use exhaustive `switch`
/// for error mapping (see `error_handler.dart`) and UI rendering.
sealed class AppException implements Exception {
  const AppException(this.message, [this.stackTrace]);

  /// Human-readable description of the error.
  final String message;

  /// Optional stack trace captured at the point of failure.
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

/// Connection refused, no internet, DNS resolution failure.
class NetworkException extends AppException {
  const NetworkException(super.message, [super.stackTrace]);
}

/// Non-auth HTTP error response (e.g. 500, 404).
class ServerException extends AppException {
  const ServerException(
    String message, {
    required this.statusCode,
    this.responseBody,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  /// HTTP status code returned by the server.
  final int statusCode;

  /// Raw response body, if available.
  final String? responseBody;
}

/// 401 / 403 responses or missing credentials.
class AuthException extends AppException {
  const AuthException(
    String message, {
    this.statusCode,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  /// HTTP status code (401 or 403), if the exception originated from a
  /// server response. `null` when the error is client-side (e.g. missing
  /// stored credentials).
  final int? statusCode;
}

/// Connect, receive, or send timeout.
class TimeoutException extends AppException {
  const TimeoutException(
    String message, {
    this.duration,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  /// The timeout duration that was exceeded, if known.
  final Duration? duration;
}

/// JSON deserialization or model parsing failure.
class ParseException extends AppException {
  const ParseException(
    String message, {
    this.source,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  /// The raw string / payload that failed to parse.
  final String? source;
}

/// Local storage read/write failure (SharedPreferences, FlutterSecureStorage).
class CacheException extends AppException {
  const CacheException(super.message, [super.stackTrace]);
}

/// SSE stream errors or unexpected disconnects.
class SseException extends AppException {
  const SseException(super.message, [super.stackTrace]);
}
