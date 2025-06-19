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
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('changeApplicationCode should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.changeApplicationCode');
      expect(methodCall.arguments, {"applicationCode": "testApplicationCode"});
      return "testApplicationCode";
    });

    await Emarsys.config.changeApplicationCode("testApplicationCode");
  });

  test('changeMerchantId should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.changeMerchantId');
      expect(methodCall.arguments, {"merchantId": "testMerchantId"});
      return "testMerchantId";
    });

    await Emarsys.config.changeMerchantId("testMerchantId");
  });

  test('applicationCode should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.applicationCode');
      return "testApplicationCode";
    });

    await Emarsys.config.applicationCode();
  });

  test('applicationCode should return null', () async {
    String? result = await Emarsys.config.applicationCode();

    expect(result, null);
  });

  test('merchantId should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.merchantId');
      return "testMerchantId";
    });

    await Emarsys.config.merchantId();
  });

  test('merchantId should return null', () async {
    String? result = await Emarsys.config.merchantId();

    expect(result, null);
  });

  test('contactFieldId should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.contactFieldId');
      return 123456;
    });

    await Emarsys.config.contactFieldId();
  });

  test('hardwareId should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.hardwareId');
      return "testHardwareId";
    });

    await Emarsys.config.hardwareId();
  });

  test('hardwareId should throw error', () async {
    expect(Emarsys.config.hardwareId(), throwsA(isA<TypeError>()));
  });

  test('languageCode should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.languageCode');
      return "testLanguage";
    });

    await Emarsys.config.languageCode();
  });

  test('languageCode should throw error', () async {
    expect(Emarsys.config.languageCode(), throwsA(isA<TypeError>()));
  });

  test('notificationSettings should retrieve the correct NotificationSettings',
      () async {
    MethodCall? actualMethodCall;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      actualMethodCall = methodCall;
      return {
        "android": {
          'areNotificationsEnabled': true,
          'importance': 1,
          "channelSettings": [
            {
              "channelId": "testChannelId",
              "importance": 1000,
              "isCanBypassDnd": false,
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
          'showPreviewsSetting': 'testShowPreviewsSetting',
          'criticalAlertSetting': 'testCriticalAlertSetting',
          'providesAppNotificationSettings': false,
          'timeSensitiveSetting': "testTimeSensitiveSetting",
          'scheduledDeliverySetting': "testScheduledDeliverySetting"
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
                        isCanBypassDnd: false,
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
                  showPreviewsSetting: 'testShowPreviewsSetting',
                  soundSetting: 'testSoundSetting',
                  criticalAlertSetting: 'testCriticalAlertSetting',
                  providesAppNotificationSettings: false,
                  timeSensitiveSetting: "testTimeSensitiveSetting",
                  scheduledDeliverySetting: "testScheduledDeliverySetting")));
    }
  });

  test('notificationSettings should throw error', () async {
    expect(Emarsys.config.notificationSettings(), throwsA(isA<TypeError>()));
  });

  test('sdkVersion should delegate to the Platform', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'config.sdkVersion');
      return "testSdkVersion";
    });

    await Emarsys.config.sdkVersion();
  });

  test('sdkVersion should throw error', () async {
    expect(Emarsys.config.sdkVersion(), throwsA(isA<TypeError>()));
  });
}
