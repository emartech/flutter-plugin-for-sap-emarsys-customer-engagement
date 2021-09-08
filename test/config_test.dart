import 'package:emarsys_sdk/notification_settings/android_notification_settings.dart';
import 'package:emarsys_sdk/notification_settings/channel_settings.dart';
import 'package:emarsys_sdk/notification_settings/ios_notification_settings.dart';
import 'package:emarsys_sdk/notification_settings/notification_settings.dart';
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

  test('changeApplicationCode should delegate to the Platform', () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return "testApplicationCode";
    });

    await Emarsys.config.changeApplicationCode("testApplicationCode");

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.changeApplicationCode');
      expect(actualMethodCall!.arguments,
          {"applicationCode": "testApplicationCode"});
    }
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

    int? result = await Emarsys.config.contactFieldId();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.contactFieldId');
      expect(result, 123456);
    }
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

    expect(Emarsys.config.hardwareId(), throwsA(isA<NullThrownError>()));
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
      expect(actualMethodCall!.method, 'config.languageCode');
      expect(result, "testLanguage");
    }
  });

  test('languageCode should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(Emarsys.config.languageCode(), throwsA(isA<NullThrownError>()));
  });

  test('notificationSettings should retrieve the correct NotificationSettings',
      () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return {
        "android": {
          'areNotificationsEnabled': true,
          'importance': 1,
          "channelSettings": [
            {
              "channelId": "testChannelId",
              "importance": 1000,
              "isCanBypassDns": false,
              "isCanShowBadge": false,
              "isShouldVibrate": false,
              "isShouldShowLights": false
            }
          ]
        },
        "iOS": {
          'authorizationStatus': 'testAuthorizationStatus',
          'soundSetting': 'testSoundSetting',
          'badgeSetting': 'testBadgeSetting',
          'notificationCenterSetting': 'testNotificationCenterSetting',
          'lockScreenSetting': 'testLockScreenSetting',
          'carPlaySetting': 'testCarPlaySetting',
          'alertStyle': 'testAlertStyle',
          'showPreviewSetting': 'testShowPreviewSetting',
          'criticalAlertSetting': 'testCriticalAlertSetting',
          'providesAppNotificationSettings': false
        }
      };
    });

    NotificationSettings result = await Emarsys.config.notificationSettings();

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'config.notificationSettings');
      expect(
          result,
          NotificationSettings(
              android: AndroidNotificationSettings(
                  areNotificationsEnabled: true,
                  importance: 1,
                  channelSettings: [
                    ChannelSettings(
                        channelId: "testChannelId",
                        importance: 1000,
                        isCanBypassDns: false,
                        isCanShowBadge: false,
                        isShouldVibrate: false,
                        isShouldShowLights: false)
                  ]),
              iOS: IOSNotificationSettings(
                  authorizationStatus: 'testAuthorizationStatus',
                  alertStyle: 'testAlertStyle',
                  badgeSetting: 'testBadgeSetting',
                  carPlaySetting: 'testCarPlaySetting',
                  lockScreenSetting: 'testLockScreenSetting',
                  notificationCenterSetting: 'testNotificationCenterSetting',
                  showPreviewSetting: 'testShowPreviewSetting',
                  soundSetting: 'testSoundSetting',
                  criticalAlertSetting: 'testCriticalAlertSetting',
                  providesAppNotificationSettings: false)));
    }
  });

  test('notificationSettings should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    expect(
        Emarsys.config.notificationSettings(), throwsA(isA<NullThrownError>()));
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

    expect(Emarsys.config.sdkVersion(), throwsA(isA<NullThrownError>()));
  });
}
