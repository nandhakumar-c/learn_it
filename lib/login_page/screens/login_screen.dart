// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:learn_it/common/models/userlogin_payload_model.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/widgets/clipper.dart';
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:learn_it/homepage/providers/dashboard_provider.dart';
import 'package:learn_it/login_page/widgets/bottomborderclipper.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:provider/provider.dart';

import '../widgets/topborderclipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //providers
    final provider = Provider.of<BackEndProvider>(context);

    //dashboardprovider
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
    /* Future<void> getDashboardData(String jwtToken) async {
      print(jwtToken);
      var res = await http.get(Uri.parse("$serverIp/getAllcourses"),
          headers: {"Authorization": jwtToken});

      //success prompt
      if (res.statusCode == 200) {
        print(res.body);
        dashboardProvider.setDashboardData(res.body);
      }
      return;
    } */

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(title: Text("Login Page")),
          body: Stack(
            alignment: Alignment.center,
            children: [
              //top design
              Align(
                  alignment: Alignment.topLeft,
                  child: topBorder(width * 0.7, height * 0.35)),
              Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                    opacity: 0.5, child: topBorder(width * 0.75, height * 0.4)),
              ),

              //bottom design
              Positioned(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                          opacity: 0.5,
                          child: bottomBorder(width, height * 0.4)))),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    opacity: 1,
                    child: bottomBorder(width * 0.99, height * 0.34),
                  ),
                ),
              ),

              //Curved Container
              Positioned(
                top: height * 0.39,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Container
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.1),
                          child: Container(
                            height: height * 0.18,
                            width: width * 0.9,
                            padding: EdgeInsets.only(right: width * 0.15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(width),
                                  bottomRight: Radius.circular(width),
                                ),
                                boxShadow: [
                                  const BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                    spreadRadius: 4,
                                    color: Color.fromARGB(15, 0, 0, 0),
                                  ),
                                  BoxShadow(
                                      blurRadius: 10,
                                      offset: -const Offset(0, 3),
                                      color: const Color.fromARGB(15, 0, 0, 0),
                                      spreadRadius: 4),
                                ],
                                color: Colors.white),
                            child: Container(
                              height: height * 0.18,
                              width: width * 0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    textInputAction: TextInputAction.next,
                                    controller: username,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      border: InputBorder.none,
                                      hintText: "Email or Username",
                                      hintStyle: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                  TextField(
                                    controller: password,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(fontSize: 20),
                                    obscureText: !isPasswordVisible,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock),
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            const TextStyle(fontSize: 20),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isPasswordVisible =
                                                    !isPasswordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye_rounded,
                                              color: isPasswordVisible
                                                  ? Colors.blue
                                                  : Colors.grey,
                                            ))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              //Login Text
              Positioned(
                top: height * 0.275,
                child: Align(
                  child: Text(
                    "Login",
                    style: GoogleFonts.cinzel(
                        fontSize: 45, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              //Login Arrow Button
              Positioned(
                right: width * 0.01,
                top: height * 0.42,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            height: height * 0.09,
                            width: height * 0.09,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 9, 43, 101),
                                  Color.fromARGB(255, 14, 96, 195),
                                ])),
                            child: IconButton(
                                onPressed: () async {
                                  print(username.text);
                                  print(password.text);

                                  var jwt = await attemptLogIn(
                                      username.text, password.text);

                                  if (jwt != null) {
                                    print("Success jwt");
                                    print(jwt);
                                    //converting the payload to class
                                    var payload = payloadFromJson(jwt);

                                    //storing the payload data into the provider
                                    provider.setpayloadData(jwt);

                                    //storing the jwt token in the local storage using provider
                                    await provider.storeJwtToken(
                                        "jwt", payload.token);

                                    // print("Token JWT ${payload.token}");

                                    // ignore: use_build_context_synchronously
                                    //Navigation to the dashboard page
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  } else {
                                    print("Failure");
                                    // ignore: use_build_context_synchronously
                                    displayDialog(context, "An Error Occurred",
                                        "No account was found matching that username and password");
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ))),
                      )),
                ),
              ),

              //Forgot Password button
              Positioned(
                  right: width * 0.25,
                  bottom: height * 0.36,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                  )),
              Positioned(
                bottom: height * 0.27,
                left: 10,
                child: Align(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "New user ? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 18)),
                        TextSpan(
                            text: " Register",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color:
                                        const Color.fromARGB(255, 14, 96, 195),
                                    fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      const UserSelectionPage(),
                                ));
                              })
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
          /*body: SingleChildScrollView(
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

                          // print("Token JWT ${payload.token}");

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
        ),*/
          ),
    );
  }

  ClipPath bottomBorder(double width, double height) {
    return ClipPath(
        clipper: BottomBorderClipper(),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195),
              ])),
        ));
  }

  ClipPath topBorder(double width, double height) {
    return ClipPath(
        clipper: TopBorderClipper(),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195)
              ])),
        ));
  }
}
