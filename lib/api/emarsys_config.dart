class EmarsysConfig {
  final String? applicationCode;
  final String? merchantId;
  final int contactFieldId;
  final bool? androidVerboseConsoleLoggingEnabled;
  final String? androidSharedSecret;
  final List<String>? androidSharedPackageNames;
  EmarsysConfig(
      {required this.contactFieldId,
      this.applicationCode,
      this.merchantId,
      this.androidVerboseConsoleLoggingEnabled,
      this.androidSharedSecret,
      this.androidSharedPackageNames});

  Map<String, dynamic> toMap() {
    return {
      'applicationCode': applicationCode,
      'merchantId': merchantId,
      'contactFieldId': contactFieldId,
      'androidVerboseConsoleLoggingEnabled':
          androidVerboseConsoleLoggingEnabled,
      'androidSharedSecret': androidSharedSecret,
      'androidSharedPackageNames': androidSharedPackageNames
    };
  }
}
