import 'package:flutter/foundation.dart';

enum ConsoleLogLevels {
  BASIC,
  DEBUG,
  WARN,
  ERROR,
  INFO,
  TRACE
}

class EmarsysConfig {
  final String? applicationCode;
  final String? merchantId;
  final int contactFieldId;
  final bool? androidVerboseConsoleLoggingEnabled;
  final String? androidSharedSecret;
  final List<String>? androidSharedPackageNames;
  final List<ConsoleLogLevels>? iOSEnabledConsoleLogLevels;
  EmarsysConfig(
      {required this.contactFieldId,
      this.applicationCode,
      this.merchantId,
      this.androidVerboseConsoleLoggingEnabled,
      this.androidSharedSecret,
      this.androidSharedPackageNames,
      this.iOSEnabledConsoleLogLevels});

  Map<String, dynamic> toMap() {
    return {
      'applicationCode': applicationCode,
      'merchantId': merchantId,
      'contactFieldId': contactFieldId,
      'androidVerboseConsoleLoggingEnabled':
          androidVerboseConsoleLoggingEnabled,
      'androidSharedSecret': androidSharedSecret,
      'androidSharedPackageNames': androidSharedPackageNames,
      'iOSEnabledConsoleLogLevels': iOSEnabledConsoleLogLevels?.map((logLevel) => describeEnum(logLevel)).toList()
    };
  }
}
