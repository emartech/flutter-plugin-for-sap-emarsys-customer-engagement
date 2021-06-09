import 'package:flutter/foundation.dart';

import 'package:emarsys_sdk/notification_settings/channel_settings.dart';

class AndroidNotificationSettings {
  bool areNotificationsEnabled;
  int importance;
  List<ChannelSettings> channelSettings;
  AndroidNotificationSettings({
    required this.areNotificationsEnabled,
    required this.importance,
    required this.channelSettings,
  });

  AndroidNotificationSettings copyWith({
    bool? areNotificationsEnabled,
    int? importance,
    List<ChannelSettings>? channelSettings,
  }) {
    return AndroidNotificationSettings(
      areNotificationsEnabled:
          areNotificationsEnabled ?? this.areNotificationsEnabled,
      importance: importance ?? this.importance,
      channelSettings: channelSettings ?? this.channelSettings,
    );
  }

  factory AndroidNotificationSettings.fromMap(Map<dynamic, dynamic> map) {
    return AndroidNotificationSettings(
      areNotificationsEnabled: map['areNotificationsEnabled'],
      importance: map['importance'],
      channelSettings: List<ChannelSettings>.from(
          map['channelSettings']?.map((x) => ChannelSettings.fromMap(x))),
    );
  }

  @override
  String toString() =>
      'AndroidNotificationSettings(areNotificationsEnabled: $areNotificationsEnabled, importance: $importance, channelSettings: $channelSettings)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AndroidNotificationSettings &&
        other.areNotificationsEnabled == areNotificationsEnabled &&
        other.importance == importance &&
        listEquals(other.channelSettings, channelSettings);
  }

  @override
  int get hashCode =>
      areNotificationsEnabled.hashCode ^
      importance.hashCode ^
      channelSettings.hashCode;
}
