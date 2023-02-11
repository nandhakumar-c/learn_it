import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_it/common/widgets/colors.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({super.key});

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  String? userType;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Selection Page"),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(children: [
          SizedBox(height: height * 0.2),
          Container(
            child: Text(
              "ARE YOU A",
              style: TextStyle(fontSize: width * 0.06),
            ),
          ),
          SizedBox(
            height: height * 0.06,
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      userType = "T";
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(userType: userType as String),
                    ));
                  },
                  child: Container(
                    height: height * 0.225,
                    width: width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userSelectionContainer(
                            height, "assets/images/teacher.png"),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                            width: width * 0.2,
                            height: height * 0.03,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Palette.kToDark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "TEACHER",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.08,
                  height: height * 0.07,
                  child: Text(
                    "OR",
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      userType = "S";
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(userType: userType as String),
                    ));
                  },
                  child: Container(
                    height: height * 0.225,
                    width: width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userSelectionContainer(
                            height, "assets/images/student.jpg"),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                            width: width * 0.2,
                            height: height * 0.03,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Palette.kToDark,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "STUDENT",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Container userSelectionContainer(double height, String asset) {
    return Container(
      height: height * 0.11,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage(asset),
        ),
      ),
    );
  }
}
