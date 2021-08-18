import 'package:flutter/services.dart';
import 'package:emarsys_sdk/model/notification_channel.dart';
import 'package:emarsys_sdk/model/event.dart';

class Push {
  final MethodChannel _channel;
  final Stream<Event> pushEventStream;
  final Stream<Event> silentPushEventStream;

  Push(this._channel, EventChannel _pushEventChannel,
      EventChannel _silentPushEventChannel)
      : pushEventStream = _pushEventChannel.receiveBroadcastStream().map(
            (event) => Event(
                name: event["name"],
                payload: Map<String, dynamic>.from(event["payload"]))),
        silentPushEventStream = _silentPushEventChannel
            .receiveBroadcastStream()
            .map((event) => Event(
                name: event["name"],
                payload: Map<String, dynamic>.from(event["payload"])));

  Future<void> pushSendingEnabled(bool enable) {
    return _channel.invokeMethod(
        'push.pushSendingEnabled', {'pushSendingEnabled': enable});
  }

  Future<void> registerAndroidNotificationChannels(
      List<NotificationChannel> notificationChannels) {
    return _channel.invokeMethod('push.android.registerNotificationChannels', {
      'notificationChannels':
          notificationChannels.map((channel) => channel.toMap()).toList()
    });
  }
}
