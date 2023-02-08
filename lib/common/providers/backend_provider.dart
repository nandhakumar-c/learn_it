import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_it/common/models/userlogin_payload_model.dart';

class BackEndProvider with ChangeNotifier {
  final String _localhost = "http://192.168.29.204:4000/api";
  String getLocalhost() {
    return _localhost;
  }

  //JWT Token Storage
  final _storage = const FlutterSecureStorage();
  Future<void> storeJwtToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String> readJwtToken(String key) async {
    String value = await _storage.read(key: key) as String;
    print("Provider Value : $value");
    return value;
  }

//User Details
  Payload? payloadData;
  void setpayloadData(String payload) {
    payloadData = payloadFromJson(payload);
    notifyListeners();
  }
}
