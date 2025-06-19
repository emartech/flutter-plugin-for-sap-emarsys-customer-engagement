import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/api/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');
  const String messageId = "testMessageId";
  const String tag = "testTag";

  TestWidgetsFlutterBinding.ensureInitialized();


  test('fetchMessages should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel, (MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return [<String, dynamic>{}];
    });

    await Emarsys.messageInbox.fetchMessages();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inbox.fetchMessages');
    }
  });

  test('addTag should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel, (MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return;
    });
    
    await Emarsys.messageInbox.addTag(messageId, tag);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inbox.addTag');
      expect(actualMethodCall!.arguments,
          {"messageId": "testMessageId", "tag": "testTag"});
    }
  });

  test('removeTag should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        channel, (MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return;
    });

    await Emarsys.messageInbox.removeTag(messageId, tag);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inbox.removeTag');
      expect(actualMethodCall!.arguments,
          {"messageId": "testMessageId", "tag": "testTag"});
    }
  });
}
