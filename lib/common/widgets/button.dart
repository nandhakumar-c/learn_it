import 'package:flutter/material.dart';

class LearnItButton extends StatelessWidget {
  String text;
  Function onPressed;
  double? height;
  double? width;
  LearnItButton(
      {this.height,
      this.width,
      required this.text,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    height = height ?? h * 0.06;
    width = width ?? w;
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        onPressed();
      },
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 10, 48, 114),
                Color.fromARGB(180, 14, 96, 195),
                //Color.fromARGB(180, 9, 43, 101),
              ])),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),
    );
  }
}
