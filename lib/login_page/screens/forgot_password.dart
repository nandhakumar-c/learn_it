import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/login_page/screens/otp_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../common/utils/screen_size.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final backendProvider = Provider.of<BackEndProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                          "assets/lottie/forgot_password_lottie.json"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: SizeConfig.height! * 4,
                      child: Text(
                        "Enter your email address",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Enter your registered email address to send otp and change the password of the LearnIt account",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height! * 2.5,
                    ),
                    Container(
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: "Email Address",
                            border: OutlineInputBorder()),
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
                            body: {"email": _emailController.text});

                        print("Result --> ${res.body}");
                        final data = jsonDecode(res.body);
                        if (data["success"] == true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtpScreen(email: _emailController.text),
                            ),
                          );
                          // _emailController.clear();
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
      ),
    );
  }
}
