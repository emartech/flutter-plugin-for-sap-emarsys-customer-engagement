import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk_example/screens/home_screen.dart';
import 'package:emarsys_sdk_example/screens/inbox_messages.dart';
import 'package:emarsys_sdk_example/screens/mobile_engage.dart';
import 'package:emarsys_sdk_example/screens/predict.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Emarsys.setup(EmarsysConfig(
    applicationCode: prefs.getString("appcode") ?? 'EMS74-EFB68',
    merchantId: "1428C8EE286EC34B",
    androidVerboseConsoleLoggingEnabled: true,
    androidSharedPackageNames: ["com.emarsys.sample"],
    androidSharedSecret: "secret",
    iOSEnabledConsoleLogLevels: [
      ConsoleLogLevels.BASIC,
      ConsoleLogLevels.DEBUG,
      ConsoleLogLevels.TRACE,
      ConsoleLogLevels.INFO,
      ConsoleLogLevels.WARN,
      ConsoleLogLevels.ERROR,
    ],
  ));

  Emarsys.push.registerAndroidNotificationChannels([
    NotificationChannel(
      id: "ems_sample_news",
      name: "News",
      description: "News and updates go into this channel",
      importance: NotificationChannel.IMPORTANCE_HIGH,
    ),
    NotificationChannel(
      id: "ems_sample_messages",
      name: "Messages",
      description: "Important messages go into this channel",
      importance: NotificationChannel.IMPORTANCE_HIGH,
    ),
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _initEventStreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: messengerKey,
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Tracking",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            label: "Predict",
          ),
        ],
      ),
      body: _buildBody(_currentIndex),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const MobileEngageScreen();
      case 2:
        return const InboxMessages();
      case 3:
        return const PredictView();
      default:
        return HomeScreen();
    }
  }

  void _initEventStreams() {
    Emarsys.push.pushEventStream.listen((event) {
      messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text("${event.name} - ${event.payload}")));
      print(event.name);
    });
    Emarsys.push.silentPushEventStream.listen((event) {
      messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text("${event.name} - ${event.payload}")));
      print(event.name);
    });
    Emarsys.geofence.geofenceEventStream.listen((event) {
      messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text("${event.name} - ${event.payload}")));
      print(event.name);
    });
    Emarsys.inApp.inAppEventStream.listen((event) {
      messengerKey.currentState!.showSnackBar(
          SnackBar(content: Text("${event.name} - ${event.payload}")));
      print(event.name);
    });
  }
}

Map<String, String>? convertTextToMap(String? text) {
  Map<String, String>? result;
  if (text != null && text.isNotEmpty) {
    result = json.decode(text);
  }
  return result;
}
