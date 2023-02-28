import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/screen_size.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: SizeConfig.height! * 20,
                  child: Lottie.asset("assets/lottie/loading.json")),
              SizedBox(
                width: SizeConfig.width! * 75,
                child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "\"The only true wisdom is in knowing you know nothing.\" ",
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: "- Socrates",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600)),
                      ])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
