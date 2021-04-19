
import 'dart:async';

import 'package:flutter/services.dart';

class EmarsysSdk {
  static const MethodChannel _channel =
      const MethodChannel('emarsys_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
