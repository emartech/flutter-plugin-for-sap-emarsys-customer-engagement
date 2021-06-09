import 'dart:io';

import 'package:emarsys_sdk/notification_settings/android_notification_settings.dart';
import 'package:emarsys_sdk/notification_settings/ios_notification_settings.dart';

class NotificationSettings {
  AndroidNotificationSettings? android;
  IOSNotificationSettings? iOS;
  NotificationSettings({
    required this.android,
    required this.iOS,
  });

  NotificationSettings copyWith({
    AndroidNotificationSettings? android,
    IOSNotificationSettings? iOS,
  }) {
    return NotificationSettings(
      android: android ?? this.android,
      iOS: iOS ?? this.iOS,
    );
  }

  factory NotificationSettings.fromMap(Map<dynamic, dynamic> map) {
    var androidNotificationSettings;
    var iosNotificationSettings;
    try {
      androidNotificationSettings =
          AndroidNotificationSettings.fromMap(map['android']);
    } catch (e) {
      androidNotificationSettings = null;
    }
    try {
      iosNotificationSettings = IOSNotificationSettings.fromMap(map['iOS']);
    } catch (e) {
      iosNotificationSettings = null;
    }
    return NotificationSettings(
      android: androidNotificationSettings,
      iOS: iosNotificationSettings,
    );
  }

  @override
  String toString() => 'NotificationSettings(android: $android, iOS: $iOS)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationSettings &&
        other.android == android &&
        other.iOS == iOS;
  }

  @override
  int get hashCode => android.hashCode ^ iOS.hashCode;
}
