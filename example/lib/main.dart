import 'package:emarsys_sdk/api/notification_settings.dart';
import 'package:emarsys_sdk/emarsys_config.dart';
import 'package:flutter/material.dart';
import 'package:emarsys_sdk/emarsys.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Emarsys.setup(EmarsysConfig(
      contactFieldId: 2575,
      applicationCode: 'EMS74-EFB68',
      androidVerboseConsoleLoggingEnabled: true));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _contactFieldValueController;
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  late String hardwareId;
  late int contactFieldId;
  String? applicationCode;
  String? languageCode;
  String? merchantId;
  String? notificationSettings;
  String? sdkVersion;
  bool pushEnabled = true;
  late SharedPreferences prefs;
  String? contactFieldValue;
  @override
  void initState() {
    super.initState();
    _contactFieldValueController = TextEditingController();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();

    String hardwareIdFromNative = await Emarsys.config.hardwareId();
    int contactFieldIdFromNative = await Emarsys.config.contactFieldId();
    String? applicationCodeFromNative = await Emarsys.config.applicationCode();
    String? languageCodeFromNative = await Emarsys.config.languageCode();
    String? merchantIdFromNative = await Emarsys.config.merchantId();
    NotificationSettings notificationSettingsFromNative =
        await Emarsys.config.notificationSettings();
    String sdkVersionFromNative = await Emarsys.config.sdkVersion();
    contactFieldValue = prefs.getString("loggedInUser");
    _contactFieldValueController.text = contactFieldValue ?? "";
    setState(() {
      hardwareId = hardwareIdFromNative;
      contactFieldId = contactFieldIdFromNative;
      applicationCode = applicationCodeFromNative;
      languageCode = languageCodeFromNative;
      merchantId = merchantIdFromNative;
      notificationSettings = notificationSettingsFromNative.toString();
      sdkVersion = sdkVersionFromNative;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Emarsys SDK Example'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextField(
                controller: _contactFieldValueController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "contactFieldValue"),
              ),
              if (contactFieldValue == null)
                ElevatedButton(
                  onPressed: () {
                    if (_contactFieldValueController.text.isNotEmpty) {
                      Emarsys.setContact(_contactFieldValueController.text);
                      setState(() {
                        contactFieldValue = _contactFieldValueController.text;
                        prefs.setString(
                            "loggedInUser", _contactFieldValueController.text);
                      });
                    } else {
                      _messangerKey.currentState!.showSnackBar(
                          SnackBar(content: Text('C... c... c...')));
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
                          children: [
                            Text("MerchantId"),
                            Text(merchantId ?? "-")
                          ],
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
                          children: [
                            Text("sdkVersion"),
                            Text(sdkVersion ?? "-")
                          ],
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
              )
            ]),
          )),
    );
  }
}
