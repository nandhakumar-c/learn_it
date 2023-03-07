import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/utils/color.dart';
import 'package:learn_it/login_page/screens/reset_password.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../common/utils/screen_size.dart';

class OtpScreen extends StatefulWidget {
  String email;
  OtpScreen({required this.email, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    print(widget.email);
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
        children: [
          Container(
              height: SizeConfig.height! * 50,
              width: SizeConfig.width! * 100,
              alignment: Alignment.center,
              child: Align(
                //alignment: Alignment.center,
                child: Container(
                  height: SizeConfig.height! * 50,
                  // alignment: Alignment.center,
                  width: SizeConfig.width! * 100,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.width! * 25,
                        width: SizeConfig.width! * 25,
                        child: Lottie.asset("assets/lottie/verify_otp.json"),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        height: SizeConfig.height! * 4,
                        child: Text(
                          "Verify OTP",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Enter the OTP that has been sent to your registered email address to reset the password of the LearnIt account",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      Container(
                        height: SizeConfig.height! * 10,
                        child: OtpTextField(
                          numberOfFields: 6,
                          // fillColor: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          //enabledBorderColor: CustomColor.primaryColor,
                          borderWidth: 1,
                          focusedBorderColor:
                              Theme.of(context).colorScheme.primary,
                          enabledBorderColor:
                              Theme.of(context).colorScheme.tertiary,
                          keyboardType: TextInputType.number,
                          showFieldAsBox: true,
                          fieldWidth: 48,
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },

                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) async {
                            print(verificationCode);
                            setState(() {
                              otp = verificationCode;
                            });
                          }, // end onSubmit
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            child: Container(
              height: SizeConfig.height! * 20,
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
                        print("otp ==> $otp");
                        final res = await http.post(
                            Uri.parse("$serverIp/verifyOtp"),
                            body: {"email": widget.email, "otp": otp});

                        print("Result --> ${res.body}");
                        if (jsonDecode(res.body)["status"] == true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Enter valid OTP"),
                                actions: [
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text("Verify",
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
