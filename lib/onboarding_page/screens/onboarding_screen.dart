import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_it/common/providers/sharedpref.dart';
import 'package:learn_it/common/routes/app_routes_name.dart';
import 'package:learn_it/common/utils/screen_size.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/routes/app_routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;

  late Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        setState(() {
          _currentPage++;
        });
      } else {
        setState(() {
          _currentPage = 0;
        });
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(height: SizeConfig.height! * 13),
          Container(
            height: SizeConfig.height! * 56,
            width: SizeConfig.width! * 100,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              controller: _pageController,
              children: [
                Container(
                  height: SizeConfig.height! * 55,
                  width: SizeConfig.width! * 100,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to LearnIt",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: SizeConfig.height! * 1,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            ' An online school that allows you to re-discover yourself , You can create and join meetings anytime , anywhere',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400,
                                    height: 1.45),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: SizeConfig.height! * 40,
                              width: SizeConfig.width! * 90,
                              child: Lottie.asset(
                                  "assets/lottie/onboarding_lottie5.json")),
                        )
                      ]),
                ),
                Container(
                  height: SizeConfig.height! * 55,
                  width: SizeConfig.width! * 100,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Organise Meetings",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: SizeConfig.height! * 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 10),
                          child: Text(
                            'As an Instructor , You can organize meetings and schedule them for the learners anytime easily using LearnIt',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400,
                                    height: 1.45),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: SizeConfig.height! * 40,
                              width: SizeConfig.width! * 90,
                              child: Lottie.asset(
                                  "assets/lottie/onboarding_lottie2.json")),
                        )
                      ]),
                ),
                Container(
                  height: SizeConfig.height! * 60,
                  width: SizeConfig.width! * 100,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Connect with Mentors",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: SizeConfig.height! * 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'As a Learner , You can easily connect with mentors through chats and upgrade your skills to the next level',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w400,
                                    height: 1.45),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: SizeConfig.height! * 40,
                              width: SizeConfig.width! * 90,
                              child: Lottie.asset(
                                  "assets/lottie/onboarding_lottie3.json")),
                        )
                      ]),
                ),
              ],
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: _currentPage,
            count: 3,
            effect: ScrollingDotsEffect(
                dotHeight: 5,
                dotWidth: 5,
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Theme.of(context).colorScheme.inversePrimary),
          ),
          SizedBox(
            height: SizeConfig.height! * 15,
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: SizeConfig.width! * 100,
            child: FilledButton(
              onPressed: () {
                // context.go("/userSelection");
                GoRouter.of(context).push("/userSelection");
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) {
                //     return UserSelectionPage();
                //   },
                // ));
              },
              child: Text("Get Started",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ),
          Container(
            width: SizeConfig.width! * 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.login);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) {
                    //     return LoginPage();
                    //   },
                    // ));
                  },
                  child: Ink(
                    // height: SizeConfig.height! * 0.02,
                    // width: SizeConfig.width! * 0.02,
                    child: Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

/* 
Title : Welcome to LearnIt
Description : This is an online school that allows you to re-discover
#FCF2EF

You can Create and Join Meetings anytime , anywhere


Connect with Mentors and upgrade your skills to the next level

*/
