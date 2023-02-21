import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:learn_it/common/widgets/colors.dart';
import 'package:learn_it/dashboard_page/video_call_page.dart';
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:learn_it/profile_page/screens/profile_page.dart';
import 'package:learn_it/schedule_page/screens/schedule_page.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'dart:ui' as ui;
import '../../common/widgets/clipper.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  bool isVisible = false;
  bool isButtonVisible = false;
  bool isTitleVisible = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        isTitleVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        isVisible = true;
      });
    });

    //Navigation to the User Selection Page
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isButtonVisible = true;
      });
    });
    navigationCallBack() {
      print("Pressed !");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserSelectionPage(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StyleContainer(
                context,
                height * 0.55,
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195),
                0.25,
                400),
            StyleContainer(
                context,
                height * 0.5,
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195),
                // Color.fromARGB(180, 9, 43, 101),
                0.5,
                800),
            StyleContainer(
                context,
                height * 0.45,
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195),
                // Color.fromARGB(255, 106, 27, 154),
                // Color.fromARGB(255, 171, 71, 188),
                1,
                1000),

            // buildTitleText(height, height * 0.10, width * 0.05, 0.25),
            // buildTitleText(height, height * 0.108, width * 0.05, 0.5),

            //Learn Text
            isTitleVisible
                ? TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(seconds: 1),
                    builder: (context, double value, child) {
                      return buildTitleText(
                          height, height * 0.116, width * 0.05, value);
                    },
                  )
                : Container(),
            //it Text
            isTitleVisible
                ? TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(seconds: 1),
                    builder: (context, double value, child) {
                      return buildSubText(
                          height * 0.8, height * 0.23, width * 0.06, value);
                    },
                  )
                : Container(),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: height),
              builder: (context, double value, child) {
                return Positioned(
                    child: CustomPaint(
                  painter: BookMarkPainter(),
                  size: Size(width, value),
                ));
              },
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 1000),
            ),
            //slogan text
            isVisible ? sloganText(height, width) : Container(),

            //get started button
            isButtonVisible
                ? getStartedButton(height, navigationCallBack)
                : Container(),
            const SizedBox(
              height: 15,
            ),

            //login text
            isButtonVisible ? loginButton(height) : Container(),
          ],
        ),
      ),
    );
  }

  TweenAnimationBuilder<double> loginButton(double height) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      builder: (context, double value, child) {
        return Positioned(
          top: height * 0.90,
          bottom: 30,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: value,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Already a user ? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 18)),
                    TextSpan(
                        text: " Login",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Color.fromARGB(180, 14, 96, 195),
                            fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TweenAnimationBuilder<double> getStartedButton(
      double height, navigationCallBack()) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      builder: (context, double value, child) {
        return Positioned(
          bottom: height * 0.07,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: LearnItButton(
                height: height * 0.06,
                onPressed: navigationCallBack,
                text: "Get Started",
              ),
            ),
          ),
        );
      },
    );
  }

//slogan text widget
  TweenAnimationBuilder<double> sloganText(double height, double width) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      builder: (context, double value, child) {
        return Positioned(
            top: height * 0.60,
            bottom: 50,
            left: width * 0.05,
            child: Opacity(
              opacity: value,
              child: Text(
                "\"Schedule your classes\"",
                style: TextStyle(fontSize: height * 0.03),
              ),
            ));
      },
    );
  }
}

//Custom Painter for bookmark
class BookMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber
      ..shader = ui.Gradient.linear(
        Offset(size.width, size.height),
        Offset(size.width * 0.2, 0),
        [Color.fromARGB(255, 12, 65, 157), Colors.white],
      )
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(size.width * 0.80, 0);
    path.lineTo(size.width * 0.80, size.height * 0.5);
    path.lineTo(size.width * 0.85, size.height * 0.45);
    path.lineTo(size.width * 0.90, size.height * 0.5);
    path.lineTo(size.width * 0.90, 0);
    path.lineTo(size.width * 0.80, 0);
    path.close();
    canvas.drawShadow(
        path, Color.fromARGB(255, 12, 65, 157).withAlpha(100), 3.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//StartUp Page Curved Container
Widget StyleContainer(BuildContext context, double height, Color startColor,
    Color endColor, double opacity, int milliseconds) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: milliseconds),
    tween: Tween<double>(begin: height - height * 0.5, end: height),
    curve: Curves.decelerate,
    builder: (context, customheight, child) {
      return TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: milliseconds),
        curve: Curves.decelerate,
        tween: Tween<double>(begin: 0.0, end: opacity),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: customheight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [startColor, endColor],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

//for the Learn Text
Widget buildTitleText(
    double originalHeight, double height, double width, double opacity) {
  return Positioned(
    left: width,
    top: height,
    child: Opacity(
      opacity: opacity,
      child: Container(
        child: Text(
          "Learn",
          style: GoogleFonts.abrilFatface(
              fontSize: originalHeight * 0.110,
              color: Colors.white70,
              fontWeight: FontWeight.w100),
        ),
      ),
    ),
  );
}

buildSubText(
    double originalHeight, double height, double width, double opacity) {
  return Positioned(
    left: width,
    top: height,
    child: Opacity(
      opacity: opacity,
      child: Container(
        child: Text(
          "it.",
          style: GoogleFonts.abrilFatface(
              fontSize: originalHeight * 0.115,
              color: Colors.white,
              fontWeight: FontWeight.w100),
        ),
      ),
    ),
  );
}
