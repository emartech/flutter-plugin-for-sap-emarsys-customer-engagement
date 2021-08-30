import 'package:emarsys_sdk/model/action_model.dart';
import 'package:emarsys_sdk/model/actions/app_event_action_model.dart';
import 'package:emarsys_sdk/model/actions/custom_event_action_model.dart';
import 'package:emarsys_sdk/model/actions/open_external_url_action_model.dart';
import 'package:emarsys_sdk/model/message.dart';

class MessageMapper {
  List<Message> map(List<dynamic> input) {
    return input
        .where((element) => element != null && (element as Map).isNotEmpty)
        .map((messageMap) => Message(
            id: messageMap["id"] as String,
            campaignId: messageMap["campaignId"] as String,
            collapseId: messageMap["collapseId"] as String?,
            title: messageMap["title"] as String,
            body: messageMap["body"] as String,
            imageUrl: messageMap["imageUrl"] as String?,
            receivedAt: messageMap["receivedAt"] as int,
            updatedAt: messageMap["updatedAt"] as int?,
            expiresAt: messageMap["expiresAt"] as int?,
            properties: Map<String, String>.from(messageMap["properties"]),
            tags: List<String>.from(messageMap["tags"]),
            actions: mapActions(
                messageMap["actions"] as List<Map<String, Object>>?)))
        .toList();
  }

  List<ActionModel>? mapActions(List<Map<String, Object>>? actionList) {
    if (actionList == null) {
      return null;
    }
    return List.from(actionList
        .map((actionMap) => actionFromMap(actionMap))
        .where((element) => element != null)
        .toList());
  }

  ActionModel? actionFromMap(Map<String, Object> actionMap) {
    String type = actionMap["type"] as String;
    switch (type) {
      case "MEAppEvent":
        return AppEventActionModel(
            id: actionMap["id"] as String,
            title: actionMap["title"] as String,
            type: actionMap["type"] as String,
            name: actionMap["name"] as String,
            payload: actionMap["payload"] as Map<String, Object>);
      case "MECustomEvent":
        return CustomEventActionModel(
            id: actionMap["id"] as String,
            title: actionMap["title"] as String,
            type: actionMap["type"] as String,
            name: actionMap["name"] as String,
            payload: actionMap["payload"] as Map<String, Object>);
      case "OpenExternalUrl":
        return OpenExternalUrlActionModel(
            id: actionMap["id"] as String,
            title: actionMap["title"] as String,
            type: actionMap["type"] as String,
            url: actionMap["url"] as String);
      default:
        return null;
    }
  }
}
