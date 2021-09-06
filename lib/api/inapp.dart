import 'package:flutter/services.dart';
import 'package:emarsys_sdk/model/event.dart';

class InApp {
  final MethodChannel _channel;
  final Stream<Event> inAppEventStream;

  InApp(this._channel, EventChannel _inAppEventChannel)
      : inAppEventStream = _inAppEventChannel.receiveBroadcastStream().map(
            (event) => Event(
                name: event["name"],
                payload: Map<String, dynamic>.from(event["payload"])));

  Future<void> pause() {
    return _channel.invokeMethod('inApp.pause');
  }

  Future<void> resume() {
    return _channel.invokeMethod('inApp.resume');
  }

  Future<bool> isPaused() async {
    bool? result = await _channel.invokeMethod('inApp.isPaused');
    if (result == null) {
      throw NullThrownError();
    }
    return result;
  }
}
