import 'dart:io';

import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk_example/inbox_messages.dart';
import 'package:emarsys_sdk_example/predict.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Emarsys.setup(EmarsysConfig(
      applicationCode: 'EMS74-EFB68',
      merchantId: "1428C8EE286EC34B",
      androidVerboseConsoleLoggingEnabled: true,
      iOSEnabledConsoleLogLevels: [
        ConsoleLogLevels.BASIC,
        ConsoleLogLevels.DEBUG,
        ConsoleLogLevels.TRACE,
        ConsoleLogLevels.INFO,
        ConsoleLogLevels.WARN,
        ConsoleLogLevels.ERROR
      ]));
  runApp(MyApp());

  Emarsys.push.registerAndroidNotificationChannels([
    NotificationChannel(
        id: "ems_sample_news",
        name: "News",
        description: "News and updates go into this channel",
        importance: NotificationChannel.IMPORTANCE_HIGH),
    NotificationChannel(
        id: "ems_sample_messages",
        name: "Messages",
        description: "Important messages go into this channel",
        importance: NotificationChannel.IMPORTANCE_HIGH),
  ]);
  Emarsys.push.pushEventStream.listen((event) {
    print(event.name);
  });
  Emarsys.push.silentPushEventStream.listen((event) {
    print(event.name);
  });
  Emarsys.geofence.geofenceEventStream.listen((event) {
    print(event.name);
  });
  Emarsys.inApp.inAppEventStream.listen((event) {
    print(event.name);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _contactFieldIdController;
  late TextEditingController _contactFieldValueController;
  late TextEditingController _appCodeFieldController;
  late TextEditingController _customEventNameFieldController;
  late TextEditingController _customEventPayloadFieldController;
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  String hardwareId = "-";
  int? contactFieldId;
  String? applicationCode;
  String? languageCode;
  String? merchantId;
  String? notificationSettings;
  String? sdkVersion;
  bool pushEnabled = true;
  late SharedPreferences prefs;
  String? contactFieldValue;
  String? customEventName;
  String? customEventPayload;
  int _currentIndex = 0;
  bool showInlineInApp = true;
  @override
  void initState() {
    super.initState();
    _contactFieldValueController = TextEditingController();
    _appCodeFieldController = TextEditingController();
    _contactFieldIdController = TextEditingController();
    _customEventNameFieldController = TextEditingController();
    _customEventPayloadFieldController = TextEditingController();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) async {
    String hardwareIdFromNative = await Emarsys.config.hardwareId();
    String? applicationCodeFromNative = await Emarsys.config.applicationCode();
    String? languageCodeFromNative = await Emarsys.config.languageCode();
    String? merchantIdFromNative = await Emarsys.config.merchantId();
    int? contactFieldIdFromNative = await Emarsys.config.contactFieldId();
    NotificationSettings notificationSettingsFromNative =
        await Emarsys.config.notificationSettings();

    String sdkVersionFromNative = await Emarsys.config.sdkVersion();
    _contactFieldValueController.text = contactFieldValue ?? "";
    _appCodeFieldController.text = applicationCodeFromNative ?? "";
    _contactFieldIdController.text =
        contactFieldId == null ? contactFieldId.toString() : "";
    setState(() {
      hardwareId = hardwareIdFromNative;
      contactFieldId = contactFieldIdFromNative;
      applicationCode = applicationCodeFromNative;
      languageCode = languageCodeFromNative;
      merchantId = merchantIdFromNative;
      notificationSettings = notificationSettingsFromNative.toString();
      sdkVersion = sdkVersionFromNative;
    });
    try {
      prefs = await SharedPreferences.getInstance();
      contactFieldValue = prefs.getString("loggedInUser");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Emarsys SDK Example'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.black87,
                  icon: Icon(Icons.home),
                  label: "Home"),
              BottomNavigationBarItem(
                  backgroundColor: Colors.black87,
                  icon: Icon(Icons.track_changes),
                  label: "Tracking"),
              BottomNavigationBarItem(
                  backgroundColor: Colors.black87,
                  icon: Icon(Icons.message),
                  label: "Inbox"),
              BottomNavigationBarItem(
                  backgroundColor: Colors.black87,
                  icon: Icon(Icons.bug_report),
                  label: "Predict"),
            ],
          ),
          body: body(_currentIndex)),
    );
  }

  Widget body(int index) {
    return [home(), tracking(), InboxMessages(), PredictView()][index];
  }

  Widget home() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _appCodeFieldController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "applicationCode"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_appCodeFieldController.text.isNotEmpty) {
                await Emarsys.config
                    .changeApplicationCode(_appCodeFieldController.text);
                setState(() {
                  applicationCode = _appCodeFieldController.text;
                  contactFieldValue = null;
                });
              } else {
                _messangerKey.currentState!.showSnackBar(
                    SnackBar(content: Text('Fill the textField')));
              }
            },
            child: Text("changeAppCode"),
          ),
          TextField(
            controller: _contactFieldIdController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "contactFieldId"),
          ),
          TextField(
            controller: _contactFieldValueController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "contactFieldValue"),
          ),
          if (contactFieldValue == null)
            ElevatedButton(
              onPressed: () {
                if (_contactFieldIdController.text.isNotEmpty &&
                    _contactFieldValueController.text.isNotEmpty) {
                  Emarsys.setContact(int.parse(_contactFieldIdController.text),
                      _contactFieldValueController.text);
                  setState(() {
                    contactFieldId = int.parse(_contactFieldIdController.text);
                    prefs.setInt("contactFieldId",
                        int.parse(_contactFieldIdController.text));
                    contactFieldValue = _contactFieldValueController.text;
                    prefs.setString(
                        "loggedInUser", _contactFieldValueController.text);
                  });
                } else {
                  _messangerKey.currentState!.showSnackBar(
                      SnackBar(content: Text('Something went wrong...')));
                }
              },
              child: Text("Login"),
            )
          else
            ElevatedButton(
              onPressed: () {
                _contactFieldValueController.text = "";
                Emarsys.clearContact();
                setState(() {
                  prefs.remove("loggedInUser");
                  contactFieldValue = null;
                });
              },
              child: Text("Logout"),
            ),
        ]),
      ),
    );
  }

  Widget tracking() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Table(
                  children: [
                    TableRow(
                      children: [Text("hardwareId"), Text(hardwareId)],
                    ),
                    TableRow(
                      children: [
                        Text("ApplicationCode"),
                        Text(applicationCode ?? "-")
                      ],
                    ),
                    TableRow(
                      children: [Text("MerchantId"), Text(merchantId ?? "-")],
                    ),
                    TableRow(
                      children: [
                        Text("ContactFieldId"),
                        Text(contactFieldId.toString())
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("languageCode"),
                        Text(languageCode ?? "-")
                      ],
                    ),
                    TableRow(
                      children: [Text("sdkVersion"), Text(sdkVersion ?? "-")],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text("Push sending enabled"),
              Switch(
                  value: pushEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      pushEnabled = newValue;
                    });
                    Emarsys.push.pushSendingEnabled(pushEnabled);
                  })
            ],
          ),
          TextField(
            controller: _customEventNameFieldController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "customEvent name"),
          ),
          TextField(
            maxLines: 3,
            controller: _customEventPayloadFieldController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "customEvent payload"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_customEventNameFieldController.text.isNotEmpty) {
                await Emarsys.trackCustomEvent(
                    _customEventNameFieldController.text,
                    convertTextToMap(_customEventPayloadFieldController.text));
                setState(() {
                  customEventName = _customEventNameFieldController.text;
                  customEventPayload = _customEventPayloadFieldController.text;
                });
              } else {
                _messangerKey.currentState!.showSnackBar(
                    SnackBar(content: Text('Fill customEventName')));
              }
            },
            child: Text("customEvent"),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text("Geofence",
                    style: TextStyle(fontWeight: FontWeight.w500))),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    if (Platform.isIOS) {
                      await Emarsys.geofence.iOSRequestAlwaysAuthorization();
                    } else {
                      await Permission.location.request();
                      await Permission.locationAlways.request();
                      await Permission.locationWhenInUse.request();
                    }
                    Emarsys.geofence.enable();
                  },
                  child: Text("Enable Geofence")),
              ElevatedButton(
                  onPressed: () async {
                    Emarsys.geofence.disable();
                  },
                  child: Text("Disable Geofence")),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          if (showInlineInApp)
            Card(
              child: SizedBox(
                height: 100,
                child: InlineInAppView(
                  viewId: "ia",
                  onAppEvent: (event) {
                    print("eventName: ${event.name}, payload:${event.payload}");
                  },
                  onCompleted: () {
                    print("in-app view has been loaded.");
                  },
                  onClose: () {
                    setState(() {
                      showInlineInApp = false;
                    });
                  },
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

Map<String, String>? convertTextToMap(String? text) {
  Map<String, String>? result;
  if (text != null && text.isNotEmpty) {
    result = json.decode(text);
  }
  return result;
}
