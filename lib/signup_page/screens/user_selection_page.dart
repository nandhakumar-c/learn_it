import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_it/common/utils/screen_size.dart';
import 'package:learn_it/common/widgets/colors.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:lottie/lottie.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({super.key});

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  String? userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Positioned(
              top: -SizeConfig.height! * 50,
              left: -SizeConfig.width! * 35,
              child: Container(
                height: SizeConfig.height! * 125,
                width: SizeConfig.width! * 125,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(48),
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.5),
                ),
              )),
          Positioned(
              bottom: -SizeConfig.height! * 50,
              right: -SizeConfig.width! * 35,
              child: Container(
                height: SizeConfig.height! * 125,
                width: SizeConfig.width! * 125,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(48),
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withOpacity(0.5),
                ),
              )),
          Positioned(
              top: SizeConfig.height! * 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Who are you ?",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )),
          Positioned(
              top: SizeConfig.height! * 15,
              left: SizeConfig.width! * 10,
              child: Container(
                height: SizeConfig.height! * 20,
                width: SizeConfig.height! * 20,
                child: Lottie.asset("assets/lottie/student.json"),
              )),
          Positioned(
              bottom: SizeConfig.height! * 5,
              right: SizeConfig.width! * 10,
              child: Container(
                height: SizeConfig.height! * 30,
                width: SizeConfig.height! * 30,
                child: Lottie.asset("assets/lottie/teacher.json"),
              )),
          Positioned(
            top: SizeConfig.height! * 30,
            right: SizeConfig.width! * 20,
            child: SizedBox(
              height: SizeConfig.height! * 11,
              width: SizeConfig.height! * 11,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    //elevation: 7,
                    backgroundColor: Theme.of(context).colorScheme.primary),
                // style: Theme.of(context).filledButtonTheme.style!.copyWith(backgroundColor:Theme.of(context).colorScheme.onPrimary ),
                onPressed: () {
                  setState(() {
                    userType = "S";
                  });

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SignUpPage(userType: userType as String),
                  ));
                },
                child: Text(
                  "Learner",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: SizeConfig.height! * 28,
            left: SizeConfig.width! * 20,
            child: SizedBox(
              height: SizeConfig.height! * 13,
              width: SizeConfig.height! * 13,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    //elevation: 7,
                    backgroundColor: Theme.of(context).colorScheme.tertiary),
                onPressed: () {
                  setState(() {
                    userType = "T";
                  });

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SignUpPage(userType: userType as String),
                  ));
                },
                child: Text("Instructor",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary)),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

//  onTap: () {
                    
//                   },


/*Stack(children: [
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
      ]), */

/*
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
} */
