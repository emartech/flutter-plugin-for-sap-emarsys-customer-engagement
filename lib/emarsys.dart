import 'dart:async';
import 'package:flutter/services.dart';

class Emarsys {
  static const MethodChannel _channel = const MethodChannel('com.emarsys.methods');

  static Future<void> setContact(String contactFieldValue) {
      return _channel.invokeMethod('setContact');
  }

}
