// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:learn_it/common/models/userlogin_payload_model.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/widgets/clipper.dart';
import 'package:learn_it/dashboard_page/screens/dashboard_page.dart';
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:learn_it/dashboard_page/providers/dashboard_provider.dart';
import 'package:learn_it/login_page/screens/forgot_password.dart';
import 'package:learn_it/login_page/screens/reset_password.dart';
import 'package:learn_it/login_page/widgets/bottomborderclipper.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../common/utils/screen_size.dart';
import '../../common/widgets/button_loader.dart';
import '../../video_call_page/screens/video_call_screen.dart';
import '../../video_call_page/screens/video_call_screen_layout.dart';
import '../widgets/topborderclipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  //final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  bool isPasswordVisible = false;
  bool emailBoolean = false;
  bool passwordBoolean = false;
  bool isLoading = false;
  final _loginUserFormKey = GlobalKey<FormState>();
  final _loginPassFormKey = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        //key: _scaffoldKey1,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.08,
                //color: Colors.blue,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: width * 0.08,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text("Login",
                        style: Theme.of(context).textTheme.headlineSmall)
                  ],
                ),
              ),
              Lottie.asset(
                "assets/lottie/Login_Lottie.json",
                height: height * 0.3,
                width: height * 0.3,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              //-----Email or username field-----
              Form(
                key: _loginUserFormKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    setState(() {
                      emailBoolean = true;
                    });
                    // Return null if the entered email is valid
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  controller: username,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      hintText: "Email or Username",
                      hoverColor: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              //----password----
              Form(
                key: _loginPassFormKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else {
                      //call function to check password
                      bool result = validatePassword(value);
                      if (result) {
                        // create account event
                        ;
                        return null;
                      } else {
                        return "Please enter the correct password";
                      }
                    }
                  },
                  controller: password,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyLarge,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye_rounded,
                        color: isPasswordVisible ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => ResetPasswordScreen(),
                    // ));
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 5,
              ),
              //----Login Button----
              FilledButton(
                onPressed: () async {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => DashBoardPage(),
                  // ));
                  print(username.text);
                  print(password.text);
                  if (_loginUserFormKey.currentState!.validate() &&
                      _loginPassFormKey.currentState!.validate()) {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    var jwt = await attemptLogIn(username.text, password.text);
                    setState(() {
                      isLoading = !isLoading;
                    });

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
                      String userType = provider.payloadData!.user.userType;

                      // ignore: use_build_context_synchronously
                      //Navigation to the dashboard page
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(userType: userType)));
                    } else {
                      print("Failure");
                      // ignore: use_build_context_synchronously
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  }
                },
                child: isLoading
                    ? ButtonLoader()
                    : Text("Login",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white)),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),

              // ignore: prefer_const_literals_to_create_immutables
              Row(children: <Widget>[
                // ignore: prefer_const_constructors
                Expanded(
                  child: const Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "OR",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
              ]),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              OutlinedButton(
                  style:
                      OutlinedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}






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

/* ClipPath bottomBorder(double width, double height) {
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
  }*/