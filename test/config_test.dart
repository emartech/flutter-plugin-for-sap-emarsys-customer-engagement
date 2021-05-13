import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/config.dart';
import 'package:emarsys_sdk/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });
  });

  test('applicationCode should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return "testApplicationCode";
    });

    String? result = await Emarsys.config.applicationCode();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.applicationCode');
      expect(result, "testApplicationCode");
    }
  });

  test('applicationCode should return null', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    String? result = await Emarsys.config.applicationCode();

    expect(result, null);
  });

  test('merchantId should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return "testMerchantId";
    });

    String? result = await Emarsys.config.merchantId();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.merchantId');
      expect(result, "testMerchantId");
    }
  });

  test('merchantId should return null', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    String? result = await Emarsys.config.merchantId();

    expect(result, null);
  });


  test('contactFieldId should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return 123456;
    });

    int result = await Emarsys.config.contactFieldId();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.contactFieldId');
      expect(result, 123456);
    }
  });

  test('contactFieldId should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.contactFieldId(),
        throwsA(isA<NullThrownError>()));
  });

  test('hardwareId should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return "testHardwareId";
    });

    String result = await Emarsys.config.hardwareId();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.hardwareId');
      expect(result, "testHardwareId");
    }
  });

  test('hardwareId should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.hardwareId(),
        throwsA(isA<NullThrownError>()));
  });

  test('languageCode should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return "testLanguage";
    });

    String result = await Emarsys.config.languageCode();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.language');
      expect(result, "testLanguage");
    }
  });

  test('languageCode should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.languageCode(),
        throwsA(isA<NullThrownError>()));
  });

  test('pushSettings should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return {
        'testKey1': 'testValue1',
        'testKey2': {}    
        };
    });

    Map<String, dynamic> result = await Emarsys.config.pushSettings();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.pushSettings');
      expect(result, {
        'testKey1': 'testValue1',
        'testKey2': {}    
        });
    }
  });

  test('pushSettings should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.pushSettings(),
        throwsA(isA<NullThrownError>()));
  });

  test('isAndroidAutomaticPushSendingEnabled should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return true;
    });

    bool result = await Emarsys.config.isAndroidAutomaticPushSendingEnabled();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.android.isAutomaticPushSendingEnabled');
      expect(result, true);
    }
  });

  test('isAndroidAutomaticPushSendingEnabled should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.isAndroidAutomaticPushSendingEnabled(),
        throwsA(isA<NullThrownError>()));
  });

  test('sdkVersion should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return "testSdkVersion";
    });

    String result = await Emarsys.config.sdkVersion();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.sdkVersion');
      expect(result, "testSdkVersion");
    }
  });

  test('sdkVersion should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.sdkVersion(),
        throwsA(isA<NullThrownError>()));
  });

}