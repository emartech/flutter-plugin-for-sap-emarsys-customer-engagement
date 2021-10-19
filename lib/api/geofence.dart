import 'package:emarsys_sdk/mappers/geofence_mapper.dart';
import 'package:emarsys_sdk/model/event.dart';
import 'package:emarsys_sdk/model/geofence_model.dart';
import 'package:flutter/services.dart';

class Geofence {
  final MethodChannel _channel;
  final Stream<Event> geofenceEventStream;
  final GeofenceMapper _mapper;  

  Geofence(this._channel, GeofenceMapper this._mapper, EventChannel _geofenceEventChannel)
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

  Future<List<GeofenceModel>> registeredGeofences() async {
    List<dynamic>? geofences =
        await _channel.invokeMethod('geofence.registeredGeofences');
    if (geofences == null) {
      throw NullThrownError();
    }
    return _mapper.map(geofences);
  }
}
