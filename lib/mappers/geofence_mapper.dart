import 'package:emarsys_sdk/mappers/mapper.dart';
import 'package:emarsys_sdk/model/geofence_model.dart';
import 'package:emarsys_sdk/model/geofence_trigger.dart';

class GeofenceMapper
    extends Mapper<List<Map<String, dynamic>?>, List<GeofenceModel>> {
  @override
  List<GeofenceModel> map(List<Map<String, dynamic>?> input) {
    return input
        .where((element) => element != null && element.isNotEmpty)
        .map((geofenceMap) => GeofenceModel(
            id: geofenceMap!["id"] as String,
            lat: geofenceMap["lat"] as double,
            lon: geofenceMap["lon"] as double,
            radius: geofenceMap["radius"] as double,
            waitInterval: geofenceMap["waitInterval"] as double?,
            triggers: mapTriggers(geofenceMap["triggers"])))
        .toList();
  }

  List<GeofenceTrigger> mapTriggers(List<dynamic> input) {
    return input.map((triggerMap) {
      final action = triggerMap["action"];
      return GeofenceTrigger(
          id: triggerMap["id"] as String,
          type: triggerMap["type"] as String,
          loiteringDelay: triggerMap["loiteringDelay"] as int,
          action: action == null ? null : Map<String, dynamic>.from(action));
    }).toList();
  }
}
