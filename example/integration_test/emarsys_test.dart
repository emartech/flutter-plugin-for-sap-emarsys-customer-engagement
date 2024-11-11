import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  const contactFieldId = 2575;

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final config = EmarsysConfig(applicationCode: "EMS11-C3FD3");
    await Emarsys.setup(config);
  });

  testWidgets("call setContact and check contactFieldId",
      (WidgetTester tester) async {
    await Emarsys.setContact(2575, "test@test.com")
        .then((value) => debugPrint("SET CONTACT"))
        .catchError((error) => expect(error, null));

    final result = await Emarsys.config.contactFieldId();
    expect(result, equals(contactFieldId));
  });

  testWidgets("call clearContact", (WidgetTester tester) async {
    await Emarsys.clearContact()
        .then((value) => debugPrint("CLEAR CONTACT"))
        .catchError((error) => expect(error, null));
  });
}
