import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String hardwareId = "-";
  String applicationCode = "-";
  String merchantId = "-";
  String contactFieldId = "-";
  String languageCode = "-";
  String sdkVersion = "-";

  @override
  void initState() {
    super.initState();
    _loadDashboardInfo();
  }

  Future<void> _loadDashboardInfo() async {
    String fetchedHardwareId = await Emarsys.config.hardwareId();
    String fetchedApplicationCode =
        await Emarsys.config.applicationCode() ?? "-";
    String fetchedMerchantId = await Emarsys.config.merchantId() ?? "-";
    int? fetchedContactFieldId =
        await Emarsys.config.contactFieldId(); 
    String fetchedLanguageCode = await Emarsys.config.languageCode();
    String fetchedSdkVersion = await Emarsys.config.sdkVersion();

    setState(() {
      hardwareId = fetchedHardwareId;
      applicationCode = fetchedApplicationCode;
      merchantId = fetchedMerchantId;
      contactFieldId =
          fetchedContactFieldId?.toString() ?? "-"; 
      languageCode = fetchedLanguageCode;
      sdkVersion = fetchedSdkVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildInfoRow("Hardware ID", hardwareId),
            _buildInfoRow("Application Code", applicationCode),
            _buildInfoRow("Merchant ID", merchantId),
            _buildInfoRow("Contact Field ID", contactFieldId),
            _buildInfoRow("Language Code", languageCode),
            _buildInfoRow("SDK Version", sdkVersion),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
