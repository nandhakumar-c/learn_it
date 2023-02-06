import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:learn_it/homepage.dart';

const SERVER_IP = 'http://192.168.29.204:4000/api';
final storage = FlutterSecureStorage();

/*register

user_type
username
email
password
c_password  */

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<dynamic> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/login"),
        body: {"email": username, "password": password});
    if (res.statusCode == 202) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    void displayDialog(context, title, text) => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text(title), content: Text(text)),
        );
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: username,
                  decoration: InputDecoration(hintText: "Username"),
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      print(username.text);
                      print(password.text);

                      var jwt =
                          await attemptLogIn(username.text, password.text);
                      print("Success");
                      if (jwt != null) {
                        print("Success jwt");
                        print(jwt);
                        storage.write(key: "jwt", value: jwt);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      } else {
                        print("Failure");
                        // ignore: use_build_context_synchronously
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that username and password");
                      }
                    },
                    child: Text("Login"))
              ],
            )),
      ),
    ));
  }
}
