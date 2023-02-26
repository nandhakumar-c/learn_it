import 'package:flutter/material.dart';

class ChatButton extends StatefulWidget {
  const ChatButton({super.key});

  @override
  State<ChatButton> createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Color.fromARGB(136, 128, 128, 128),
      ),
      onPressed: () {},
      icon: Icon(Icons.chat),
      color: Color(0xffffffff),
    );
  }
}
