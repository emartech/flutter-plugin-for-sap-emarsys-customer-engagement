import 'dart:io';
import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MobileEngageScreen extends StatefulWidget {
  const MobileEngageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MobileEngageScreenState();
}

class _MobileEngageScreenState extends State<MobileEngageScreen> {
  bool _isPushEnabled = true;
  bool _isGeofenceEnabled = false;
  TextEditingController _customEventNameController = TextEditingController();
  TextEditingController _customEventPayloadController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _togglePushEnabled(bool value) async {
    setState(() {
      _isPushEnabled = value;
    });
    Emarsys.push.pushSendingEnabled(value);

    if (value) {
      await Permission.notification.request();
    }
  }

  Future<void> _toggleGeofenceEnabled(bool value) async {
    setState(() {
      _isGeofenceEnabled = value;
    });

    if (value) {
      if (Platform.isIOS) {
        await Emarsys.geofence.iOSRequestAlwaysAuthorization();
      } else {
        await Permission.location.request();
        await Permission.locationAlways.request();
      }
      Emarsys.geofence.enable();
    } else {
      Emarsys.geofence.disable();
    }
  }

  Future<void> _trackCustomEvent() async {
    String eventName = _customEventNameController.text;
    String eventPayload = _customEventPayloadController.text;

    if (eventName.isNotEmpty) {
      await Emarsys.trackCustomEvent(
          eventName, _convertTextToMap(eventPayload));
      _showSnackbar("Custom event tracked: $eventName");
      setState(() {
        _customEventNameController.clear();
        _customEventPayloadController.clear();
      });
    } else {
      _showSnackbar("Please enter an event name.");
    }
  }

  Map<String, String>? _convertTextToMap(String? text) {
    if (text == null || text.isEmpty) return null;
    return {text: text};
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPushNotificationSwitch(),
          const SizedBox(height: 16),
          _buildGeofenceSwitch(),
          const SizedBox(height: 16),
          _buildCustomEventSection(),
          const SizedBox(height: 16),
          _buildInlineInAppSection(),
        ],
      ),
    ));
  }

  Widget _buildPushNotificationSwitch() {
    return SwitchListTile(
      title: const Text("Push Sending Enabled"),
      value: _isPushEnabled,
      onChanged: _togglePushEnabled,
    );
  }

  Widget _buildGeofenceSwitch() {
    return SwitchListTile(
      title: const Text("Geofence Enabled"),
      value: _isGeofenceEnabled,
      onChanged: _toggleGeofenceEnabled,
    );
  }

  Widget _buildCustomEventSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Track Custom Event",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _customEventNameController,
              decoration: const InputDecoration(labelText: "Event Name"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _customEventPayloadController,
              decoration: const InputDecoration(labelText: "Event Payload"),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _trackCustomEvent,
              child: const Text("Track Event"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineInAppSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Inline In-App",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: InlineInAppView(
                viewId: "ia",
                onAppEvent: (event) {
                  debugPrint("In-App Event: ${event.name} - ${event.payload}");
                },
                onCompleted: () {
                  _showSnackbar("Inline In-App View Loaded");
                },
                onClose: () {
                  _showSnackbar("Inline In-App View Closed");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
