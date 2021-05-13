import 'dart:async';
import 'package:emarsys_sdk/push.dart';
import 'package:flutter/services.dart';

import 'emarsys_config.dart';
import 'config.dart';

class Emarsys {
  static const MethodChannel _channel =
      const MethodChannel('com.emarsys.methods');
      
  static Push push = Push(_channel);

  static Config config = Config(_channel);

  static Future<void> setup(EmarsysConfig config) {
    return _channel.invokeMethod('setup', config.toMap());
  }

  static Future<void> setContact(String contactFieldValue) {
    return _channel
        .invokeMethod('setContact', {"contactFieldValue": contactFieldValue});
  }

  static Future<void> clearContact() {
    return _channel.invokeMethod('clearContact');
  }
}
