import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/api/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');
  const String messageId = "testMessageId";
  const String tag = "testTag";

  TestWidgetsFlutterBinding.ensureInitialized();

  test('fetchMessages should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'inbox.fetchMessages');
      return [<String, dynamic>{}];
    });

    await Emarsys.messageInbox.fetchMessages();
  });

  test('addTag should delegate to the Platform', () async {
     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'inbox.addTag');
      expect(methodCall.arguments,
          {"messageId": "testMessageId", "tag": "testTag"});
    });

    await Emarsys.messageInbox.addTag(messageId, tag);
  });

  test('removeTag should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'inbox.removeTag');
      expect(methodCall.arguments,
          {"messageId": "testMessageId", "tag": "testTag"});
      return;
    });

    await Emarsys.messageInbox.removeTag(messageId, tag);
  });
}
