import 'dart:async';
import 'dart:ui';
import 'package:emarsys_sdk/push.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'emarsys_config.dart';
import 'config.dart';
typedef _GetCallbackHandle = CallbackHandle? Function(Function callback);
const MethodChannel _channel = const MethodChannel('com.emarsys.methods');
class Emarsys {
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
  static _GetCallbackHandle _getCallbackHandle =
      (Function callback) => PluginUtilities.getCallbackHandle(callback);
  static initialize() async {
    final handle = _getCallbackHandle(_callbackDispatcher);
    if (handle == null) {
      return false;
    }
    final r = await _channel
        .invokeMethod<bool>('android.initialize', {'callback': handle.toRawHandle()});
    return r ?? false;
  }
}
Future<void> _callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();
  const MethodChannel _backgroundChannel =
      MethodChannel('com.emarsys.background');
  _backgroundChannel.setMethodCallHandler((MethodCall call) async {
    final List<dynamic> args = call.arguments;
    final handle = CallbackHandle.fromRawHandle(args[0]);
    final Function closure = PluginUtilities.getCallbackFromHandle(handle)!;
    closure();
  });
  _backgroundChannel.invokeMethod('android.setupFromCache');
}