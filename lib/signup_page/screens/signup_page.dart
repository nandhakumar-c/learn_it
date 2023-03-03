import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_it/common/utils/screen_size.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../common/providers/backend_provider.dart';
import '../../login_page/widgets/bottomborderclipper.dart';
import '../../login_page/widgets/topborderclipper.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({required this.userType, super.key});
  String userType;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

/*register

user_type
username
email
password
c_password  */
class _SignUpPageState extends State<SignUpPage> {
  TextEditingController? username;
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? confirmPassword;
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  bool emailBoolean = false;
  bool nameBoolean = false;
  bool passwordBoolean = false;
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  int? _value = 0;
  List<String> data = ["Student", "Teacher"];
  List<String> values = ["S", "T"];
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username!.dispose();
    email!.dispose();
    password!.dispose();
    confirmPassword!.dispose();
  }

  animateToPage() {
    _pageController.animateToPage(_currentPage,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userType);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final provider = Provider.of<BackEndProvider>(context);
    //  String serverIp = provider.getLocalhost();

    //Displays Error Message
    void displayDialog(context, title, text) => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text(title), content: Text(text)),
        );

    //Attempt SignUP
    attemptSignUp(String username, String email, String password,
        String confirmPassword, String userType) async {
      var res = await http
          .post(Uri.parse("${provider.getLocalhost()}/register"), body: {
        "username": username,
        "email": email,
        "password": password,
        "c_password": confirmPassword,
        "user_type": userType
      });
      if (res.statusCode == 201) return res.body;
      return null;
    }

    //backEndIntegration Function
    handleSignUp(BuildContext context, String username, String email,
        String password, String confirmPassword, String userType) async {
      var payload = await attemptSignUp(
          username, email, password, confirmPassword, widget.userType);
      if (payload != null) {
        print(payload);

        provider.setpayloadData(payload);
        provider.storeJwtToken("jwt", provider.payloadData!.token);
        print("Success");
        String userType = provider.payloadData!.user.userType;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(
            userType: userType,
          ),
        ));
      } else {
        print("Failure");
        // ignore: use_build_context_synchronously
        displayDialog(
            context, "Oops!", "User Account not created..Try again Later");
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserSelectionPage(),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          "Create Account",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Stepper(
        physics: NeverScrollableScrollPhysics(),
        elevation: 0,
        type: StepperType.horizontal,
        controlsBuilder: (context, details) {
          // print(details);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: SizeConfig.width! * 80,
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.width! * 80,
                    child: FilledButton(
                      onPressed: () {
                        if (details.currentStep == 0) {
                          print("0 press");
                          _formKey.currentState!.validate();
                          if (nameBoolean) {
                            details.onStepContinue!.call();
                          }
                        }
                        if (details.currentStep == 1) {
                          print("1 press");
                          _emailFormKey.currentState!.validate();
                          if (emailBoolean) {
                            details.onStepContinue!.call();
                          }
                        }

                        // _index == 2
                        //     ? handleSignUp(context, username!.text, email!.text,
                        //         password!.text, password!.text, widget.userType)
                        //     : _formKey.currentState?.validate();
                        // details.onStepContinue!.call();
                      },
                      child: Text(
                          details.currentStep == 2 ? "Register" : "Continue",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        //margin: EdgeInsetsGeometry.infinity,
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index < 2) {
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          Step(
            title: Text(""),
            state: _index <= 0 ? StepState.indexed : StepState.complete,
            isActive: true,
            content: Container(
              height: SizeConfig.height! * 15,
              // alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    height: SizeConfig.height! * 4,
                    child: Text(
                      "Enter your name",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (arg) {
                        if (arg!.length < 3)
                          return 'Name must be more than 2 charater';
                        else {
                          setState(() {
                            nameBoolean = true;
                          });
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      controller: username,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          hoverColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text(""),
            label: Text(""),
            state: _index <= 1 ? StepState.indexed : StepState.complete,
            isActive: true,
            content: Container(
              height: SizeConfig.height! * 15,
              // alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Form(
                    key: _emailFormKey,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: email,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Check if the entered email has the right format
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email address';
                        }
                        setState(() {
                          emailBoolean = true;
                        });
                        // Return null if the entered email is valid
                        return null;
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_rounded),
                          border: OutlineInputBorder(),
                          hintText: "Email address",
                          hoverColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text(""),
            label: Text(""),
            state: _index <= 2 ? StepState.indexed : StepState.complete,
            isActive: true,
            content: Container(
              height: SizeConfig.height! * 15,
              // alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    height: SizeConfig.height! * 4,
                    child: Text(
                      "Enter your password",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  TextField(
                    controller: password,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyLarge,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye_rounded,
                          color: isPasswordVisible ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      /* body: ListView(
        children: [
          
          Container(
            padding: EdgeInsets.all(16),
            height: SizeConfig.height! * 94,
            width: SizeConfig.width! * 100,
            child: Column(children: [
              // Container(
              //   height: SizeConfig.height! * 35,
              //   width: SizeConfig.width! * 100,
              //   child: Lottie.asset("assets/lottie/dashboard_meeting.json"),
              // ),

              TextFormField(
                textInputAction: TextInputAction.next,
                controller: username,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: "Username",
                    hoverColor: Colors.white),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: email,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_rounded),
                    border: OutlineInputBorder(),
                    hintText: "Email address",
                    hoverColor: Colors.white),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              //----password----
              TextField(
                controller: password,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyLarge,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye_rounded,
                      color: isPasswordVisible ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: SizeConfig.width! * 100,
                child: FilledButton(
                  onPressed: () {
                    handleSignUp(context, username!.text, email!.text,
                        password!.text, password!.text, widget.userType);
                  },
                  child: Text("Register",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ]),
          ),
        ],
      ), */
    );
    /*return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          //top design
          topBorder(width * 0.7, height * 0.35),
          Opacity(opacity: 0.5, child: topBorder(width * 0.75, height * 0.4)),

          //bottom design
          Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                      opacity: 0.5, child: bottomBorder(width, height * 0.4)))),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: 1,
                child: bottomBorder(width * 0.99, height * 0.34),
              ),
            ),
          ),
          Positioned(
            // top: height * 0.25,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "REGISTER",
                      style: GoogleFonts.cinzel(
                          fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(50, 50),
                              bottomLeft: Radius.circular(50))),
                      height: height * 0.4,
                      width: width * 0.9,
                      child: Center(
                        child: Container(
                          height: height * 0.38,
                          width: width * 0.86,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //username
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(fontSize: 20),
                                  controller: username,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),

                                //email
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(fontSize: 20),
                                  controller: email,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),

                                //password
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(fontSize: 20),
                                  obscureText: !isPasswordVisible,
                                  controller: password,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(fontSize: 20),
                                      suffixIcon: IconButton(
                                          padding: EdgeInsets.only(right: 30),
                                          onPressed: () {
                                            setState(() {
                                              isPasswordVisible =
                                                  !isPasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye_rounded,
                                            color: isPasswordVisible
                                                ? Colors.blue
                                                : Colors.grey,
                                          ))),
                                ),
                                const SizedBox(
                                  height: 20,
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),

                                //confirm password
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(fontSize: 20),
                                  obscureText: !isConfirmPasswordVisible,
                                  controller: confirmPassword,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock_person),
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(fontSize: 20),
                                      suffixIcon: IconButton(
                                          padding: EdgeInsets.only(right: 30),
                                          onPressed: () {
                                            setState(() {
                                              isConfirmPasswordVisible =
                                                  !isConfirmPasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye_rounded,
                                            color: isConfirmPasswordVisible
                                                ? Colors.blue
                                                : Colors.grey,
                                          ))),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    LearnItButton(
                        height: height * 0.05,
                        width: width * 0.4,
                        text: "SIGN UP",
                        onPressed: () {
                          handleSignUp(
                              context,
                              username!.text,
                              email!.text,
                              password!.text,
                              confirmPassword!.text,
                              widget.userType);
                        })
                  ],
                ),
              ),
            ),
          ),
        ]),
        /* appBar: AppBar(
          title: const Text("Signup Page"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: username,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      labelText: "Username"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: confirmPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                  ),
                ),
              ),
              Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    2,
                    (int index) {
                      return ChoiceChip(
                        label: Text(data[index]),
                        selected: _value == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : null;
                            user = values[index];
                            print(user);
                          });
                        },
                      );
                    },
                  ).toList()),
              const SizedBox(
                height: 15,
              ),
              LearnItButton(
                  text: "Register",
                  onPressed: () {
                    handleSignUp(context, username!.text, email!.text,
                        password!.text, confirmPassword!.text, user);
                  }),
            ],
          ),
        )),*/
      ),
    );*/
  }

  ClipPath bottomBorder(double width, double height) {
    return ClipPath(
        clipper: BottomBorderClipper(),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195),
              ])),
        ));
  }

  ClipPath topBorder(double width, double height) {
    return ClipPath(
        clipper: TopBorderClipper(),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 9, 43, 101),
                Color.fromARGB(180, 14, 96, 195)
              ])),
        ));
  }
}
