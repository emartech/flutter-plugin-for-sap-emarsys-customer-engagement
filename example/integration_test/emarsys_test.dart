import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final config = EmarsysConfig(applicationCode: "EMS11-C3FD3");
    await Emarsys.setup(config);
  });

  testWidgets("call setContact", (WidgetTester tester) async {
    await Emarsys.setContact(2575, "test@test.com")
        .then((value) => print("SET CONTACT"))
        .catchError((error) => expect(error, null));
  });

  testWidgets("call clearContact", (WidgetTester tester) async {
    await Emarsys.clearContact()
        .then((value) => print("CLEAR CONTACT"))
        .catchError((error) => expect(error, null));
  });
}
