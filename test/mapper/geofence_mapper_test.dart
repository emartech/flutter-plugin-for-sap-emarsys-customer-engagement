import 'package:emarsys_sdk/mappers/geofence_mapper.dart';
import 'package:emarsys_sdk/model/geofence_model.dart';
import 'package:emarsys_sdk/model/geofence_trigger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final GeofenceMapper mapper = GeofenceMapper();

  test('map should not crash when inputList is empty', () async {
    final List<Map<String, String>> emptyList = [];
    final List<GeofenceModel> result = mapper.map(emptyList);

    expect(result.length, 0);
  });

  test('map should not crash when inputList contains null', () async {
    final List<Map<String, dynamic>?> emptyList = [null];
    final List<GeofenceModel> result = mapper.map(emptyList);

    expect(result.length, 0);
  });

  test('map should not crash when inputList contains emptyMap', () async {
    final List<Map<String, String>> emptyList = [{}];
    final List<GeofenceModel> result = mapper.map(emptyList);

    expect(result.length, 0);
  });

  test('map should return with correct result', () async {
    Map<String, Object> fullMessageMap = {
      "id": "testId",
      "lat": 12.34,
      "lon": 56.78,
      "radius": 30.0,
      "waitInterval": 90.12
    };
    fullMessageMap["triggers"] = [
      {
        "id": "trigger1",
        "type": "Type1",
        "loiteringDelay": 123,
        "action": {
          "actionKey1": "actionValue1",
          "actionKey12": "actionValue12",
          "actionKey13": 123
        }
      },
      {
        "id": "trigger2",
        "type": "Type2",
        "loiteringDelay": 456,
        "action": {
          "actionKey2": "actionValue2",
          "actionKey22": "actionValue22",
          "actionKey23": 456
        }
      }
    ];

    GeofenceTrigger trigger1 = const GeofenceTrigger(
        id: "trigger1",
        type: "Type1",
        loiteringDelay: 123,
        action: {
          "actionKey1": "actionValue1",
          "actionKey12": "actionValue12",
          "actionKey13": 123
        });

    GeofenceTrigger trigger2 = const GeofenceTrigger(
        id: "trigger2",
        type: "Type2",
        loiteringDelay: 456,
        action: {
          "actionKey2": "actionValue2",
          "actionKey22": "actionValue22",
          "actionKey23": 456
        });

    GeofenceModel expectedMessage = GeofenceModel(
        id: "testId",
        lat: 12.34,
        lon: 56.78,
        radius: 30.0,
        waitInterval: 90.12,
        triggers: [trigger1, trigger2]);

    List<GeofenceModel> result = mapper.map([fullMessageMap]);

    expect(result[0], expectedMessage);
  });
}
