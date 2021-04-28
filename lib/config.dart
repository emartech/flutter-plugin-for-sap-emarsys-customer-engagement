class Config {
  final String? applicationCode;
  final int contactFieldId;

  Config({this.applicationCode, required this.contactFieldId});

  Map<String, dynamic> toMap() {
    return {
      'mobileEngageApplicationCode': applicationCode,
      'contactFieldId': contactFieldId,
    };
  }
}
