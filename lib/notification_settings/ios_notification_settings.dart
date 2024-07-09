class IOSNotificationSettings {
  String authorizationStatus;
  String soundSetting;
  String badgeSetting;
  String notificationCenterSetting;
  String lockScreenSetting;
  String carPlaySetting;
  String alertStyle;
  String showPreviewsSetting;
  String? criticalAlertSetting;
  bool? providesAppNotificationSettings;
  String? scheduledDeliverySetting;
  String? timeSensitiveSetting;
  IOSNotificationSettings(
      {required this.authorizationStatus,
      required this.soundSetting,
      required this.badgeSetting,
      required this.notificationCenterSetting,
      required this.lockScreenSetting,
      required this.carPlaySetting,
      required this.alertStyle,
      required this.showPreviewsSetting,
      this.criticalAlertSetting,
      this.providesAppNotificationSettings,
      this.scheduledDeliverySetting,
      this.timeSensitiveSetting});

  IOSNotificationSettings copyWith(
      {String? authorizationStatus,
      String? soundSetting,
      String? badgeSetting,
      String? notificationCenterSetting,
      String? lockScreenSetting,
      String? carPlaySetting,
      String? alertStyle,
      String? showPreviewsSetting,
      String? criticalAlertSetting,
      bool? providesAppNotificationSettings,
      String? scheduledDeliverySetting,
      String? timeSensitiveSetting}) {
    return IOSNotificationSettings(
        authorizationStatus: authorizationStatus ?? this.authorizationStatus,
        soundSetting: soundSetting ?? this.soundSetting,
        badgeSetting: badgeSetting ?? this.badgeSetting,
        notificationCenterSetting:
            notificationCenterSetting ?? this.notificationCenterSetting,
        lockScreenSetting: lockScreenSetting ?? this.lockScreenSetting,
        carPlaySetting: carPlaySetting ?? this.carPlaySetting,
        alertStyle: alertStyle ?? this.alertStyle,
        showPreviewsSetting: showPreviewsSetting ?? this.showPreviewsSetting,
        criticalAlertSetting: criticalAlertSetting ?? this.criticalAlertSetting,
        providesAppNotificationSettings: providesAppNotificationSettings ??
            this.providesAppNotificationSettings,
        scheduledDeliverySetting:
            scheduledDeliverySetting ?? this.scheduledDeliverySetting,
        timeSensitiveSetting:
            timeSensitiveSetting ?? this.timeSensitiveSetting);
  }

  factory IOSNotificationSettings.fromMap(Map<dynamic, dynamic> map) {
    return IOSNotificationSettings(
      authorizationStatus: map['authorizationStatus'],
      soundSetting: map['soundSetting'],
      badgeSetting: map['badgeSetting'],
      notificationCenterSetting: map['notificationCenterSetting'],
      lockScreenSetting: map['lockScreenSetting'],
      carPlaySetting: map['carPlaySetting'],
      alertStyle: map['alertStyle'],
      showPreviewsSetting: map['showPreviewsSetting'],
      criticalAlertSetting: map['criticalAlertSetting'],
      providesAppNotificationSettings: map['providesAppNotificationSettings'],
      scheduledDeliverySetting: map['scheduledDeliverySetting'],
      timeSensitiveSetting: map['timeSensitiveSetting'],
    );
  }

  @override
  String toString() {
    return 'IOSNotificationSettings(authorizationStatus: $authorizationStatus, soundSetting: $soundSetting, badgeSetting: $badgeSetting, notificationCenterSetting: $notificationCenterSetting, lockScreenSetting: $lockScreenSetting, carPlaySetting: $carPlaySetting, alertStyle: $alertStyle, showPreviewsSetting: $showPreviewsSetting, criticalAlertSetting: $criticalAlertSetting, providesAppNotificationSettings: $providesAppNotificationSettings, timeSensitiveSetting: $timeSensitiveSetting, scheduledDeliverySetting: $scheduledDeliverySetting)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IOSNotificationSettings &&
        other.authorizationStatus == authorizationStatus &&
        other.soundSetting == soundSetting &&
        other.badgeSetting == badgeSetting &&
        other.notificationCenterSetting == notificationCenterSetting &&
        other.lockScreenSetting == lockScreenSetting &&
        other.carPlaySetting == carPlaySetting &&
        other.alertStyle == alertStyle &&
        other.showPreviewsSetting == showPreviewsSetting &&
        other.criticalAlertSetting == criticalAlertSetting &&
        other.providesAppNotificationSettings ==
            providesAppNotificationSettings &&
        other.scheduledDeliverySetting == scheduledDeliverySetting &&
        other.timeSensitiveSetting == timeSensitiveSetting;
  }

  @override
  int get hashCode {
    return authorizationStatus.hashCode ^
        soundSetting.hashCode ^
        badgeSetting.hashCode ^
        notificationCenterSetting.hashCode ^
        lockScreenSetting.hashCode ^
        carPlaySetting.hashCode ^
        alertStyle.hashCode ^
        showPreviewsSetting.hashCode ^
        criticalAlertSetting.hashCode ^
        providesAppNotificationSettings.hashCode ^
        timeSensitiveSetting.hashCode ^
        scheduledDeliverySetting.hashCode;
  }
}
