import 'package:shared_preferences/shared_preferences.dart';

import '../models/userlogin_payload_model.dart';

class UserLoginDetails {
  static late SharedPreferences pref;
  static late Payload payloadData;
  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future setProfilePicture(String image) async {
    await pref.setString("dp", image);
  }

  static Future setEmailPassword(String data, String jwt) async {
    payloadData = payloadFromJson(data);
    await pref.setString("loginData", data);
    // await pref.setString("password", password);
    await pref.setString("jwtToken", jwt);
  }

  // static String? getEmail() {
  //   final email = pref.getString("email");
  //   return email;
  // }

  // static String? getPassword() {
  //   final email = pref.getString("password");
  //   return email;
  // }
  static String? getLoginData() {
    final data = pref.getString("loginData");

    return data;
  }

  static String? getJwtToken() {
    final email = pref.getString("jwtToken");
    return email;
  }

  static String? getdp() {
    final dp = pref.getString("dp");
    return dp;
  }

  static void clearData() {
    pref.clear();
  }
}
