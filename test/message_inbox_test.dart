import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/api/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');
  const String _messageId = "testMessageId";
  const String _tag = "testTag";

  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });
  });

  test('fetchMessages should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      final map = <String, dynamic>{};
      return [map];
    });

    await Emarsys.messageInbox.fetchMessages();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inbox.fetchMessages');
    }
  });

  test('addTag should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return;
    });

    await Emarsys.messageInbox.addTag(_messageId, _tag);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inbox.addTag');
      expect(actualMethodCall!.arguments,
          {"messageId": "testMessageId", "tag": "testTag"});
    }
  });

  test('removeTag should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return;
    });

    await Emarsys.messageInbox.removeTag(_messageId, _tag);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inbox.removeTag');
      expect(actualMethodCall!.arguments,
          {"messageId": "testMessageId", "tag": "testTag"});
    }
  });
}
