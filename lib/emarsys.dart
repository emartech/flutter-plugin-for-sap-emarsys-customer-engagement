import 'dart:async';
import 'package:flutter/services.dart';

import 'config.dart';

class Emarsys {
  static const MethodChannel _channel =
      const MethodChannel('com.emarsys.methods');

  static Future<void> setup(Config config) {
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
