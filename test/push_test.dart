import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();

  test('pushSendingEnabled should delegate to the Platform', () async {
    const enable = true;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'push.pushSendingEnabled');
      expect(methodCall.arguments, {"pushSendingEnabled": enable});
      return null;
    });

    await Emarsys.push.pushSendingEnabled(enable);
  });

  test('setPushToken should delegate to the Platform', () async {
    const testPushToken = "testPushToken";
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'push.setPushToken');
      expect(methodCall.arguments, {"pushToken": testPushToken});
      return null;
    });

    await Emarsys.push.setPushToken(testPushToken);
  });

  test('setPushToken should throw error', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Test error message',
          details: 'Test detail',
          stacktrace: 'Test stacktrace');
    });

    expect(
        Emarsys.push.setPushToken(""),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Test error message')));
  });

  test('pushSendingEnabled should throw error', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Test error message',
          details: 'Test detail',
          stacktrace: 'Test stacktrace');
    });

    expect(
        Emarsys.push.pushSendingEnabled(true),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Test error message')));
  });

  test('registerAndroidNotificationChannels should delegate to platform',
      () async {
    final notificationChannel = NotificationChannel(
        id: "testId",
        name: "tesetName",
        description: "testDescription",
        importance: 1);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'push.android.registerNotificationChannels');
      expect(methodCall.arguments, {
        'notificationChannels': [notificationChannel.toMap()]
      });
      return null;
    });

    await Emarsys.push
        .registerAndroidNotificationChannels([notificationChannel]);
  });
}
