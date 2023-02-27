import 'package:flutter/material.dart';
import 'package:learn_it/chatpage/screens/chat_screen.dart';

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
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(),
        ));
      },
      icon: Icon(Icons.chat),
      color: Color(0xffffffff),
    );
  }
}
