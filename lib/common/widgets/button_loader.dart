import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48), color: Colors.white),
        child: SizedBox(
          height: 25,
          width: 25,
          child: Lottie.asset(
            "assets/lottie/loader.json",
          ),
        ),
      ),
    );
  }
}
