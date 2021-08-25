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

  test('enable should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.geofence.enable();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'geofence.enable');
    }
  });

  test('disable should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.geofence.disable();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'geofence.disable');
    }
  });

  test('isEnabled should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return true;
    });

    bool result = await Emarsys.geofence.isEnabled();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'geofence.isEnabled');
      expect(result, true);
    }
  });

  test('setInitialEnterTriggerEnabled should delegate to the Platform',
      () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
    });

    await Emarsys.geofence.setInitialEnterTriggerEnabled(true);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'geofence.initialEnterTriggerEnabled');
      expect(actualMethodCall!.arguments, {"enabled": true});
    }
  });
  test('iOSRequestAlwaysAuthorization should delegate to the Platform',
      () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
    });

    await Emarsys.geofence.iOSRequestAlwaysAuthorization();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(
          actualMethodCall!.method, 'geofence.ios.requestAlwaysAuthorization');
    }
  });
}
