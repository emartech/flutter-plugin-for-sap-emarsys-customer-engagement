import 'package:emarsys_sdk/emarsys_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:emarsys_sdk/emarsys.dart';

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
}
