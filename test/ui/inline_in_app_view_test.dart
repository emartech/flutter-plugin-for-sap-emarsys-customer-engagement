import 'package:emarsys_sdk/model/event.dart';
import 'package:emarsys_sdk/ui/inline_in_app_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const platformViewId = 0;
  final onCloseChannel = MethodChannel("inlineInAppViewOnClose$platformViewId");
  final onCompletedChannel =
      MethodChannel("inlineInAppViewOnCompleted$platformViewId");
  final onAppEventChannel =
      MethodChannel("inlineInAppViewOnAppEvent$platformViewId");

  void clearMockHandlers() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(onCloseChannel, null);
    messenger.setMockMethodCallHandler(onCompletedChannel, null);
    messenger.setMockMethodCallHandler(onAppEventChannel, null);
  }

  tearDown(clearMockHandlers);

  test(
      'registerOnCloseListener should invoke onClose callback when event arrives',
      () async {
    var onCloseInvocations = 0;
    final inlineInAppView = InlineInAppView(
      viewId: 'test-view',
      onClose: () {
        onCloseInvocations += 1;
      },
    );
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
        onCloseChannel, (MethodCall call) async => null);

    inlineInAppView.registerOnCloseListener(platformViewId);
    await Future<void>.delayed(Duration.zero);
    final encodedEvent = const StandardMethodCodec()
        .encodeSuccessEnvelope(<String, String>{});
    await messenger.handlePlatformMessage(
        onCloseChannel.name, encodedEvent, (_) {});

    expect(onCloseInvocations, 1);
  });

  test(
      'registerOnCompletedListener should invoke onCompleted callback when event arrives',
      () async {
    var onCompletedInvocations = 0;
    final inlineInAppView = InlineInAppView(
      viewId: 'test-view',
      onCompleted: () {
        onCompletedInvocations += 1;
      },
    );
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
        onCompletedChannel, (MethodCall call) async => null);

    inlineInAppView.registerOnCompletedListener(platformViewId);
    await Future<void>.delayed(Duration.zero);
    final encodedEvent = const StandardMethodCodec()
        .encodeSuccessEnvelope(<String, Object>{});
    await messenger.handlePlatformMessage(
        onCompletedChannel.name, encodedEvent, (_) {});

    expect(onCompletedInvocations, 1);
  });

  test(
      'registerOnAppEventListener should invoke onAppEvent callback when event arrives',
      () async {
    Event? receivedAppEvent;
    final inlineInAppView = InlineInAppView(
      viewId: 'test-view',
      onAppEvent: (event) {
        receivedAppEvent = event;
      },
    );
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
        onAppEventChannel, (MethodCall call) async => null);

    inlineInAppView.registerOnAppEventListener(platformViewId);
    await Future<void>.delayed(Duration.zero);
    final encodedEvent =
        const StandardMethodCodec().encodeSuccessEnvelope(<String, Object>{
      "name": "purchase",
      "payload": <String, dynamic>{"productId": "abc-123"},
    });
    await messenger.handlePlatformMessage(
        onAppEventChannel.name, encodedEvent, (_) {});

    expect(receivedAppEvent?.name, "purchase");
    expect(receivedAppEvent?.payload, {"productId": "abc-123"});
  });
}
