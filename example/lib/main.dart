import 'package:emarsys_sdk/emarsys_config.dart';
import 'package:flutter/material.dart';
import 'package:emarsys_sdk/emarsys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Emarsys.initialize();
  Emarsys.setup(EmarsysConfig(
      contactFieldId: 2575,
      applicationCode: 'EMS74-EFB68'));
  Emarsys.setContact("test@test.com");
  Emarsys.push.enablePushSending(true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
