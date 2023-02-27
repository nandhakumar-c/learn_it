import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/screens/video_call_screen_layout.dart';

class JoinButton extends StatefulWidget {
  const JoinButton({super.key});

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          // Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => VideoCallScreen(),
          ));
        },
        child: Text("Join"));
  }
}
