class EmarsysConfig {
  final String? applicationCode;
  final String? merchantId;
  final int contactFieldId;
  final bool? androidDisableAutomaticPushTokenSending;
  final bool? androidVerboseConsoleLoggingEnabled;
  EmarsysConfig(
      {this.applicationCode,
      this.merchantId,
      required this.contactFieldId,
      this.androidDisableAutomaticPushTokenSending,
      this.androidVerboseConsoleLoggingEnabled});

  Map<String, dynamic> toMap() {
    return {
      'applicationCode': applicationCode,
      'merchantId': merchantId,
      'contactFieldId': contactFieldId,
      'androidVerboseConsoleLoggingEnabled':
          androidVerboseConsoleLoggingEnabled,
      'androidDisableAutomaticPushTokenSending':
          androidDisableAutomaticPushTokenSending
    };
  }
}
