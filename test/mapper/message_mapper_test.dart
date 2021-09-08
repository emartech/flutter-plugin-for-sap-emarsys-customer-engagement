import 'package:emarsys_sdk/mappers/message_mapper.dart';
import 'package:emarsys_sdk/model/action_model.dart';
import 'package:emarsys_sdk/model/actions/app_event_action_model.dart';
import 'package:emarsys_sdk/model/actions/custom_event_action_model.dart';
import 'package:emarsys_sdk/model/actions/open_external_url_action_model.dart';
import 'package:emarsys_sdk/model/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final MessageMapper mapper = MessageMapper();

  test('map should not crash when inputList is empty', () async {
    final List<Map<String, String>> emptyList = [];
    final List<Message> result = mapper.map(emptyList);

    expect(result.length, 0);
  });
  test('map should not crash when inputList contains null', () async {
    final List<dynamic> emptyList = [null];
    final List<Message> result = mapper.map(emptyList);

    expect(result.length, 0);
  });
  test('map should not crash when inputList contains emptyMap', () async {
    final List<Map<String, String>> emptyList = [{}];
    final List<Message> result = mapper.map(emptyList);

    expect(result.length, 0);
  });

  test('map should return with correct result', () async {
    Map<String, Object> fullMessageMap = {
      "id": "testId",
      "campaignId": "testCampaignId",
      "collapseId": "testCollapseId",
      "title": "testTitle",
      "body": "testBody",
      "imageUrl": "testImageUrl",
      "receivedAt": 1234,
      "updatedAt": 4321,
      "expiresAt": 5678
    };
    fullMessageMap["tags"] = ["TAG1", "TAG2", "TAG3"];
    fullMessageMap["properties"] = {"key1": "value1", "key2": "value2"};
    fullMessageMap["actions"] = [
      {
        "id": "actionId1",
        "title": "actionTitle1",
        "type": "MEAppEvent",
        "name": "actionName1",
        "payload": {"key11": "value", "key12": 123}
      },
      {
        "id": "actionId2",
        "title": "actionTitle2",
        "type": "MECustomEvent",
        "name": "actionName2",
        "payload": {"key21": "value", "key22": 456}
      },
      {
        "id": "actionId4",
        "title": "actionTitle4",
        "type": "OpenExternalUrl",
        "url": "https://www.emarsys.com"
      }
    ];

    ActionModel appEventAction = AppEventActionModel(
        id: "actionId1",
        title: "actionTitle1",
        type: "MEAppEvent",
        name: "actionName1",
        payload: {"key11": "value", "key12": 123});

    ActionModel customEventAction = CustomEventActionModel(
        id: "actionId2",
        title: "actionTitle2",
        type: "MECustomEvent",
        name: "actionName2",
        payload: {"key21": "value", "key22": 456});

    ActionModel openExternalUrlAction = OpenExternalUrlActionModel(
        id: "actionId4",
        title: "actionTitle4",
        type: "OpenExternalUrl",
        url: "https://www.emarsys.com");

    Message expectedMessage = Message(
        id: "testId",
        campaignId: "testCampaignId",
        collapseId: "testCollapseId",
        title: "testTitle",
        body: "testBody",
        imageUrl: "testImageUrl",
        receivedAt: 1234,
        updatedAt: 4321,
        expiresAt: 5678,
        tags: ["TAG1", "TAG2", "TAG3"],
        properties: {"key1": "value1", "key2": "value2"},
        actions: [appEventAction, customEventAction, openExternalUrlAction]);

    List<Message> result = mapper.map([fullMessageMap]);

    // expect(listEquals(result, [expectedMessage]), true);
    expect(result[0], expectedMessage);
  });
}
