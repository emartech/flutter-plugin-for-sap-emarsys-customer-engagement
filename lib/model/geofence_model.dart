import 'package:emarsys_sdk/model/geofence_trigger.dart';
import 'package:equatable/equatable.dart';

class GeofenceModel extends Equatable {
  final String id;
  final double lat;
  final double lon;
  final int r;
  final double waitInterval;
  final List<GeofenceTrigger> triggers;

  GeofenceModel(
      {required this.id,
      required this.lat,
      required this.lon,
      required this.r,
      required this.waitInterval,
      required this.triggers});

  @override
  List<Object?> get props => [id, lat, lon, r, waitInterval, triggers];
}
