import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk_example/main.dart';
import 'package:emarsys_sdk_example/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _appCodeController;
  late TextEditingController _merchantIdController;
  late TextEditingController _contactFieldIdController;
  late TextEditingController _contactFieldValueController;
  late SharedPreferences prefs;
  String? contactFieldValue;
  bool _isDashboardExpanded = false;

  @override
  void initState() {
    super.initState();
    _appCodeController = TextEditingController();
    _merchantIdController = TextEditingController();
    _contactFieldIdController = TextEditingController();
    _contactFieldValueController = TextEditingController();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      contactFieldValue = prefs.getString("loggedInUser");
      _appCodeController.text = prefs.getString("appcode") ?? '';
      _merchantIdController.text = prefs.getString("merchantId") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          _buildDashboardExpansion(),
          const SizedBox(height: 16),
          _buildTextField("Application Code", _appCodeController),
          _buildElevatedButton("Change App Code", _changeAppCode),
          _buildTextField("Merchant ID", _merchantIdController),
          _buildElevatedButton("Change Merchant ID", _changeMerchantId),
          _buildTextField("Contact Field ID", _contactFieldIdController,
              inputType: TextInputType.number),
          _buildTextField("Contact Field Value", _contactFieldValueController),
          if (contactFieldValue == null)
            _buildElevatedButton("Link Contact", _linkContact)
          else
            _buildElevatedButton("Set Anonymous Contact", _logout),
        ],
      ),
    );
  }

  Widget _buildDashboardExpansion() {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isDashboardExpanded = !_isDashboardExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text("Dashboard"),
            );
          },
          body: Dashboard(),
          isExpanded: _isDashboardExpanded,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Future<void> _changeAppCode() async {
    if (_appCodeController.text.isNotEmpty) {
      await prefs.setString("appcode", _appCodeController.text);
      _showSnackbar("Application Code changed");
    } else {
      _showSnackbar("Please fill the Application Code");
    }
  }

  Future<void> _changeMerchantId() async {
    if (_merchantIdController.text.isNotEmpty) {
      await prefs.setString("merchantId", _merchantIdController.text);
      _showSnackbar("Merchant ID changed");
    } else {
      _showSnackbar("Please fill the Merchant ID");
    }
  }

  Future<void> _linkContact() async {
    if (_contactFieldIdController.text.isNotEmpty &&
        _contactFieldValueController.text.isNotEmpty) {
      int contactFieldId = int.parse(_contactFieldIdController.text);
      String contactValue = _contactFieldValueController.text;
      prefs.setInt("contactFieldId", contactFieldId);
      prefs.setString("loggedInUser", contactValue);
      Emarsys.setContact(contactFieldId, contactValue);
      setState(() {
        contactFieldValue = contactValue;
      });
      _showSnackbar("Contact linked");
    } else {
      _showSnackbar("Please fill all fields");
    }
  }

  Future<void> _logout() async {
    prefs.remove("loggedInUser");
    Emarsys.clearContact();
    setState(() {
      contactFieldValue = null;
    });
    _showSnackbar("Anonymous contact set");
  }

  void _showSnackbar(String message) {
    messengerKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
