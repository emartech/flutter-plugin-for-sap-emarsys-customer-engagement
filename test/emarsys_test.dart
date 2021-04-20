import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('setContact should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(code: '42', message: 'Test error message', details: 'Test detail', stacktrace: 'Test stacktrace');
    });

    expect(Emarsys.setContact('testContactFieldValue'), throwsA(
      isA<PlatformException>().having(
        (error) => error.message, 
        'message', 
        'Test error message')));
  });

  test('setContact should not throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    await Emarsys.setContact('testContactFieldValue');
  });

  test('clearContact should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(code: '42', message: 'Test error message', details: 'Test detail', stacktrace: 'Test stacktrace');
    });

    expect(Emarsys.clearContact(), throwsA(
      isA<PlatformException>().having(
        (error) => error.message, 
        'message', 
        'Test error message')));
  });

  test('clearContact should not throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    await Emarsys.clearContact();
  });
}