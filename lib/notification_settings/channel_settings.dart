class ChannelSettings {
  String channelId;
  int importance = -1000;
  bool isCanBypassDns = false;
  bool isCanShowBadge = false;
  bool isShouldVibrate = false;
  bool isShouldShowLights = false;
  ChannelSettings({
    required this.channelId,
    required this.importance,
    required this.isCanBypassDns,
    required this.isCanShowBadge,
    required this.isShouldVibrate,
    required this.isShouldShowLights,
  });

  ChannelSettings copyWith({
    String? channelId,
    int? importance,
    bool? isCanBypassDns,
    bool? isCanShowBadge,
    bool? isShouldVibrate,
    bool? isShouldShowLights,
  }) {
    return ChannelSettings(
      channelId: channelId ?? this.channelId,
      importance: importance ?? this.importance,
      isCanBypassDns: isCanBypassDns ?? this.isCanBypassDns,
      isCanShowBadge: isCanShowBadge ?? this.isCanShowBadge,
      isShouldVibrate: isShouldVibrate ?? this.isShouldVibrate,
      isShouldShowLights: isShouldShowLights ?? this.isShouldShowLights,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'channelId': channelId,
      'importance': importance,
      'isCanBypassDns': isCanBypassDns,
      'isCanShowBadge': isCanShowBadge,
      'isShouldVibrate': isShouldVibrate,
      'isShouldShowLights': isShouldShowLights,
    };
  }

  factory ChannelSettings.fromMap(Map<dynamic, dynamic> map) {
    return ChannelSettings(
      channelId: map['channelId'],
      importance: map['importance'],
      isCanBypassDns: map['isCanBypassDns'],
      isCanShowBadge: map['isCanShowBadge'],
      isShouldVibrate: map['isShouldVibrate'],
      isShouldShowLights: map['isShouldShowLights'],
    );
  }

  @override
  String toString() {
    return 'ChannelSettings(channelId: $channelId, importance: $importance, isCanBypassDns: $isCanBypassDns, isCanShowBadge: $isCanShowBadge, isShouldVibrate: $isShouldVibrate, isShouldShowLights: $isShouldShowLights)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChannelSettings &&
        other.channelId == channelId &&
        other.importance == importance &&
        other.isCanBypassDns == isCanBypassDns &&
        other.isCanShowBadge == isCanShowBadge &&
        other.isShouldVibrate == isShouldVibrate &&
        other.isShouldShowLights == isShouldShowLights;
  }

  @override
  int get hashCode {
    return channelId.hashCode ^
        importance.hashCode ^
        isCanBypassDns.hashCode ^
        isCanShowBadge.hashCode ^
        isShouldVibrate.hashCode ^
        isShouldShowLights.hashCode;
  }
}
