import 'dart:async';
import 'dart:ui';
import 'package:emarsys_sdk/api/inapp.dart';
import 'package:emarsys_sdk/api/push.dart';
import 'package:emarsys_sdk/mappers/cart_item_list_mapper.dart';
import 'package:emarsys_sdk/mappers/geofence_mapper.dart';
import 'package:emarsys_sdk/mappers/message_mapper.dart';
import 'package:emarsys_sdk/mappers/product_mapper.dart';
import 'package:emarsys_sdk/mappers/product_to_map_mapper.dart';
import 'package:emarsys_sdk/mappers/recommendation_filter_list_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import 'package:emarsys_sdk/model/emarsys_config.dart';
import 'config.dart';
import 'geofence.dart';
import 'message_inbox.dart';
import 'predict.dart';

typedef _GetCallbackHandle = CallbackHandle? Function(Function callback);
const MethodChannel _channel = MethodChannel('com.emarsys.methods');
const EventChannel _silentPushEventChannel =
    EventChannel('com.emarsys.events.silentPush');
const EventChannel _pushEventChannel = EventChannel('com.emarsys.events.push');
const EventChannel _geofenceEventChannel =
    EventChannel('com.emarsys.events.geofence');
const EventChannel _inAppEventChannel =
    EventChannel('com.emarsys.events.inApp');

class Emarsys {
  static Push push = Push(_channel, _pushEventChannel, _silentPushEventChannel);

  static InApp inApp = InApp(_channel, _inAppEventChannel);

  static Config config = Config(_channel);

  static MessageInbox messageInbox = MessageInbox(_channel, MessageMapper());

  static Geofence geofence =
      Geofence(_channel, GeofenceMapper(), _geofenceEventChannel);

  static Predict predict = Predict(
      _channel,
      ProductMapper(),
      CartItemListMapper(),
      RecommendationFilterListMapper(),
      ProductToMapMapper());

  static Future<void> setup(EmarsysConfig config) {
    Emarsys._initialize();
    return _channel.invokeMethod('setup', config.toMap());
  }

  static Future<void> setContact(int contactFieldId, String contactFieldValue) {
    return _channel.invokeMethod('setContact', {
      "contactFieldId": contactFieldId,
      "contactFieldValue": contactFieldValue
    });
  }

  static Future<void> clearContact() {
    return _channel.invokeMethod('clearContact');
  }

  static Future<void> trackCustomEvent(
      String eventName, Map<String, String>? eventAttributes) {
    Map<String, Object> attributes = <String, Object>{};
    attributes["eventName"] = eventName;
    if (eventAttributes != null) {
      attributes["eventAttributes"] = eventAttributes;
    }
    return _channel.invokeMethod('trackCustomEvent', attributes);
  }

  static final _GetCallbackHandle _getCallbackHandle =
      (Function callback) => PluginUtilities.getCallbackHandle(callback);

  static _initialize() async {
    bool? result = false;
    if (Platform.isAndroid) {
      final handle = _getCallbackHandle(_callbackDispatcher);
      if (handle == null) {
        return false;
      }
      result = await _channel.invokeMethod<bool>(
          'android.initialize', {'callbackHandle': handle.toRawHandle()});
    }
    return result ?? false;
  }
}

@pragma('vm:entry-point')
Future<void> _callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();
  const MethodChannel backgroundChannel =
      MethodChannel('com.emarsys.background');
  backgroundChannel.setMethodCallHandler((MethodCall call) async {
    final List<dynamic> args = call.arguments;
    final handle = CallbackHandle.fromRawHandle(args[0]);
    final Function closure = PluginUtilities.getCallbackFromHandle(handle)!;
    closure();
  });
  backgroundChannel.invokeMethod('android.setupFromCache');
}
