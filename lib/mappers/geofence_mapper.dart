import 'package:emarsys_sdk/mappers/mapper.dart';
import 'package:emarsys_sdk/model/geofence_model.dart';
import 'package:emarsys_sdk/model/geofence_trigger.dart';

class GeofenceMapper extends Mapper<List<GeofenceModel>, List<dynamic>> {
  
  @override
  List<GeofenceModel> map(List<dynamic> input) {
    return input
      .where((element) => element != null && (element as Map).isNotEmpty)
      .map((geofenceMap) => GeofenceModel(
        id: geofenceMap["id"] as String, 
        lat: geofenceMap["lat"] as double, 
        lon: geofenceMap["lon"] as double, 
        r: geofenceMap["r"] as int, 
        waitInterval: geofenceMap["waitInterval"] as double, 
        triggers: mapTriggers(geofenceMap["triggers"])))
      .toList();
  }

  List<GeofenceTrigger> mapTriggers(List<dynamic> input) {
    return input
      .map((triggerMap) => GeofenceTrigger(
        id: triggerMap["id"] as String,
        type: triggerMap["type"] as String,
        loiteringDelay: triggerMap["loiteringDelay"] as int,
        action: triggerMap["action"]
      ))
      .toList();
  }

}