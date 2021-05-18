import 'package:flutter/services.dart';

class Push {
  final MethodChannel _channel;
  Push(this._channel);

  Future<void> pushSendingEnabled(bool enable) {
    return _channel.invokeMethod('push.pushSendingEnabled', {'pushSendingEnabled': enable});
  }

}
