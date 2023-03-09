import 'package:http/http.dart' as http;

class LoginController {
  String serverIp;
  LoginController({required this.serverIp});

  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$serverIp/login"),
        body: {"email": username, "password": password});
    if (res.statusCode == 202) return res.body;
    return "";
  }
}
