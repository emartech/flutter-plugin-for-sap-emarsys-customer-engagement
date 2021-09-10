import 'package:emarsys_sdk/model/event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class InlineInAppView extends StatelessWidget {
  final String viewId;
  final Function(Event)? onAppEvent;
  final Function? onCompleted;
  final Function? onClose;
  final bool androidUseVirtualDisplay;
  final String viewType = "inlineInAppView";
  final Map<String, String> creationParams;
  InlineInAppView(
      {Key? key,
      required this.viewId,
      this.androidUseVirtualDisplay = false,
      this.onAppEvent,
      this.onCompleted,
      this.onClose})
      : creationParams = {
          "viewId": viewId,
        },
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (androidUseVirtualDisplay) {
          return buildAndroidVirtualDisplay();
        } else {
          return buildAndroidHybridDisplay();
        }
      case TargetPlatform.iOS:
        return buildIOSDisplay();
    default: 
        throw UnsupportedError("Unsupported platform view");
    }
  }

  buildAndroidVirtualDisplay() {
    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  buildAndroidHybridDisplay() {
    return PlatformViewLink(
        viewType: viewType,
        surfaceFactory:
            (BuildContext context, PlatformViewController controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (PlatformViewCreationParams params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: StandardMessageCodec(),
          )
            ..addOnPlatformViewCreatedListener((id) {
              _onPlatformViewCreated(id);
            })
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        });
  }

  buildIOSDisplay() {
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  void _onPlatformViewCreated(int id) {
    _registerOnCloseListener(id);
    _registerOnCompletedListener(id);
    _registerOnAppEventListener(id);
  }

  void _registerOnCloseListener(id) {
    EventChannel? eventChannel = EventChannel("inlineInAppViewOnClose$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      onClose?.call();
    });
  }

  void _registerOnCompletedListener(id) {
    EventChannel? eventChannel = EventChannel("inlineInAppViewOnCompleted$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      onCompleted?.call();
    });
  }

  void _registerOnAppEventListener(id) {
    EventChannel? eventChannel = EventChannel("inlineInAppViewOnAppEvent$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      onAppEvent?.call(Event(
          name: event["name"],
          payload: Map<String, dynamic>.from(event["payload"])));
    });
  }
}
