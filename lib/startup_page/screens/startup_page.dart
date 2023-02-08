import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';

import '../../common/widgets/clipper.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    navigationCallBack() {
      print("Pressed !");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
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
                Color.fromARGB(255, 106, 27, 154),
                Color.fromARGB(255, 171, 71, 188),
                0.25,
                500),
            StyleContainer(
                context,
                height * 0.5,
                Color.fromARGB(255, 106, 27, 154),
                Color.fromARGB(255, 171, 71, 188),
                0.5,
                1000),
            StyleContainer(
                context,
                height * 0.45,
                Color.fromARGB(255, 106, 27, 154),
                Color.fromARGB(255, 171, 71, 188),
                1,
                1500),

            //Title Text
            // buildTitleText(height, height * 0.10, width * 0.05, 0.25),
            // buildTitleText(height, height * 0.108, width * 0.05, 0.5),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 2),
              builder: (context, double value, child) {
                return buildTitleText(
                    height, height * 0.116, width * 0.05, value);
              },
            ),

            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 2),
              builder: (context, double value, child) {
                return buildSubText(
                    height * 0.8, height * 0.23, width * 0.06, value);
              },
            ),
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
              duration: const Duration(milliseconds: 1800),
            ),
            Positioned(
              top: height * 0.80,
              bottom: 50,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: LearnItButton(
                  // height: height * 0.06,
                  // width: width,
                  onPressed: navigationCallBack,
                  text: "Get Started",
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Positioned(
              top: height * 0.90,
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Already a user ? ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  TextSpan(
                      text: " Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.purple),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                        })
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Custom Painter for bookmark
class BookMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 239, 216, 247)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(size.width * 0.80, 0);
    path.lineTo(size.width * 0.80, size.height * 0.5);
    path.lineTo(size.width * 0.85, size.height * 0.45);
    path.lineTo(size.width * 0.90, size.height * 0.5);
    path.lineTo(size.width * 0.90, 0);
    path.lineTo(size.width * 0.80, 0);
    path.close();
    canvas.drawShadow(
        path, Color.fromARGB(255, 83, 27, 92).withAlpha(100), 3.0, true);
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
          style: GoogleFonts.crimsonPro(
              fontSize: originalHeight * 0.135,
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
          style: GoogleFonts.crimsonPro(
              fontSize: originalHeight * 0.135,
              color: Colors.white70,
              fontWeight: FontWeight.w100),
        ),
      ),
    ),
  );
}
