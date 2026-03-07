class AppConstants {
  AppConstants._();

  static const String appName = 'OpenCode Remote';
  static const String mdnsServiceType = '_opencode._tcp';
  static const Duration healthPollingInterval = Duration(seconds: 30);
  static const int maxReconnectAttempts = 5;

  static const String androidNotificationChannelId = 'opencode_remote_channel';
  static const String androidNotificationChannelName =
      'OpenCode Remote Notifications';
  static const String androidNotificationChannelDescription =
      'Push notifications for OpenCode Remote app';
}
