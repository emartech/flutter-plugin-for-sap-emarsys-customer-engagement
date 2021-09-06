import 'package:emarsys_sdk/model/emarsys_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/api/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('push is not null', () async {
    expect(Emarsys.push != null, true);
  });

  test('inApp is not null', () async {
    expect(Emarsys.inApp != null, true);
  });

  test('setup should work', () async {
    EmarsysConfig config = EmarsysConfig(applicationCode: '');

    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      expect(methodCall.method, 'setup');
      expect(methodCall.arguments, config.toMap());
    });

    await Emarsys.setup(config);
  });

  test('setContact should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Test error message',
          details: 'Test detail',
          stacktrace: 'Test stacktrace');
    });

    expect(
        Emarsys.setContact(123, 'testContactFieldValue'),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Test error message')));
  });

  test('setContact should not throw error', () async {
    await Emarsys.setContact(123, 'testContactFieldValue');
  });

  test('clearContact should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Test error message',
          details: 'Test detail',
          stacktrace: 'Test stacktrace');
    });

    expect(
        Emarsys.clearContact(),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Test error message')));
  });

  test('clearContact should not throw error', () async {
    await Emarsys.clearContact();
  });

  test('trackCustomEvent should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Test error message',
          details: 'Test detail',
          stacktrace: 'Test stacktrace');
    });

    expect(
        Emarsys.trackCustomEvent("testEventName", null),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Test error message')));
  });

  test('trackCustomEvent should not throw error', () async {
    await Emarsys.trackCustomEvent("testEventName", null);
  });

  test('trackCustomEvent should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return;
    });

    await Emarsys.trackCustomEvent(
        "testEventName", {"key1": "value1", "key2": "value2"});

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'trackCustomEvent');
      expect(actualMethodCall!.arguments, {
        "eventName": "testEventName",
        "eventAttributes": {"key1": "value1", "key2": "value2"}
      });
    }
  });
}
