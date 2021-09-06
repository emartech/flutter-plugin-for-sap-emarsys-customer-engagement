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

  test('pause should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });

    await Emarsys.inApp.pause();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inApp.pause');
    }
  });

  test('resume should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });

    await Emarsys.inApp.resume();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inApp.resume');
    }
  });

  test('isPaused should return true', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return true;
    });

    bool result = await Emarsys.inApp.isPaused();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'inApp.isPaused');
      expect(result, true);
    }
  });

  test('isPaused should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });
    expect(Emarsys.inApp.isPaused(), throwsA(isA<NullThrownError>()));
  });
}
