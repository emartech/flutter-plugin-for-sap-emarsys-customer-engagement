class EmarsysConfig {
  final String? applicationCode;
  final int contactFieldId;

  EmarsysConfig({this.applicationCode, required this.contactFieldId});

  Map<String, dynamic> toMap() {
    return {
      'mobileEngageApplicationCode': applicationCode,
      'contactFieldId': contactFieldId,
    };
  }
}
