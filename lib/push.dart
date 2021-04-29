import 'package:flutter/services.dart';

class Push {
  final MethodChannel _channel;
  Push(this._channel);
  Future<void> setPushToken(String pushToken) {
    return _channel.invokeMethod('push.setPushToken', {"pushToken": pushToken});
  }

  Future<void> clearPushToken() {
    return _channel.invokeMethod('push.clearPushToken');
  }
}
