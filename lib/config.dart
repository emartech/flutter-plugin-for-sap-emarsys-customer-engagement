import 'package:flutter/services.dart';

class Config {
  final MethodChannel _channel;

  Config(this._channel);

  Future<String?> applicationCode() {
    return _channel.invokeMethod('config.applicationCode');
  }

  Future<String?> merchantId() {
    return _channel.invokeMethod('config.merchantId');
  }

  Future<int> contactFieldId() async {
    int? contactFieldId = await _channel.invokeMethod('config.contactFieldId');
    if (contactFieldId == null) {
      throw NullThrownError();
    }
    return contactFieldId;
  }

  Future<String> hardwareId() async {
    String? hardwareId = await _channel.invokeMethod('config.hardwareId');
    if (hardwareId == null) {
      throw NullThrownError();
    }
    return hardwareId;
  }

  Future<String> languageCode() async {
    String? language = await _channel.invokeMethod('config.languageCode');
    if (language == null) {
      throw NullThrownError();
    }
    return language;
  }

  Future<Map<String, dynamic>> pushSettings() async {
    Map<dynamic, dynamic>? pushSettings =
        await _channel.invokeMethod('config.pushSettings');
    if (pushSettings == null) {
      throw NullThrownError();
    }
    return Map.from(pushSettings);
  }

  Future<String> sdkVersion() async {
    String? sdkVersion = await _channel.invokeMethod('config.sdkVersion');
    if (sdkVersion == null) {
      throw NullThrownError();
    }
    return sdkVersion;
  }
}
