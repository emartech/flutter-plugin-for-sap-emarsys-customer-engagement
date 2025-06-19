import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/api/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();

  test('enable should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'geofence.enable');
      return null;
    });

    await Emarsys.geofence.enable();
  });

  test('disable should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'geofence.disable');
      return null;
    });

    await Emarsys.geofence.disable();
  });

  test('isEnabled should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'geofence.isEnabled');
      return true;
    });

    await Emarsys.geofence.isEnabled();
  });

  test('setInitialEnterTriggerEnabled should delegate to the Platform',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'geofence.initialEnterTriggerEnabled');
      return true;
    });

    await Emarsys.geofence.setInitialEnterTriggerEnabled(true);
  });

  test('iOSRequestAlwaysAuthorization should delegate to the Platform',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'geofence.ios.requestAlwaysAuthorization');
      return true;
    });

    await Emarsys.geofence.iOSRequestAlwaysAuthorization();
  });

  test('registeredGeofences should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'geofence.registeredGeofences');
      return [<String, dynamic>{}];
    });

    await Emarsys.geofence.registeredGeofences();
  });
}
