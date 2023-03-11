import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../common/providers/backend_provider.dart';
import '../../common/routes/app_routes.dart';
import '../../common/utils/screen_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool passwordBoolean = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  // regular expression to check if string
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
  Widget build(BuildContext context) {
    final backendProvider = Provider.of<BackEndProvider>(context);
    return Scaffold(
        body: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // leading: IconButton(
              //   icon: Icon(Icons.chevron_left),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    height: SizeConfig.height! * 50,
                    width: SizeConfig.width! * 100,
                    // alignment: Alignment.center,
                    child: Align(
                      // alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.width! * 22,
                            width: SizeConfig.width! * 22,
                            child: Lottie.asset(
                                "assets/lottie/reset_password.json"),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            height: SizeConfig.height! * 4,
                            child: Text(
                              "Reset Password",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Enter your new password and confirm password",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: Text(
                              "Note: Your confirm password should be same as your new password ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.error),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.height! * 2.5,
                          ),
                          Container(
                            child: Form(
                              key: _passwordKey,
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: !isPasswordVisible,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password";
                                  } else {
                                    //call function to check password
                                    bool result = validatePassword(value);
                                    if (result) {
                                      // create account event
                                      setState(() {
                                        passwordBoolean = true;
                                      });
                                      return null;
                                    } else {
                                      return "Password should contain Capital, small letter & Number & Special";
                                    }
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  _passwordKey.currentState!.validate();
                                },
                                decoration: InputDecoration(
                                  hintText: "New Password",
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: isPasswordVisible
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.height! * 1.0,
                          ),
                          Container(
                            child: Form(
                              key: _confirmPasswordKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return "Enter the same password";
                                  }
                                  return null;
                                },
                                controller: _confirmPasswordController,
                                obscureText: !isConfirmPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPasswordVisible =
                                            !isConfirmPasswordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: isConfirmPasswordVisible
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: SizeConfig.height! * 10,
                    width: SizeConfig.width! * 100,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: SizeConfig.width! * 100,
                          child: FilledButton(
                            onPressed: () async {
                              String serverIp = backendProvider.getLocalhost();
                              if (_passwordKey.currentState!.validate() &&
                                  _confirmPasswordKey.currentState!
                                      .validate()) {
                                final res = await http.post(
                                    Uri.parse(
                                        "$serverIp/resetPassword/c2d67fa0-d6eb-4ff0-8e43-5e9e748a8940/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFza3JpdGhpMTJAZ21haWwuY29tIiwiaWQiOiJjMmQ2N2ZhMC1kNmViLTRmZjAtOGU0My01ZTllNzQ4YTg5NDAiLCJpYXQiOjE2NzU2MDMxNTgsImV4cCI6MTY3NTYwNDA1OH0.KUAk_3jRNk2l-AyAwBy6SfEvPfwBb__yNlQU9L0MdgQ"),
                                    body: {
                                      "password": _passwordController.text,
                                      "cpassword":
                                          _confirmPasswordController.text
                                    });

                                print("Result --> ${res.body}");
                                final data = jsonDecode(res.body);
                                if (data["success"] == true) {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const LoginPage(),
                                  //   ),
                                  // );
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppRoutes.login, (route) => false);
                                  _passwordController.clear();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Oops :("),
                                        content: const Text(
                                            "Something went wrong. Try again later"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                // Navigator.of(context).pop();
                                                Navigator.of(context).popUntil(
                                                    ModalRoute.withName(
                                                        AppRoutes
                                                            .forgotPassword));
                                              },
                                              child: const Text("OK"))
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Text("Continue",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
