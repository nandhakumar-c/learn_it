import 'package:flutter/material.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:provider/provider.dart';

import '../../common/providers/backend_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

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

  int? _value = 0;
  List<String> data = ["Student", "Teacher"];
  List<String> values = ["S", "T"];
  String user = "";
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BackEndProvider>(context);
    String serverIp = provider.getLocalhost();

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
          username, email, password, confirmPassword, userType);
      if (payload != null) {
        print(payload);
        print("Success");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      } else {
        print("Failure");
        // ignore: use_build_context_synchronously
        displayDialog(
            context, "Oops!", "User Account not created..Try again Later");
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
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
      )),
    );
  }
}
