import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../common/providers/backend_provider.dart';
import '../../common/utils/screen_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    padding: EdgeInsets.all(16),
                    height: SizeConfig.height! * 50,
                    width: SizeConfig.width! * 100,
                    // alignment: Alignment.center,
                    child: Align(
                      // alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.width! * 25,
                            width: SizeConfig.width! * 25,
                            child: Lottie.asset(
                                "assets/lottie/reset_password.json"),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
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
                            padding: EdgeInsets.only(left: 5),
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
                            padding: EdgeInsets.only(left: 5, top: 5),
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
                            child: TextField(
                              controller: _passwordController,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: "New Password",
                                border: OutlineInputBorder(),
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
                          SizedBox(
                            height: SizeConfig.height! * 2.5,
                          ),
                          Container(
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: !isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                border: OutlineInputBorder(),
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
                              final res = await http.post(
                                  Uri.parse("$serverIp/forgotPass"),
                                  body: {"email": _passwordController.text});

                              print("Result --> ${res.body}");
                              final data = jsonDecode(res.body);
                              if (data["success"] == true) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                                _passwordController.clear();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Oops :("),
                                      content: Text(
                                          "Email not registered. Please register to continue"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK"))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text("Next",
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
