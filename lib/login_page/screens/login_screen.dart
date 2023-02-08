// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:learn_it/common/models/userlogin_payload_model.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:learn_it/homepage/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //providers
    final provider = Provider.of<BackEndProvider>(context);
    final dashboardProvider = Provider.of<DashBoardProvider>(context);
    String serverIp = provider.getLocalhost();

    //function for http login
    Future<dynamic> attemptLogIn(String username, String password) async {
      var res = await http.post(Uri.parse("$serverIp/login"),
          body: {"email": username, "password": password});
      if (res.statusCode == 202) return res.body;
      return null;
    }

    //displays error
    void displayDialog(context, title, text) => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text(title), content: Text(text)),
        );

    //function to get dashboard data
    Future<void> getDashboardData(String jwtToken) async {
      print(jwtToken);
      var res = await http.get(Uri.parse("$serverIp/getAllcourses"),
          headers: {"Authorization": jwtToken});

      //success prompt
      if (res.statusCode == 200) {
        print(res.body);
        dashboardProvider.setDashboardData(res.body);
      }
      return;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: username,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Username"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Password"),
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

                      if (jwt != null) {
                        print("Success jwt");
                        print(jwt);
                        //converting the payload to class
                        var payload = payloadFromJson(jwt);

                        //storing the payload data into the provider
                        provider.setpayloadData(jwt);

                        //storing the jwt token in the local storage using provider
                        await provider.storeJwtToken("jwt", payload.token);
                        print("Token JWT ${payload.token}");
                        await getDashboardData(payload.token);

                        // ignore: use_build_context_synchronously
                        //Navigation to the dashboard page
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      } else {
                        print("Failure");
                        // ignore: use_build_context_synchronously
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that username and password");
                      }
                    },
                    child: const Text("Login")),
              ],
            )),
      ),
    );
  }
}
