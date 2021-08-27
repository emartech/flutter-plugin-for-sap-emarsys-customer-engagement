import 'package:emarsys_sdk/model/event.dart';
import 'package:flutter/services.dart';

class Geofence {
  final MethodChannel _channel;
  final Stream<Event> geofenceEventStream;

  Geofence(this._channel, EventChannel _geofenceEventChannel)
      : geofenceEventStream = _geofenceEventChannel
            .receiveBroadcastStream()
            .map((event) => Event(
                name: event["name"],
                payload: Map<String, dynamic>.from(event["payload"])));

  Future<void> enable() {
    return _channel.invokeMethod('geofence.enable');
  }

  Future<void> disable() {
    return _channel.invokeMethod('geofence.disable');
  }

  Future<void> setInitialEnterTriggerEnabled(bool enabled) {
    return _channel.invokeMethod(
        'geofence.initialEnterTriggerEnabled', {'enabled': enabled});
  }

  Future<void> iOSRequestAlwaysAuthorization() {
    return _channel.invokeMethod('geofence.ios.requestAlwaysAuthorization');
  }

  Future<bool> isEnabled() async {
    bool? result = await _channel.invokeMethod('geofence.isEnabled');
    if (result == null) {
      throw NullThrownError();
    }
    return result;
  }
}
