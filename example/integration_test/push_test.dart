import 'package:emarsys_sdk/emarsys_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:emarsys_sdk/emarsys.dart';
import 'package:emarsys_sdk/api/notification_channel.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final config =
        EmarsysConfig(contactFieldId: 2575, applicationCode: "EMS11-C3FD3");
    await Emarsys.setup(config);
  });

  testWidgets("call pushSendingEnabled with true", (WidgetTester tester) async {
    await Emarsys.push
        .pushSendingEnabled(true)
        .catchError((error) => expect(error, null));
  });

  testWidgets("call pushSendingEnabled with false",
      (WidgetTester tester) async {
    await Emarsys.push
        .pushSendingEnabled(false)
        .catchError((error) => expect(error, null));
  });

  testWidgets("call registerNotificationChannels", (WidgetTester tester) async {
    await Emarsys.push.registerAndroidNotificationChannels([
      NotificationChannel(
          id: "ems_sample_news",
          name: "News",
          description: "News and updates go into this channel",
          importance: NotificationChannel.IMPORTANCE_HIGH),
      NotificationChannel(
          id: "ems_sample_messages",
          name: "Messages",
          description: "Important messages go into this channel",
          importance: NotificationChannel.IMPORTANCE_HIGH),
    ]).catchError((error) => expect(error, null));
  });
}
